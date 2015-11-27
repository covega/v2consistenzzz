//
//  SetUpViewController.m
//  consistenzzz
//
//  Created by Brian Higgins on 11/19/15.
//  Copyright © 2015 the dream team. All rights reserved.
//

#import "SetUpViewController.h"
#import "ViewController.h"

@interface SetUpViewController ()

@end

@implementation SetUpViewController



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
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *home = (ViewController *)segue.destinationViewController;
    float want = self.wantStepper.value;
    float get = self.getStepper.value;
    home.want = want;
    home.get = get;
    home.setUp = true;
    
}


@end
