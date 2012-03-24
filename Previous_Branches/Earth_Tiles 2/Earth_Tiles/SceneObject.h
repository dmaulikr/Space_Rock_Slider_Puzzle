//
//  SceneObject.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>

@class Mesh;

@interface SceneObject : NSObject {
	// transform values
	CGFloat x,y,z;
	CGFloat xRotation,yRotation,zRotation;
	CGFloat xScale,yScale,zScale;
	
	Mesh * mesh;
	
	BOOL active;
}

@property (assign) CGFloat x;
@property (assign) CGFloat y;
@property (assign) CGFloat z;

@property (assign) CGFloat xRotation;
@property (assign) CGFloat yRotation;
@property (assign) CGFloat zRotation;

@property (assign) CGFloat xScale;
@property (assign) CGFloat yScale;
@property (assign) CGFloat zScale;

@property (assign) BOOL active;

- (id) init;
- (void) dealloc;
- (void)awake;
- (void)render;
- (void)update;

@end
