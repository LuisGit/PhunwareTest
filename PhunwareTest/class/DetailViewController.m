//
//  DetailViewController.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define kBackUpImageURL @"http://jackicarr.com/wp-content/uploads/2015/02/No_Image.png"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        [self.initialMessageLabel setHidden:YES];
        [self loadDetaiImage];
        [self loadDetailInfo];
        if ([self.detailItem.schedule count]>0) {
            [self loadDetailSchedules];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupNavigationBar];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavigationBar{
    self.title = NSLocalizedString(@"Details", @"Details");
}

#pragma mark - Image

-(void)loadDetaiImage{
    [self.spinner startAnimating];
    
    self.detailImage.backgroundColor = [UIColor grayColor];
    
    //Build the url.
    NSString *urlString = self.detailItem.image_url;
    if ([urlString length]<= 0) {
        urlString  = kBackUpImageURL;
    }
    
    //load image
    NSURL *url = [NSURL URLWithString:urlString];
    [self.detailImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //remove activity indicator animation
        self.detailImage.image = image;
        [self hideSpinner];
    }];
    
}

#pragma mark - data
-(void)loadDetailInfo{
    self.titleLabel.text = [self.detailItem name];
    self.subTitle1Label.text = [self.detailItem address];
    self.subTitle2Label.text = [NSString stringWithFormat:@"%@, %@ %@",[self.detailItem city], [self.detailItem state], [self.detailItem zip]];
}

-(void)loadDetailSchedules{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    
    //Set the time zone
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];

    //Set dates format
    NSDateFormatter *fromDateformatter = [[NSDateFormatter alloc]init];
    [fromDateformatter setDateFormat:@"EEEE dd/MM HH:mm a"];
    [fromDateformatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDateFormatter *toDateformatter = [[NSDateFormatter alloc]init];
    [toDateformatter setDateFormat:@"HH:mm a"];
    [toDateformatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *scheduleEntry = @"";
    for (int i=0; i< [self.detailItem.schedule count]; i++) {
        //Get all schedules
        VenueSchedule *venueSchedule = [self.detailItem.schedule objectAtIndex:i];
        NSString *fromDateStr = venueSchedule.start_date;
        NSString *toDateStr = venueSchedule.end_date;
        
        //Format Dates
        NSString *fromDate = [fromDateformatter stringFromDate:[dateFormatter dateFromString:fromDateStr]];
        NSString *toDate = [toDateformatter stringFromDate:[dateFormatter dateFromString:toDateStr]];
        scheduleEntry = [NSString stringWithFormat:@"%@%@ to %@\n",scheduleEntry,fromDate, toDate];
    }
    
    //set schedules
    self.scheduleWrapperTView.text = scheduleEntry;
}

#pragma mark - ui elements
-(void)hideSpinner{
    [self.spinner setHidden:YES];
    [self.spinner stopAnimating];
}



@end
