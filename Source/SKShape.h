//
//  SKShape.h
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static NSString * const SKShapeGoodRating = @"good";
static NSString * const SKShapeBadRating  = @"bad";
static NSString * const SKShapeUndoRating = @"undo";

@interface SKShape : NSObject

@property (nonatomic, readonly) NSURL *characterImageUrl;
@property (nonatomic, readonly) NSUInteger codepoint;
@property (nonatomic, readonly) NSString *codepointHex;
@property (nonatomic, readonly) NSString *fullname;
@property (nonatomic, readonly) NSString *rateId;
@property (nonatomic, readonly) CGFloat score;
@property (nonatomic, readonly) NSString *unicodeBlock;
@property (nonatomic, readonly) NSURL *unicodeBlockUrl;
@property (nonatomic, readonly) NSString *utf8;
@property (nonatomic, readonly) NSString *rating;

+ (id)shapeWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)requestCharacterImageWithSuccess:(void (^)(NSImage *image))success 
                              andFailure:(void (^)(NSError *error))failure;
- (void)setRating:(NSString *)rating withSuccess:(void (^)())success 
       andFailure:(void (^)(NSError *error))failure;
@end
