//
//  ToDoViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Component.h"

@interface ToDoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) Component *detailItem;
@property (nonatomic,strong) NSMutableArray *data;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
