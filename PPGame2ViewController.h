//
//  PPGame2ViewController.h
//  PopPop
//
//  Created by Ardo Septama on 21.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPResultViewController.h"

@interface PPGame2ViewController : UIViewController
{
    int reqCount;
    int gameCount;    
    int score;
    BOOL shaken;
    PPResultViewController *resultViewController;
}

@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) NSDictionary *venue1;
@property (nonatomic, strong) NSDictionary *venue2;
@property (nonatomic, strong) NSDictionary *venue3;
@property (nonatomic, strong) NSDictionary *venue4;
@property (nonatomic, strong) NSArray *rightAnswerList;
@property (nonatomic, strong) NSArray *otherAnswerList;

@property (nonatomic, strong) NSString *location;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreDisplay;

@property (weak, nonatomic) IBOutlet UIImageView *imgPlat;
@property (weak, nonatomic) IBOutlet UIButton *butt1;
@property (weak, nonatomic) IBOutlet UIButton *butt2;
@property (weak, nonatomic) IBOutlet UIButton *butt3;
@property (weak, nonatomic) IBOutlet UIButton *butt4;

- (IBAction)butt1press:(id)sender;
- (IBAction)butt2press:(id)sender;
- (IBAction)butt3press:(id)sender;
- (IBAction)butt4press:(id)sender;

-(BOOL)canBecomeFirstResponder;
-(void)viewDidAppear:(BOOL)animated;
-(void)viewWillDisappear:(BOOL)animated;
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
-(void)disableButt;
-(void)enableButt;
-(IBAction)playClick;

@end
