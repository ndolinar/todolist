//
//  TDLTableViewController.m
//  ToDoList
//
//  Created by Neja Dolinar on 04/06/14.
//  Copyright (c) 2014 Neja Dolinar. All rights reserved.
//

#define allItems @"allItems"
#import "TDLTableViewController.h"
#import "TDLToDoItem.h"
#import "TDLViewController.h"


@interface TDLTableViewController ()

@end

@implementation TDLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadInitialData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *arrayAsData = [defaults objectForKey:@"savedArray"];
    if (arrayAsData != nil)
    {
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayAsData];
        if (savedArray != nil)
            self.toDoItems = [[NSMutableArray alloc] initWithArray:savedArray];
        else
            self.toDoItems = [[NSMutableArray alloc] init];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCheckedItems:)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(triggerSegue:)];
    NSArray *barItems = @[addButton, trashButton];
    self.navigationItem.rightBarButtonItems = barItems;
    
    [self loadInitialData];
}

-(void)triggerSegue:(id)sender{
    [self performSegueWithIdentifier:@"addToDoItem" sender:self];
}

-(void)deleteCheckedItems:(id)sender{

    UITableViewCell *aCell = [[UITableViewCell alloc]init];
    
    for (NSInteger j = 0; j < [self.tableView numberOfSections]; ++j)
    {
        for (NSInteger i = 0; i < [self.tableView numberOfRowsInSection:j]; ++i)
        {
            aCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
            if(aCell.accessoryType == UITableViewCellAccessoryCheckmark){
                
                [self.toDoItems removeObjectAtIndex:i];
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:j]] withRowAnimation:UITableViewRowAnimationNone];

                i-=1;
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.toDoItems] forKey:@"savedArray"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.tableView reloadData];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToList:(UIStoryboardSegue*)segue{
    
    TDLViewController *source = [segue sourceViewController];
    TDLToDoItem *item = source.toDoItem;
    
    if(item != nil) {
        [self.toDoItems addObject:item];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.toDoItems] forKey:@"savedArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.toDoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    TDLToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.name;
    
    if(toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TDLToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.toDoItems] forKey:@"savedArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
