//
//  MGViewController.m
//  Earth_Tiles
//
//  Created by Michael Golden on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGViewController.h"
#import "SceneController.h"
#import "InputVC.h"
#import "EAGLView.h"

@interface MGViewController ()

@end

@implementation MGViewController
@synthesize puzzleView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    
    SceneController * sceneController = [SceneController sharedSceneController];
	
	// make a new input view controller, and save it as an instance variable
	InputVC * anInputController = [[InputVC alloc] initWithNibName:nil bundle:nil];
	sceneController.inputController = anInputController;
	[anInputController release];
    
    EAGLView * glView = [[EAGLView alloc] initWithFrame:puzzleView.bounds];
	sceneController.inputController.view = glView;
	sceneController.openGLView = glView;
	[glView release];

    [puzzleView addSubview:sceneController.inputController.view];
    
    // begin the game.
	[sceneController loadScene];
	[sceneController startScene];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
