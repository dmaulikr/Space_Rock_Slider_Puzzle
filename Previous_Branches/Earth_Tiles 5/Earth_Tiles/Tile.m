//
//  Tile.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"
#import "MGCollider.h"
#import "MGConfiguration.h"
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

// position matrix for the tiles
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

static NSInteger tileVertexSize = 2;

@implementation Tile
@synthesize startPoint;


-(id) init
{
	self = [super init];
	if (self != nil) {
		
	}
    // tile origins
    
    
	return self;
}

+(Tile*)makeTileNumber:(NSInteger)count{
    
    Tile *tile = [[Tile alloc] init];
    NSLog(@"TileNumber:%i", count);
   
    NSString *position = [[NSString alloc] initWithFormat:@"%c", [kInitialPositions characterAtIndex:(count)]];
    
    NSLog(@"TileNumber:%@", position);
    
    CGFloat scale = 67.0;
	tile.scale = MGPointMake(scale, scale, 1.0);
    NSInteger a;
    NSInteger b;
    count += 1;
    tile.counter = count;
    a = (count + (count -1));
    b = 2 * count;
    
    //NSLog(@"MatrixNumber:%i, %i", a, b);
    
    tile.emptyPosition = CGPointMake(positionMatrix[30], positionMatrix[31]);
    
    CGPoint p0 = CGPointMake(positionMatrix[0], positionMatrix[1]);
    CGPoint p1 = CGPointMake(positionMatrix[2], positionMatrix[3]);
    CGPoint p2 = CGPointMake(positionMatrix[4], positionMatrix[5]);
    CGPoint p3 = CGPointMake(positionMatrix[6], positionMatrix[7]);
    CGPoint p4 = CGPointMake(positionMatrix[8], positionMatrix[9]);
    CGPoint p5 = CGPointMake(positionMatrix[10], positionMatrix[11]);
    CGPoint p6 = CGPointMake(positionMatrix[12], positionMatrix[13]);
    CGPoint p7 = CGPointMake(positionMatrix[14], positionMatrix[15]);
    CGPoint p8 = CGPointMake(positionMatrix[16], positionMatrix[17]);
    CGPoint p9 = CGPointMake(positionMatrix[18], positionMatrix[19]);
    CGPoint pA = CGPointMake(positionMatrix[20], positionMatrix[21]);
    CGPoint pB = CGPointMake(positionMatrix[22], positionMatrix[23]);
    CGPoint pC = CGPointMake(positionMatrix[24], positionMatrix[25]);
    CGPoint pD = CGPointMake(positionMatrix[26], positionMatrix[27]);
    CGPoint pE = CGPointMake(positionMatrix[28], positionMatrix[29]);
    CGPoint pF = CGPointMake(positionMatrix[30], positionMatrix[31]);
    
    if ([position isEqualToString:@"0"]) tile.translation = MGPointMake(p0.x, p0.y, 0.0);
    if ([position isEqualToString:@"1"]) tile.translation = MGPointMake(p1.x, p1.y, 0.0);
    if ([position isEqualToString:@"2"]) tile.translation = MGPointMake(p2.x, p2.y, 0.0);
    if ([position isEqualToString:@"3"]) tile.translation = MGPointMake(p3.x, p3.y, 0.0);
    if ([position isEqualToString:@"4"]) tile.translation = MGPointMake(p4.x, p4.y, 0.0);
    if ([position isEqualToString:@"5"]) tile.translation = MGPointMake(p5.x, p5.y, 0.0);
    if ([position isEqualToString:@"6"]) tile.translation = MGPointMake(p6.x, p6.y, 0.0);
    if ([position isEqualToString:@"7"]) tile.translation = MGPointMake(p7.x, p7.y, 0.0);
    if ([position isEqualToString:@"8"]) tile.translation = MGPointMake(p8.x, p8.y, 0.0);
    if ([position isEqualToString:@"9"]) tile.translation = MGPointMake(p9.x, p9.y, 0.0);
    if ([position isEqualToString:@"A"]) tile.translation = MGPointMake(pA.x, pA.y, 0.0);
    if ([position isEqualToString:@"B"]) tile.translation = MGPointMake(pB.x, pB.y, 0.0);
    if ([position isEqualToString:@"C"]) tile.translation = MGPointMake(pC.x, pC.y, 0.0);
    if ([position isEqualToString:@"D"]) tile.translation = MGPointMake(pD.x, pD.y, 0.0);
    if ([position isEqualToString:@"E"]) tile.translation = MGPointMake(pE.x, pE.y, 0.0);
    if ([position isEqualToString:@"F"]) tile.translation = MGPointMake(pF.x, pF.y, 0.0);
    
    
    return [tile autorelease];
    
}

-(void)awake{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveBegan) name:@"start" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveEnded) name:@"end" object:nil];
    
    NSString *atlasKey = [[NSString alloc] initWithFormat:@"square%i",counter];
    
    mesh = [[MaterialController sharedMaterialController] quadFromAtlasKey:atlasKey];
    
    verts = (CGFloat *) malloc(4 * tileVertexSize * sizeof(CGFloat));
    
    self.collider = [MGCollider collider];
    
    [self.collider setCheckForCollision:YES];
    
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    
    startPoint = translation;
    
    pointInBounds = NO; firstTile = NO; secondTile = NO; thirdTile = NO; stop = NO;
}

-(void)update
{
    
    // move tile touchzone to new location.
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    
    // check for touches 
    [self handleTouches];
    
    [super update];
}

