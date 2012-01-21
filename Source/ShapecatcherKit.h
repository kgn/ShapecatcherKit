//
//  ShapecatcherKit.h
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShapecatcherKit : NSObject

+ (ShapecatcherKit *)sharedKit;

- (id)initWithApiKey:(NSString *)apiKey;
- (void)setApiKey:(NSString *)apiKey;

@end
