//
//  TDLViewController.h
//  ToDoList
//
//  Created by Neja Dolinar on 04/06/14.
//  Copyright (c) 2014 Neja Dolinar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLToDoItem.h"

@interface TDLViewController : UIViewController <UITextFieldDelegate>

@property TDLToDoItem *toDoItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end
