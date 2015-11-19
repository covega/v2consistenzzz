//
//  ViewController+home.h
//  consistenzzz
//
//  Created by Nate Lohn on 11/19/15.
//  Copyright © 2015 the dream team. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (home)

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
