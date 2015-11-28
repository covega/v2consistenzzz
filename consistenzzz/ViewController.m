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
float want;
float get;
float debt;
float days = 14;
int percent;
int MAX_IMAGE_COUNT = 51;
bool isSetUp = false;


//countdown to bed/wake
NSTimer *countdownTimer;
int countdownSeconds;
bool timerRunning = false;

-(void)timerRun{
    countdownSeconds = countdownSeconds - 1;
    int hoursCount = countdownSeconds / 3600;
    int minutesCount = (countdownSeconds - (hoursCount * 3600)) / 60;
    int secondsCount = countdownSeconds - (minutesCount * 60) - (hoursCount * 3600);
    
    if(_homeView.hidden == NO){
    _countDownLabel.text = [NSString stringWithFormat:@"Bedtime in %2d hrs %2d mins %2d secs", hoursCount, minutesCount, secondsCount];
    } else if (_sleepView.hidden == NO){
        NSLog(@"sleep view timer");
        _countdownToWake.text = [NSString stringWithFormat:@"%2d hours %2d minutes %2d seconds", hoursCount, minutesCount, secondsCount];
    }
    
    if (countdownSeconds == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }

}



-(void) setTimer {
    NSLog(@"set timer");
    if (timerRunning) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    timerRunning = true;

}


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
    [super viewDidLoad];
    _sleepView.hidden = YES;
    if (isSetUp) {
        _setUpView.hidden = YES;
        if (!sleepTimeSet) {
            _countDownLabel.hidden = YES;
        }
        
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                                  categories:nil]];
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    } else {
        //initial set up
        _homeView.hidden = YES;
    }
}


- (void)viewDidAppear:(BOOL)animated {
    if (isSetUp) {
        [self animateBedGraphic];
    }

}

-(void)calculateSleepDebt{
    //sleep debt/percentage logic
    debt = days * (get - ((24 - get) * (want/(24 - want))));
    int debtHours = (debt / 1);
    int debtMins = ((debt - debtHours) * 60) / 1;
    self.debtLabel.text = [NSString stringWithFormat:@"Sleep Debt = %d hrs %d min", -debtHours, -debtMins];
}

-(void)calculatePercentage{
    float minSleep = 0;
    float maxSleepDebt = days * (minSleep - ((24 - minSleep) * (want/(24 - want))));
    percent = ((1 - (debt/maxSleepDebt)) * 100) / 1;
    self.percentLabel.text = [NSString stringWithFormat:@"Functioning at %d%%", percent];
}


-(void)animateBedGraphic{
    NSMutableArray *bedImageArray = [[NSMutableArray alloc] initWithCapacity:MAX_IMAGE_COUNT];
    
    //build array of images, cycling through image names
    int increment = 2;
    for(int i = 0; i < (percent + 1) / increment; i++){
        [bedImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"two%d.png", (i * increment) + increment]]];
    }
    self.bedImageView.animationImages = bedImageArray;
    self.bedImageView.animationRepeatCount = 1;
    self.bedImageView.animationDuration = 2;
    self.bedImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"two%d.png", percent - (percent % increment)]];
    [self.bedImageView startAnimating];
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
    
    //countdown logic/sleep amount logic
    NSDate *now = [NSDate date];
    NSDateComponents *nowComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: now];
    NSDateComponents *sleepComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _sleepTimePicker.date];
    NSDateComponents *wakeComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _wakeTimePicker.date];
    NSInteger sleepHour = [sleepComponents hour];
    NSInteger sleepMinute = [sleepComponents minute];
    NSInteger wakeHour = [wakeComponents hour];
    NSInteger wakeMinute = [wakeComponents minute];
    NSInteger nowHour = [nowComponents hour];
    NSInteger nowMinute = [nowComponents minute];
    NSInteger nowSecond = [nowComponents second];

    
    
    
    //set stuff
    if(_sleepWakeController.selectedSegmentIndex == 0){
        sleepTimeSet = true;
        _countDownLabel.hidden = NO;
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
        
        //countdown
        long totalHoursUntilBed;
        long totalMinutesUntilBed;
        if(nowHour >= sleepHour){
            totalHoursUntilBed = 24 + (sleepHour - nowHour);
        } else {
            totalHoursUntilBed = sleepHour - nowHour;
        }
        if (nowMinute > sleepMinute) {
            totalMinutesUntilBed = 60 + (sleepMinute - nowMinute) - 1;
            totalHoursUntilBed = totalHoursUntilBed - 1;
        } else {
            totalMinutesUntilBed = sleepMinute - nowMinute - 1;
        }
        countdownSeconds = (totalHoursUntilBed * 3600) + (totalMinutesUntilBed * 60) + (60 - nowSecond);
        [self setTimer];
        
        
        
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


}

