//
//  SKShape.m
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "SKShape.h"
#import "ShapecatcherKit+Private.h"
#import "AFImageRequestOperation.h"

@interface NSDictionary(SKJSON)
- (CGFloat)floatSafelyFromKey:(id)key;
- (NSUInteger)uintSafelyFromKey:(id)key;
- (NSString *)stringSafelyFromKey:(id)key;
- (NSURL *)URLSafelyFromKey:(id)key;
- (id)objectSafelyFromKey:(id)key;
@end

@implementation SKShape

@synthesize characterImageUrl = _characterImageUrl;
@synthesize codepoint = _codepoint;
@synthesize codepointHex = _codepointHex;
@synthesize fullname = _fullname;
@synthesize rateId = _rateId;
@synthesize score = _score;
@synthesize unicodeBlock = _unicodeBlock;
@synthesize unicodeBlockUrl = _unicodeBlockUrl;
@synthesize utf8 = _utf8;
@synthesize rating = _rating;
+ (id)shapeWithDictionary:(NSDictionary *)dictionary{
    return [[[[self class] alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _characterImageUrl = [[dictionary URLSafelyFromKey:@"character_image_url"] retain];
        _codepoint = [dictionary uintSafelyFromKey:@"codepoint"];
        _codepointHex = [[dictionary stringSafelyFromKey:@"codepoint_hex"] copy];
        _fullname = [[dictionary stringSafelyFromKey:@"fullname"] copy];
        _rateId = [[dictionary stringSafelyFromKey:@"rateId"] copy];
        _score = [dictionary floatSafelyFromKey:@"rateId"];
        _unicodeBlock = [[dictionary stringSafelyFromKey:@"unicode_block"] copy];
        _unicodeBlockUrl = [[dictionary URLSafelyFromKey:@"unicode_block_url"] retain];
        _utf8 = [[dictionary stringSafelyFromKey:@"utf8"] copy];
    }
    return self;
}

- (void)requestCharacterImageWithSuccess:(void (^)(NSImage *image))success 
                              andFailure:(void (^)(NSError *error))failure{
    if(success == nil){
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.characterImageUrl];
    AFImageRequestOperation *operation = 
    [AFImageRequestOperation 
     imageRequestOperationWithRequest:request imageProcessingBlock:nil cacheName:nil 
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSImage *image){
        success(image);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if(failure)failure(error);
    }];
    [operation start];
}

- (void)setRating:(NSString *)rating withSuccess:(void (^)())success 
       andFailure:(void (^)(NSError *error))failure{
    if([rating isEqualToString:self.rating] || 
       ([rating isEqualToString:SKShapeUndoRating] && self.rating == nil)){
        return;
    }
    NSString *previusRating = self.rating;
    [_rating release];
    _rating = nil; 
    if(![rating isEqualToString:SKShapeUndoRating]){
        _rating = [rating copy];
    }
    [ShapecatcherKit setRating:rating onRateId:self.rateId withSuccess:success andFailure:^(NSError *error){
        if(![rating isEqualToString:SKShapeUndoRating]){
            _rating = previusRating;
        }
        if(failure)failure(error);
    }];
}

- (NSUInteger)hash{
    return self.codepoint;
}

- (BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]]){
        return (self.codepoint == [(SKShape *)object codepoint]);
    }
    return NO;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %@ Codepoint='%lu' Fullname='%@'>", 
            [self class], self.utf8, self.codepoint, self.fullname];
}

- (void)dealloc{
    [_characterImageUrl release];
    [_codepointHex release];
    [_fullname release];
    [_rateId release];
    [_unicodeBlock release];
    [_unicodeBlockUrl release];
    [_utf8 release];
    [_rating release];
    [super dealloc];
}

@end

@implementation NSDictionary(SKJSON)

- (CGFloat)floatSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return 0.0f;
    }
    return [[self objectForKey:key] floatValue];
}

- (NSUInteger)uintSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return NSNotFound;
    }
    return [[self objectForKey:key] integerValue];
}

- (NSString *)stringSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    return [NSString stringWithString:[self objectForKey:key]];
}

- (NSURL *)URLSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    NSString *urlString =
    [[self objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    return [NSURL URLWithString:urlString];
}

- (id)objectSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    return [self objectForKey:key];
}

@end
