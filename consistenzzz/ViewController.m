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
bool sleepTimeSet = false;
bool wakeTimeSet = false;
int IMAGE_COUNT = 20;


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
    //12 hour time, not 24 hour bs
    if(hour > 12){
        hour = hour-12;
    }
    NSString *hourString = [NSString stringWithFormat:@"%ld:", (long)hour];
    
    NSString *minuteString = [NSString stringWithFormat:@"%ld", (long)minute];
    NSUInteger length = [minuteString length];
    
    //make sure it is human readable and has 0s
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
        
        //schedule alert
        //NATE ADDED CODE HERE
        UILocalNotification* preBedAlert = [[UILocalNotification alloc] init];
        preBedAlert.alertAction = @"Go To App";
        preBedAlert.timeZone = [NSTimeZone defaultTimeZone];
        
        NSDate * preBedDate = [sleepPickerTime dateByAddingTimeInterval:-60*30];
        
        preBedAlert.fireDate = preBedDate;
        preBedAlert.alertBody = @"Less than 30 mins until bedtime!";
        [[UIApplication sharedApplication] scheduleLocalNotification: preBedAlert];
        
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


- (void) updateBedtimeCountdown {
    //NSDate Time - currentTime
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    if(sleepPickerTime){
        NSDateComponents *conversionInfo = [calendar components:unitFlags   fromDate:now  toDate:sleepPickerTime  options:0];
    
        long hours = [conversionInfo hour];
        long minutes = [conversionInfo minute] + 1;
    
        NSString *hourString = [NSString stringWithFormat:@"%ld", hours];
    
        NSString *minuteString = [NSString stringWithFormat:@"%ld", minutes];
        NSUInteger length = [minuteString length];
        //make sure it is human readable and has 0s
        if(length < 2){
            NSString *zero = @"0";
            minuteString = [zero stringByAppendingString:minuteString];
        }
    
        length = [hourString length];
        if(length < 2){
            NSString *zero = @"0";
            hourString = [zero stringByAppendingString:hourString];
        }
    
        _countdownHours.text = hourString;
        _countdownMinutes.text = minuteString;
    }
    
    [self performSelector:@selector(updateBedtimeCountdown) withObject:self afterDelay:1.0];
    
}

- (IBAction)sleepNow:(id)sender {
    NSDate * now = [NSDate date];
    _sleepTimePicker.date = now;
    sleepPickerTime = now;
}

