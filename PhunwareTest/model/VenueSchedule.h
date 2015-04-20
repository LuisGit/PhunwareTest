//
//  venueSchedule.h
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueSchedule : NSObject

//Attributes
@property (nonatomic, strong)NSDate *startDate;
@property (nonatomic, strong)NSDate *endDate;

//Methods
-(id)initWithSchedule:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
