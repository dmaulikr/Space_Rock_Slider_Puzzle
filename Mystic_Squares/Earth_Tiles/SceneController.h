//
//  SceneController.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InputVC;
@class EAGLView;
@class MGCollisionController;
@class SceneObject;
@interface SceneController : NSObject {
    
    NSMutableArray * sceneObjects;
	NSMutableArray * objectsToRemove;
	NSMutableArray * objectsToAdd;
	
	InputVC * inputController;
	EAGLView * openGLView;
	
	NSTimer *animationTimer;
	NSTimeInterval animationInterval;
    
    MGCollisionController *collisionController;
    
    NSDate * levelStartDate;
	
	NSTimeInterval lastFrameStartTime;
	NSTimeInterval thisFrameStartTime;
    
}

@property (retain) InputVC * inputController;
@property (retain) EAGLView * openGLView;
@property (retain) NSDate * levelStartDate;
@property NSTimeInterval deltaTime;
@property NSTimeInterval animationInterval;
@property (nonatomic, assign) NSTimer *animationTimer;

+ (SceneController*)sharedSceneController;
- (void) dealloc;
- (void) loadScene;
- (void) startScene;
- (void)gameLoop;
- (void)renderScene;
- (void)setAnimationInterval:(NSTimeInterval)interval ;
- (void)setAnimationTimer:(NSTimer *)newTimer ;
- (void)startAnimation ;
- (void)stopAnimation ;
- (void)updateModel;
- (void)generateTiles;
- (void)addObjectToScene:(SceneObject*)sceneObject;
- (void)removeObjectFromScene:(SceneObject*)sceneObject;
@end
