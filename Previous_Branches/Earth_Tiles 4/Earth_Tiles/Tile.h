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
    
    
    
}


+ (Tile*)makeTileNumber:(NSInteger)count;

- (void)handleTouches;
-(void)moveTile:(CGPoint)touchPoint;
-(void)touchEndedX;
@end
