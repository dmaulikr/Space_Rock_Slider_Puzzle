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

// initial position string
//#define kInitialPositions @"0123456789ABCDEF"
#define kInitialPositions @"FE1B9065D2CA7834"
// allowable tile disance per move
#define kSmoothingDistance 0
#define kCutoffDistance 90.0
#define kMaxFingerSpeed 20.0