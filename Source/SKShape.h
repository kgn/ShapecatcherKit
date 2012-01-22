//
//  SKShape.h
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

//"character_image_url" = "http://shapecatcher.com/unicode_img/226.png";
//codepoint = 226;
//"codepoint_hex" = 0xe2;
//fullname = "Latin small letter a with circumflex";
//rateId = 2267de14ea307d3f830b0e31232de0;
//score = "1757.54";
//"unicode_block" = "Latin-1 Supplement";
//"unicode_block_url" = "http://shapecatcher.com/unicode/block/Latin-1_Supplement.html";
//utf8 = "\U00e2";

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

+ (id)shapeWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
