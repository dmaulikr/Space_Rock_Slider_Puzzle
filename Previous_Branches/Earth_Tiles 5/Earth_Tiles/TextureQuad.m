//
//  TextureQuad.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextureQuad.h"

static CGFloat MGTexturedQuadVertexes[8] = {-0.5,-0.5, 0.5,-0.5, -0.5,0.5, 0.5,0.5};
static CGFloat MGTexturedQuadColorValues[16] = {1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0};

@implementation TextureQuad
@synthesize uvCoordinates,materialKey;

- (id) init
{
	self = [super initWithVertexes:MGTexturedQuadVertexes vertexCount:4 vertexSize:2 renderStyle:GL_TRIANGLE_STRIP];
	if (self != nil) {
		// 4 vertexes
		uvCoordinates = (CGFloat *) malloc(8 * sizeof(CGFloat));
		colors = MGTexturedQuadColorValues;
		colorSize = 4;
	}
	return self;
}


// called once every frame
-(void)render
{
	glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorSize, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);	
	
	if (materialKey != nil) {
		[[MaterialController sharedMaterialController] bindMaterial:materialKey];
        
		glEnableClientState(GL_TEXTURE_COORD_ARRAY); 
		glTexCoordPointer(2, GL_FLOAT, 0, uvCoordinates);
	} 
	//render
	glDrawArrays(renderStyle, 0, vertexCount);	
}



- (void) dealloc
{
	free(uvCoordinates);
	[super dealloc];
}
@end
