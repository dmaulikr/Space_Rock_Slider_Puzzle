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
    
    if (translation.x >= 105.5) {
        translation.x = 105.0;
        speed.x = 0;
    }
    if (translation.x <= -105.5) {
        translation.x = -105.0;
        speed.x = 0;
    }
    if (translation.y >= 105.5) {
        translation.y = 105.0;
        speed.y = 0;
    }
    if (translation.y <= -105.5){
        translation.y = -105.0;
        speed.y = 0;
    }
    
}

@end
