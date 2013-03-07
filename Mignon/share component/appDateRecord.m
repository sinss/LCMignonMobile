//
//  appDateRecord.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "appDateRecord.h"

appDateRecord *appDateInstance;

@implementation appDateRecord
@synthesize welcomePage, lotterySubPage, lotteryPage, winnerPage;

- (void)dealloc
{
    [welcomePage release], welcomePage = nil;
    [lotteryPage release], lotteryPage = nil;
    [lotterySubPage release], lotterySubPage = nil;
    [winnerPage release], winnerPage = nil;
    [super dealloc];
}

+ (appDateRecord*)appDateInstance
{
    if (appDateInstance == nil)
    {
        appDateInstance = [[appDateRecord alloc] init];
    }
    return appDateInstance;
}
@end
