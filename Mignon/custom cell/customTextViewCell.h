//
//  customTextViewCell.h
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTextViewCell : UITableViewCell
{
    UITextView *contentTextView;
}
@property (nonatomic , retain) IBOutlet UITextView *contentTextView;

@end
