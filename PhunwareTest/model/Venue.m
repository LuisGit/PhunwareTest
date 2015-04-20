//
//  Venue.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "Venue.h"

@implementation Venue


-(id)initWithVenue:(NSString *)venueName venueDescription:(NSString *)venueDescription city:(NSString *)city state:(NSString *)state identificationNumber:(NSString *)identificationNumber tollFreePhone:(NSString *)tollFreePhone address:(NSString *)address imageUrl:(NSString *)imageUrl ticketUrl:(NSString *)ticketUrl pCode:(NSString *)pCode zipCode:(NSString *)zipCode phoneNumber:(NSString *)phoneNumber latitud:(NSNumber *)latitud longitude:(NSNumber *)longitude schedule:(NSArray *)schedule{

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
        _latitud = latitud;
        _longitude = longitude;
        _schedule = [NSMutableArray arrayWithArray:schedule];
    }
    return self;
}

@end
