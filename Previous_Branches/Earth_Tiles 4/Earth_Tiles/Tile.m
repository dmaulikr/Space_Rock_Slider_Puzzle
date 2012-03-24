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
    pointInBounds = NO;
}

-(void)update
{
    // check for touches
	[self handleTouches];
    [super update];
    
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
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
			pointInBounds = YES;
            startPoint = CGPointMake((touchPointB.x - 160), -(touchPointB.y - 240));
            NSLog(@"start: %f, %f", startPoint.x, startPoint.y);
            touchOffset.x = translation.x - startPoint.x;
            touchOffset.y = translation.y - startPoint.y;
        }
        
    }
	for (UITouch * movedTouch in [movedTouches allObjects]) {
		CGPoint touchPointM = [movedTouch locationInView:[movedTouch view]];
		if (CGRectContainsPoint(screenRect, touchPointM)) {
            
            //NSLog(@"moved: %f, %f", touchPointM.x, touchPointM.y);
            CGPoint passPoint = CGPointMake((touchPointM.x - 160), -(touchPointM.y - 240));
            NSLog(@"passed: %f, %f", passPoint.x, passPoint.y);
            [self moveTile:passPoint];
        
        }
    
    }
    for (UITouch * endTouch in [endTouches allObjects]) {
        
		CGPoint touchPointE = [endTouch locationInView:[endTouch view]];
        [self touchEndedX];
        NSLog(@"end: %f, %f", touchPointE.x, touchPointE.y);
        
    }
}

-(void)touchEndedX{
    if (translation.x < -70.0) {
        translation.x = -105.0;
    }
    if (translation.x >= -70 && translation.x < 0.0) {
        translation.x = -35.0;
    }
    if (translation.x >= 0.0 && translation.x < 70) {
        translation.x = 35.0;
    }
    if (translation.x >= 70) {
        translation.x = 150.0;
    }
}

-(void)moveTile:(CGPoint)touchPoint{
    if (!pointInBounds) return;
    outerTouchPoint.x = translation.x;
    float distanceX = (touchPoint.x + touchOffset.x) - translation.x;
    translation.x += distanceX;
    
    
}


- (void)didCollideWith:(SceneObject*)sceneObject 
{
    if (sceneObject == self) return;
    NSLog(@"collided");
    //float distanceX = (outerTouchPoint.x + touchOffset.x) - translation.x;
    if (firstTile) {
        sceneObject.firstTile = NO;
        sceneObject.secondTile = YES;
         NSLog(@"PIB: %f",translation.x);
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            pointInBounds = NO;
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            pointInBounds = NO;
        }
    }else if(secondTile){

        NSLog(@"Next: %f",sceneObject.translation.x);
        translation.x += sceneObject.translation.x - sceneObject.outerTouchPoint.x +1;
        
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            
        }
        
    }else if (!secondTile && !firstTile) {
        
        
        
    }else{
        
    }
    
    
}

@end
