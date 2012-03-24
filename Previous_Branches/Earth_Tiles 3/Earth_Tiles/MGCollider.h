//
//  MGCollider.h
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SceneObject.h"


@interface MGCollider : SceneObject {
    
    MGPoint transformedCenter;
    BOOL checkForCollision;
    CGFloat maxRadius;
}

@property (assign) BOOL checkForCollision;
@property (assign) CGFloat maxRadius;

+(MGCollider*)collider;
- (BOOL)doesCollideWithCollider:(MGCollider*)aCollider;
- (BOOL)doesCollideWithMesh:(SceneObject*)sceneObject;
- (void)dealloc;
- (void)awake;
- (void)render;
- (void)updateCollider:(SceneObject*)sceneObject;
@end


