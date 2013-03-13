//
//  productCell.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class productCell;
@protocol productCellAction <NSObject>

- (void)productCell:(productCell*)cell didPressWithProductTag:(NSInteger)tag;

@end

@interface productCell : UITableViewCell
{
    id <productCellAction> delegate;
    UILabel *categoryLabel1;
    UILabel *titleLabel1;
    UILabel *categoryLabel2;
    UILabel *titleLabel2;
}

@property (assign) id <productCellAction> delegate;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel1;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel1;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel2;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel2;

- (void)setGroup2Enable:(BOOL)value;
- (void)downloadImageButton1WithUrl:(NSString*)imageUrl andName:(NSString*)imageName;
- (void)downloadImageButton2WithUrl:(NSString*)imageUrl andName:(NSString*)imageName;

@end
