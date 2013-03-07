//
//  shareHeaderView2.h
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareHeaderView2 : UIView
{
    UILabel *titleLabel;
    BOOL autoScrollInd;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (assign) BOOL autoScrollInd;

@end