-(void)handleTouches
{
	NSSet * beganTouches = [[SceneController sharedSceneController].inputController beganTouchEvents];
    NSSet * movedTouches = [[SceneController sharedSceneController].inputController movedTouchEvents];
    
	if ([beganTouches count] == 0 && [movedTouches count] == 0) return;
	
    for (UITouch * startTouch in [beganTouches allObjects]) {
		CGPoint touchPointB = [startTouch locationInView:[startTouch view]];
		if (CGRectContainsPoint(screenRect, touchPointB)) {
            
            firstTile = YES; 
            pointInBounds = YES;
            
            startPoint = MGPointMake((touchPointB.x - 160), -(touchPointB.y - 240), 0.0);
            
            touchOffset.x = translation.x - startPoint.x;
            touchOffset.y = translation.y - startPoint.y;
            
        }
        
    }
	for (UITouch * movedTouch in [movedTouches allObjects]) {
        //Each new touch needs to be counted, 
        //offset and then checked for which 
        //direction is intended. After that 
        //we pass the offset only touch in
        //the intended direction.
		
       
        
        CGPoint touchPointM = [movedTouch locationInView:[movedTouch view]];
        
        if (CGRectContainsPoint(screenRect, touchPointM) && pointInBounds) {
            
            CGPoint point = CGPointMake((touchPointM.x - 160), - (touchPointM.y - 240));
            CGPoint firstDisance = CGPointMake((point.x + touchOffset.x) - translation.x, (point.y + touchOffset.y) - translation.y);
             NSLog(@"tile touched: %i",counter);
            if (!stop ) {
                
                //(sqrtf((translation.x - startPoint.x) * (translation.x - startPoint.x)) < 75 || sqrtf((translation.y - startPoint.y) * (translation.y - startPoint.y)) < 75) && 
                
                moveCount +=1;
                
                NSLog(@"%f, %f %f", firstDisance.x, firstDisance.y, (sqrtf(firstDisance.x * firstDisance.x) - sqrtf(firstDisance.y * firstDisance.y)));
                
                if ((sqrtf(firstDisance.x * firstDisance.x) - sqrtf(firstDisance.y * firstDisance.y)) > 0) {
                
                    if(moveCount <= 1) xWasBigger = YES;
                
                }else{
                
                    if(moveCount <= 1) xWasBigger = NO;
                    
                }
                //NSLog(@"x was bigger: %i", xWasBigger);
                [self moveTile:point];
            }
        }
    }
}

-(void)moveBegan{
    
        self.startPoint = translation;
}
     
-(void)moveEnded{
    
    //initialize Prof. Bool: http://en.wikipedia.org/wiki/George_Boole = 0;
    firstTile = NO;
    secondTile = NO;
    thirdTile = NO;
    pointInBounds = NO;
    stop = NO;
    
    moveCount = 0;
    if (xWasBigger) {
         NSLog(@"%f",translation.y);
        // If not fully moved jump to nearest x position.
        if (translation.x < -70.0) {
            translation.x = -105.0;
        }
        if (translation.x >= -70 && translation.x < 0.0) {
            translation.x = -35.0;
        }
        if (translation.x >= 0.0 && translation.x < 70) {
            translation.x = 35.0;
        }
        if (translation.x >= 70.0) {
            translation.x = 150.0;
        }
   
    }else{
        // Do the same for y
        if (translation.y < -70.0) {
            translation.y = -105.0;
        }
        if (translation.y >= -70 && translation.y < 0.0) {
            translation.y = -35.0;
        }
        if (translation.y >= 0.0 && translation.y < 70) {
            translation.y = 35.0;
        }
        if (translation.y >= 70.0) {
            translation.y = 150.0;
        }
    }
}

-(void)moveTile:(CGPoint)touchPoint{
    
    if (xWasBigger){
    
        distanceX = (touchPoint.x + touchOffset.x) - translation.x;
        translation.x += distanceX;
        
    }else{
        
        distanceY = (touchPoint.y + touchOffset.y) - translation.y;
        translation.y += distanceY;
    }
}



- (void)didCollideWith:(SceneObject*)sceneObject 
{
    if (sceneObject.translation.x == translation.x) return;
    NSLog(@"collided");
    //float distanceX = (outerTouchPoint.x + touchOffset.x) - translation.x;
    if (firstTile) {
        NSLog(@"firstTile");
        if (!sceneObject.secondTile && !sceneObject.thirdTile) {
            sceneObject.secondTile = YES;
            sceneObject.thirdTile = NO;
        }
        
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            stop = YES;
            NSLog(@"Should Stop 1");
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            stop = YES;
            NSLog(@"Should Stop 2");
        }
        stop = sceneObject.stop;
    }else if(secondTile){
        NSLog(@"secondTile");
        if (sceneObject.firstTile) {
            distanceX = sceneObject.distanceX;
            translation.x += distanceX;
            
        }else if (!sceneObject.firstTile && !sceneObject.secondTile && !sceneObject.thirdTile) {
                sceneObject.thirdTile = YES;
        }
        
        if (sceneObject.translation.x == 105.0) {
                translation.x = 35.0;
                stop = YES;
                NSLog(@"Should Stop 4");
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            stop = YES;
            NSLog(@"Should Stop 5");
        }
        stop = sceneObject.stop;
    }else if (thirdTile) {
        
        if (!sceneObject.firstTile && !sceneObject.secondTile) {
            stop = YES;
        }
        if (sceneObject.secondTile) {
            distanceX = sceneObject.distanceX;
            translation.x += distanceX;
        
        }else{
            
            if (sceneObject.translation.x == 105.0) {
                translation.x = 35.0;
                stop = YES;
                NSLog(@"Should Stop 7");
            }
            if (sceneObject.translation.x == -105.0) {
                translation.x = -35.0;
                stop = YES;
                NSLog(@"Should Stop 8");
            }
        }
    }
}

@end
