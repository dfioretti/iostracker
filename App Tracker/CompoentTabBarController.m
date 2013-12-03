//
//  CompoentTabBarController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "CompoentTabBarController.h"
#import "ToDoViewController.h"
#import "TaskDetailsController.h"
#import "NotesView.h"

@interface CompoentTabBarController ()

@end

@implementation CompoentTabBarController

-(void)setTabController:(UITabBarController *)tabController
{
    if (_tabController != tabController) {
        _tabController = tabController;
    }
}

-(void)setComponentItem:(Component *)componentItem
{
    if(_componentItem != componentItem) {
        _componentItem = componentItem;
    }
    
    ToDoViewController *todoView = [self.viewControllers objectAtIndex:1];
    todoView.detailItem = self.detailItem;
    [todoView setTabController:self.tabBarController];
    
    TaskDetailsController *taskView = [self.viewControllers objectAtIndex:0];
    taskView.detailItem = self.detailItem;
    
    NotesView *notesView = [self.viewControllers objectAtIndex:2];
    notesView.detailItem = self.detailItem;
    [notesView setTabController:self.tabBarController];
}

- (void)setDetailItem:(Component *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
    }
    
    ToDoViewController *todoView = [self.viewControllers objectAtIndex:1];
    todoView.detailItem = self.detailItem;
    [todoView setTabController:self.tabBarController];
    
    TaskDetailsController *taskView = [self.viewControllers objectAtIndex:0];
    taskView.detailItem = self.detailItem;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
