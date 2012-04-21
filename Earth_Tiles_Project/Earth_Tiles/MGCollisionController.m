//
//  MGCollisionController.m
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MGCollisionController.h"
#import "MGMobileObject.h"
#import "MGCollider.h"

@implementation MGCollisionController
@synthesize sceneObjects;

-(void)handleCollisions
{
	// two types of colliders
	// ones that need to be checked for collision and ones that do not
	if (allColliders == nil) allColliders = [[NSMutableArray alloc] init];
	[allColliders removeAllObjects];
	if (collidersToCheck == nil) collidersToCheck = [[NSMutableArray alloc] init];
	[collidersToCheck removeAllObjects];
	//build seporate arrays
	for (SceneObject * obj in sceneObjects) {
		if (obj.collider != nil){
			[allColliders addObject:obj];
			if (obj.collider.checkForCollision) [collidersToCheck addObject:obj];
		}	
	}
    
	// now check to see if anything is hitting anything else
	for (SceneObject * colliderObject in collidersToCheck) {
		for (SceneObject * collideeObject in allColliders) {
			if (colliderObject == collideeObject) continue;
			if ([colliderObject.collider doesCollideWithCollider: collideeObject.collider]) {
				if ([colliderObject respondsToSelector:@selector(didCollideWith:)]) [colliderObject didCollideWith:collideeObject];
			}
		}
	}
}

#pragma mark BBSceneObject overrides for rendering and debug

-(void)awake
{
}

// called once every frame
-(void)update
{	
}

// called once every frame
-(void)render
{
	if (!active) return; // if we do not have a mesh, no need to render
	// clear the matrix
	glPushMatrix();
	glLoadIdentity();
	for (SceneObject * obj in allColliders) {						
		[obj.collider render];
	}
	glPopMatrix();
}



@end
