//
//  Tile.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "Tile.h"
#import "MGCollider.h"
#import "MGConfiguration.h"


//#pragma mark Square mesh
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

// origin matrix for the tiles
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
@synthesize startPoint, p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF, endPoint, totalDistance;

#pragma Mark -
#pragma Mark Initization Methods

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
    NSString *emptyPosition = [[NSString alloc] initWithFormat:@"%c", [kInitialPositions characterAtIndex:15]];
    
    NSLog(@"TileNumber:%@", position);
    NSLog(@"EmptySpace:%@", emptyPosition);
                               
    CGFloat scale = 67.0;
	tile.scale = MGPointMake(scale, scale, 1.0);
    NSInteger a;
    NSInteger b;
    count += 1;
    tile.counter = count;
    a = (count + (count -1));
    b = 2 * count;
    
    //NSLog(@"MatrixNumber:%i, %i", a, b);
    
    tile.p0 = CGPointMake(positionMatrix[0], positionMatrix[1]);
    tile.p1 = CGPointMake(positionMatrix[2], positionMatrix[3]);
    tile.p2 = CGPointMake(positionMatrix[4], positionMatrix[5]);
    tile.p3 = CGPointMake(positionMatrix[6], positionMatrix[7]);
    tile.p4 = CGPointMake(positionMatrix[8], positionMatrix[9]);
    tile.p5 = CGPointMake(positionMatrix[10], positionMatrix[11]);
    tile.p6 = CGPointMake(positionMatrix[12], positionMatrix[13]);
    tile.p7 = CGPointMake(positionMatrix[14], positionMatrix[15]);
    tile.p8 = CGPointMake(positionMatrix[16], positionMatrix[17]);
    tile.p9 = CGPointMake(positionMatrix[18], positionMatrix[19]);
    tile.pA = CGPointMake(positionMatrix[20], positionMatrix[21]);
    tile.pB = CGPointMake(positionMatrix[22], positionMatrix[23]);
    tile.pC = CGPointMake(positionMatrix[24], positionMatrix[25]);
    tile.pD = CGPointMake(positionMatrix[26], positionMatrix[27]);
    tile.pE = CGPointMake(positionMatrix[28], positionMatrix[29]);
    tile.pF = CGPointMake(positionMatrix[30], positionMatrix[31]);
    
    if ([position isEqualToString:@"0"]) tile.translation = MGPointMake(tile.p0.x, tile.p0.y, 0.0);
    if ([position isEqualToString:@"1"]) tile.translation = MGPointMake(tile.p1.x, tile.p1.y, 0.0);
    if ([position isEqualToString:@"2"]) tile.translation = MGPointMake(tile.p2.x, tile.p2.y, 0.0);
    if ([position isEqualToString:@"3"]) tile.translation = MGPointMake(tile.p3.x, tile.p3.y, 0.0);
    if ([position isEqualToString:@"4"]) tile.translation = MGPointMake(tile.p4.x, tile.p4.y, 0.0);
    if ([position isEqualToString:@"5"]) tile.translation = MGPointMake(tile.p5.x, tile.p5.y, 0.0);
    if ([position isEqualToString:@"6"]) tile.translation = MGPointMake(tile.p6.x, tile.p6.y, 0.0);
    if ([position isEqualToString:@"7"]) tile.translation = MGPointMake(tile.p7.x, tile.p7.y, 0.0);
    if ([position isEqualToString:@"8"]) tile.translation = MGPointMake(tile.p8.x, tile.p8.y, 0.0);
    if ([position isEqualToString:@"9"]) tile.translation = MGPointMake(tile.p9.x, tile.p9.y, 0.0);
    if ([position isEqualToString:@"A"]) tile.translation = MGPointMake(tile.pA.x, tile.pA.y, 0.0);
    if ([position isEqualToString:@"B"]) tile.translation = MGPointMake(tile.pB.x, tile.pB.y, 0.0);
    if ([position isEqualToString:@"C"]) tile.translation = MGPointMake(tile.pC.x, tile.pC.y, 0.0);
    if ([position isEqualToString:@"D"]) tile.translation = MGPointMake(tile.pD.x, tile.pD.y, 0.0);
    if ([position isEqualToString:@"E"]) tile.translation = MGPointMake(tile.pE.x, tile.pE.y, 0.0);
    if ([position isEqualToString:@"F"]) tile.translation = MGPointMake(tile.pF.x, tile.pF.y, 0.0);
    
    if ([emptyPosition isEqualToString:@"0"]) tile.emptyPosition = CGPointMake(tile.p0.x, tile.p0.y);
    if ([emptyPosition isEqualToString:@"1"]) tile.emptyPosition = CGPointMake(tile.p1.x, tile.p1.y);
    if ([emptyPosition isEqualToString:@"2"]) tile.emptyPosition = CGPointMake(tile.p2.x, tile.p2.y);
    if ([emptyPosition isEqualToString:@"3"]) tile.emptyPosition = CGPointMake(tile.p3.x, tile.p3.y);
    if ([emptyPosition isEqualToString:@"4"]) tile.emptyPosition = CGPointMake(tile.p4.x, tile.p4.y);
    if ([emptyPosition isEqualToString:@"5"]) tile.emptyPosition = CGPointMake(tile.p5.x, tile.p5.y);
    if ([emptyPosition isEqualToString:@"6"]) tile.emptyPosition = CGPointMake(tile.p6.x, tile.p6.y);
    if ([emptyPosition isEqualToString:@"7"]) tile.emptyPosition = CGPointMake(tile.p7.x, tile.p7.y);
    if ([emptyPosition isEqualToString:@"8"]) tile.emptyPosition = CGPointMake(tile.p8.x, tile.p8.y);
    if ([emptyPosition isEqualToString:@"9"]) tile.emptyPosition = CGPointMake(tile.p9.x, tile.p9.y);
    if ([emptyPosition isEqualToString:@"A"]) tile.emptyPosition = CGPointMake(tile.pA.x, tile.pA.y);
    if ([emptyPosition isEqualToString:@"B"]) tile.emptyPosition = CGPointMake(tile.pB.x, tile.pB.y);
    if ([emptyPosition isEqualToString:@"C"]) tile.emptyPosition = CGPointMake(tile.pC.x, tile.pC.y);
    if ([emptyPosition isEqualToString:@"D"]) tile.emptyPosition = CGPointMake(tile.pD.x, tile.pD.y);
    if ([emptyPosition isEqualToString:@"E"]) tile.emptyPosition = CGPointMake(tile.pE.x, tile.pE.y);
    if ([emptyPosition isEqualToString:@"F"]) tile.emptyPosition = CGPointMake(tile.pF.x, tile.pF.y);
    
    
    return [tile autorelease];
    
}

