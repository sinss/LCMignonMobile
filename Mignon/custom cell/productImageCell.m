//
//  productImageCell.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "productImageCell.h"

@implementation productImageCell


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
}

- (void)createImageButtonWithImageUrl:(NSArray*)urlArray
{
    [aPageControl setEnabled:NO];
    [aScrollView setDelegate:self];
    float startX = adImageViewStartX;
    float startY = adImageViewStartY;
    aScrollView.contentSize = CGSizeMake(320*[urlArray count], aScrollView.bounds.size.height);
    for (int i = 0 ; i < [urlArray count] ; i ++)
    {
        CGRect rect = CGRectMake(startX, startY, adImageViewWidth, adImageViewHeight);
        NSString *url = [urlArray objectAtIndex:i];
        customImgaeView *adImageView = [[customImgaeView alloc] initWithFrame:rect andImageName:[NSString stringWithFormat:@"%@", url] andSmallInd:NO];
        adImageView.tag = i;
        [adImageView setDelegate:self];
        [adImageView downloadAndDisplayImageWithURL:[NSURL URLWithString:url]];
        [aScrollView addSubview:adImageView];
        startX += 320;
        [adImageView release];
    }
    [aPageControl setNumberOfPages:[urlArray count]];
}

- (void)didPressButtonWithTag:(NSInteger)imageTag
{
    
}

- (void)didPressButtonWithImage:(UIImage*)image
{
    
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = aScrollView.frame.size.width;
    int page = floor((aScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    aPageControl.currentPage = page;
    
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}


@end
