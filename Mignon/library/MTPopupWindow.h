//
//  MTPopupWindow.h
//  PopupWindowProject
//
//  Created by Marin Todorov on 7/1/11.
//  Copyright 2011 Marin Todorov. MIT license
//  http://www.opensource.org/licenses/mit-license.php
//  

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MTPopupWindow : NSObject<UIWebViewDelegate, MBProgressHUDDelegate >
{
    UIView          * bgView;
    UIView          * bigPanelView;
    MTPopupWindow   * HUD;
    
//    UIImageView * background;
//    UIView      * fauxView;
//    UIWebView   * web;
//    UIButton    * closeBtn;
}

+(void)showWindowWithHTMLFile:(NSString*)fileName insideView:(UIView*)view;
@end
