//
//  SKTableCellView.h
//  ShapecatcherKitTest
//
//  Created by David Keegan on 1/22/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <ShapecatcherKit/ShapecatcherKit.h>

@interface SKTableCellView : NSTableCellView

@property (nonatomic, weak) SKShape *shape;
@property (nonatomic, weak) IBOutlet NSTextField *utf8TextField;
@property (nonatomic, weak) IBOutlet NSSegmentedControl *segmentController;

- (void)displayShape:(SKShape *)shape;

- (IBAction)voteAction:(NSSegmentedControl *)voteButton;

@end
