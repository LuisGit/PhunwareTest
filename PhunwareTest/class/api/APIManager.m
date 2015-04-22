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

#define kBaseURLString @"https://s3.amazonaws.com/jon-hancock-phunware/"

@implementation APIManager

+(void)retrieveVenuesFromURL:(NSString *)stringURL success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSString *string = [NSString stringWithFormat:@"%@%@", kBaseURLString, stringURL];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Get the string from the WS.
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //Encode string for non standard /exit characters
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        //Initialize error handler.
        NSError *error;
        NSArray *itemsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@", itemsArray);
        
        //Parse feed items to Venues Array
        [self parseVenuesData:itemsArray withCompletionHandler:^(NSMutableArray *venuesArray) {
            NSLog(@"%@", venuesArray);
            successBlock(venuesArray);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Send error message
        failureBlock(error);
    }];
    
    //Start feed download
    [operation start];
}


+(void)parseVenuesData:(NSArray *)items withCompletionHandler:(void (^)(NSMutableArray *))completionHandler{
    // load only new values
    NSMutableArray *venuesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in items) {
        //load values into array.
        [venuesArray addObject:[Venue parseVenueFromDictionary:dict]];
    }
    completionHandler(venuesArray);
}
@end
