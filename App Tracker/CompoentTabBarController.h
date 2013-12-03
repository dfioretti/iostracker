//
//  CompoentTabBarController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Component.h"

@interface CompoentTabBarController : UITabBarController

@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) Component *detailItem;
@property (strong, nonatomic) Component *componentItem;

@end
