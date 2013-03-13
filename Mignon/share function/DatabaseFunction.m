//
//  DatabaseFunction.m
//  MLIproposal
//
//  Created by 張星星 on 12/5/19.
//  Copyright (c) 2012年 Mountant Star Software. All rights reserved.
//

#import "DatabaseFunction.h"
#import "PathAndDirectoryFunction.h"

FMDatabase *_saveDB;

@implementation DatabaseFunction

+ (FMDatabase*)GetSaveDB
{
    NSString *dbPath = [PathAndDirectoryFunction getDocumentPathWithFileName:@"saveDB" andExtension:@"sqlite"];
    if (_saveDB == nil)
    {
        _saveDB = [[FMDatabase databaseWithPath:dbPath] retain];
        if ([_saveDB open])
        {
            NSLog(@"open pass.sqlite succeed");
        }
    }
    else 
    {
        if (![_saveDB goodConnection])
        {
            if ([_saveDB open])
            {
                NSLog(@"open pass.sqlite again");
            }
        }
    }
    return _saveDB;
}

@end
