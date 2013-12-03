//
//  ComponentTableViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/2/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface ComponentTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) App *detailItem;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger row;

@end
