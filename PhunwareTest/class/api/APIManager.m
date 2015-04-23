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

#define kBaseURLString @"https://s3.amazonaws.com/jon-hancock-phunware/"

@implementation APIManager

+(void)retrieveVenuesFromURL:(NSString *)stringURL success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSString *string = [NSString stringWithFormat:@"%@%@", kBaseURLString, stringURL];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Get feed to string.
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //Encode string for non standard /exit characters
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
       
        //Parse Json feed.
        NSArray *venuesArray  = [Venue arrayOfModelsFromData:jsonData error:nil];
        successBlock(venuesArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Send error message
        failureBlock(error);
    }];
    
    //Start feed download
    [operation start];
}

@end
