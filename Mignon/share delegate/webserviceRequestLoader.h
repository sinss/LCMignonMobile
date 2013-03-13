//
//  webserviceRequestLoader.h
//  MLIproposal
//
//  Created by 張星星 on 12/5/23.
//  Copyright (c) 2012年 Mountant Star Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class webserviceRequestLoader;
@protocol webserviceRequestDelegate <NSObject>

- (void)webserviceRequest:(webserviceRequestLoader*)loader didFinishRequestWithData:(NSData*)data;
- (void)webserviceRequest:(webserviceRequestLoader *)loader didReceiveDataLength:(NSUInteger)length;
- (void)webserviceRequest:(webserviceRequestLoader *)loader didFaildRequestWithError:(NSError*)error;

@end
@interface webserviceRequestLoader : NSObject <NSURLConnectionDataDelegate>
{
    id<webserviceRequestDelegate>delegate;
    NSMutableData *responseData;
    NSURLConnection *connection;
    NSUInteger loaderTag;
}
@property (assign) id<webserviceRequestDelegate> delegate;
@property (assign) NSUInteger loaderTag;

- (void)startWithURL:(NSURL*)url andPara:(NSMutableDictionary*)paraDict;
- (void)startWithURL2:(NSURL *)url andPara:(NSMutableDictionary *)paraDict;
- (void)cancelDelegate;

@end
