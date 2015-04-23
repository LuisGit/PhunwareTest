//
//  MasterViewController.m
//  PhunwareTest
//
//  Created by Work on 4/20/15.
//  Copyright (c) 2015 Luis Alvarado. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MBProgressHud.h"
#import "APIManager.h"
#import "Reachability.h"
#import "Venue.h"

//Constants section
#define kReachabilityTestURL @"www.google.com"
#define kJsonURLSource @"nflapi-static.json"

@interface MasterViewController ()

@property NSArray *objects;
@property(strong) Reachability * googleReach;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
        
    }
    [self checkOnlineAccess];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - customization
-(void)setupNavigationBar{
    self.title = NSLocalizedString(@"Sample App", @"Sample App");
}

#pragma mark - Reachability
-(void)checkOnlineAccess{
    Reachability *reachability = [Reachability reachabilityWithHostname:kReachabilityTestURL];
    reachability.reachableBlock = ^(Reachability *reachability) {
        [self loadExternalData];
    };
    reachability.unreachableBlock = ^(Reachability *reachability) {
        [self showMessageToUser:@"Connectivity" message:@"Please check your connection"];
    };
    
    [reachability startNotifier];
}


#pragma mark - Data Methods
-(void)loadExternalData{
    //call to API
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [APIManager retrieveVenuesFromURL:kJsonURLSource success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //Sort the array.
        NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameDescriptor,nil];
        
        //load the array.
        self.objects = [(NSMutableArray *)response sortedArrayUsingDescriptors:sortDescriptors];
        
        //load the tableview.
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessageToUser:NSLocalizedString(@"Connection error",@"Connection error") message:[error localizedDescription]];
    }];
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
        Venue *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",@"Back") style:UIBarButtonItemStylePlain target:nil action:nil];
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

    cell.textLabel.text = [venue name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@ %@", venue.address, venue.city, venue.state, venue.zip];
    return cell;
}

@end
