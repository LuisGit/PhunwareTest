//
//  venueSchedule.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "VenueSchedule.h"

@implementation VenueSchedule

-(id)initWithSchedule:(NSDate *)startDate endDate:(NSDate *)endDate{
    self = [super init];
    if (self){
        _startDate = startDate;
        _endDate = endDate;
    }
    return self;
}

+(VenueSchedule *)scheduleWithDates:(NSString *)startDate endDate:(NSString *)endDate{
    VenueSchedule *venueSchedule = [[VenueSchedule alloc]init];
    
    //Set the formatter for the coming date.
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    
    //Set the time zone (locale)
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    
    //Create the dates objects
    venueSchedule.startDate = [formatter dateFromString:startDate];
    venueSchedule.endDate = [formatter dateFromString:endDate];
    
    return venueSchedule;
}


@end
