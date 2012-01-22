//
//  ShapecatcherKit+Private.h
//  ShapecatcherKit
//
//  Created by David Keegan on 1/22/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "ShapecatcherKit.h"

@interface ShapecatcherKit()
+ (NSData *)dataForImage:(NSImage *)image;
+ (void)setRating:(NSString *)rating onRateId:(NSString *)rateId 
      withSuccess:(void (^)())success andFailure:(void (^)(NSError *error))failure;
@end
