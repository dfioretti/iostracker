//
//  ComponentViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "ComponentViewController.h"

@interface ComponentViewController ()
    - (void)configureView;
@end

@implementation ComponentViewController


- (void)setDetailItem:(App *)newDetailItem
{
    NSLog(@"compoent view new detail");
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView
{
    // Update the user interface for the detail item.
    
    NSLog(@"configure view component detail");
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"title"] description];
        //self.titleLabel.text = [[self.detailItem valueForKey:@"title"] description];
        self.deadlineText.text = [[self.detailItem valueForKey:@"deadline"]description];
        self.emailText.text = [[self.detailItem valueForKey:@"email"]description];
        self.phoneText.text = [[self.detailItem valueForKey:@"phone"] description];
        self.usernameText.text = [[self.detailItem valueForKey:@"username"] description];
        self.passwordText.text = [[self.detailItem valueForKey:@"password"] description];
        self.websiteText.text = [[self.detailItem valueForKey:@"website"] description];
        
        //Component *c = [[self.detailItem.components allObjects] objectAtIndex:0];
        //        NSString *numCount = [NSString stringWithFormat:@"%d", self.detailItem.components.count];
        //self.componentCount.text = c.name;
        //int myInt = [self.detailItem.components count];
        
        /*if (self.detailItem.components) {
         NSLog(@"has components");
         } else {
         NSLog(@"no components");
         }*/
        
        //NSString *numCount = [NSString stringWithFormat:@"%d", count];
        //self.componentCount.text = numCount;
        
        //self.componentCount.text = [NSString stringWithFormat:@"%d", self.detailItem.components.count];
        //self.componentCount.text = [NSString stringWithFormat:@"%d", ((App *) self.detailItem).components.count];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
}

- (IBAction) editDetails:(id)sender {
    [self performSegueWithIdentifier:@"showEdit" sender:@"component"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEdit"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //App *object = (App *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:self.detailItem];
    }
}


- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
