//
//  InputVC.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputVC : UIViewController {

    NSMutableSet* beganTouchEvents;
    NSMutableSet* movedTouchEvents;
    NSMutableSet* endTouchEvents;
}

@property (retain) NSMutableSet* beganTouchEvents;
@property (retain) NSMutableSet* movedTouchEvents;
@property (retain) NSMutableSet* endTouchEvents;

- (CGRect)screenRectFromMeshRect:(CGRect)rect atPoint:(CGPoint)meshCenter;
//- (BOOL)touchesDidBegin;
- (void)clearEvents;
- (void)dealloc ;
- (void)didReceiveMemoryWarning ;
//- (void)loadView ;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)viewDidUnload ;

@end
