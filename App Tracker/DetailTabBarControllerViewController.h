//
//  DetailTabBarControllerViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/2/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface DetailTabBarControllerViewController : UITabBarController

@property (strong, nonatomic) App *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;



@end
