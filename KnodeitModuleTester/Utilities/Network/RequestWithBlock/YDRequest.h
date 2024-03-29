//
//  TSDRequest.h
//  TechStartUpDeveloper
//
//  Created by Peter van de Put on 14/04/2014.
//  Copyright (c) 2014 TechStartUpDeveloper. All rights reserved.

#import <Foundation/Foundation.h>

@interface YDRequest : NSObject

- (id)initWithRequest:(NSURLRequest*)request;

- (id) initWithURL:(NSURL*)url withJSONDict:(NSDictionary*) jsonDict;

- (void)startWithCompletion:(void (^)(YDRequest* request, NSData* data, BOOL success))completion;

@end
