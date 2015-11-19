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


//Set up screen
@property (weak, nonatomic) IBOutlet UILabel *wantLabel;
@property (weak, nonatomic) IBOutlet UIStepper *wantStepper;
- (IBAction)wantPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *getLabel;
@property (weak, nonatomic) IBOutlet UIStepper *getStepper;
- (IBAction)getPressed:(id)sender;

- (IBAction)setUpPushed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *debtLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

//home screen
@property (weak, nonatomic) IBOutlet UIDatePicker *sleepTimePicker;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UIButton *sleepTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *wakeTimeButton;

@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sleepTime;
@property (weak, nonatomic) IBOutlet UILabel *wakeTime;


@end