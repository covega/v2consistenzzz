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

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                              categories:nil]];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // must copy this, the main graphics folder, and the linked code in the header.
    // the images is 20 of them layered evenly
        _zero.hidden = YES;
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
        _ninty.hidden = YES;
        _nintyFive.hidden = YES;
        _hundred.hidden = YES;
    
        float sleepDebtPercent = .05;
        int screen = ((100 * sleepDebtPercent) / 5);
        switch (screen) {
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
                _ninty.hidden = NO;
                break;
            case 18:
                _nintyFive.hidden = NO;
                break;
            case 19:
                _hundred.hidden = NO;
                break;
            default:
                _hundred.hidden = NO;
                break;
        }
    // end of brian part
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
