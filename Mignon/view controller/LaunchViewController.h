//
//  LaunchViewController.h
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/26.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"

@interface LaunchViewController : UIViewController
<MBProgressHUDDelegate, downloadStoreListProcess, UIApplicationDelegate>
{
    UIImageView         *launchImageView;
    MBProgressHUD       *HUD;
    
    downloadStoreDelegate *downloadProcess;
    downloadStoreDelegate *downloadProcess2;
}



@end
