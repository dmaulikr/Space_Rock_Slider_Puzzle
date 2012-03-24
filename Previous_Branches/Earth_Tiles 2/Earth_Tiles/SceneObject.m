//
//  SceneObject.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneObject.h"
#import "SceneController.h"
#import "InputVC.h"
#import "Mesh.h"

#pragma mark Spinny Square mesh
static CGFloat spinnySquareVertices[8] = {
    -0.5f, -0.5f,
    0.5f,  -0.5f,
    -0.5f,  0.5f,
    0.5f,   0.5f,
};

static CGFloat spinnySquareColors[16] = {
    1.0, 1.0,   0, 1.0,
    0,   1.0, 1.0, 1.0,
    0,     0,   0,   0,
    1.0,   0, 1.0, 1.0,
};


@implementation SceneObject
@synthesize x,y,z,xRotation,yRotation,zRotation,xScale,yScale,zScale,active;

- (id) init
{
	self = [super init];
	if (self != nil) {
		x = 0.0;
		y = 0.0;
		z = 0.0;
		
        xRotation = 0.0;
		yRotation = 0.0;
		zRotation = 0.0;
		
		xScale = 0.5;
		yScale = 0.5;
		zScale = 0.5;
        
		active = NO;
	}
	return self;
}

// called once when the object is first created.
-(void)awake
{
	mesh = [[Mesh alloc] initWithVertexes:spinnySquareVertices 
                                vertexCount:4 
                                 vertexSize:2
                                renderStyle:GL_TRIANGLE_STRIP];
	mesh.colors = spinnySquareColors;
	mesh.colorSize = 4;
}

// called once every frame
-(void)update
{
	
	// check the inputs, have we gotten a touch down?
	NSSet * touches = [[SceneController sharedSceneController].inputController touchEvents];
	for (UITouch * touch in [touches allObjects]) {
		// then we toggle our active state
		if (touch.phase == UITouchPhaseEnded) {
			active = !active;				
		} 
	}
	
	// if we are currently active, we will update our zRotation by 3 degrees
	if (active)	zRotation += 3.0;
}

// called once every frame
-(void)render
{
	// clear the matrix
	glPushMatrix();
	glLoadIdentity();
	
	// move to my position
	glTranslatef(x, y, z);
	
	// rotate
	glRotatef(xRotation, 1.0f, 0.0f, 0.0f);
	glRotatef(yRotation, 0.0f, 1.0f, 0.0f);
	glRotatef(zRotation, 0.0f, 0.0f, 1.0f);
	
	//scale
	glScalef(xScale, yScale, zScale);
	
	[mesh render];
	
	//restore the matrix
	glPopMatrix();
}


- (void) dealloc
{
	[super dealloc];
}


@end
