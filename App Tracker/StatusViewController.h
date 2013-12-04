//
//  StatusViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface StatusViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) App *detailItem;
@property (nonatomic,strong) NSMutableArray *data;


@end
