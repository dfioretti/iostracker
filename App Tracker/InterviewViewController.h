//
//  InterviewViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface InterviewViewController : UIViewController

@property (strong, nonatomic) App *detailItem;

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *address1Label;
@property (weak, nonatomic) IBOutlet UITextField *address2Label;
@property (weak, nonatomic) IBOutlet UITextField *interviewerLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneButton;
@property (weak, nonatomic) IBOutlet UITextField  *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *timeLabel;


@end
