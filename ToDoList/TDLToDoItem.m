//
//  TDLToDoItem.m
//  ToDoList
//
//  Created by Neja Dolinar on 04/06/14.
//  Copyright (c) 2014 Neja Dolinar. All rights reserved.
//

#import "TDLToDoItem.h"

@interface TDLToDoItem ()

@property NSDate *completionDate;

@end

@implementation TDLToDoItem

- (id) init {
    self = [super init];
    if(self) {
        _creationDate = [NSDate date];
    }
    
    return self;
    
}

-(void)markAsCompleted:(BOOL)isCompleted {
    self.completed = isCompleted;
    [self setCompletionDate];
}

-(void)setCompletionDate {
    if (self.completed) {
        self.completionDate = [NSDate date];
    } else {
        self.completionDate = nil;
    }
}


- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.creationDate forKey:@"creationDate"];
    [coder encodeBool:self.completed forKey:@"completed"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey:@"name"];
        _creationDate = [coder decodeObjectForKey:@"creationDate"];
        self.completed = [coder decodeBoolForKey:@"completed"];
    }
    return self;
}



@end
