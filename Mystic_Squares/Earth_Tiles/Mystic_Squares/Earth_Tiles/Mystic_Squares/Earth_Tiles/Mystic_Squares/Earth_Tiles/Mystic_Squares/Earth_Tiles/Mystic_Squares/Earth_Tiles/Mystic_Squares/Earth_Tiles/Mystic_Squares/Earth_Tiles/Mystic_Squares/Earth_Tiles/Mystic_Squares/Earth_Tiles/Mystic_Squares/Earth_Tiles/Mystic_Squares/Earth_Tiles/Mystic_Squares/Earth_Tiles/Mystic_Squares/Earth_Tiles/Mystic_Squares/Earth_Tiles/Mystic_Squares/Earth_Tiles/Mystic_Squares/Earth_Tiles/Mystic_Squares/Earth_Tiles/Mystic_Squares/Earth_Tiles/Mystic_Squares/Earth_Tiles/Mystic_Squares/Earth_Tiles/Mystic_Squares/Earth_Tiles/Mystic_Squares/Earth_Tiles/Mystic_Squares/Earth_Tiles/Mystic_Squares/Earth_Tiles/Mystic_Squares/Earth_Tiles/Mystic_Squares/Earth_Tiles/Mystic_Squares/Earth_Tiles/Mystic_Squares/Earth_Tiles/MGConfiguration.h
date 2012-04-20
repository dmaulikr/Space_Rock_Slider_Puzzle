//
//  MGConfiguration.h
//  Tetrabots
//
//  Created by Michael Golden on 10/4/11.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
#define kSmoothingDistance 1
#define kCutoffDistance 100.0
#define kMaxFingerSpeed 30.0
#define kAutoMoveDistance 3.0