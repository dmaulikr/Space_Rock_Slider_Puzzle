//
//  Tile.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"
#import "MGCollider.h"
#pragma mark Square mesh


/*
static NSInteger MGVertStride = 2;
static NSInteger MGColorStride = 4;
static NSInteger MGOutlineVertCount = 4;
static GLfloat squareVertices[8] = {
    -0.5f, -0.5f,
    0.5f,  -0.5f,
    -0.5f,  0.5f,
    0.5f,   0.5f,
};

static GLfloat squareColors[16] = {
    1.0, 1.0,   0, 1.0,
    0,   1.0, 1.0, 1.0,
    0,     0,   0,   0,
    1.0,   0, 1.0, 1.0,
};
*/

static NSInteger tileVertexSize = 2;
static GLfloat positionMatrix[32] = {
    -105.0, 105.0,
    -35.0,  105.0,
    35.0, 105.0,
    105.0, 105.0,
    
    -105.0, 35.0,
    -35.0,  35.0,
    35.0, 35.0,
    105.0, 35.0,
    
    -105.0, -35.0,
    -35.0,  -35.0,
    35.0, -35.0,
    105.0, -35.0,
    
    -105.0, -105.0,
    -35.0,  -105.0,
    35.0, -105.0,
    105.0, -105.0,
};
@implementation Tile

- (id) init
{
	self = [super init];
	if (self != nil) {
		
	}
    
	return self;
}

+(Tile*)makeTileNumber:(NSInteger)count{
    
    Tile *tile = [[Tile alloc] init];
    NSLog(@"TileNumber:%i", count);
    CGFloat scale = 67.0;
	tile.scale = MGPointMake(scale, scale, 1.0);
    NSInteger a;
    NSInteger b;
    count += 1;
    tile.counter = count;
    a = (count + (count -1));
    b = 2 * count;
    
    //NSLog(@"MatrixNumber:%i, %i", a, b);
    
    GLfloat x = positionMatrix[a-1];
	GLfloat y = positionMatrix[b-1];
    
    //NSLog(@"Position:%f, %f", x, y);
    
	tile.translation = MGPointMake(x, y, 0.0);
    tile.emptyPosition = CGPointMake(positionMatrix[30], positionMatrix[31]);
	return [tile autorelease];
    
}

-(void)awake{
    NSString *atlasKey = [[NSString alloc] initWithFormat:@"square%i",counter];
    //NSLog(@"%@",atlasKey);
    mesh = [[MaterialController sharedMaterialController] quadFromAtlasKey:atlasKey];
    
    verts = (CGFloat *) malloc(4 * tileVertexSize * sizeof(CGFloat));
    
    self.collider = [MGCollider collider];
    [self.collider setCheckForCollision:YES];
    
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    pointInBounds = YES;
    firstTile = NO;
    secondTile = NO;
    thirdTile = NO;
}

-(void)update
{
    // check for touches
    if (pointInBounds) {
        [self handleTouches];
    }
	
    
    
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    
    [super update];
}

-(void)handleTouches
{
	NSSet * beganTouches = [[SceneController sharedSceneController].inputController beganTouchEvents];
    NSSet * movedTouches = [[SceneController sharedSceneController].inputController movedTouchEvents];
    NSSet * endTouches = [[SceneController sharedSceneController].inputController endTouchEvents];
	if ([beganTouches count] == 0 && [movedTouches count] == 0 && [endTouches count] == 0) return;
	//[self.collider setCheckForCollision:NO];
	
    for (UITouch * startTouch in [beganTouches allObjects]) {
		CGPoint touchPointB = [startTouch locationInView:[startTouch view]];
		if (CGRectContainsPoint(screenRect, touchPointB)) {
            firstTile = YES;
            startPoint = MGPointMake((touchPointB.x - 160), -(touchPointB.y - 240), 0.0);
            //NSLog(@"start: %f, %f", startPoint.x, startPoint.y);
            touchOffset.x = translation.x - startPoint.x;
            touchOffset.y = translation.y - startPoint.y;
            
        }else{
            movedTouches = nil;
        }
        
    }
	for (UITouch * movedTouch in [movedTouches allObjects]) {
		CGPoint touchPointM = [movedTouch locationInView:[movedTouch view]];
		if (CGRectContainsPoint(screenRect, touchPointM)) {
            if ((MGPointDistance(startPoint, translation)) > 70) {
                NSLog(@"distanceMoved: %f", MGPointDistance(startPoint, translation));
                return;
            }
            //NSLog(@"moved: %f, %f", touchPointM.x, touchPointM.y);
            CGPoint passPoint = CGPointMake((touchPointM.x - 160), -(touchPointM.y - 240));
            //NSLog(@"passed: %f, %f", passPoint.x, passPoint.y);
            [self moveTile:passPoint];
        
        }
    
    }
    for (UITouch * endTouch in [endTouches allObjects]) {
        
		//CGPoint touchPointE = [endTouch locationInView:[endTouch view]];
        [self touchesEndedX];
        [self touchesEndedY];
        //NSLog(@"end: %f, %f", touchPointE.x, touchPointE.y);
        
    }
}

