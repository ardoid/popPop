//
//  PPMainViewController.m
//  PopPop
//
//  Created by Ardo Septama on 20.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import "PPMainViewController.h"
//#import <MapKit/MapKit.h>

@interface PPMainViewController ()

@end

@implementation PPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self locationFinder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)singleBtnClicked:(id)sender
{
    if ([_relocateLabel.text isEqualToString:@"location not set"])  {
        [self locationFinder];
    }
    if (gameViewController == nil)  {
        gameViewController=[[PPGameViewController alloc] initWithNibName:@"PPGameViewController" bundle:nil ];
    }
    gameViewController.location = _relocateLabel.text;
    [self  presentViewController:gameViewController animated:YES completion:nil]; //pushViewController:gameViewController
}

- (IBAction)vsBtnClicked:(id)sender
{
}

- (IBAction)relocateBtnClicked:(id)sender
{
    [self locationFinder];
}

- (void) locationFinder
{
    if ([CLLocationManager locationServicesEnabled]){
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        
        [self.myLocationManager startUpdatingLocation];
        _relocateLabel.text = @"Acquiring your location..";
    } else {
        /* Location services are not enabled. Take appropriate action: default to Paris */
        _relocateLabel.text = @"Paris";
        //NSLog(@"Location services are not enabled");
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    
//    NSLog(@"Latitude = %f", newLocation.coordinate.latitude);
//    NSLog(@"Longitude = %f", newLocation.coordinate.longitude);
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    __block NSString *location;
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        location = ([placemarks count] > 0) ? [[placemarks objectAtIndex:0] locality] : @"Not Found";
        NSLog(@"Location = %@", location);
        _relocateLabel.text = location;
        _relocateLabel.font = [UIFont boldSystemFontOfSize:14 ];
    }];
    [self.myLocationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    /* Failed to receive user's location */
}

@end