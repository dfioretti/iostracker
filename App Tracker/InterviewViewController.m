//
//  InterviewViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "InterviewViewController.h"
#import "EditInterviewViewController.h"
#import "AppDelegate.h"

@interface InterviewViewController ()
    - (void)configureView;
@end

@implementation InterviewViewController


- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    [self configureView];
}

-(void)configureView
{
    if (self.detailItem) {
        NSLog(@"configure view in interview %@", self.detailItem.title);
        self.interviewerLabel.text = self.detailItem.interviewer;
        self.dateLabel.text = self.detailItem.idate;
        self.timeLabel.text = self.detailItem.itime;
        self.address1Label.text = self.detailItem.iaddress1;
        self.address2Label.text = self.detailItem.iaddress2;
        self.phoneButton.text = self.detailItem.iphone;
        self.emailButton.text = self.detailItem.iemail;
      
        
        UITableView* TV = [[UITableView alloc] init];
        UIColor* C = [TV separatorColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, self.view.bounds.size.width - 50, 1)];
        lineView.backgroundColor = C;
        lineView.alpha = 0.20;
        [self.view addSubview:lineView];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 160, self.view.bounds.size.width - 50, 1)];
        lineView.alpha = 0.20;
        lineView.backgroundColor = C;
        [self.view addSubview:lineView];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 50, 1)];
        lineView.alpha = 0.20;
        lineView.backgroundColor = C;
        [self.view addSubview:lineView];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 240, self.view.bounds.size.width - 50, 1)];
        lineView.alpha = 0.20;
        lineView.backgroundColor = C;
        [self.view addSubview:lineView];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 280, self.view.bounds.size.width - 50, 1)];
        lineView.alpha = 0.20;
        lineView.backgroundColor = C;
        [self.view addSubview:lineView];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 320, self.view.bounds.size.width - 50, 1)];
        lineView.alpha = 0.20;
        lineView.backgroundColor = C;
        [self.view addSubview:lineView];
        
        
    /*
        [self.phoneButton setTitle:self.detailItem.iphone forState:UIControlStateNormal];
        [self.emailButton setTitle:self.detailItem.iemail forState:UIControlStateNormal];
     */
    }

}

- (IBAction) editInterview:(id)sender {
    self.tabBarController.navigationItem.rightBarButtonItem = self.doneButton;

    self.interviewerLabel.enabled = TRUE;
    [self.interviewerLabel becomeFirstResponder];
    self.dateLabel.enabled = YES;
    self.timeLabel.enabled = YES;
    self.address1Label.enabled = YES;
    self.address2Label.enabled = YES;
    self.phoneButton.enabled = YES;
    self.emailButton.enabled = YES;
    [self reloadInputViews];
}

- (IBAction) saveInterview:(id)sender {
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    self.detailItem.iemail = self.emailButton.text;
    self.detailItem.iaddress1 = self.address1Label.text;
    self.detailItem.iaddress2 = self.address2Label.text;
    [self.detailItem setValue:self.interviewerLabel.text forKey:@"interviewer"];
    self.detailItem.iphone = self.phoneButton.text;
    self.detailItem.idate = self.dateLabel.text;
    self.detailItem.itime = self.timeLabel.text;
    
    self.interviewerLabel.enabled = NO;
    self.dateLabel.enabled = NO;
    self.timeLabel.enabled = NO;
    self.address1Label.enabled = NO;
    self.address2Label.enabled = NO;
    self.phoneButton.enabled = NO;
    self.emailButton.enabled = NO;
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    [self configureView];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editInterview"]) {
        EditInterviewViewController *editInterview = [segue destinationViewController];
        [editInterview setDetailItem: self.detailItem];

    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                      target:self action: @selector(editInterview:)];
    self.doneButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                      target:self action: @selector(saveInterview:)];
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


@end
