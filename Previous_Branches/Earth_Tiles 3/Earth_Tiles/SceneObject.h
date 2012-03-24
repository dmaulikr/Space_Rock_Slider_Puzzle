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
#import "MGPoint.h"
#import "Mesh.h"
#import "SceneController.h"
#import "InputVC.h"
#import "MGConfiguration.h"
#import "MaterialController.h"
#import "TextureQuad.h"

@class MGCollider;
@interface SceneObject : NSObject {
	// transform values
    MGPoint translation;
    MGPoint rotation;
    MGPoint scale;
	
	Mesh * mesh;
	
	BOOL active;
    
    CGFloat * matrix;
    
    CGRect meshBounds;
    
    MGCollider * collider;
}

@property (assign) CGRect meshBounds;
@property (retain) Mesh * mesh;
@property (retain) MGCollider * collider;
@property (assign) CGFloat * matrix;

@property (assign) MGPoint translation;
@property (assign) MGPoint rotation;
@property (assign) MGPoint scale;

@property (assign) BOOL active;

- (id) init;
- (void) dealloc;
- (void)awake;
- (void)render;
- (void)update;

@end
