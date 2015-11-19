//
//  ViewController.m
//  consistenzzz
//
//  Created by John Nathaniel Morgan on 11/13/15.
//  Copyright (c) 2015 the dream team. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

NSDate * sleepPickerTime;
NSDate * wakePickerTime;

- (IBAction)setNotificationTime:(id)sender {
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.alertAction = @"Go To App";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    //get picker time
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _sleepTimePicker.date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if(hour > 12){
        hour = hour-12;
    }
    NSString *hourString = [NSString stringWithFormat:@"%ld:", (long)hour];
    
    NSString *minuteString = [NSString stringWithFormat:@"%ld", (long)minute];
    NSUInteger length = [minuteString length];
    
    if(length < 2){
        NSString *zero = @"0";
        minuteString = [zero stringByAppendingString:minuteString];
    }
    
    //set stuff
    if(_sleepTimeButton.enabled == NO){
        //set sleepTime to be label to be this value, keep hidden
        sleepPickerTime = _sleepTimePicker.date;
        _sleepTime.text = [hourString stringByAppendingString:minuteString];
        _sleepTime.hidden = YES;
        
        localNotification.fireDate = sleepPickerTime;
        localNotification.alertBody = @"Sleep time";
    } else if (_wakeTimeButton.enabled == NO){
        //set wake time label to be this value, keep hidden
        wakePickerTime = _sleepTimePicker.date;
        
        
        _wakeTime.text = [hourString stringByAppendingString:minuteString];
        _wakeTime.hidden = YES;
        
        localNotification.fireDate = wakePickerTime;
        localNotification.alertBody = @"Wake Up time";
        localNotification.soundName = @"alarm-clock-sound.caf";
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

//if sleepTimeButton is enabled, that means wake time is currently selected in picker
- (IBAction)displaySleepTime:(id)sender {
    if(_sleepTimeButton.enabled == YES){
        _wakeTimeButton.enabled = YES;
        _wakeTimeLabel.hidden = NO;
        _wakeTime.hidden = NO;
        
        _sleepTime.hidden = YES;
        _sleepTimeLabel.hidden = YES;
        
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        

        if(sleepPickerTime){
            [_sleepTimePicker setDate:sleepPickerTime];
        }
        
        
    }
    _sleepTimeButton.enabled = NO;
}

//if wakeTimeButton is enabled, that means sleep time is currently selected in picker
- (IBAction)displayWakeTime:(id)sender {
    if(_wakeTimeButton.enabled == YES){
        _sleepTimeButton.enabled = YES;
        _sleepTime.hidden = NO;
        _sleepTimeLabel.hidden = NO;
        
        _wakeTime.hidden = YES;
        _wakeTimeLabel.hidden = YES;

        if(wakePickerTime){
            [_sleepTimePicker setDate:wakePickerTime];
        }
        
    }
    _wakeTimeButton.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                              categories:nil]];
    }
    //__block UITextField *localTextField;
    _wakeTimeButton.enabled = YES;
    _wakeTimeLabel.hidden = NO;
    _sleepTimeLabel.hidden = YES;
    _wakeTime.hidden = YES;
    _sleepTimeButton.enabled = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
