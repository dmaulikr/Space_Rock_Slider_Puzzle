//
//  TextureQuad.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/8/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import "Mesh.h"
#import "MaterialController.h"

@interface TextureQuad : Mesh {
GLfloat * uvCoordinates;
NSString * materialKey;
}

@property (assign) GLfloat * uvCoordinates;
@property (retain) NSString * materialKey;
@end
