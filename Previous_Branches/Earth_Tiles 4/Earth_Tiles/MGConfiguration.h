//
//  MGConfiguration.h
//  Tetrabots
//
//  Created by Michael Golden on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))

// for debugging
#define DEBUG_DRAW_COLLIDERS 0

// a handy constant to keep around
#define MGRADIANS_TO_DEGREES 57.2958

// material import settings
#define MG_CONVERT_TO_4444 0