//
//  SKTableCellView.m
//  ShapecatcherKitTest
//
//  Created by David Keegan on 1/22/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "SKTableCellView.h"

@implementation SKTableCellView

@synthesize shape = _shape;
@synthesize utf8TextField = _utf8TextField;

- (void)displayShape:(SKShape *)shape{
    self.shape = shape;
    self.utf8TextField.stringValue = shape.utf8;
}

- (IBAction)voteAction:(NSSegmentedControl *)voteButton{
    if([voteButton selectedSegment] == 0){
        [self.shape setRating:SKShapeGoodRating withSuccess:^(){
            NSLog(@"Rated %@ good", self.shape.utf8);
        } andFailure:^(NSError *error){
            NSLog(@"%@", error);
        }];
    }else{
        [self.shape setRating:SKShapeBadRating withSuccess:^(){
            NSLog(@"Rated %@ bad", self.shape.utf8);
        } andFailure:^(NSError *error){
            NSLog(@"%@", error);
        }];
    }
}

@end
