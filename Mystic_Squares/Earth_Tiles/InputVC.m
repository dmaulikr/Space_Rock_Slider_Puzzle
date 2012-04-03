//
//  InputVC.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "InputVC.h"

@implementation InputVC

@synthesize beganTouchEvents, movedTouchEvents, endTouchEvents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// init our touch storage set
		beganTouchEvents = [[NSMutableSet alloc] init];
        movedTouchEvents = [[NSMutableSet alloc] init];
	}
	return self;
}

-(CGRect)screenRectFromMeshRect:(CGRect)rect atPoint:(CGPoint)meshCenter
{
	// find the point on the screen that is the center of the rectangle
	// and use that to build a screen-space rectangle
	CGPoint screenCenter = CGPointZero;
	CGPoint rectOrigin = CGPointZero;

    //Portrait Mode:
    
	screenCenter.x = meshCenter.x + 160.0; // need to shift it over
	screenCenter.y = -1*(meshCenter.y - 240.0); // need to shift it down and invert
	
	rectOrigin.x = screenCenter.x - (CGRectGetWidth(rect)/2.0);  
	rectOrigin.y = screenCenter.y - (CGRectGetHeight(rect)/2.0); 
    
    
    //Landscape Mode:
    // since our view is rotated, then our x and y are flipped
	//screenCenter.x = meshCenter.y + 160.0; // need to shift it over
	//screenCenter.y = meshCenter.x + 240.0; // need to shift it up
	
	//rectOrigin.x = screenCenter.x - (CGRectGetHeight(rect)/2.0); // height and width 
	//rectOrigin.y = screenCenter.y - (CGRectGetWidth(rect)/2.0); // are flipped
	return CGRectMake(rectOrigin.x, rectOrigin.y, CGRectGetWidth(rect), CGRectGetHeight(rect));
  
}



#pragma mark Touch Event Handlers

// just a handy way for other object to clear our events
- (void)clearEvents
{
	[beganTouchEvents removeAllObjects];
    [movedTouchEvents removeAllObjects];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// just store them all in the big set.
	[beganTouchEvents addObjectsFromArray:[touches allObjects]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"start" object:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// just store them all in the big set.
	[movedTouchEvents addObjectsFromArray:[touches allObjects]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[endTouchEvents addObjectsFromArray:[touches allObjects]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"end" object:nil]; 
    
	
}

#pragma mark unload, dealloc

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
