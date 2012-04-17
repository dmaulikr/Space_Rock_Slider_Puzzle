//
//  Tile.h
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
#import "MGMobileObject.h"

@interface Tile : MGMobileObject {
    
    CGFloat *verts;
    
    CGFloat *colors;
    
    CGRect screenRect;
    
    CGPoint startPoint;
    
    CGPoint endPoint;
    
    NSInteger moveCount;
    NSInteger tilesChecked;
    
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
    
    CGPoint totalDistance;
   
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
@property(assign) CGPoint totalDistance;
@property(assign) CGPoint endPoint;

+ (Tile*)makeTileNumber:(NSInteger)count;

- (void)handleTouches;

- (void)moveTile:(CGPoint)touchPoint;

- (void)stopMove;

- (void)moveBegan;

- (void)autoMove;

- (void)moveXorY;

- (void)moveEnded;

@end
