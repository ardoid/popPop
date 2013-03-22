//
//  PPGame2ViewController.m
//  PopPop
//
//  Created by Ardo Septama on 21.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import "PPGame2ViewController.h"
#import "PPCacheImage.h"
#import "QuartzCore/QuartzCore.h"
#import "AudioToolbox/AudioToolbox.h"

@interface PPGame2ViewController ()

@end

@implementation PPGame2ViewController

@synthesize imgPlat;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        reqCount = 1;
        gameCount = 0;
        score = 0;
        shaken = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _locLabel.text =  [NSString stringWithFormat: @"Location: %@",_location ];
    [_butt1.layer setCornerRadius:7.0f];
    _butt1.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt2.layer setCornerRadius:7.0f];
    _butt2.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt3.layer setCornerRadius:7.0f];
    _butt3.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt4.layer setCornerRadius:7.0f];
    _butt4.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt1 setTitle:[_rightAnswerList objectAtIndex:0] forState:UIControlStateNormal];
    [_butt2 setTitle:[_rightAnswerList objectAtIndex:1] forState:UIControlStateNormal];
    [_butt3 setTitle:[_rightAnswerList objectAtIndex:2] forState:UIControlStateNormal];
    [_butt4 setTitle:[_rightAnswerList objectAtIndex:3] forState:UIControlStateNormal];
    [self disableButt];

