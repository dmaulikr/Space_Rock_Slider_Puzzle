//
//  AnimatedQuad.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnimatedQuad.h"
#import "SceneController.h"

@implementation AnimatedQuad
@synthesize speed,loops,didFinish;
- (id) init
{
	self = [super init];
	if (self != nil) {
		self.speed = 12; // 12 fps
		self.loops = NO;
		self.didFinish = NO;
		elapsedTime = 0.0;
	}
	return self;
}

-(void)addFrame:(TextureQuad*)aQuad
{
	if (frameQuads == nil) frameQuads = [[NSMutableArray alloc] init];
	[frameQuads addObject:aQuad];
}

-(void)updateAnimation
{
	elapsedTime += [SceneController sharedSceneController].deltaTime;
	NSInteger frame = (int)(elapsedTime/(1.0/speed));
	if (loops) frame = frame % [frameQuads count];
	if (frame >= [frameQuads count]) {
		didFinish = YES;
		return;
	}
	[self setFrame:[frameQuads objectAtIndex:frame]];
}

-(void)setFrame:(TextureQuad*)quad
{
	self.uvCoordinates = quad.uvCoordinates;
	self.materialKey = quad.materialKey;
}

- (void) dealloc
{
	uvCoordinates = 0;
	[super dealloc];
}

@end