- (IBAction)calculatePushed:(id)sender {
    isSetUp = true;
    _setUpView.hidden = YES;
    _homeView.hidden = NO;
    _sleepTimePicker.hidden = YES;
    _wakeTimePicker.hidden = YES;
    _setButton.hidden = YES;
    _sleepAmountLabel.hidden = YES;
    _countDownLabel.hidden = YES;
    want = self.wantStepper.value;
    get = self.getStepper.value;
    [self calculateSleepDebt];
    [self calculatePercentage];
    [self animateBedGraphic];
}
- (IBAction)wantStepperPushed:(id)sender {
    int wantHours = self.wantStepper.value / 1;
    int wantMin = (self.wantStepper.value - wantHours) * 60;
    self.wantLabel.text = [NSString stringWithFormat:@"%d hrs %d min", wantHours, wantMin];
    
}
- (IBAction)getStepperPushed:(id)sender {
    int getHours = self.getStepper.value;
    int getMin = (self.getStepper.value - getHours) * 60;
    self.getLabel.text = [NSString stringWithFormat:@"%d hrs %d min", getHours, getMin];
}

- (IBAction)wakeUpButtonPushed:(id)sender {
    _sleepView.hidden = YES;
    _homeView.hidden = NO;
}

- (IBAction)sleepNowButtonPushed:(id)sender {
    _sleepView.hidden = NO;
    _homeView.hidden = YES;
    
    //countdow to wake


    
    NSMutableArray *sleepBedImageArray = [[NSMutableArray alloc] initWithCapacity:4];
    //build array of images, cycling through image names
    for(int i = 0; i < 4; i++){
        [sleepBedImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Logo-white-%dZ.png", i]]];
    }
    self.sleepBedImageView.animationImages = sleepBedImageArray;
    self.sleepBedImageView.animationDuration = 3;
    [self.sleepBedImageView startAnimating];
    [self sleepViewTimeDisplay];
    
}

-(void)sleepViewTimeDisplay{
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *nowComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: now];
    NSDateComponents *wakeComponents = [calendar components:(NSCalendarUnitHour| NSCalendarUnitMinute) fromDate: _wakeTimePicker.date];
    NSInteger wakeHour = [wakeComponents hour];
    NSInteger wakeMinute = [wakeComponents minute];
    NSInteger nowHour = [nowComponents hour];
    NSInteger nowMinute = [nowComponents minute];
    NSInteger nowSecond = [nowComponents second];
    long totalHours = -1;
    long totalMinutes = -1;
    if(nowHour >= wakeHour){
        totalHours = 24 + (wakeHour - nowHour);
    } else {
        totalHours = wakeHour - nowHour;
    }
    if (nowMinute > wakeMinute) {
        totalMinutes = 60 + (wakeMinute - nowMinute);
        totalHours = totalHours - 1;
    } else {
        totalMinutes = wakeMinute - nowMinute;
    }
    countdownSeconds = (totalHours * 3600) + (totalMinutes * 60) + (60 - nowSecond);
    [self setTimer];
}
@end
