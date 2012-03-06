//
//  Tile.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMobileObject.h"

@interface Tile : MGMobileObject {
    
    CGFloat *verts;
    
    CGFloat *colors;
    
    CGRect screenRect;
    
    CGPoint startPoint;
    
    NSInteger moveCount;
    BOOL pointInBounds;
    BOOL xWasBigger;
    BOOL autoMoveSwitch;
    
    
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGPoint p4;
    CGPoint p5;
    CGPoint p6;
    CGPoint p7;
    CGPoint p8;
    CGPoint p9;
    CGPoint pA;
    CGPoint pB;
    CGPoint pC;
    CGPoint pD;
    CGPoint pE;
    CGPoint pF;
   
}

@property(assign) CGPoint startPoint;

@property(assign) CGPoint p0;
@property(assign) CGPoint p1;
@property(assign) CGPoint p2;
@property(assign) CGPoint p3;
@property(assign) CGPoint p4;
@property(assign) CGPoint p5;
@property(assign) CGPoint p6;
@property(assign) CGPoint p7;
@property(assign) CGPoint p8;
@property(assign) CGPoint p9;
@property(assign) CGPoint pA;
@property(assign) CGPoint pB;
@property(assign) CGPoint pC;
@property(assign) CGPoint pD;
@property(assign) CGPoint pE;
@property(assign) CGPoint pF;


+(Tile*)makeTileNumber:(NSInteger)count;

-(void)handleTouches;

-(void)moveTile:(CGPoint)touchPoint;

-(void)stopMove;

-(void)moveBegan;

-(void)autoMove;

-(void)emptySpacePermutation:(CGPoint)emptySpace;

-(void)getEmptyPosition:(NSNotification*)notification;

-(void)moveXorY;

-(void)moveEnded;

@end
