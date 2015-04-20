//
//  Venue.h
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueSchedule.h"

@interface Venue : NSObject

@property (nonatomic,copy)NSString *venueName;
@property (nonatomic,copy)NSString *venueDescription;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *state;
@property (nonatomic,copy)NSString *identificationNumber;
@property (nonatomic,copy)NSString *tollFreePhone;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *ticketUrl;
@property (nonatomic,copy)NSString *pCode;
@property (nonatomic,copy)NSString *zipCode;
@property (nonatomic,copy)NSString *phoneNumber;

@property (nonatomic,strong)NSNumber *latitud;
@property (nonatomic,strong)NSNumber *longitude;

@property (nonatomic, strong)NSMutableArray *schedule;
/*
"schedule": [
             {
                 "end_date": "2013-01-30 20:00:00 -0800",
                 "start_date": "2013-01-30 13:00:00 -0800"
             },
             {
                 "end_date": "2013-01-31 20:00:00 -0800",
                 "start_date": "2013-01-31 08:00:00 -0800"
             }
            ],

 */

@end
