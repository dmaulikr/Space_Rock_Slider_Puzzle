//
//  MGMobileObject.h
//  Tetrabots
//
//  Created by Michael Golden on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SceneObject.h"

@interface MGMobileObject : SceneObject {
    MGPoint speed;
    MGPoint rotationalSpeed;
}

@property (assign) MGPoint speed;
@property (assign) MGPoint rotationalSpeed;
-(void)checkArenaBounds;
@end
