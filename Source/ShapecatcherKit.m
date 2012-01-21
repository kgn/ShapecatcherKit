//
//  ShapecatcherKit.m
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "ShapecatcherKit.h"

@implementation ShapecatcherKit{
    NSString *_apiKey;
}

+ (ShapecatcherKit *)sharedKit{
    static ShapecatcherKit *_sharedKit = nill
    if(_sharedKit == nil){
        _sharedKit = [[ShapecatcherKit alloc] init];
    }
    return _sharedKit;
}

- (id)initWithApiKey:(NSString *)apiKey{
    if((self = [super init])){
        [self setApiKey:apiKey];
    }
    return self;
}

- (void)setApiKey:(NSString *)apiKey{
    [_apiKey release];
    _apiKey = nil;
    _apiKey = [key copy];
}

@end
