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
@property (weak, nonatomic) IBOutlet UIButton *setUpButton;


@property (weak, nonatomic) IBOutlet UIDatePicker *sleepTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *wakeTimePicker;
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
@property (weak, nonatomic) IBOutlet UIImageView *bedImageView;

//countdown
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;


@property(nonatomic) float want;
@property(nonatomic) float get;
@property(nonatomic) bool setUp;

@property (weak, nonatomic) IBOutlet UILabel *debtLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIView *setUpView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
- (IBAction)calculatePushed:(id)sender;






@end