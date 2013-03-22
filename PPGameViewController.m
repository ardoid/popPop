//
//  PPGameViewController.m
//  PopPop
//
//  Created by Ardo Septama on 20.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import "PPGameViewController.h"
#include "stdlib.h"
//#import "PPMainViewController.m"

@interface PPGameViewController ()

@end

@implementation PPGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        cityList = @{
                     @"Paris" : @"https://api.foursquare.com/v2/lists/4ee11eea722e9d45c4c06470?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321",
                     @"Milan" : @"https://api.foursquare.com/v2/lists/4f2ffc65e4b062ad2da9cf4b?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321",
                     @"Jakarta" : @"https://api.foursquare.com/v2/lists/4fa3d0f0e4b039aeea2281b4?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321",
                     @"Chicago" : @"https://api.foursquare.com/v2/lists/4e7394402271391c706915cc?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321"
                    };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //check location
    if ([_location isEqualToString:@"location not set"] || [_location isEqualToString:@"Acquiring your location.."])  {
        _location = @"Paris";
    }

    //[_butt1 setTitle:_location forState:UIControlStateNormal];
    self.responseData = [NSMutableData data];
    
    //request to 4sq
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:cityList[_location]]];
    //(void)[[NSURLConnection alloc] initWithRequest:request delegate:self]; -> cast to void to remove warnings OR ...
    [NSURLConnection connectionWithRequest:request delegate:self];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    //NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
//    for(id key in res) {
//        id value = [res objectForKey:key];
//        
//        NSString *keyAsString = (NSString *)key;
//        NSString *valueAsString = (NSString *)value;
        
//        NSLog(@"key: %@", keyAsString);
//        NSLog(@"value: %@", valueAsString);
//    }
    // extract specific value...
//    NSArray *results = [res objectForKey:@"results"];
//    
//    for (NSDictionary *result in results) {
//        NSString *icon = [result objectForKey:@"icon"];
//        NSLog(@"icon: %@", icon);
//    }
    // extract venues from 4sq
    NSDictionary *response = [res objectForKey:@"response"];
    NSDictionary *listItem = [response objectForKey:@"list"];
    NSDictionary *listItems= [listItem objectForKey:@"listItems"];
    NSArray *venueItems = [listItems objectForKey:@"items"];
    int venueMax = [[listItems objectForKey:@"count"]integerValue];
    NSInteger questOrder[4];// = [[NSMutableArray alloc]init];
    for (int j=0; j<4; j++)  {
        questOrder[j] = arc4random_uniform(venueMax); //() % venueMax;
        for (int k=0; k<j; k++)  {
            if (questOrder[j] == questOrder[k]) questOrder[j] = arc4random() % venueMax;
        }
        //[questOrder addObject:[NSNumber numberWithInt:randNum]];
    }
    NSDictionary *venuesList1 = [venueItems objectAtIndex:questOrder[0]]; //[questOrder objectAtIndex:0]];
    NSDictionary *venuesList2 = [venueItems objectAtIndex:questOrder[1]]; //(int)[questOrder objectAtIndex:1]];
    NSDictionary *venuesList3 = [venueItems objectAtIndex:questOrder[2]]; //(int)[questOrder objectAtIndex:2]];
    NSDictionary *venuesList4 = [venueItems objectAtIndex:questOrder[3]]; //(int)[questOrder objectAtIndex:3]];//
    
    venuesList1 = [venuesList1 objectForKey:@"venue"];
    venuesList2 = [venuesList2 objectForKey:@"venue"];
    venuesList3 = [venuesList3 objectForKey:@"venue"];
    venuesList4 = [venuesList4 objectForKey:@"venue"];
    
    rightAnswerList = [[NSMutableArray alloc]init];
    [rightAnswerList addObject:(NSString *)[venuesList1 objectForKey:@"name"]];
    [rightAnswerList addObject:(NSString *)[venuesList2 objectForKey:@"name"]];
    [rightAnswerList addObject:(NSString *)[venuesList3 objectForKey:@"name"]];
    [rightAnswerList addObject:(NSString *)[venuesList4 objectForKey:@"name"]];
 
    NSDictionary *otherVenue;
    otherAnswerList = [[NSMutableArray alloc]init ];
    for (int j=0; j<12; j++)  {
        //questList[j] = arc4random_uniform(venueMax);
        otherVenue = [venueItems objectAtIndex:arc4random_uniform(venueMax)];
        [otherAnswerList addObject:(NSString *)[[otherVenue objectForKey:@"venue" ] objectForKey:@"name"]] ;
    }

    //go to main game
    if (game2ViewController == nil)  {
        game2ViewController=[[PPGame2ViewController alloc] initWithNibName:@"PPGame2ViewController" bundle:nil ];
    }
    game2ViewController.venue1 = venuesList1;
    game2ViewController.venue2 = venuesList2;
    game2ViewController.venue3 = venuesList3;
    game2ViewController.venue4 = venuesList4;
    game2ViewController.rightAnswerList = rightAnswerList;
    game2ViewController.otherAnswerList = otherAnswerList;
    game2ViewController.location = _location;
    [self presentViewController:game2ViewController animated:YES completion:nil];

}
@end