//    [_butt2 setTitle:[_otherAnswerList objectAtIndex:0] forState:UIControlStateNormal];
//    [_butt3 setTitle:[_otherAnswerList objectAtIndex:1] forState:UIControlStateNormal];
//    [_butt4 setTitle:[_otherAnswerList objectAtIndex:2] forState:UIControlStateNormal];
//    [_butt1 addTarget:self action:@selector(playClick)  forControlEvents:UIControlEventTouchUpInside];

    PPCacheImage *cacheImg = [[PPCacheImage alloc] init];
    [cacheImg removeImage:@"venue11.jpg"];
    [cacheImg removeImage:@"venue12.jpg"];
    [cacheImg removeImage:@"venue21.jpg"];
    [cacheImg removeImage:@"venue22.jpg"];
    [cacheImg removeImage:@"venue31.jpg"];
    [cacheImg removeImage:@"venue32.jpg"];
    [cacheImg removeImage:@"venue41.jpg"];
    [cacheImg removeImage:@"venue42.jpg"];
    
    self.responseData = [NSMutableData data];
    
    //request to 4sq
    NSString *venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue1 objectForKey:@"id"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueReqURL]];
    [NSURLConnection connectionWithRequest:request delegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // extract pictures from 4sq
    NSArray *picLocA = [[[[res objectForKey:@"response"] objectForKey:@"venue"] objectForKey:@"photos"] objectForKey:@"groups"];
    NSDictionary *picLocD = [picLocA objectAtIndex:0];
    picLocA = [picLocD objectForKey:@"items"];
    picLocD = [picLocA objectAtIndex:0];
    NSMutableString *imageReqURL = (NSMutableString *)[picLocD objectForKey:@"prefix"];  //@"https://irs3.4sqi.net/img/general/240x240/%@.jpg";
    int imageReqIndex = 1;
    [imageReqURL appendString:@"240x240"];
    [imageReqURL appendString:(NSString *)[picLocD objectForKey:@"suffix"]];
    PPCacheImage *cacheImg = [[PPCacheImage alloc] init];
    NSString *imgFileName = [NSString stringWithFormat:@"venue%d%d.jpg",reqCount, imageReqIndex];
    [cacheImg cacheImage:imageReqURL imageFile:imgFileName];
    //again for 2nd pic
    picLocA = [[[[res objectForKey:@"response"] objectForKey:@"venue"] objectForKey:@"photos"] objectForKey:@"groups"];
    picLocD = [picLocA objectAtIndex:0];
    picLocA = [picLocD objectForKey:@"items"];
    picLocD = [picLocA objectAtIndex:1];
    imageReqURL = (NSMutableString *)[picLocD objectForKey:@"prefix"];  
    [imageReqURL appendString:@"240x240"];
    [imageReqURL appendString:(NSString *)[picLocD objectForKey:@"suffix"]];
    imageReqIndex = 2;
    imgFileName = [NSString stringWithFormat:@"venue%d%d.jpg",reqCount, imageReqIndex];
    [cacheImg cacheImage:imageReqURL imageFile:imgFileName];

    //reset button
    [_butt1.layer setCornerRadius:7.0f];
    _butt1.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt2.layer setCornerRadius:7.0f];
    _butt2.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt3.layer setCornerRadius:7.0f];
    _butt3.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    [_butt4.layer setCornerRadius:7.0f];
    _butt4.backgroundColor = [UIColor whiteColor];
    //[_butt1.layer setClipToBounds:YES];
    
    //display the image
    imageReqIndex = 1;
    imgFileName = [NSString stringWithFormat:@"venue%d%d.jpg",reqCount, imageReqIndex];
    if (gameCount<4) [imgPlat setImage:[cacheImg getCachedImage:imgFileName]];
    gameCount++; // start the game !!!
    if (gameCount == 2)  {
        [_butt1 setTitle:[_otherAnswerList objectAtIndex:3] forState:UIControlStateNormal];
        [_butt2 setTitle:[_otherAnswerList objectAtIndex:4] forState:UIControlStateNormal];
        [_butt3 setTitle:[_otherAnswerList objectAtIndex:5] forState:UIControlStateNormal];
        [_butt4 setTitle:[_rightAnswerList objectAtIndex:1] forState:UIControlStateNormal];
    } else if (gameCount ==3)  {
        [_butt1 setTitle:[_otherAnswerList objectAtIndex:6] forState:UIControlStateNormal];
        [_butt2 setTitle:[_otherAnswerList objectAtIndex:7] forState:UIControlStateNormal];
        [_butt4 setTitle:[_otherAnswerList objectAtIndex:8] forState:UIControlStateNormal];        
        [_butt3 setTitle:[_rightAnswerList objectAtIndex:2] forState:UIControlStateNormal];
    } else if (gameCount ==4)  {
        [_butt1 setTitle:[_otherAnswerList objectAtIndex:9] forState:UIControlStateNormal];
        [_butt4 setTitle:[_otherAnswerList objectAtIndex:10] forState:UIControlStateNormal];
        [_butt3 setTitle:[_otherAnswerList objectAtIndex:11] forState:UIControlStateNormal];        
        [_butt2 setTitle:[_rightAnswerList objectAtIndex:3] forState:UIControlStateNormal];
    }
    [self enableButt];

    if (gameCount>4)  {
        if (resultViewController == nil)  {
            resultViewController=[[PPResultViewController alloc] initWithNibName:@"PPResultViewController" bundle:nil ];
        }
        resultViewController.scoreFin = [NSString stringWithFormat:@"%d",score];
        [self presentViewController:resultViewController animated:YES completion:nil];
    }
}
- (IBAction)butt1press:(id)sender {
    [self disableButt];
    NSString *a = (NSString *)_butt1.titleLabel.text;
    a = _rightAnswerList[gameCount-1];
    if (gameCount == 0)  {
    } else if ([(NSString *)_rightAnswerList[gameCount-1] isEqualToString:(NSString *)_butt1.titleLabel.text])  { //gameCount == 1)  {
        _butt1.backgroundColor = [UIColor greenColor];
        _butt1.layer.borderColor = [UIColor blackColor].CGColor;
        if (shaken)  {
            score = score + 2;
            shaken = NO;
        } else {
            score = score + 5;
        }
        _scoreDisplay.text = [NSString stringWithFormat:@"Score: %d",score];

        //reqCount++;
        //gameCount++;
    } else {
        _butt1.backgroundColor = [UIColor redColor];
        
    }
    //request to 4sq again
    if (gameCount<5)  {
        reqCount++;
        //gameCount++;
        NSString *venueReqURL;
        if (gameCount==1)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue2 objectForKey:@"id"]];
        }
        if (gameCount==2)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue3 objectForKey:@"id"]];
        }
        if (gameCount==3)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        if (gameCount==4)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueReqURL]];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (IBAction)butt2press:(id)sender {
    [self disableButt];
    if (gameCount == 0)  {
    } else if ([(NSString *)_rightAnswerList[gameCount-1] isEqualToString:(NSString *)_butt2.titleLabel.text])  {
        _butt2.backgroundColor = [UIColor greenColor];
        _butt2.layer.borderColor = [UIColor blackColor].CGColor;
        if (shaken)  {
            score = score + 2;
            shaken = NO;
        } else {
            score = score + 5;
        }
        _scoreDisplay.text = [NSString stringWithFormat:@"Score: %d",score];
        
        //reqCount++;
        //gameCount++;
    } else {
        _butt2.backgroundColor = [UIColor redColor];
        
    }
    //request to 4sq again
    if (gameCount<5)  {
        reqCount++;
        //gameCount++;
        NSString *venueReqURL;
        if (gameCount==1)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue2 objectForKey:@"id"]];
        }
        if (gameCount==2)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue3 objectForKey:@"id"]];
