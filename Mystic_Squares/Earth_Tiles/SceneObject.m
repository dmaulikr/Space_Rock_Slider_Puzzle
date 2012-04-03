//
//  SceneObject.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "SceneObject.h"
#import "SceneController.h"
#import "InputVC.h"
#import "MGCollider.h"
#import "Mesh.h"


@implementation SceneObject
@synthesize translation, rotation, scale, active, mesh, matrix; 
@synthesize meshBounds, collider, counter, outerTouchPoint, touchOffset, emptyPosition;
@synthesize firstTile, secondTile, thirdTile, singleTap, stop, distanceX, distanceY;

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
        firstTile = NO;
        secondTile = NO;
        thirdTile = NO;
        singleTap = NO;
        stop = NO;
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