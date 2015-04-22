//
//  APIManager.h
//  PhunwareTest
//
//  Created by Work on 4/22/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^failureBlock)(NSError *error);
typedef void(^successBlock)(id response);

@interface APIManager : NSObject

+(void)retrieveVenuesFromURL:(NSString *)stringURL success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