-(void)awake{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveBegan) name:@"start" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveXorY) name:@"whichWay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopMove) name:@"stop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveEnded) name:@"end" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmptyPosition:) name:@"broadcastPosition" object:nil];
    
    
    
    NSString *atlasKey = [[NSString alloc] initWithFormat:@"square%i",counter];
    
    mesh = [[MaterialController sharedMaterialController] quadFromAtlasKey:atlasKey];
    
    verts = (CGFloat *) malloc(4 * tileVertexSize * sizeof(CGFloat));
    
    self.collider = [MGCollider collider];
    
    [self.collider setCheckForCollision:YES];
    
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    
    startPoint.x = translation.x;
    startPoint.y = translation.y;
    
    pointInBounds = NO; firstTile = NO; secondTile = NO; thirdTile = NO; stop = NO;
    
     tilesChecked = 0;
}

#pragma Mark -
#pragma Mark Game Loop Methods


-(void)update
{
    
    // move tile touchzone to new location.
    screenRect = [[SceneController sharedSceneController].inputController 
                  screenRectFromMeshRect:self.meshBounds 
                  atPoint:CGPointMake(translation.x, translation.y)];
    
    // check for touches 
    [self handleTouches];
    
    if (autoMoveSwitch) [self autoMove];
    
    [super update];
}

#pragma Mark -
#pragma Mark Touch Method

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
            singleTap = YES;
            
            startPoint = CGPointMake((touchPointB.x - 160), -(touchPointB.y - 240));
            
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
        
        if (CGRectContainsPoint(screenRect, touchPointM) && firstTile) {
            
            
            
            singleTap = NO;
            
            CGPoint point = CGPointMake((touchPointM.x - 160), - (touchPointM.y - 240));
            CGPoint firstDisance = CGPointMake((point.x + touchOffset.x) - translation.x, (point.y + touchOffset.y) - translation.y);
             NSLog(@"tile touched: %i",counter);
             NSLog(@"stop1: %i %i",self.stop, stop);
            if (!stop) {
                
                //(sqrtf((translation.x - startPoint.x) * (translation.x - startPoint.x)) < 75 || sqrtf((translation.y - startPoint.y) * (translation.y - startPoint.y)) < 75) && 
                
                moveCount +=1;
                
                //NSLog(@"%f, %f %f", firstDisance.x, firstDisance.y, (sqrtf(firstDisance.x * firstDisance.x) - sqrtf(firstDisance.y * firstDisance.y)));
            
                if ((sqrtf(firstDisance.x * firstDisance.x) - sqrtf(firstDisance.y * firstDisance.y)) > 0) {
                
                    if(moveCount <= 1) [[NSNotificationCenter defaultCenter] postNotificationName:@"whichWay" object:nil];
                
                }else{
                
                    if(moveCount <= 1) xWasBigger = NO;
                    
                }
                //NSLog(@"x was bigger: %i", xWasBigger);
                [self moveTile:point];
            }else {
                //get the new empty space.
                NSLog(@"Before %.1f, %.1f", emptyPosition.x, emptyPosition.y);
                emptyPosition = [[SceneController sharedSceneController] findTheEmptySpaceWithStarter:startPoint andLastSpace:emptyPosition];
                NSLog(@"After %.1f, %.1f", emptyPosition.x, emptyPosition.y);
            }
        }
    }
    //emptyPosition = [[SceneController sharedSceneController] findTheEmptySpace:startPoint default:emptyPosition];
}
#pragma Mark -
#pragma Mark Notification Methods


