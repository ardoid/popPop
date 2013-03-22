//
//  PPResultViewController.h
//  PopPop
//
//  Created by Ardo Septama on 21.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreFinal;
@property (nonatomic, strong) NSString *scoreFin;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (IBAction)gameOver:(id)sender;

@end
