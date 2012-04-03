//
//  Mesh.h
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

@interface Mesh : NSObject {
// mesh data
    GLfloat * vertexes;
    GLfloat * colors;

    GLenum renderStyle;
    NSInteger vertexCount;
    NSInteger vertexSize;
    NSInteger colorSize;	
    MGPoint center;
    CGFloat radius;
}

@property (assign) NSInteger vertexCount;
@property (assign) NSInteger vertexSize;
@property (assign) NSInteger colorSize;
@property (assign) GLenum renderStyle;

@property (assign) MGPoint center;

@property (assign) GLfloat * vertexes;
@property (assign) GLfloat * colors;

- (id)initWithVertexes:(CGFloat*)verts vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style;

-(void)render;

+(CGRect)meshBounds:(Mesh*)mesh scale:(MGPoint)scale;
-(MGPoint)calculateCenter;

@end
