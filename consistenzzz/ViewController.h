//
//  ViewController.h
//  consistenzzz
//
//  Created by John Nathaniel Morgan on 11/13/15.
//  Copyright (c) 2015 the dream team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *sleepTimePicker;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
- (IBAction)timeButtonPushed:(id)sender;
- (IBAction)setButtonPushed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *setButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sleepWakeController;
- (IBAction)sleepWakeControllerPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *sleepAmountLabel;


@property (weak, nonatomic) IBOutlet UIButton *sleepTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *wakeTimeButton;

@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sleepTime;
@property (weak, nonatomic) IBOutlet UILabel *wakeTime;

@property (weak, nonatomic) IBOutlet UILabel *countdownHours;
@property (weak, nonatomic) IBOutlet UILabel *countdownMinutes;

@property (weak, nonatomic) IBOutlet UIButton *sleepNowButton;

// all graphics for main
@property (weak, nonatomic) IBOutlet UIImageView *zero;
@property (weak, nonatomic) IBOutlet UIImageView *five;
@property (weak, nonatomic) IBOutlet UIImageView *ten;
@property (weak, nonatomic) IBOutlet UIImageView *fifteen;
@property (weak, nonatomic) IBOutlet UIImageView *twenty;
@property (weak, nonatomic) IBOutlet UIImageView *twentyFive;
@property (weak, nonatomic) IBOutlet UIImageView *thirty;
@property (weak, nonatomic) IBOutlet UIImageView *thirtyFive;
@property (weak, nonatomic) IBOutlet UIImageView *fourty;
@property (weak, nonatomic) IBOutlet UIImageView *fourtyFive;
@property (weak, nonatomic) IBOutlet UIImageView *fifty;
@property (weak, nonatomic) IBOutlet UIImageView *fiftyFive;
@property (weak, nonatomic) IBOutlet UIImageView *sixty;
@property (weak, nonatomic) IBOutlet UIImageView *sixtyFive;
@property (weak, nonatomic) IBOutlet UIImageView *seventy;
@property (weak, nonatomic) IBOutlet UIImageView *seventyFive;

@property (weak, nonatomic) IBOutlet UIImageView *eighty;
@property (weak, nonatomic) IBOutlet UIImageView *eightyFive;
@property (weak, nonatomic) IBOutlet UIImageView *ninety;
@property (weak, nonatomic) IBOutlet UIImageView *ninetyFive;
@property (weak, nonatomic) IBOutlet UIImageView *hundred;

@property(nonatomic) float want;
@property(nonatomic) float get;
@property (weak, nonatomic) IBOutlet UILabel *debtLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;



@end