//            [_butt1 setTitle:[_otherAnswerList objectAtIndex:6] forState:UIControlStateNormal];
//            [_butt2 setTitle:[_otherAnswerList objectAtIndex:7] forState:UIControlStateNormal];
//            [_butt4 setTitle:[_otherAnswerList objectAtIndex:8] forState:UIControlStateNormal];
        }
        if (gameCount==3)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
//            [_butt1 setTitle:[_otherAnswerList objectAtIndex:9] forState:UIControlStateNormal];
//            [_butt2 setTitle:[_otherAnswerList objectAtIndex:10] forState:UIControlStateNormal];
//            [_butt3 setTitle:[_otherAnswerList objectAtIndex:11] forState:UIControlStateNormal];
        }
        if (gameCount==4)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueReqURL]];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (IBAction)butt3press:(id)sender {
    [self disableButt];
    if (gameCount == 0)  {
    } else if ([(NSString *)_rightAnswerList[gameCount-1] isEqualToString:(NSString *)_butt3.titleLabel.text])  {
        _butt3.backgroundColor = [UIColor greenColor];
        _butt3.layer.borderColor = [UIColor blackColor].CGColor;
        if (shaken)  {
            score = score + 2;
            shaken = NO;
        } else {
            score = score + 5;
        }
        _scoreDisplay.text = [NSString stringWithFormat:@"Score: %d",score];
        
        //reqCount++;
        //gameCount++;
    } else {
        _butt3.backgroundColor = [UIColor redColor];
        
    }
    //request to 4sq again
    if (gameCount<5)  {
        reqCount++;
        //gameCount++;
        NSString *venueReqURL;
        if (gameCount==1)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue2 objectForKey:@"id"]];
        }
        if (gameCount==2)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue3 objectForKey:@"id"]];
        }
        if (gameCount==3)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        if (gameCount==4)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueReqURL]];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (IBAction)butt4press:(id)sender {
    [self disableButt];
    if (gameCount == 0)  {
    } else if ([(NSString *)_rightAnswerList[gameCount-1] isEqualToString:(NSString *)_butt4.titleLabel.text])  {
        _butt4.backgroundColor = [UIColor greenColor];
        _butt4.layer.borderColor = [UIColor blackColor].CGColor;
        if (shaken)  {
            score = score + 2;
            shaken = NO;
        } else {
            score = score + 5;
        }
        _scoreDisplay.text = [NSString stringWithFormat:@"Score: %d",score];
        
        //reqCount++;
        //gameCount++;
    } else {
        _butt4.backgroundColor = [UIColor redColor];
        
    }
    //request to 4sq again
    if (gameCount<5)  {
        reqCount++;
        //gameCount++;
        NSString *venueReqURL;
        if (gameCount==1)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue2 objectForKey:@"id"]];
        }
        if (gameCount==2)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue3 objectForKey:@"id"]];
        }
        if (gameCount==3)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        if (gameCount==4)  {
            venueReqURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=XQSZNOVPVQZ2E4ME5DTLXETSCN1H1TGJ00GEJDQPERI1SFOO&v=20130321", (NSString *)[_venue4 objectForKey:@"id"]];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueReqURL]];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    PPCacheImage *cacheImg = [[PPCacheImage alloc] init];
    if (motion == UIEventSubtypeMotionShake)
    {
        int imageReqIndex = 2;
        NSString *imgFileName = [NSString stringWithFormat:@"venue%d%d.jpg",reqCount, imageReqIndex];
        [imgPlat setImage:[cacheImg getCachedImage:imgFileName]];
        shaken = YES;
    }
}

- (void) disableButt  {
    _butt1.userInteractionEnabled = NO;
    _butt2.userInteractionEnabled = NO;
    _butt3.userInteractionEnabled = NO;
    _butt4.userInteractionEnabled = NO;    
}

- (void) enableButt  {
    _butt1.userInteractionEnabled = YES;
    _butt2.userInteractionEnabled = YES;
    _butt3.userInteractionEnabled = YES;
    _butt4.userInteractionEnabled = YES;
}

- (IBAction)playClick
{
//    NSString *effect;
//    NSString *type;
//    effect = @"button-3";
//    type = @"wav";
//    SystemSoundID soundID;
//    NSString *path = [[NSBundle mainBundle] pathForResource:effect ofType:type];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)url, &soundID);
//    AudioServicesPlaySystemSound(soundID);
}
//      [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
//        [_butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _butt1.layer.borderWidth = 0.5f;
//        _butt1.layer.cornerRadius = 10.0f;

@end
