//
//  APIManager.m
//  PhunwareTest
//
//  Created by Work on 4/22/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "Venue.h"
#import "JSONModel.h"

const NSString *kBaseURLString = @"https://s3.amazonaws.com/jon-hancock-phunware/";

@implementation APIManager

+(void)retrieveVenuesFromURL:(NSString *)stringURL success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSString *fullStringURL = [NSString stringWithFormat:@"%@%@", kBaseURLString, stringURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:[NSString stringWithFormat:fullStringURL ,kBaseURLString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Parse Json Feed.
        NSArray *venuesArray = [Venue arrayOfModelsFromDictionaries:responseObject error:nil];
        successBlock(venuesArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Send error message
        failureBlock(error);
    }];
}

@end
