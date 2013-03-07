//
//  MignonNewsViewController.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonNewsViewController.h"

@interface MignonNewsViewController () <UISearchBarDelegate>
{
    NSMutableArray *productArray;
}

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *fetchProductArray;
@property (nonatomic, retain) NSMutableString *searchKey;

- (void)createSearchBar;
- (void)startDownloadProductList;
- (void)fetchRresult;

@end

@implementation MignonNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (_searchKey == nil)
        {
            _searchKey = [[NSMutableString alloc] initWithCapacity:0];
        }
        if (_fetchProductArray == nil)
        {
            _fetchProductArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        if (productArray == nil)
        {
            productArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSearchBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_fetchProductArray release], _fetchProductArray = nil;
    [_searchKey release], _searchKey = nil;
    [productArray release], productArray = nil;
    [_searchBar release], _searchBar = nil;
    [super dealloc];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self.searchKey setString:[searchBar text]];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - createBarItem
- (void)createSearchBar
{
    if (self.searchBar == nil)
    {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        [self.searchBar setPlaceholder:[NSString stringWithFormat:@"關鍵字搜尋"]];
        [self.searchBar setDelegate:self];
        //建立 toolbar
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        toolbar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"收合" style:UIBarButtonItemStyleBordered target:self action:@selector(closeKeyboard)];
        [toolbar setItems:[NSArray arrayWithObjects:flexItem,closeItem, nil]];
        [self.searchBar setInputAccessoryView:toolbar];
        [flexItem release];
        [closeItem release];
        [toolbar release];
        
    }
    
    aTableView.tableHeaderView = self.searchBar;
}

- (void)closeKeyboard
{
    [self.searchBar resignFirstResponder];
}

- (void)startDownloadProductList
{
    
}

- (void)fetchRresult
{
    
}

@end
