//
//  MGAppDelegate.m
//  Earth_Tiles
//
//  Created by Michael Golden on 2/7/12.
//  Copyright (c) 2012 Norobo_Studios. All rights reserved.
//

#import "MGAppDelegate.h"
#import "InputVC.h"
#import "SceneController.h"
#import "EAGLView.h"


@implementation MGAppDelegate

@synthesize window;

- (void)dealloc
{
    [window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
	SceneController * sceneController = [SceneController sharedSceneController];
	
	// make a new input view controller, and save it as an instance variable
	InputVC * anInputController = [[InputVC alloc] initWithNibName:nil bundle:nil];
	sceneController.inputController = anInputController;
	[anInputController release];
	
	// init our main EAGLView with the same bounds as the window
	EAGLView * glView = [[EAGLView alloc] initWithFrame:window.bounds];
	sceneController.inputController.view = glView;
	sceneController.openGLView = glView;
	[glView release];
	
	// set our view as the first window view
	[window addSubview:sceneController.inputController.view];
	[window makeKeyAndVisible];
	
	// begin the game.
	[sceneController loadScene];
	[sceneController startScene];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
