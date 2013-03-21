//
//  productImageCell.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customImgaeView.h"


#define adImageViewWidth 320
#define adImageViewHeight 200
#define adImageViewStartX 0
#define adImageViewStartY 0

@interface productImageCell : UITableViewCell <customImageViewButtonDelegate, UIScrollViewDelegate>
{
    IBOutlet UIScrollView *aScrollView;
    IBOutlet UIPageControl *aPageControl;
    IBOutlet UILabel *pageNumberLagel;
    BOOL pageControlUsed;
}

- (void)createImageButtonWithImageUrl:(NSArray*)urlArray;



@end
