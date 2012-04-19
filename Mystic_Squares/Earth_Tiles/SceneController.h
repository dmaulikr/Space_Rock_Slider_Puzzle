//
//  SceneController.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
    CGPoint lastPoint;

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
- (CGPoint)findTheEmptySpaceWithStarter:(CGPoint)startingTile andLastSpace:(CGPoint)lastEmptySpace;
- (CGPoint)sychronizeLastPoint;

@end
