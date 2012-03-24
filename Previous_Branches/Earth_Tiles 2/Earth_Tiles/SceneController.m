//
//  SceneController.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneController.h"
#import "InputVC.h"
#import "EAGLView.h"
#import "SceneObject.h"

@implementation SceneController

@synthesize inputController, openGLView;
@synthesize animationInterval, animationTimer;

// Singleton accessor.  this is how you should ALWAYS get a reference
// to the scene controller.  Never init your own. 
+(SceneController*)sharedSceneController
{
    static SceneController *sharedSceneController;
    @synchronized(self)
    {
        if (!sharedSceneController)
            sharedSceneController = [[SceneController alloc] init];
	}
	return sharedSceneController;
}


#pragma mark scene preload

// this is where we initialize all our scene objects
-(void)loadScene
{
	// this is where we store all our objects
	sceneObjects = [[NSMutableArray alloc] init];
	
	//Add a single scene object just for testing
	SceneObject * object = [[SceneObject alloc] init];
	[object awake];
	[sceneObjects addObject:object];
	[object release];
}

-(void) startScene
{
	self.animationInterval = 1.0/60.0;
	[self startAnimation];
}

#pragma mark Game Loop

- (void)gameLoop
{
	// apply our inputs to the objects in the scene
	[self updateModel];
	// send our objects to the renderer
	[self renderScene];
}

- (void)updateModel
{
	// simply call 'update' on all our scene objects
	[sceneObjects makeObjectsPerformSelector:@selector(update)];
	// be sure to clear the events
	[inputController clearEvents];
}

- (void)renderScene
{
	// turn openGL 'on' for this frame
	[openGLView beginDraw];
	// simply call 'render' on all our scene objects
	[sceneObjects makeObjectsPerformSelector:@selector(render)];
	// finalize this frame
	[openGLView finishDraw];
}


#pragma mark Animation Timer

// these methods are copied over from the EAGLView template

- (void)startAnimation {
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)stopAnimation {
	self.animationTimer = nil;
}

- (void)setAnimationTimer:(NSTimer *)newTimer {
	[animationTimer invalidate];
	animationTimer = newTimer;
}

- (void)setAnimationInterval:(NSTimeInterval)interval {	
	animationInterval = interval;
	if (animationTimer) {
		[self stopAnimation];
		[self startAnimation];
	}
}

#pragma mark dealloc

- (void) dealloc
{
	[self stopAnimation];
	[super dealloc];
}

@end