-(void)moveBegan{

    startPoint.x = translation.x;
    startPoint.y = translation.y;

}

-(void)stopMove{
    
    stop = YES;
}

-(void)moveXorY{
    xWasBigger = YES;
}

-(void)moveEnded{
    
    if (firstTile) {
        //get the new empty space.
        NSLog(@"Before %.1f, %.1f", emptyPosition.x, emptyPosition.y);
        emptyPosition = [[SceneController sharedSceneController] findTheEmptySpaceWithStarter:startPoint andLastSpace:emptyPosition];
        NSLog(@"After %.1f, %.1f", emptyPosition.x, emptyPosition.y);
    }
    
    firstTile = NO;
    secondTile = NO;
    thirdTile = NO;
    stop = NO;
    pointInBounds = NO;
    singleTap = NO;
    xWasBigger = NO;
    moveCount = 0;
    tilesChecked = 0;
    
    // If not fully moved jump to nearest x position.
    if (translation.x < -60.0) {
        translation.x = -105.0;
    }
    if (translation.x >= -80 && translation.x < -10.0) {
        translation.x = -35.0;
    }
    if (translation.x >= 0.0 && translation.x < 70) {
        translation.x = 35.0;
    }
    if (translation.x >= 70.0) {
        translation.x = 150.0;
    }
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
    
    totalDistance.x = 0.0;
    totalDistance.y = 0.0;
    
    endPoint = CGPointMake(translation.x, translation.y);
}



-(void)moveTile:(CGPoint)touchPoint{
   
    if (xWasBigger){
        if (sqrtf((translation.x - startPoint.x) * (translation.x - startPoint.x)) > 70) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
        }
        distanceX = (touchPoint.x + touchOffset.x) - translation.x;
        if (sqrtf(distanceX * distanceX) > kCutoffDistance) {
            distanceX = -(-distanceX/distanceX) * kMaxFingerSpeed;
        }
        translation.x += distanceX;
        
    }else{
        if (sqrtf((translation.y - startPoint.y) * (translation.y - startPoint.y)) > 70) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
        }
        distanceY = (touchPoint.y + touchOffset.y) - translation.y;
        if (distanceY > kCutoffDistance) {
            distanceY = (-distanceY/distanceY) * kMaxFingerSpeed;
        }
        translation.y += distanceY;
    }
    totalDistance.x += sqrtf(distanceX * distanceX);
    totalDistance.y += sqrtf(distanceY * distanceY);
}

#pragma Mark -
#pragma Mark Auto Move Method

-(void)autoMove{
    /*
    if (moveCount < 5 ) {
        NSLog(@"emptyx:%f, y: %f", emptyPosition.x, emptyPosition.y);
        
        CGPoint autoMovePoint = CGPointMake(translation.x, translation.y);
        
        NSLog(@"autox:%f, y: %f", autoMovePoint.x, autoMovePoint.y);
        
        
        if (translation.y == emptyPosition.y) {
            xWasBigger = YES;
            if (emptyPosition.x > translation.x) {
                autoMovePoint.x += kAutoMoveDistance;
            }else{
                autoMovePoint.x -= kAutoMoveDistance;
            }
            
        }
        
        if (translation.x == emptyPosition.x){
            xWasBigger = NO;
            if (emptyPosition.y > translation.y) {
                autoMovePoint.y += kAutoMoveDistance;
            }else{
                autoMovePoint.y -= kAutoMoveDistance;
            }
        }
        
        [self moveTile:autoMovePoint];
        
    }else {
        autoMoveSwitch = NO;
        singleTap = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    */
    moveCount += 1;
    
}

#pragma Mark -
#pragma Mark Collition Methods

