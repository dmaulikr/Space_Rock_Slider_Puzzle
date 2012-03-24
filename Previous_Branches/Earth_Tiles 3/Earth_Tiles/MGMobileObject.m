//
//  MGMobileObject.m
//  Tetrabots
//
//  Created by Michael Golden on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"


@implementation MGMobileObject
@synthesize speed, rotationalSpeed;

-(void)update{
    
    [self checkArenaBounds];
    [super update];
    
}

-(void)checkArenaBounds{
    /*
    if (translation.x >= 225.2) {
        translation.x = 225.0;
        speed.x = (speed.x * -1.0);
    }
    if (translation.x <= -225.2) {
        translation.x = -225.0;
        speed.x = (speed.x * -1.0);
    }
    if (translation.y >= 145.2) {
        translation.y = 145.0;
        speed.y = (speed.y * -1.0);
    }
    if (translation.y <= -145.2){
        translation.y = -145.0;
        speed.y = (speed.y * -1.0);
    }
   */ 
}

@end
