//
//  ToDoViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "ToDoViewController.h"
#import "AppDelegate.h"
#import "Todo.h"
#import "App.h"

@interface ToDoViewController ()
    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ToDoViewController

static NSString *cellIdentifier;

-(void)setTabController:(UITabBarController *)tabController
{
    if (_tabController != tabController) {
        _tabController = tabController;
    }
}

- (void)setDetailItem:(Component *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Todo *todo = [self.data objectAtIndex: indexPath.row];
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        [context deleteObject:todo];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        //        self.data = [[self.detailItem.components allObjects] mutableCopy];
        self.data = nil;
        self.data = [[self.detailItem.todos allObjects] mutableCopy];
        [self.tableView reloadData];
        
        //add code here for when you hit delete
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
}

- (void)viewDidLoad
{
    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                      target:self action: @selector(addButtonPressed:)];
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    
    self.data = [[self.detailItem.todos allObjects] mutableCopy];
    cellIdentifier = @"rowCell2";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellIdentifier];
    
     [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addButtonPressed:(UIBarButtonItem *)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"New Todo"
                          message:@"Please enter your new item."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK"
                          , nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *componentName = [actionSheet textFieldAtIndex:0];
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        Todo *todo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:context];
        todo.title = componentName.text;
        [self.detailItem addTodosObject:todo];
        [todo setComponent:self.detailItem];
        [self.data addObject:todo];
        [self.tableView reloadData];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Todo *todo = [self.data objectAtIndex: indexPath.row];
    cell.textLabel.text = todo.title;
    //cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
