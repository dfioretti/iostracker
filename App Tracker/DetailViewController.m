//
//  DetailViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/2/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "DetailViewController.h"
#import "App.h"
#import "Component.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"title"] description];
        self.titleLabel.text = [[self.detailItem valueForKey:@"title"] description];
        self.deadlineText.text = [[self.detailItem valueForKey:@"deadline"]description];
        self.emailText.text = [[self.detailItem valueForKey:@"email"]description];
        self.phoneText.text = [[self.detailItem valueForKey:@"phone"] description];
        self.usernameText.text = [[self.detailItem valueForKey:@"username"] description];
        self.passwordText.text = [[self.detailItem valueForKey:@"password"] description];
        self.websiteText.text = [[self.detailItem valueForKey:@"website"] description];
        
    }

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

- (IBAction) updateDetails:(id)sender {
    
    NSLog(@"logging....");
    // NSManagedObject is detailitem
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    [self.detailItem setValue:self.deadlineText.text forKey:@"deadline"];
    [self.detailItem setValue:self.emailText.text forKey:@"email"];
    [self.detailItem setValue:self.phoneText.text forKey:@"phone"];
    [self.detailItem setValue:self.usernameText.text forKey:@"username"];
    [self.detailItem setValue:self.passwordText.text forKey:@"password"];
    [self.detailItem setValue:self.websiteText.text forKey:@"website"];

 
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];

   // [self configureView];

  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
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
