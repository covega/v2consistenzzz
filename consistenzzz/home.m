//
//  home.m
//  consistenzzz
//
//  Created by Nate Lohn on 11/19/15.
//  Copyright © 2015 the dream team. All rights reserved.
//

#import "home.h"

@implementation home

//NSDate * sleepPickerTime;
//NSDate * wakePickerTime;
//
////if sleepTimeButton is enabled, that means wake time is currently selected in picker
//- (IBAction)displaySleepTime:(id)sender {
//    if(_sleepTimeButton.enabled == YES){
//        _wakeTimeButton.enabled = YES;
//        _wakeTimeLabel.hidden = NO;
//        _wakeTime.hidden = NO;
//
//        _sleepTime.hidden = YES;
//        _sleepTimeLabel.hidden = YES;
//
//        wakePickerTime = _sleepTimePicker.date;
//        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        NSCalendar * calendar = [NSCalendar currentCalendar];
//        NSDateComponents *components = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: wakePickerTime];
//
//        NSInteger hour = [components hour];
//        NSInteger minute = [components minute];
//        if(hour > 12){
//            hour = hour-12;
//        }
//        NSString *hourString = [NSString stringWithFormat:@"%ld:", (long)hour];
//
//        NSString *minuteString = [NSString stringWithFormat:@"%ld", (long)minute];
//        NSUInteger length = [minuteString length];
//        if(length < 2){
//            NSString *zero = @"0";
//            minuteString = [zero stringByAppendingString:minuteString];
//        }
//
//        _wakeTime.text = [hourString stringByAppendingString:minuteString];
//
//        if(sleepPickerTime){
//            [_sleepTimePicker setDate:sleepPickerTime];
//        }
//
//        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//        localNotification.fireDate = sleepPickerTime;
//        localNotification.alertBody = @"Wake Up time";
//        localNotification.alertAction = @"Go To App";
//        localNotification.timeZone = [NSTimeZone defaultTimeZone];
//        //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    }
//    _sleepTimeButton.enabled = NO;
//}
//
////if wakeTimeButton is enabled, that means sleep time is currently selected in picker
//- (IBAction)displayWakeTime:(id)sender {
//    if(_wakeTimeButton.enabled == YES){
//        _sleepTimeButton.enabled = YES;
//        _sleepTime.hidden = NO;
//        _sleepTimeLabel.hidden = NO;
//
//        _wakeTime.hidden = YES;
//        _wakeTimeLabel.hidden = YES;
//
//        sleepPickerTime = _sleepTimePicker.date;
//
//        NSCalendar * calendar = [NSCalendar currentCalendar];
//        NSDateComponents *components = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: sleepPickerTime];
//
//        NSInteger hour = [components hour];
//        NSInteger minute = [components minute];
//        if(hour > 12){
//            hour = hour-12;
//        }
//        NSString *hourString = [NSString stringWithFormat:@"%ld:", (long)hour];
//
//        NSString *minuteString = [NSString stringWithFormat:@"%ld", (long)minute];
//        NSUInteger length = [minuteString length];
//        if(length < 2){
//            NSString *zero = @"0";
//            minuteString = [zero stringByAppendingString:minuteString];
//        }
//        _sleepTime.text = [hourString stringByAppendingString:minuteString];
//        if(wakePickerTime){
//            [_sleepTimePicker setDate:wakePickerTime];
//        }
//
//
//        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//        localNotification.fireDate = sleepPickerTime;
//        localNotification.alertBody = @"Sleep time";
//        localNotification.alertAction = @"Go To App";
//        localNotification.timeZone = [NSTimeZone defaultTimeZone];
//        //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//
//    }
//    _wakeTimeButton.enabled = NO;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
//                                                                                                              categories:nil]];
//    }
//    //__block UITextField *localTextField;
//    _wakeTimeButton.enabled = YES;
//    _wakeTimeLabel.hidden = NO;
//    _sleepTimeLabel.hidden = YES;
//    _wakeTime.hidden = YES;
//    _sleepTimeButton.enabled = NO;
//
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//

@end
