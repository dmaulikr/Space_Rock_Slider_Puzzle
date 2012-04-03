//
//  MaterialController.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "MGPoint.h"
#import "MGConfiguration.h"

@class TextureQuad;
@class AnimatedQuad;
@interface MaterialController : NSObject {
    NSMutableDictionary *materialLib;
    NSMutableDictionary * quadLibrary;
}

+ (MaterialController*)sharedMaterialController;

- (TextureQuad*)quadFromAtlasKey:(NSString*)atlasKey;
- (TextureQuad*)texturedQuadFromAtlasRecord:(NSDictionary*)record 
                                     atlasSize:(CGSize)atlasSize
                                   materialKey:(NSString*)key;
- (AnimatedQuad*)animationFromAtlasKeys:(NSArray*)atlasKeys;
- (CGSize)loadTextureImage:(NSString*)imageName materialKey:(NSString*)materialKey;
- (id) init;
- (void) dealloc;
- (void)bindMaterial:(NSString*)materialKey;
- (void)loadAtlasData:(NSString*)atlasName;

@end
