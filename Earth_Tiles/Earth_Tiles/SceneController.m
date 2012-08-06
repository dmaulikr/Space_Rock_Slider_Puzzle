//
//  SceneController.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

// we dont add the object directly to the scene.
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

// we cannot just remove objects from
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
	@autoreleasepool {
    
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
	
	}
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

- (CGPoint)findTheEmptySpaceWithStarter:(CGPoint)startingTile andLastSpace:(CGPoint)lastEmptySpace{
    
    Tile *tile;
    BOOL spaceFilled;
    for (int i = 0; i < 4; i++) {
        //switch to most likely open space using
        //the touched tile and last empty position.
        
        //NSLog(@"startPosition: %f, %f", startingTile.x, startingTile.y);
        //NSLog(@"lastEmptyPosition: %f, %f", lastEmptySpace.x, lastEmptySpace.y);
        spaceFilled = NO;
        if (startingTile.x == lastEmptySpace.x){
            //Then it must be in the same column.
            //Damn this got twisted somehow...
            
            lastPoint.x = lastEmptySpace.x;
            //check all the spaces in this column.
            float floater = -105.0 + (70.0 * i);
            lastPoint.y = floater;
            
            for (tile in sceneObjects) {
                //NSLog(@"emptyGuess: %f, %f", lastPoint.x, lastPoint.y);
                //NSLog(@"checkTile: %f, %f \n\n..", tile.fTilePosition.x, tile.fTilePosition.y);
                
                if (tile.fTilePosition.x == lastPoint.x) {
                    if (CGPointEqualToPoint(lastPoint, tile.fTilePosition)) {
                        spaceFilled = YES;
                       // NSLog(@"They're Equal\n\n..");
                        break;
                        
                    }
                }
            }
            if (!spaceFilled) {
                
                return lastPoint;
            }
            
        }else{
            //It must be in the same row.
            lastPoint.y = lastEmptySpace.y;
            
            //check all the spaces in this row.
            float floater = -105.0 + (70.0 * i);
            lastPoint.x = floater;
            
            for (tile in sceneObjects) {
                //NSLog(@"emptyGuess: %f, %f", lastPoint.x, lastPoint.y);
                //NSLog(@"checkTile: %f, %f \n\n..", tile.fTilePosition.x, tile.fTilePosition.y);
                
                if (tile.fTilePosition.y == lastPoint.y) {
                    if (CGPointEqualToPoint(lastPoint, tile.fTilePosition)) {
                        spaceFilled = YES;
                       // NSLog(@"They're Equal\n\n..");
                        break;
                        
                    }
                }
            }
            if (!spaceFilled) {
                
                return lastPoint;
            }
        }
    }
    
    //should not hit this point
    return lastPoint;
}

-(CGPoint)sychronizeLastPoint{
    
    return lastPoint;
    
}


#pragma mark dealloc

- (void) dealloc
{
	[self stopAnimation];
	
	
}

@end
