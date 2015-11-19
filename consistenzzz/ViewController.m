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


//set up
- (IBAction)wantPressed:(id)sender {
    int wantHours = self.wantStepper.value / 1;
    int wantMin = (self.wantStepper.value - wantHours) * 60;
    self.wantLabel.text = [NSString stringWithFormat:@"%d hrs %d min", wantHours, wantMin];
    
}


- (IBAction)getPressed:(id)sender {
    int getHours = self.getStepper.value;
    int getMin = (self.getStepper.value - getHours) * 60;
    self.getLabel.text = [NSString stringWithFormat:@"%d hrs %d min", getHours, getMin];
}

- (IBAction)setUpPushed:(id)sender {
    float minSleep = 0;
    float days = 14;
    float want = self.wantStepper.value;
    float get = self.getStepper.value;
    float debt = days * (get - ((24 - get) * (want/(24 - want))));
    float maxSleepDebt = days * (minSleep - ((24 - minSleep) * (want/(24 - want))));
    float percentage = 1 - (debt/maxSleepDebt);
    int debtHours = (debt / 1);
    int debtMins = ((debt - debtHours) * 60) / 1;
    int percentDisplay = (percentage * 100) / 1;
    NSLog(@"Debt = %f", debt);
    self.debtLabel.text = [NSString stringWithFormat:@"Debt = %d hrs %d min", -debtHours, -debtMins];
    self.percentLabel.text = [NSString stringWithFormat:@"%d %%", percentDisplay];
}


@end
