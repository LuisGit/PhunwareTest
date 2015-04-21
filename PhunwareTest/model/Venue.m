//
//  Venue.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "Venue.h"

@implementation Venue


-(id)initWithVenue:(NSString *)venueName venueDescription:(NSString *)venueDescription city:(NSString *)city state:(NSString *)state identificationNumber:(NSNumber *)identificationNumber tollFreePhone:(NSString *)tollFreePhone address:(NSString *)address imageUrl:(NSString *)imageUrl ticketUrl:(NSString *)ticketUrl pCode:(NSNumber *)pCode zipCode:(NSNumber *)zipCode phoneNumber:(NSString *)phoneNumber latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude schedule:(NSArray *)schedule{

    self = [super init];
    if (self){
        
        _venueName = venueName;
        _venueDescription = venueDescription;
        _city = city;
        _state = state;
        _identificationNumber = identificationNumber;
        _tollFreePhone = tollFreePhone;
        _address = address;
        _imageUrl = imageUrl;
        _ticketUrl = ticketUrl;
        _pCode = pCode;
        _zipCode = zipCode;
        _phoneNumber = phoneNumber;
        _latitude = latitude;
        _longitude = longitude;
        _schedule = [NSMutableArray arrayWithArray:schedule];
    }
    return self;
}


+(Venue *)parseVenueFromDictionary:(NSDictionary *)venuesDictionary{
    Venue *venueItem = [[Venue alloc]init];
    
    venueItem.venueName = [venuesDictionary valueForKey:@"name"];
    venueItem.venueDescription = [venuesDictionary valueForKey:@"description"];
    venueItem.city = [venuesDictionary valueForKey:@"city"];
    venueItem.state = [venuesDictionary valueForKey:@"state"];
    venueItem.identificationNumber = [venuesDictionary valueForKey:@"id"];
    venueItem.tollFreePhone = [venuesDictionary valueForKey:@"tollFreePhone"];
    venueItem.address = [venuesDictionary valueForKey:@"address"];
    venueItem.imageUrl = [venuesDictionary valueForKey:@"image_url"];
    venueItem.ticketUrl = [venuesDictionary valueForKey:@"ticket_link"];
    venueItem.pCode = [venuesDictionary valueForKey:@"pcode"];
    venueItem.zipCode = [venuesDictionary valueForKey:@"zip"];
    venueItem.phoneNumber = [venuesDictionary valueForKey:@"phone"];
    venueItem.latitude = [venuesDictionary valueForKey:@"latitude"];
    venueItem.longitude = [venuesDictionary valueForKey:@"longitude"];
    
    //Schedule Parse;
    venueItem.schedule = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dateDict in [venuesDictionary valueForKey:@"schedule"]) {
        //Get the date from the service.
        NSString *startDate = [dateDict valueForKey:@"start_date"];
        NSString *endDate = [dateDict valueForKey:@"end_date"];
        
        //Create an schedule object
        VenueSchedule *vs = [VenueSchedule scheduleWithDates:startDate endDate:endDate];
        
        //Add the new object to the venue item
        [venueItem.schedule addObject:vs];
    }
    
    return venueItem;
}


@end
