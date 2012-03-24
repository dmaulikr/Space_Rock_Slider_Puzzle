//
//  InputVC.h
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputVC : UIViewController {

NSMutableSet* touchEvents;
}

@property (retain) NSMutableSet* touchEvents;

//- (BOOL)touchesDidBegin;
- (void)clearEvents;
- (void)dealloc ;
- (void)didReceiveMemoryWarning ;
//- (void)loadView ;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)viewDidUnload ;

@end
