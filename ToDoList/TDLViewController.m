//
//  TDLViewController.m
//  ToDoList
//
//  Created by Neja Dolinar on 04/06/14.
//  Copyright (c) 2014 Neja Dolinar. All rights reserved.
//

#import "TDLViewController.h"

@interface TDLViewController ()

@end

@implementation TDLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField.delegate = self;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if(sender != self.doneButton) return;
    
    if (self.textField.text.length > 0) {
        self.toDoItem = [[TDLToDoItem alloc]init];
        self.toDoItem.name = self.textField.text;
        self.toDoItem.completed = NO;
 
    }
    
}
@end
