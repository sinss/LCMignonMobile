//
//  productCell.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "productCell.h"
#import "customImgaeView.h"

@interface productCell() <customImageViewButtonDelegate>
{
    NSMutableData *responseData;
    NSURLConnection *connection;
}
@end

@implementation productCell
@synthesize categoryLabel1, categoryLabel2, titleLabel1, titleLabel2, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGroup2Enable:(BOOL)value
{
    [titleLabel2 setHidden:value];
    [categoryLabel2 setHidden:value];
}

- (void)downloadImageButton1WithUrl:(NSString*)imageUrl andName:(NSString*)imageName
{
    /*
     10, 20, 140, 159
     */
    CGRect frame = CGRectMake(10, 20, 140, 159);
    customImgaeView *imageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [imageView downloadAndDisplayImageWithURL:[NSURL URLWithString:imageUrl]];
    [imageView setTag:0];
    [imageView setDelegate:self];
    [self addSubview:imageView];
    [imageView release];
}

- (void)downloadImageButton2WithUrl:(NSString*)imageUrl andName:(NSString*)imageName
{
    /*
     160, 20, 140, 159
     */
    CGRect frame = CGRectMake(160, 20, 140, 159);
    customImgaeView *imageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [imageView downloadAndDisplayImageWithURL:[NSURL URLWithString:imageUrl]];
    [imageView setTag:1];
    [imageView setDelegate:self];
    [self addSubview:imageView];
    [imageView release];
}

- (void)didPressButtonWithImage:(UIImage *)image
{
    
}

- (void)didPressButtonWithTag:(NSInteger)imageTag
{
    [delegate productCell:self didPressWithProductTag:imageTag];
}

- (void) dealloc
{
    delegate = nil;
    [categoryLabel1 release], categoryLabel1 = nil;
    [titleLabel1 release], titleLabel1 = nil;
    [categoryLabel2 release], categoryLabel2 = nil;
    [titleLabel2 release], titleLabel2 = nil;
    [super dealloc];
}

@end
