//
//  EditInterviewViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "EditInterviewViewController.h"
#import "AppDelegate.h"

@interface EditInterviewViewController ()
    -(void) configureView;
@end

@implementation EditInterviewViewController

- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    [self configureView];
}


- (IBAction) updateInterview:(id)sender {
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    NSLog(@"email = %@", self.interviewerLabel.text);
    NSLog(@"detail = %@", self.detailItem.title);
    
    self.detailItem.iemail = self.emailLabel.text;
    self.detailItem.iaddress1 = self.address1Label.text;
    self.detailItem.iaddress2 = self.address2Label.text;
    [self.detailItem setValue:self.interviewerLabel.text forKey:@"interviewer"];
    self.detailItem.iphone = self.phoneLabel.text;
    self.detailItem.idate = self.dateLabel.text;
    self.detailItem.itime = self.timeLabel.text;
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self action: @selector(updateInterview:)];
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

}

-(void)configureView {
    if (self.detailItem) {
        NSLog(@"whaa %@", self.detailItem);
        self.emailLabel.text = self.detailItem.iemail;
        self.address2Label.text = self.detailItem.iaddress2;
        self.address1Label.text = self.detailItem.iaddress1;
        self.phoneLabel.text = self.detailItem.iphone;
        self.interviewerLabel.text = self.detailItem.interviewer;
        self.dateLabel.text = self.detailItem.idate;
        self.timeLabel.text = self.detailItem.itime;
    }
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
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
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
