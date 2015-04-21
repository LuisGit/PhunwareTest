//
//  DetailViewController.h
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Venue.h"
#import "VenueSchedule.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Venue *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

