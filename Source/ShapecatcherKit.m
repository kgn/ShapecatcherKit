//
//  ShapecatcherKit.m
//  ShapecatcherKit
//
//  Created by David Keegan on 1/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "ShapecatcherKit.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface ShapecatcherKit()
- (NSData *)dataForImage:(NSImage *)image;
@end

@implementation ShapecatcherKit{
    NSString *_apiKey;
}

+ (ShapecatcherKit *)sharedKit{
    static ShapecatcherKit *_sharedKit = nil;
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
    _apiKey = [apiKey copy];
}

- (void)recognizeFromImage:(NSImage *)image withSuccess:(void (^)(NSArray *shapes))success andFailure:(void (^)(NSError *error))failure{
    [self recognizeFromImage:image withSuccess:success failure:failure andProgress:nil];
}

- (void)recognizeFromImage:(NSImage *)image withSuccess:(void (^)(NSArray *shapes))success failure:(void (^)(NSError *error))failure andProgress:(void (^)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite))progress{
    if(_apiKey == nil){
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"The API key was not set, use [ShapecatcherKit setApiKey:] to set it", nil) 
                                                             forKey:NSLocalizedRecoverySuggestionErrorKey];
        [[NSException exceptionWithName:NSInternalInconsistencyException 
                                 reason:NSLocalizedString(@"API key not specified", nil) 
                               userInfo:userInfo] raise];
        return;
    }
    
    if(success == nil){
        return;
    }
    
    NSData *imageData = [self dataForImage:image];    
    if(imageData == nil){
        if(failure){
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Invalid image data" 
                                                                 forKey:NSLocalizedDescriptionKey];
            failure([NSError errorWithDomain:[self className] code:100 userInfo:userInfo]);
        }
        return;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://api.shapecatcher.com"];
    NSString *path = [NSString stringWithFormat:@"/recognize/%@", _apiKey];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData){
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"drawing.png" mimeType:@"image/png"];
    }];
    
    AFJSONRequestOperation *operation = [[[AFJSONRequestOperation alloc] initWithRequest:request] autorelease];
    
    if(progress){
        [operation setUploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite){
            progress(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }];
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *response){
        success(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure)failure(error);
    }];    
    
    [operation start];
}

 - (NSData *)dataForImage:(NSImage *)image{
     if(image == nil){
         return nil;
     }
     CGImageRef cgimage = [image CGImageForProposedRect:nil context:nil hints:nil];
     NSBitmapImageRep *bitimage = [[NSBitmapImageRep alloc] initWithCGImage:cgimage];
     NSData *data = [bitimage representationUsingType:NSPNGFileType properties:nil];
     [bitimage release];
     return data;
 }
     
@end
