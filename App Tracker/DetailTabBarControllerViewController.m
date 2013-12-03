//
//  DetailTabBarControllerViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/2/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "DetailTabBarControllerViewController.h"
#import "DetailViewController.h"
#import "ComponentTableViewController.h"
#import "ComponentViewController.h"

@interface DetailTabBarControllerViewController ()
- (void)configureView;
@end


@implementation DetailTabBarControllerViewController


- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    
    //DetailViewController *detailView = [self.viewControllers objectAtIndex:0];
    //detailView.detailItem = self.detailItem;
    ComponentViewController *detailView = [self.viewControllers objectAtIndex:0];
    detailView.detailItem = self.detailItem;

    ComponentTableViewController *componentView = [self.viewControllers objectAtIndex:1];
    componentView.detailItem = self.detailItem;

    componentView.tabController = self;
    
    [self configureView];

}

- (void)configureView {
    //self.tabBarController.navigationItem.title = [[self.detailItem valueForKey:@"title"] description];
    //self.navigationItem.title = [[self.detailItem valueForKey:@"title"] description];
    self.navigationItem.title = self.detailItem.title;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
