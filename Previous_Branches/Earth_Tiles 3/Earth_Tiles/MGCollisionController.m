//
//  MGCollisionController.m
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
			if ([colliderObject.collider doesCollideWithCollider:collideeObject.collider]) {
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
