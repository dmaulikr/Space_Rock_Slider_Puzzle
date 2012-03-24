//
//  Tile.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"
#import "MGCollider.h"
#pragma mark Square mesh


/*
static NSInteger MGVertStride = 2;
static NSInteger MGColorStride = 4;
static NSInteger MGOutlineVertCount = 4;
static GLfloat squareVertices[8] = {
    -0.5f, -0.5f,
    0.5f,  -0.5f,
    -0.5f,  0.5f,
    0.5f,   0.5f,
};

static GLfloat squareColors[16] = {
    1.0, 1.0,   0, 1.0,
    0,   1.0, 1.0, 1.0,
    0,     0,   0,   0,
    1.0,   0, 1.0, 1.0,
};
*/

static NSInteger tileVertexSize = 2;
static NSInteger tileColorSize = 4;
static GLfloat positionMatrix[32] = {
    105.0, 105.0,
    35.0,  105.0,
    -35.0, 105.0,
    -105.0, 105.0,
    
    105.0, 35.0,
    35.0,  35.0,
    -35.0, 35.0,
    -105.0, 35.0,
    
    105.0, -35.0,
    35.0,  -35.0,
    -35.0, -35.0,
    -105.0, -35.0,
    
    105.0, -105.0,
    35.0,  -105.0,
    -35.0, -105.0,
    -105.0, -105.0,
};
@implementation Tile
@synthesize counter;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
	}
    
	return self;
}

+(Tile*)makeTileNumber:(NSInteger)count{
    
    Tile *tile = [[Tile alloc] init];
    NSLog(@"TileNumber:%i", count);
    CGFloat scale = 69.0;
	tile.scale = MGPointMake(scale, scale, 1.0);
    NSInteger a;
    NSInteger b;
    count += 1;
    tile.counter = count;
    a = (count + (count -1));
    b = 2 * count;
    
    //NSLog(@"MatrixNumber:%i, %i", a, b);
    
    GLfloat x = positionMatrix[a-1];
	GLfloat y = positionMatrix[b-1];
    //NSLog(@"Position:%f, %f", x, y);
	tile.translation = MGPointMake(x, y, 0.0);
	return [tile autorelease];
    
}

-(void)awake{
    NSString *atlasKey = [[NSString alloc] initWithFormat:@"square%i",counter];
    NSLog(@"%@",atlasKey);
    mesh = [[MaterialController sharedMaterialController] quadFromAtlasKey:atlasKey];
    
    verts = (CGFloat *) malloc(4 * tileVertexSize * sizeof(CGFloat));
    
    self.collider = [MGCollider collider];
    //[self.collider setCheckForCollision:YES];
}

-(void)update
{
    [super update];
    
    
}

- (void)didCollideWith:(SceneObject*)sceneObject; 
{
    //MGPoint location = MGPointMake(translation.x, translation.y, translation.z);
	// if we did not hit a tile, then get out early
	if (![sceneObject isKindOfClass:[Tile class]]) return;
	// just to make sure we hit it.
	if (![sceneObject.collider doesCollideWithMesh:self]) return;
	// we did hit a tile. Move the tiles.
	//[(MGBe9Cell*)sceneObject bounceVector:location];
	
}
@end
