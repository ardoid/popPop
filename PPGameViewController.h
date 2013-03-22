//
//  PPGameViewController.h
//  PopPop
//
//  Created by Ardo Septama on 20.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGame2ViewController.h"

@interface PPGameViewController : UIViewController
{
    NSDictionary *cityList;
    NSDictionary *quizList;
    NSArray *answerList1;
    NSArray *answerList2;
    NSArray *answerList3;
    NSArray *answerList4;
    NSMutableArray *rightAnswerList;
    NSMutableArray *otherAnswerList;
    PPGame2ViewController *game2ViewController;
}

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *location;

@property (weak, nonatomic) IBOutlet UILabel *locLabel;

@end