- (void)viewDidLoad {
//    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:IMAGE_COUNT];
//    
//    //build array of images, cycling through image names
//    int increment = 5;
//    for(int i = 0; i < IMAGE_COUNT; i++)
//        
//        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]]];
//    
//    //another short example:
//    for (int c=0;c<300;c++)
//    {
//        NSString *imageName = [NSString stringWithFormat:@"name%d.png", c];
//        [UIImage imageNamed: imageName];
//    }
    
    
    [super viewDidLoad];
    _sleepTimePicker.hidden = YES;
    _wakeTimePicker.hidden = YES;
    _setButton.hidden = YES;
    _sleepAmountLabel.hidden = YES;
    
    
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                              categories:nil]];
    }

    
    [self updateBedtimeCountdown];
    // Do any additional setup after loading the view, typically from a nib.
    
    // start home screen graphics
    _zero.hidden = YES; // hide all graphics
    _five.hidden = YES;
    _ten.hidden = YES;
    _fifteen.hidden = YES;
    _twenty.hidden = YES;
    _twentyFive.hidden = YES;
    _thirty.hidden = YES;
    _thirtyFive.hidden = YES;
    _fourty.hidden = YES;
    _fourtyFive.hidden = YES;
    _fifty.hidden = YES;
    _fiftyFive.hidden = YES;
    _sixty.hidden = YES;
    _sixtyFive.hidden = YES;
    _seventy.hidden = YES;
    _seventyFive.hidden = YES;
    _eighty.hidden = YES;
    _eightyFive.hidden = YES;
    _ninety.hidden = YES;
    _ninetyFive.hidden = YES;
    _hundred.hidden = YES;
    
    
    //sleep debt/percentage logic
    float minSleep = 0;
    float days = 14;
    float want = self.want;
    float get = self.get;
    float debt = days * (get - ((24 - get) * (want/(24 - want))));
    float maxSleepDebt = days * (minSleep - ((24 - minSleep) * (want/(24 - want))));
    float percentage = 1 - (debt/maxSleepDebt);
    int debtHours = (debt / 1);
    int debtMins = ((debt - debtHours) * 60) / 1;
    int percentDisplay = (percentage * 100) / 1;
    self.debtLabel.text = [NSString stringWithFormat:@"Sleep Debt = %d hrs %d min", -debtHours, -debtMins];
    self.percentLabel.text = [NSString stringWithFormat:@"Functioning at %d%%", percentDisplay];
    
    int screen = ((100 * percentage) / 5);
    
    switch (screen) { // show one graphic
        case 0:
            _zero.hidden = NO;
            break;
        case 1:
            _five.hidden = NO;
            break;
        case 2:
            _ten.hidden = NO;
            break;
        case 3:
            _fifteen.hidden = NO;
            break;
        case 4:
            _twenty.hidden = NO;
            break;
        case 5:
            _twentyFive.hidden = NO;
            break;
        case 6:
            _thirty.hidden = NO;
            break;
        case 7:
            _thirtyFive.hidden = NO;
            break;
        case 8:
            _fourty.hidden = NO;
            break;
        case 9:
            _fourtyFive.hidden = NO;
            break;
        case 10:
            _fifty.hidden = NO;
            break;
        case 11:
            _fiftyFive.hidden = NO;
            break;
        case 12:
            _sixty.hidden = NO;
            break;
        case 13:
            _sixtyFive.hidden = NO;
            break;
        case 14:
            _seventy.hidden = NO;
            break;
        case 15:
            _seventyFive.hidden = NO;
            break;
        case 16:
            _eighty.hidden = NO;
            break;
        case 17:
            _ninety.hidden = NO;
            break;
        case 18:
            _ninetyFive.hidden = NO;
            break;
        case 19:
            _hundred.hidden = NO;
            break;
        default:
            _hundred.hidden = NO;
            break;
    }
    // end home graphics
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)timeButtonPushed:(id)sender {
    //toggle
    _timeButton.hidden = YES;
    _setButton.hidden = NO;
    if(_sleepWakeController.selectedSegmentIndex == 0){
        _sleepTimePicker.hidden = NO;
    } else {
        _wakeTimePicker.hidden = NO;
    }

}

