//
//  SceneObject.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
    
    NSInteger counter;
    
    CGPoint outerTouchPoint;
    CGPoint touchOffset;
    CGPoint emptyPosition;
   
    BOOL firstTile;
    BOOL secondTile;
    BOOL thirdTile;
    BOOL singleTap;
    BOOL autoMoveSwitch;
    BOOL stop;
    float distanceX;
    float distanceY;
    
    NSString *witchMove;
}


@property (assign) CGRect meshBounds;
@property (strong) Mesh * mesh;
@property (strong) MGCollider * collider;
@property (assign) CGFloat * matrix;

@property (assign) MGPoint translation;
@property (assign) MGPoint rotation;
@property (assign) MGPoint scale;

@property (assign) NSInteger counter;
@property (assign) CGPoint outerTouchPoint;
@property (assign) CGPoint touchOffset;
@property (assign) CGPoint emptyPosition;

@property (assign) BOOL active;
@property (assign) BOOL firstTile;
@property (assign) BOOL secondTile;
@property (assign) BOOL thirdTile;
@property (assign) BOOL singleTap;
@property (assign) BOOL autoMoveSwitch;
@property (assign) BOOL stop;
@property (assign) float distanceX;
@property (assign) float distanceY;
@property(nonatomic, strong) NSString *witchMove;

- (id) init;
- (void) dealloc;
- (void)awake;
- (void)render;
- (void)update;
- (void)didCollideWith:(SceneObject*)sceneObject;

@end
