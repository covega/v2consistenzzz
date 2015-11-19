//
//  SetUpViewController.h
//  consistenzzz
//
//  Created by Brian Higgins on 11/19/15.
//  Copyright © 2015 the dream team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpViewController : UIViewController

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

@end
