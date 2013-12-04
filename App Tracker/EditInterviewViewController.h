//
//  EditInterviewViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface EditInterviewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) App *detailItem;

//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *address1Label;
@property (weak, nonatomic) IBOutlet UITextField *address2Label;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *interviewerLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *timeLabel;

@end
