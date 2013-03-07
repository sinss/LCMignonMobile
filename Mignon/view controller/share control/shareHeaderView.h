//
//  shareHeaderView.h
//  SlyCool001
//
//  Created by sinss on 12/8/25.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareHeaderView : UIView
{
    UILabel *titleLabel;
    BOOL autoScrollInd;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (assign) BOOL autoScrollInd;
@end
