//
//  MGCollider.m
//  Tetrabots
//
//  Created by Michael Golden on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGCollider.h"
#import "SceneObject.h"
#import "Mesh.h"


#pragma mark circle mesh
static NSInteger MGCircleVertexStride = 2;
static NSInteger MGCircleColorStride = 4;

static NSInteger MGCircleOutlineVertexesCount = 20;
static CGFloat MGCircleOutlineVertexes[40] = {1.0000,0.0000,0.9511,0.3090,0.8090,0.5878,0.5878,0.8090,0.3090,0.9511,0.0000,1.0000,-0.3090,0.9511,-0.5878,0.8090,-0.8090,0.5878,-0.9511,0.3090,-1.0000,0.0000,-0.9511,-0.3090,-0.8090,-0.5878,-0.5878,-0.8090,-0.3090,-0.9511,-0.0000,-1.0000,0.3090,-0.9511,0.5878,-0.8090,0.8090,-0.5878,0.9511,-0.3090};

static CGFloat MGCircleColorValues[80] = 
{   1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 
    1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 
    1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 
    1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 
    1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0, 1.0,0.0,0.0,1.0} ;



@implementation MGCollider

@synthesize checkForCollision,maxRadius;

+(MGCollider*)collider
{
	MGCollider * collider = [[MGCollider alloc] init];
	if (DEBUG_DRAW_COLLIDERS) {
		collider.active = YES;
		[collider awake];		
	}
	collider.checkForCollision = NO;
	return [collider autorelease];	
}

-(void)updateCollider:(SceneObject*)sceneObject
{
	if (sceneObject == nil) return;
	
}

-(BOOL)doesCollideWithCollider:(MGCollider*)aCollider
{
    // just need to check the distance between our two points and 
	// our radius
	CGFloat collisionDistance = self.maxRadius + aCollider.maxRadius;
	CGFloat objectDistance = MGPointDistance(self.translation, aCollider.translation);
	if (objectDistance < collisionDistance) return YES;
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
		if (sceneObject.mesh.vertexSize > 2) {
			vert = MGPointMake(sceneObject.mesh.vertexes[position], sceneObject.mesh.vertexes[position + 1], sceneObject.mesh.vertexes[position + 2]);		
		} else {
			vert = MGPointMake(sceneObject.mesh.vertexes[position], sceneObject.mesh.vertexes[position + 1], 0.0);
		}
		vert = MGPointMatrixMultiply(vert , [sceneObject matrix]);
		CGFloat distance = MGPointDistance(self.translation, vert);
		if (distance < self.maxRadius) return YES;
	}
	return NO;
}

#pragma mark Scene Object methods for debugging;

-(void)awake
{
	mesh = [[Mesh alloc] initWithVertexes:MGCircleOutlineVertexes 
                                vertexCount:MGCircleOutlineVertexesCount 
                               vertexSize:MGCircleVertexStride
                                renderStyle:GL_LINE_LOOP];
	mesh.colors = MGCircleColorValues;
	mesh.colorSize = MGCircleColorStride;
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

-(void)dealloc{
    
    [super dealloc];
}


@end
