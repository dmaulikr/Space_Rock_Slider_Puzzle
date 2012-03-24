//
//  MGCollisionController.h
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SceneObject.h"

@interface MGCollisionController : SceneObject{
    NSArray * sceneObjects;
	NSMutableArray * allColliders;
	NSMutableArray * collidersToCheck;
}

@property (retain) NSArray * sceneObjects;

- (void)awake;
- (void)handleCollisions;
- (void)render;
- (void)update;

@end
