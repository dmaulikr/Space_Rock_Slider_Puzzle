//
//  SceneController.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InputVC;
@class EAGLView;

@interface SceneController : NSObject {
    
    NSMutableArray * sceneObjects;
	
	InputVC * inputController;
	EAGLView * openGLView;
	
	NSTimer *animationTimer;
	NSTimeInterval animationInterval;
}

@property (retain) InputVC * inputController;
@property (retain) EAGLView * openGLView;

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

@end
