//
//  ZenConnection.h
//  Zen
//
//  Created by roger on 13-07-23.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

@protocol ZenConnectionDelegate;

@interface ZenConnection : NSObject <NSURLConnectionDataDelegate>
{
    SEL _didFinishedSelector;
    SEL _didFailedSelector;
    __weak NSObject <ZenConnectionDelegate>  *_delegate;
    NSString *_httpMethod;
    NSData *_httpBody;
    NSMutableDictionary *_requestHeaders;
    NSDictionary *_responseHeaders;
    NSMutableData *_responseData;
    NSString *_responseString;
    NSError *_error;
    BOOL _shouldHandleCookies;
    int _tag;
    NSUInteger _progress;
}

@property (nonatomic, assign) SEL didFinishedSelector;
@property (nonatomic, assign) SEL didFailedSelector;
@property (nonatomic, weak) NSObject <ZenConnectionDelegate> *delegate;

@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSData *httpBody;
@property (nonatomic, strong) NSMutableDictionary *requestHeaders;
@property (nonatomic, strong) NSDictionary *responseHeaders;
@property (nonatomic, assign) int tag;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) BOOL shouldHandleCookies;
@property (nonatomic, assign) NSUInteger progress;
/**
 *	init method
 *
 *	@param	url	- request url
 *
 *	@return	ZenConnection Instance
 */
+ (ZenConnection *)connectionWithURL:(NSURL *)url;

- (void)addRequestHeader:(NSString *)header value:(NSString *)value;

- (NSData *)startSynchronous;

- (void)startAsynchronous;

- (void)cancel;

@end

@protocol ZenConnectionDelegate <NSObject>

@optional
- (void)requestDidFinished:(ZenConnection *)connection;
- (void)requestDidFailed:(ZenConnection *)connection;
- (void)progressOfConnection:(ZenConnection *)connection;

@end