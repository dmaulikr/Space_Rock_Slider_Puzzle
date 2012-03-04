//
//  Point.h
//  Tetrabots
//
//  Created by Michael Golden on 9/17/11.
//  Copyright 2011 NoRoBoStudios. All rights reserved.
//

// A 3D point
typedef struct {
	CGFloat			x, y, z;
} MGPoint;

typedef MGPoint* MGPointPtr;

static inline MGPoint MGPointMake(CGFloat x, CGFloat y, CGFloat z)
{
    return (MGPoint){x, y, z};
    
}

static inline NSString * MGStringFromMGPoint(MGPoint p)
{
	return [NSString stringWithFormat:@"{%3.2f, %3.2f, %3.2f}",p.x,p.y,p.z];
}

static inline NSString * NSStringFromMatrix(CGFloat * m)
{
	return [NSString stringWithFormat:@"%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n",m[0],m[4],m[8],m[12],m[1],m[5],m[9],m[13],m[2],m[6],m[10],m[14],m[3],m[7],m[11],m[15]];
}

static inline MGPoint MGPointMatrixMultiply(MGPoint p, CGFloat* m)
{
	CGFloat x = (p.x*m[0]) + (p.y*m[4]) + (p.z*m[8]) + m[12];
	CGFloat y = (p.x*m[1]) + (p.y*m[5]) + (p.z*m[9]) + m[13];
	CGFloat z = (p.x*m[2]) + (p.y*m[6]) + (p.z*m[10]) + m[14];
	
	return (MGPoint) {x, y, z};
}

static inline float MGPointDistance(MGPoint p1, MGPoint p2)
{
	return sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + 
                ((p1.y - p2.y)  * (p1.y - p2.y)) + 
                ((p1.z - p2.z) * (p1.z - p2.z)));
}
static inline float CGPointDistance(CGPoint p1, CGPoint p2)
{
	return sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + 
                ((p1.y - p2.y)  * (p1.y - p2.y)));
}