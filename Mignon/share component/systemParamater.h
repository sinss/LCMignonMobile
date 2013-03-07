//
//  systemParamater.h
//  MobileProposal
//
//  Created by 張星星 on 13/1/11.
//  Copyright (c) 2013年 Among. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface systemParamater : NSObject
{
    NSString *agentCode;
    NSString *name;
    NSString *title;
    NSString *belongOrg;
    NSString *belongOrgName;
    NSNumber *brokerCode;
}
@property (nonatomic, retain) NSString *agentCode;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *belongOrg;
@property (nonatomic, retain) NSString *belongOrgName;
@property (nonatomic, retain) NSNumber *brokerCode;

+ (systemParamater*)systemParamaterInstance;

@end
