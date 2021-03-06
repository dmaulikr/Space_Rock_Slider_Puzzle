//
//  MGCollider.m
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "MGCollider.h"
#import "SceneObject.h"
#import "Mesh.h"


 static NSInteger MGVertStride = 2;
 static NSInteger MGColorStride = 4;
 static NSInteger MGOutlineVertCount = 4;
 static GLfloat squareVertices[8] = {
 -0.5f, -0.5f,
 0.5f,  -0.5f,
 0.5f,  0.5f,
 -0.5f,   0.5f,

 };
 
 static GLfloat squareColors[32] = {
 1.0,  0,   0, 1.0,
 1.0,  0,   0, 1.0,
 1.0,  0,   0, 1.0,
 1.0,  0,   0, 1.0,

 };
 

@implementation MGCollider

@synthesize checkForCollision,colliderRect;

+(MGCollider*)collider
{
	MGCollider * collider = [[MGCollider alloc] init];
	if (DEBUG_DRAW_COLLIDERS) {
		collider.active = YES;
		[collider awake];		
	}
    
	collider.checkForCollision = NO;
	return collider;	
}

-(void)updateCollider:(SceneObject*)sceneObject
{
	if (sceneObject == nil) return;
	transformedCenter = MGPointMatrixMultiply([sceneObject mesh].center , [sceneObject matrix]);
	translation = transformedCenter;
    
	//maxRadius = sceneObject.scale.x;
	//if (maxRadius <= sceneObject.scale.y) 	maxRadius = sceneObject.scale.y;
	//if ((maxRadius < sceneObject.scale.z) && ([sceneObject mesh].vertexSize > 2)) maxRadius = sceneObject.scale.z;//for 3D
    colliderRect = sceneObject.meshBounds;
    colliderRect.origin = CGPointMake(transformedCenter.x, transformedCenter.y);
    scale = MGPointMake(sceneObject.scale.x, sceneObject.scale.y,1.0);
    colliderRect.size = CGSizeMake((sceneObject.scale.x + 2.5), (sceneObject.scale.y + 2.5));
    
}

-(BOOL)doesCollideWithCollider:(MGCollider*)aCollider
{
    // just need to check the distance between our two points and 
	// our radius
    // used for abnormally shaped SceneObjects 
    // we only have squares so proceed to doesCollideWithMesh
    
	//CGFloat collisionDistance = self.maxRadius + aCollider.maxRadius;
	//CGFloat objectDistance = MGPointDistance(self.translation, aCollider.translation);
    if (!CGRectEqualToRect(self.colliderRect, aCollider.colliderRect)) {
        if (CGRectIntersectsRect(self.colliderRect, aCollider.colliderRect))return YES;
    }
    return NO;
}

- (BOOL)doesCollideWithMesh:(SceneObject*)sceneObject{
    NSInteger index;
	// step through each vertex of the scene object
	// transform it into real space coordinates
	// and check it against our radius
	for (index = 0; index < sceneObject.mesh.vertexCount; index++) {
		NSInteger position = index * sceneObject.mesh.vertexSize;
		MGPoint vert;
        CGPoint simpleVert;
        
		if (sceneObject.mesh.vertexSize > 2) {
			vert = MGPointMake(sceneObject.mesh.vertexes[position], sceneObject.mesh.vertexes[position + 1], sceneObject.mesh.vertexes[position + 2]);
            
		} else {
			vert = MGPointMake(sceneObject.mesh.vertexes[position], sceneObject.mesh.vertexes[position + 1], 0.0);

		}
		vert = MGPointMatrixMultiply(vert, [sceneObject matrix]);
                
        simpleVert = CGPointMake(vert.x, vert.y);//for 2D
        
        if(CGRectContainsPoint(colliderRect, simpleVert)) return YES;
        
		//CGFloat distance = MGPointDistance(self.translation, vert);
		//if (distance < self.maxRadius) return YES;
	}
	return NO;
}

#pragma mark Scene Object methods for debugging;

-(void)awake
{
	mesh = [[Mesh alloc] initWithVertexes:squareVertices 
                                vertexCount:MGOutlineVertCount 
                               vertexSize:MGVertStride
                                renderStyle:GL_LINE_LOOP];
	mesh.colors = squareColors;
	mesh.colorSize = MGColorStride;
    
}


-(void)render
{
	if (!mesh || !active) return; // if we do not have a mesh, no need to render
	// clear the matrix
	glPushMatrix();
	glLoadIdentity();
	glTranslatef(translation.x, translation.y, translation.z);
	glScalef(scale.x, scale.y, scale.z);
	[mesh render];	
	glPopMatrix();
}



@end
