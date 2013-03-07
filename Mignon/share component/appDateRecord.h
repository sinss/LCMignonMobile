//
//  appDateRecord.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <Foundation/Foundation.h>

@interface appDateRecord : NSObject
{
    NSString *welcomePage;
    NSString *lotteryPage;
    NSString *lotterySubPage;
    NSString *winnerPage;
}
@property (nonatomic, retain) NSString *welcomePage;
@property (nonatomic, retain) NSString *lotteryPage;
@property (nonatomic, retain) NSString *lotterySubPage;
@property (nonatomic, retain) NSString *winnerPage;

+(appDateRecord*)appDateInstance;

@end
