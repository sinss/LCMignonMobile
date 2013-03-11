//
//  MignonShareViewController.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MignonShareViewController : UIViewController <MBProgressHUDDelegate,
UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *aTableView;
    MBProgressHUD       *HUD;
}

@end
