//
//  DetailViewController.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"


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
    
    NSString *urlString = self.detailItem.imageUrl;
    if ([urlString length]<= 0) {
        urlString  = kBackUpImageURL;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.detailImage.backgroundColor = [UIColor grayColor];
    [self.detailImage setImageWithURLRequest:request
                            placeholderImage:nil
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                         self.detailImage.image = image;
                                         [self hideSpinner];
                                         
                                     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         NSLog(@"failed loading: %@", error);
                                         [self hideSpinner];
                                     }
     ];

}

#pragma mark - data
-(void)loadDetailInfo{
    self.titleLabel.text = [self.detailItem venueName];
    self.subTitle1Label.text = [self.detailItem address];
    self.subTitle2Label.text = [NSString stringWithFormat:@"%@, %@ %@",[self.detailItem city], [self.detailItem state], [self.detailItem zipCode]];
}

-(void)loadDetailSchedules{
    NSDateFormatter *fromDateformatter = [[NSDateFormatter alloc]init];
    [fromDateformatter setDateFormat:@"EEEE dd/MM HH:mm a"];
    [fromDateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSDateFormatter *toDateformatter = [[NSDateFormatter alloc]init];
    [toDateformatter setDateFormat:@"HH:mm a"];
    [toDateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *scheduleEntry = @"";
    
    for (int i=0; i< [self.detailItem.schedule count]; i++) {
        //Get all data
        VenueSchedule *venueSchedule = [self.detailItem.schedule objectAtIndex:i];
        
        //Format Dates
        NSString *fromDate = [fromDateformatter stringFromDate:venueSchedule.startDate];
        NSString *toDate = [toDateformatter stringFromDate:venueSchedule.endDate];
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
