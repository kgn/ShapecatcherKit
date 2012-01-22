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
#import "SKTableCellView.h"

@implementation SKAppDelegate{
    NSArray *_shapes;
}

@synthesize window = _window;
@synthesize tableView = _tableView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [[ShapecatcherKit sharedKit] setApiKey:ShapecatcherKitTestApiKey];
    [[ShapecatcherKit sharedKit] recognizeFromImage:[NSImage imageNamed:@"beta_test"] withSuccess:^(NSArray *shapes) {
        _shapes = shapes;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } andFailure:^(NSError *error){
        NSLog(@"%@", error);
    }];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [_shapes count];
}

- (SKTableCellView *)tableView:(NSTableView *)tableView 
            viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    SKTableCellView *view = (SKTableCellView *)[tableView makeViewWithIdentifier:@"ShapeCell" owner:self];
    [view displayShape:[_shapes objectAtIndex:row]];
    return view;
}

@end
