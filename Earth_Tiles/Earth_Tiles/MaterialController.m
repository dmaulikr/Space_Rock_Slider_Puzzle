//
//  MaterialController.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MaterialController.h"
#import "TextureQuad.h"
#import "AnimatedQuad.h"

@implementation MaterialController
// Singleton accessor.  this is how you should ALWAYS get a reference
// to the controller.  Never init your own. 
+(MaterialController*)sharedMaterialController
{
    static MaterialController *sharedMaterialController;
    @synchronized(self)
    {
        if (!sharedMaterialController)
            sharedMaterialController = [[MaterialController alloc] init];
		
        return sharedMaterialController;
    }
	return sharedMaterialController;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self loadAtlasData:@"SpaceRockAtlas"];
	}
	return self;
}

-(void)loadAtlasData:(NSString*)atlasName
{
	@autoreleasepool {	
		if (quadLibrary == nil) quadLibrary = [[NSMutableDictionary alloc] init];
		
		CGSize atlasSize = [self loadTextureImage:[atlasName stringByAppendingPathExtension:@"png"] materialKey:atlasName];
    
		NSArray * itemData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:atlasName ofType:@"plist"]];
		
		for (NSDictionary * record in itemData) {
			TextureQuad * quad = [self texturedQuadFromAtlasRecord:record atlasSize:atlasSize materialKey:atlasName];
			[quadLibrary setObject:quad forKey:[record objectForKey:@"name"]];
		}
		[self bindMaterial:atlasName];
	}
}

-(TextureQuad*)quadFromAtlasKey:(NSString*)atlasKey
{
	return [quadLibrary objectForKey:atlasKey];
}

-(AnimatedQuad*)animationFromAtlasKeys:(NSArray*)atlasKeys
{
	AnimatedQuad * animation = [[AnimatedQuad alloc] init];
	for (NSString * key in atlasKeys) {
		[animation addFrame:[self quadFromAtlasKey:key]];
	}
	return animation;
}

-(TextureQuad*)texturedQuadFromAtlasRecord:(NSDictionary*)record 
                                    atlasSize:(CGSize)atlasSize
                                  materialKey:(NSString*)key;
{
	TextureQuad * quad = [[TextureQuad alloc] init];
	
	GLfloat xLocation = [[record objectForKey:@"xLocation"] floatValue];
	GLfloat yLocation = [[record objectForKey:@"yLocation"] floatValue];
	GLfloat width = [[record objectForKey:@"width"] floatValue];
	GLfloat height = [[record objectForKey:@"height"] floatValue];
	
	// find the normalized texture coordinates
	GLfloat uMin = xLocation/atlasSize.width;
	GLfloat vMin = yLocation/atlasSize.height;
	GLfloat uMax = (xLocation + width)/atlasSize.width;
	GLfloat vMax = (yLocation + height)/atlasSize.height;
	
	
	quad.uvCoordinates[0] = uMin;
	quad.uvCoordinates[1] = vMax;
	
	quad.uvCoordinates[2] = uMax;
	quad.uvCoordinates[3] = vMax;
	
	quad.uvCoordinates[4] = uMin;
	quad.uvCoordinates[5] = vMin;
    
	quad.uvCoordinates[6] = uMax;
	quad.uvCoordinates[7] = vMin;
	
	quad.materialKey = key;
	
	return quad;
}

// grabs the openGL texture ID from the library and calls the openGL bind texture method
-(void)bindMaterial:(NSString*)materialKey
{
	NSNumber * numberObj = [materialLib objectForKey:materialKey];
	if (numberObj == nil) return;
	GLuint textureID = [numberObj unsignedIntValue];
	
    glEnable(GL_TEXTURE_2D); 
	glBindTexture(GL_TEXTURE_2D, textureID);
}

// does the heavy lifting for getting a named image into a texture
// that is loaded into openGL
// this is a modified version of the way Apple loads textures in their sample code
-(CGSize)loadTextureImage:(NSString*)imageName materialKey:(NSString*)materialKey
{
	CGContextRef spriteContext; //context ref for the UIImage
	GLubyte *spriteData; // a temporary buffer to hold our image data
	size_t	width, height;
	GLuint textureID; // the ultimate ID for this texture
	// grab the image off the file system, jam it into a CGImageRef
	
	UIImage*	uiImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
	CGImageRef spriteImage = [uiImage CGImage];
	// Get the width and height of the image
	width = CGImageGetWidth(spriteImage);
	height = CGImageGetHeight(spriteImage);
	
	CGSize imageSize = CGSizeMake(width, height);
	// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
	// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
	
	if (spriteImage) {
		// Allocated memory needed for the bitmap context
		spriteData = (GLubyte *) malloc(width * height * 4);
		memset(spriteData, 0, (width * height * 4)); 
		// Uses the bitmap creation function provided by the Core Graphics framework. 
		spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
		// After you create the context, you can draw the sprite image to the context.
		CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), spriteImage);
		// You don't need the context at this point, so you need to release it to avoid memory leaks.
		CGContextRelease(spriteContext);
		
		// Use OpenGL ES to generate a name for the texture.
		glGenTextures(1, &textureID);
		// Bind the texture name. 
		glBindTexture(GL_TEXTURE_2D, textureID);
		// Specidfy a 2D texture image, provideing the a pointer to the image data in memory
		
		//Convert "RRRRRRRRRGGGGGGGGBBBBBBBBAAAAAAAA" to "RRRRRGGGGBBBBAAAA"
		// this will make your images take up half as much space in memory
		// but you will lose half of your color depth.
		if (MG_CONVERT_TO_4444) {
			void*					tempData;
			unsigned int*			inPixel32;
			unsigned short*			outPixel16;
			
			tempData = malloc(height * width * 2);
			
			inPixel32 = (unsigned int*)spriteData;
			outPixel16 = (unsigned short*)tempData;
			NSUInteger i;
			for(i = 0; i < width * height; ++i, ++inPixel32)
				*outPixel16++ = ((((*inPixel32 >> 0) & 0xFF) >> 4) << 12) | ((((*inPixel32 >> 8) & 0xFF) >> 4) << 8) | ((((*inPixel32 >> 16) & 0xFF) >> 4) << 4) | ((((*inPixel32 >> 24) & 0xFF) >> 4) << 0);
			
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_SHORT_4_4_4_4, tempData);
			free(tempData);
		} else {
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);			
		}
		
		free(spriteData);
		// Release the image data
		// Set the texture parameters to use a minifying filter and a linear filer (weighted average)
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		
		// Enable use of the texture
		glEnable(GL_TEXTURE_2D);
		// Set a blending function to use
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		// Enable blending
		glEnable(GL_BLEND);
	} else {
		return CGSizeZero;
	}
	
	if (materialLib == nil) materialLib = [[NSMutableDictionary alloc] init];
	
	// now put the texture ID into the library
	[materialLib setObject:[NSNumber numberWithUnsignedInt:textureID] forKey:materialKey];
	return imageSize;
}





@end
