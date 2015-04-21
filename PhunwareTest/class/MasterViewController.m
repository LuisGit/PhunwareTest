//
//  MasterViewController.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "AFNetworking.h"
#import "Reachability.h"

#import "Venue.h"

//Constants section
#define kReachabilityTestURL @"www.google.com"
#define kBaseURLString @"https://s3.amazonaws.com/jon-hancock-phunware/"
#define kJsonURLSource @"nflapi-static.json"


@interface MasterViewController ()

@property NSMutableArray *objects;
@property(strong) Reachability * googleReach;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Reachability *reachability = [Reachability reachabilityWithHostname:kReachabilityTestURL];
    reachability.reachableBlock = ^(Reachability *reachability) {
        [self loadExternalData];
    };
    reachability.unreachableBlock = ^(Reachability *reachability) {
        [self showMessageToUser:@"Connectivity" message:@"Please check your connection"];
    };

    [reachability startNotifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - customization
-(void)setupNavigationBar{
    self.title = @"Sample App";
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:25.0/255 green:25.0/255 blue:25.0/255 alpha:0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark - Data Methods
-(void)loadExternalData{
    NSString *string = [NSString stringWithFormat:@"%@%@", kBaseURLString, kJsonURLSource];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Get the string from the WS.
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //Encode string for non standard /exit characters
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        //Initialize error handler.
        NSError *e;
        NSArray *venuesArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&e];
        NSLog(@"%@", venuesArray);
        
        [self parseVenuesData:venuesArray withCompletionHandler:^{
            [self.tableView reloadData];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showMessageToUser:@"Error retrieving data" message:[error localizedDescription]];
        
    }];
    
    //Start feed download
    [operation start];
}

-(void)parseVenuesData:(NSArray *)venuesArray withCompletionHandler:(void (^)(void))completionHandler{
    // load only current values
    self.objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in venuesArray) {
        //load values into array.
        [self.objects addObject:[Venue parseVenueFromDictionary:dict]];
    }
    completionHandler();
}

#pragma mark - User Messages

-(void)showMessageToUser:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        //controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.objects[indexPath.row];

    cell.textLabel.text = [venue venueName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@ %@", venue.address, venue.city, venue.state, venue.zipCode];
    return cell;
}

@end
