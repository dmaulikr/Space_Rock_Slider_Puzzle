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
#import "MGCollider.h"
#import "Mesh.h"


@implementation SceneObject
@synthesize translation, rotation, scale, active, mesh, matrix; 
@synthesize meshBounds, collider, counter, outerTouchPoint, touchOffset, emptyPosition;
@synthesize pointInBounds, firstTile, secondTile, thirdTile;

- (id) init
{
	self = [super init];
	if (self != nil) {
		translation = MGPointMake(0.0, 0.0, 0.0);
        rotation = MGPointMake(0.0, 0.0, 0.0);
        scale = MGPointMake(1.0, 1.0, 1.0);
        matrix = (CGFloat *) malloc(16 * sizeof(CGFloat));
        active = NO;
		meshBounds = CGRectZero;
        self.collider = nil;
	}
	return self;
}

// called once when the object is first created.
-(void)awake
{
	//Override point.
}

// called once every frame
-(void)update
{
    // clear the matrix
	glPushMatrix();
	glLoadIdentity();
	
	// move to my position
	glTranslatef(translation.x, translation.y, translation.z);
	
	// rotate
	glRotatef(rotation.x, 1.0f, 0.0f, 0.0f);
	glRotatef(rotation.y, 0.0f, 1.0f, 0.0f);
	glRotatef(rotation.z, 0.0f, 0.0f, 1.0f);
	
	//scale
	glScalef(scale.x, scale.y, scale.z);
    // save the matrix transform
	glGetFloatv(GL_MODELVIEW_MATRIX, matrix);
    //restore the matrix
	glPopMatrix();
    if (collider != nil) [collider updateCollider:self];
}

-(CGRect) meshBounds
{
	if (CGRectEqualToRect(meshBounds, CGRectZero)) {
    meshBounds = [Mesh meshBounds:mesh scale:scale];
	}
	return meshBounds;
}

// called once every frame
-(void)render
{
	if(!mesh || !active) return;
    glPushMatrix();
    glLoadIdentity();
    //set our transform
    glMultMatrixf(matrix);
	[mesh render];
	glPopMatrix();
    
}


- (void) dealloc
{
	[mesh release];
	[collider release];
	free(matrix);
    [super dealloc];
}

- (void)didCollideWith:(SceneObject*)sceneObject 
{
         
}


@end