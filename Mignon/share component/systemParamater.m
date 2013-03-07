//
//  systemParamater.m
//  MobileProposal
//
//  Created by 張星星 on 13/1/11.
//  Copyright (c) 2013年 Among. All rights reserved.
//

#import "systemParamater.h"

systemParamater *systemParamaterInstance;

@implementation systemParamater
@synthesize agentCode, name, title, belongOrg, belongOrgName, brokerCode;

- (void)dealloc
{
    [agentCode release], agentCode = nil;
    [name release], name = nil;
    [title release],  title = nil;
    [belongOrg release], belongOrg = nil;
    [belongOrgName release], belongOrgName = nil;
    [brokerCode release], brokerCode = nil;
    [super dealloc];
}

+ (systemParamater*)systemParamaterInstance
{
    if (systemParamaterInstance == nil)
    {
        systemParamaterInstance = [[systemParamater alloc] init];
    }
    return systemParamaterInstance;
}

@end
