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
#import "MGCollisionController.h"
#import "MGConfiguration.h"
#import "Tile.h"

@implementation SceneController

@synthesize inputController, openGLView;
@synthesize animationInterval, animationTimer, levelStartDate, deltaTime;

// Singleton accessor.  this is how you should ALWAYS get a reference
// to the scene controller.  Never init your own. 
+(SceneController*)sharedSceneController
{
    static SceneController *sharedSceneController;
    @synchronized(self)
    {
        if (!sharedSceneController)
            sharedSceneController = [[SceneController alloc] init];
        return sharedSceneController;
	}
	return sharedSceneController;
}


#pragma mark scene preload

-(void)generateTiles{
    NSInteger i;
    for (i = 0; i < 15; i++) {
        [self addObjectToScene:[Tile makeTileNumber:i]];
    }
}

// this is where we initialize all our scene objects
-(void)loadScene
{
	// this is where we store all our objects
	if (sceneObjects == nil) sceneObjects = [[NSMutableArray alloc] init];
	[sceneObjects removeAllObjects];
    
    [self generateTiles];
    
    
    collisionController = [[MGCollisionController alloc] init];
    collisionController.sceneObjects = sceneObjects;
    if (DEBUG_DRAW_COLLIDERS) [self addObjectToScene:collisionController];
        
        
}

// we dont actualy add the object directly to the scene.
// this can get called anytime during the game loop, so we want to
// queue up any objects that need adding and add them at the start of
// the next game loop. useful for arcade style games. 
-(void)addObjectToScene:(SceneObject*)sceneObject
{
	if (objectsToAdd == nil) objectsToAdd = [[NSMutableArray alloc] init];
    
	sceneObject.active = YES;
	[sceneObject awake];
	[objectsToAdd addObject:sceneObject];
}

// similar to adding objects, we cannot just remove objects from
// the scene at any time.  we want to queue them for removal 
// and purge them at the end of the game loop
-(void)removeObjectFromScene:(SceneObject*)sceneObject
{
	if (objectsToRemove == nil) objectsToRemove = [[NSMutableArray alloc] init];
	[objectsToRemove addObject:sceneObject];
}



-(void) startScene
{
	self.animationInterval = 1.0/60.0;
	[self startAnimation];
    // reset our clock
	self.levelStartDate = [NSDate date];
	lastFrameStartTime = 0;
}

#pragma mark Game Loop

- (void)gameLoop
{
	// we use our own autorelease pool so that we can control when garbage gets collected
	NSAutoreleasePool * apool = [[NSAutoreleasePool alloc] init];
    
	// collect game metrics for time and performance.
    thisFrameStartTime = [levelStartDate timeIntervalSinceNow];
	deltaTime =  lastFrameStartTime - thisFrameStartTime;
	lastFrameStartTime = thisFrameStartTime;
    
    // add any queued scene objects
	if ([objectsToAdd count] > 0) {
		[sceneObjects addObjectsFromArray:objectsToAdd];
		[objectsToAdd removeAllObjects];
	}
    
	// update our model
	[self updateModel];
	
    //deal with collisions
	[collisionController handleCollisions];
    
	// send our objects to the renderer
	[self renderScene];
	
	// remove any objects that need removal
	if ([objectsToRemove count] > 0) {
		[sceneObjects removeObjectsInArray:objectsToRemove];
		[objectsToRemove removeAllObjects];
	}
	
	[apool release];
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
	
	[sceneObjects release];
	[objectsToAdd release];
	[objectsToRemove release];
	[inputController release];
	[openGLView release];
	[collisionController release];
	
	[super dealloc];
}

@end
