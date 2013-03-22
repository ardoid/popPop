//
//  PPMainViewController.h
//  PopPop
//
//  Created by Ardo Septama on 20.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGameViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PPMainViewController : UIViewController <CLLocationManagerDelegate>
{
    PPGameViewController *gameViewController;
}

@property (nonatomic, strong) CLLocationManager *myLocationManager;
@property (weak, nonatomic) IBOutlet UILabel *relocateLabel;

- (IBAction)singleBtnClicked:(id)sender;
- (IBAction)vsBtnClicked:(id)sender;
- (IBAction)relocateBtnClicked:(id)sender;

@end