//this still has the notification stuff in it.. not sure if it needs to
- (IBAction)setButtonPushed:(id)sender {
    NSLog(@"Set pushed!");
    //toggle
    _timeButton.hidden = NO;
    _sleepTimePicker.hidden = YES;
    _wakeTimePicker.hidden = YES;
    _setButton.hidden = YES;
    
    
    //Stuff from John's Code
    //--------------------------
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Go To App";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //get picker time
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    if(_sleepWakeController.selectedSegmentIndex == 0){
        components = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _sleepTimePicker.date];
    } else {
        components = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _wakeTimePicker.date];
    }
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSString *amORpm = @"AM";
    
    //12 hour time, not that 24 hour bs
    if(hour > 12){
        amORpm = @"PM";
        hour = hour-12;
    }
    //removing 0 o'clock
    if (hour == 0) {
        hour = 12;
    }
    NSString *hourString = [NSString stringWithFormat:@"%ld:", (long)hour];
    NSString *minuteString = [NSString stringWithFormat:@"%ld ", (long)minute];
    
    
    //make sure it is human readable and has 0s
    if( (long)minute < 10){
        NSString *zero = @"0";
        minuteString = [zero stringByAppendingString:minuteString];
    }
    
    
    //set stuff
    if(_sleepWakeController.selectedSegmentIndex == 0){
        sleepTimeSet = true;
        //set sleepTime to be label to be this value, keep hidden
        sleepPickerTime = _sleepTimePicker.date;
        minuteString = [minuteString stringByAppendingString:amORpm]; //add am/pm to time label
        _sleepTime.text = [hourString stringByAppendingString:minuteString];
        [_timeButton setTitle:_sleepTime.text forState:UIControlStateNormal];
        
        localNotification.fireDate = sleepPickerTime;
        localNotification.alertBody = @"Sleep time";
        
        //schedule alert
        UILocalNotification* preBedAlert = [[UILocalNotification alloc] init];
        preBedAlert.alertAction = @"Go To App";
        preBedAlert.timeZone = [NSTimeZone defaultTimeZone];
        
        NSDate * preBedDate = [sleepPickerTime dateByAddingTimeInterval:-60*30];
        
        preBedAlert.fireDate = preBedDate;
        preBedAlert.alertBody = @"Less than 30 mins until bedtime!";
        [[UIApplication sharedApplication] scheduleLocalNotification: preBedAlert];
        
    } else if (_sleepWakeController.selectedSegmentIndex == 1){
        wakeTimeSet = true;
        //set wake time label to be this value, keep hidden
        wakePickerTime = _wakeTimePicker.date;
        
        minuteString = [minuteString stringByAppendingString:amORpm]; //add am/pm to time label
        _wakeTime.text = [hourString stringByAppendingString:minuteString];
        [_timeButton setTitle:_wakeTime.text forState:UIControlStateNormal];
        
        localNotification.fireDate = wakePickerTime;
        localNotification.alertBody = @"Wake Up Time!";
        localNotification.soundName = @"alarm-clock-sound.caf";
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    //sleep ammount logic
    if (sleepTimeSet && wakeTimeSet){
        NSDateComponents *sleepComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: sleepPickerTime];
        NSDateComponents *wakeComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: wakePickerTime];
        NSInteger sleepHour = [sleepComponents hour];
        NSInteger sleepMinute = [sleepComponents minute];
        NSInteger wakeHour = [wakeComponents hour];
        NSInteger wakeMinute = [wakeComponents minute];
        long totalHours = -1;
        long totalMinutes = -1;
        if(sleepHour >= wakeHour){
            totalHours = 24 + (wakeHour - sleepHour);
        } else {
            totalHours = wakeHour - sleepHour;
        }
        if (sleepMinute > wakeMinute) {
            totalMinutes = 60 + (wakeMinute - sleepMinute);
            totalHours = totalHours - 1;
        } else {
            totalMinutes = wakeMinute - sleepMinute;
        }
        _sleepAmountLabel.text = [NSString stringWithFormat:@"%ld hrs and %ld mins of sleep", totalHours,totalMinutes];
        _sleepAmountLabel.hidden = NO;
    }
    
    //Next action text
    if (!sleepTimeSet) {
        _sleepWakeController.selectedSegmentIndex = 0;
        [_timeButton setTitle:@"Set Bed Time"forState:UIControlStateNormal];
    }
    if (!wakeTimeSet) {
        _sleepWakeController.selectedSegmentIndex = 1;
        [_timeButton setTitle:@"Set Wake Time"forState:UIControlStateNormal];
    }
}
- (IBAction)sleepWakeControllerPushed:(id)sender {
    _timeButton.hidden = NO;
    _sleepTimePicker.hidden = YES;
    _wakeTimePicker.hidden = YES;
    _setButton.hidden = YES;
    if (_sleepWakeController.selectedSegmentIndex == 1){
        if(wakeTimeSet){
            [_timeButton setTitle:_wakeTime.text forState:UIControlStateNormal];
        } else {
            [_timeButton setTitle:@"Set Wake Time"forState:UIControlStateNormal];
        }
    }
    if (_sleepWakeController.selectedSegmentIndex == 0){
        if(sleepTimeSet){
            [_timeButton setTitle:_sleepTime.text forState:UIControlStateNormal];
        } else {
            [_timeButton setTitle:@"Set Bed Time"forState:UIControlStateNormal];
        }
    }

    
    //We need to get it so that it shows the proper time in the picker
//    if (sleepTimeSet) {
//        [_sleepTimePicker setDate:sleepPickerTime];
//    }
//    if (wakeTimeSet) {
//        [_sleepTimePicker setDate:wakePickerTime];
//    }

}
@end
