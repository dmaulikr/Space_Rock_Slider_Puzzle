//
//  Mesh.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh
@synthesize vertexCount,vertexSize,colorSize,renderStyle,vertexes,colors,center;

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
        self.center = [self calculateCenter];
	}
	return self;
}

-(MGPoint)calculateCenter
{
	CGFloat xTotal = 0;
	CGFloat yTotal = 0;
	CGFloat zTotal = 0;
	NSInteger index;
	// step through each vertex and add them all up
	for (index = 0; index < vertexCount; index++) {
		NSInteger position = index * vertexSize;
		xTotal += vertexes[position];
		yTotal += vertexes[position + 1];
		if (vertexSize > 2) zTotal += vertexes[position + 2];
	}
	// now average each total over the number of vertexes
	return MGPointMake(xTotal/(CGFloat)vertexCount, yTotal/(CGFloat)vertexCount, zTotal/(CGFloat)vertexCount);
}


// called once every frame
-(void)render
{
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_TEXTURE_2D);
	// load arrays into the engine
	glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorSize, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);
	
	//render
	glDrawArrays(renderStyle, 0, vertexCount);	
}

+(CGRect)meshBounds:(Mesh*)mesh scale:(MGPoint)scale
{
	if (mesh == nil) return CGRectZero;
	// need to run through the vertexes and find the extremes
	if (mesh.vertexCount < 2) return CGRectZero;
	CGFloat xMin,yMin,xMax,yMax;
	xMin = xMax = mesh.vertexes[0];
	yMin = yMax = mesh.vertexes[1];
	NSInteger index;
	for (index = 0; index < mesh.vertexCount; index++) {
		NSInteger position = index * mesh.vertexSize;
		if (xMin > mesh.vertexes[position] * scale.x) xMin = mesh.vertexes[position] * scale.x;
		if (xMax < mesh.vertexes[position] * scale.x) xMax = mesh.vertexes[position] * scale.x;
		if (yMin > mesh.vertexes[position + 1] * scale.y) yMin = mesh.vertexes[position + 1] * scale.y;
		if (yMax < mesh.vertexes[position + 1] * scale.y) yMax = mesh.vertexes[position + 1] * scale.y;
	}
	CGRect meshBounds = CGRectMake(xMin, yMin, xMax - xMin, yMax - yMin);
	if (CGRectGetWidth(meshBounds) < 1.0) meshBounds.size.width = 1.0;
	if (CGRectGetHeight(meshBounds) < 1.0) meshBounds.size.height = 1.0;
	return meshBounds;
}

- (void) dealloc
{
	[super dealloc];
}
@end
