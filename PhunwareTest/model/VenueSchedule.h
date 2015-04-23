//
//  venueSchedule.h
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface VenueSchedule : JSONModel

//Attributes
@property (nonatomic, strong)NSString *start_date;
@property (nonatomic, strong)NSString *end_date;

@end