-(void)touchesEndedX{
    [super touchesEndedX];
    startPoint = translation;
}

-(void)touchesEndedY{
    [super touchesEndedY];
    startPoint = translation;
}

-(void)shouldStop{
    [super shouldStop];
}

-(void)moveTile:(CGPoint)touchPoint{
    if (pointInBounds) {
        distanceX = (touchPoint.x + touchOffset.x) - translation.x;
        distanceY = (touchPoint.y + touchOffset.y) - translation.y;
    }
    
    translation.x += distanceX;
    translation.y += distanceY;
}


- (void)didCollideWith:(SceneObject*)sceneObject 
{
    if (sceneObject.translation.x == translation.x) return;
    if (sceneObject.translation.y == translation.y) return;
    NSLog(@"collided");
    
    if (firstTile) {
        NSLog(@"firstTile");
        sceneObject.firstTile = NO;
        sceneObject.secondTile = YES;
        sceneObject.thirdTile = NO;
        
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            [self shouldStop];
            NSLog(@"Should Stop 1");
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            [self shouldStop];
            NSLog(@"Should Stop 2");
        }
        if (sceneObject.translation.y == 105.0) {
            translation.y = 35.0;
            [self shouldStop];
            NSLog(@"Should Stop 1");
        }
        if (sceneObject.translation.y == -105.0) {
            translation.y = -35.0;
            [self shouldStop];
            NSLog(@"Should Stop 2");
        }
    }else if(secondTile){
        NSLog(@"secondTile");
        if (sceneObject.firstTile) {
            if (sceneObject.pointInBounds) {
                distanceX = sceneObject.distanceX;
                distanceY = sceneObject.distanceY;
                translation.x += distanceX;
                translation.y += distanceY;
            }
            
        }else{
            sceneObject.thirdTile = YES;
            sceneObject.secondTile = NO;
            sceneObject.firstTile = NO;
            if (sceneObject.translation.x == 105.0) {
                translation.x = 35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 4");
            }
            if (sceneObject.translation.x == -105.0) {
                translation.x = -35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 5");
            }
            if (sceneObject.translation.y == 105.0) {
                translation.y = 35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 4");
            }
            if (sceneObject.translation.y == -105.0) {
                translation.y = -35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 5");
            }
        }
    }else if (thirdTile) {
        NSLog(@"thirdTile");
        if (sceneObject.secondTile) {
            if (sceneObject.pointInBounds) {
                distanceX = sceneObject.distanceX;
                distanceY = sceneObject.distanceY;
                translation.x += (distanceX);
                translation.y += (distanceY);
            }
        }else{
            [self shouldStop];
            return;
            if (sceneObject.translation.x == 105.0) {
                translation.x = 35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 7");
            }
            if (sceneObject.translation.x == -105.0) {
                translation.x = -35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 8");
            }
            if (sceneObject.translation.y == 105.0) {
                translation.y = 35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 7");
            }
            if (sceneObject.translation.y == -105.0) {
                translation.y = -35.0;
                [self shouldStop];
                
                NSLog(@"Should Stop 8");
            }
        }
        
    }
}

@end
