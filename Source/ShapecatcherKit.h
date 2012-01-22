//
//  ShapecatcherKit.h
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SKShape.h"

@interface ShapecatcherKit : NSObject

+ (ShapecatcherKit *)sharedKit;

- (id)initWithApiKey:(NSString *)apiKey;
- (void)setApiKey:(NSString *)apiKey;

- (void)recognizeFromImage:(NSImage *)image withSuccess:(void (^)(NSArray *shapes))success andFailure:(void (^)(NSError *error))failure;
- (void)recognizeFromImage:(NSImage *)image withSuccess:(void (^)(NSArray *shapes))success failure:(void (^)(NSError *error))failure 
               andProgress:(void (^)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite))progress;

@end