- (void)didCollideWithY:(SceneObject *)sceneObject{
    NSLog(@"tiles321? %i,%i,%i",thirdTile, secondTile, firstTile);
    NSLog(@"sceneObjectTiles321? %i,%i,%i",sceneObject.thirdTile, sceneObject.secondTile, sceneObject.firstTile);
    NSLog(@"collidedY");
    if (emptyPosition.x != translation.x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    if (sceneObject.translation.y == translation.y) return;
    if (sqrtf((translation.y - (touchOffset.y + startPoint.y)) * (translation.y - (touchOffset.y + startPoint.y))) >= 70) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    if (firstTile){
        stop = sceneObject.stop;
        if (!sceneObject.secondTile){
            sceneObject.secondTile = YES;
            sceneObject.firstTile = NO;
            sceneObject.thirdTile = NO;
        }
        if (sceneObject.translation.y == 105.0) {
            translation.y = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 1");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        if (sceneObject.translation.y == -105.0) {
            translation.y = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 2");
            NSLog(@"stop!? %i",sceneObject.stop);
            NSLog(@"stop!? %i",stop);
        }
        
    }else if(secondTile){
        
        NSLog(@"secondTile");
        if (sceneObject.firstTile && !stop) {
            distanceY = sceneObject.distanceY;
            translation.y += (distanceY * (kSmoothingDistance + 0.2));
            
        }else if (!sceneObject.firstTile && !sceneObject.secondTile && !sceneObject.thirdTile) {
            sceneObject.thirdTile = YES;
        }
        
        if (sceneObject.translation.y == 105.0) {
            translation.y = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 4");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        if (sceneObject.translation.y == -105.0) {
            translation.y = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 5");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        self.stop = sceneObject.stop;
    }else if (thirdTile) {
        NSLog(@"3rdTiles321? %i,%i,%i",sceneObject.thirdTile, sceneObject.secondTile, sceneObject.firstTile);
        if (!sceneObject.secondTile) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 6");
            
        }
        if (sceneObject.secondTile && !stop) {
            distanceY = sceneObject.distanceY;
            translation.y += (distanceY * (kSmoothingDistance + 0.5));
            
        }
        if (sceneObject.translation.y == 105.0) {
            translation.y = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 7");
        }
        if (sceneObject.translation.y == -105.0) {
            translation.y = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 8");
        }
        
    }
}

- (void)didCollideWith:(SceneObject*)sceneObject 
{
    
    
    
    if (!xWasBigger) {
        [self didCollideWithY:sceneObject];
        return;
    }
    
    if (emptyPosition.y != translation.y) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    
    if (sceneObject.translation.x == translation.x) return;
    
    if (sqrtf((translation.x - (touchOffset.x + startPoint.x)) * (translation.x - (touchOffset.x + startPoint.x))) >= 70) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    
    NSLog(@"collidedx");
    //float distanceX = (outerTouchPoint.x + touchOffset.x) - translation.x;
    if (firstTile) {
        NSLog(@"firstTile");
        stop = sceneObject.stop;
        NSLog(@"Tiles321? %i,%i,%i",sceneObject.thirdTile, sceneObject.secondTile, sceneObject.firstTile);
        if (!sceneObject.secondTile && !sceneObject.thirdTile) {
            sceneObject.firstTile = NO;
            sceneObject.secondTile = YES;
            sceneObject.thirdTile = NO;
            NSLog(@"Tiles321? %i,%i,%i",sceneObject.thirdTile, sceneObject.secondTile, sceneObject.firstTile);
        }
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 1");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 2");
            NSLog(@"stop!? %i",sceneObject.stop);
            NSLog(@"stop!? %i",stop);
        }
    }else if(secondTile){
        
        NSLog(@"secondTile");
        if (sceneObject.firstTile && !stop) {
            distanceX = sceneObject.distanceX;
            translation.x += (distanceX * (kSmoothingDistance + 0.2));
            
        }else if (!sceneObject.firstTile && !sceneObject.secondTile && !sceneObject.thirdTile) {
            sceneObject.thirdTile = YES;
        }
        
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 4");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 5");
            NSLog(@"stop!? %i",sceneObject.stop);
        }
        self.stop = sceneObject.stop;
    }else if (thirdTile) {
        NSLog(@"Tiles321? %i,%i,%i",sceneObject.thirdTile, sceneObject.secondTile, sceneObject.firstTile);
        if (!sceneObject.secondTile) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 6");
            
        }else if (sceneObject.secondTile && !stop) {
            distanceX = sceneObject.distanceX;
            translation.x += distanceX * (kSmoothingDistance + 0.5);
            
        }
        if (sceneObject.translation.x == 105.0) {
            translation.x = 35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 7");
        }
        if (sceneObject.translation.x == -105.0) {
            translation.x = -35.0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
            NSLog(@"Should Stop 8");
        }
        
    }
}

@end
