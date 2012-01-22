//
//  SKTableCellView.m
//  ShapecatcherKitTest
//
//  Created by David Keegan on 1/22/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "SKTableCellView.h"

@interface SKTableCellView()
- (void)updateSegmentController;
@end

@implementation SKTableCellView

@synthesize shape = _shape;
@synthesize utf8TextField = _utf8TextField;
@synthesize segmentController = _segmentController;

- (void)updateSegmentController{
    [self.segmentController setEnabled:YES forSegment:0];
    [self.segmentController setEnabled:YES forSegment:1];
    [self.segmentController setSelected:NO forSegment:0];
    [self.segmentController setSelected:NO forSegment:1];            
    if([self.shape.rating isEqualToString:SKShapeGoodRating]){
        [self.segmentController setSelectedSegment:0];
    }else if([self.shape.rating isEqualToString:SKShapeBadRating]){
        [self.segmentController setSelectedSegment:1];
    }
}

- (void)displayShape:(SKShape *)shape{
    self.shape = shape;
    self.utf8TextField.stringValue = shape.utf8;
    [self updateSegmentController];
}

- (IBAction)voteAction:(NSSegmentedControl *)voteButton{
    NSString *rating = SKShapeBadRating;
    if([voteButton selectedSegment] == 0){
        rating = SKShapeGoodRating;
    }
    
    if([self.shape.rating isEqualToString:rating]){
        rating = SKShapeUndoRating;
    }    
    
    [voteButton setEnabled:NO forSegment:0];
    [voteButton setEnabled:NO forSegment:1];
    
    [self.shape setRating:rating withSuccess:^(){           
        [self updateSegmentController];
        NSLog(@"Rated %@ %@", self.shape.utf8, self.shape.rating);
    } andFailure:^(NSError *error){                    
        [self updateSegmentController];
        NSLog(@"%@", error);
    }];    
}

@end
