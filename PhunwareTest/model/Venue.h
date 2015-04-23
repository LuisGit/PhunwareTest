//
//  Venue.h
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonModel.h"
#import "VenueSchedule.h"

@protocol VenueSchedule @end

@interface Venue : JSONModel

//Attributes
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *description;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *state;
@property (nonatomic,copy)NSNumber *id;
@property (nonatomic,copy)NSString *tollfreephone;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString <Optional> *image_url;
@property (nonatomic,copy)NSString *ticket_link;
@property (nonatomic,copy)NSNumber *pcode;
@property (nonatomic,copy)NSNumber *zip;
@property (nonatomic,copy)NSString *phone;

@property (nonatomic,strong)NSNumber *latitude;
@property (nonatomic,strong)NSNumber *longitude;

@property (nonatomic, strong)NSMutableArray<VenueSchedule, Optional> *schedule;

@end
