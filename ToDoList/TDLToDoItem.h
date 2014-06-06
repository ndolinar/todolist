//
//  TDLToDoItem.h
//  ToDoList
//
//  Created by Neja Dolinar on 04/06/14.
//  Copyright (c) 2014 Neja Dolinar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLToDoItem : NSObject

@property NSString *name;
@property (readonly, nonatomic, strong) NSDate *creationDate;
@property BOOL completed;

-(void)markAsCompleted:(BOOL)isCompleted;

@end
