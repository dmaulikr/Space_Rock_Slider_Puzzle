//
//  Mesh.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh
@synthesize vertexCount,vertexSize,colorSize,renderStyle,vertexes,colors;

- (id)initWithVertexes:(CGFloat*)verts 
           vertexCount:(NSInteger)vertCount 
            vertexSize:(NSInteger)vertSize
           renderStyle:(GLenum)style;
{
	self = [super init];
	if (self != nil) {
		self.vertexes = verts;
		self.vertexCount = vertCount;
		self.vertexSize = vertSize;
		self.renderStyle = style;
	}
	return self;
}

// called once every frame
-(void)render
{
	// load arrays into the engine
	glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorSize, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);
	
	//render
	glDrawArrays(renderStyle, 0, vertexCount);	
}


- (void) dealloc
{
	[super dealloc];
}
@end
