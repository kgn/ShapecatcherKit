//
//  SKAppDelegate.m
//  ShapecatcherKitTest
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "SKAppDelegate.h"
#import <ShapecatcherKit/ShapecatcherKit.h>
#import "ShapecatcherKitTestApiKey.h" // contains my api key that is not included in this project

@implementation SKAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [[ShapecatcherKit sharedKit] setApiKey:ShapecatcherKitTestApiKey];
    [[ShapecatcherKit sharedKit] recognizeFromImage:[NSImage imageNamed:@"beta_test"] withSuccess:^(NSArray *shapes) {
        NSLog(@"%@", shapes);
    } andFailure:^(NSError *error){
        NSLog(@"%@", error);
    }];
}

@end
