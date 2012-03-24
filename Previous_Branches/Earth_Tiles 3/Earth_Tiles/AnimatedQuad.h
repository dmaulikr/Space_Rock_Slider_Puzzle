//
//  AnimatedQuad.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextureQuad.h"

@interface AnimatedQuad : TextureQuad{
	NSMutableArray * frameQuads;
	CGFloat speed;
	NSTimeInterval elapsedTime;
	BOOL loops;
	BOOL didFinish;
}

@property (assign) CGFloat speed;
@property (assign) BOOL loops;
@property (assign) BOOL didFinish;

- (id) init;
- (void) dealloc;
- (void)addFrame:(TextureQuad*)aQuad;
- (void)setFrame:(TextureQuad*)quad;
- (void)updateAnimation;
@end
