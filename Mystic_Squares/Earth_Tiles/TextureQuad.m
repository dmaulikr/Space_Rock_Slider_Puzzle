//
//  TextureQuad.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/8/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
