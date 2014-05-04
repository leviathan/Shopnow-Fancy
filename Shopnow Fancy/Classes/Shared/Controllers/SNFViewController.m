//
//  SNFViewController.m
//  Shopnow Fancy
//
//  Created by Jörg Polakowski on 03/05/14.
//  Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFViewController.h"
#import "SNFTableViewCell.h"
#import "SNFTwitterDataSource.h"
#import "SNFTweet.h"


// constant definitions
static NSString *const kSNFCollectionViewCellIdentifier = @"kSNFCollectionViewCellIdentifier";


//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFViewController ()

@property(nonatomic, strong) NSArray *tableRows; // todo the data source should server the table data

@property(nonatomic, strong) SNFTableView *snfTableView;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    // Custom Table View Setup
    self.snfTableView = [[SNFTableView alloc] initWithFrame:self.view.frame];
    self.snfTableView.dataSource = self;
    self.snfTableView.delegate = self;
    self.snfTableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.snfTableView];

    // trigger loading of table data
    [[SNFTwitterDataSource sharedDataSource] addDelegate:self];
    // todo there should be a search field on the UI for the twitter search term
    [[SNFTwitterDataSource sharedDataSource] updateTweetsFor:@"Weltherrschaft"];
}

#pragma mark - SNFTableViewDataSource

- (NSUInteger)numberOfRowsInSnfTableView:(SNFTableView *)tableView {
    return [[SNFTwitterDataSource sharedDataSource] dataItems].count;
}

- (SNFTableViewCell *)snfTableView:(SNFTableView *)snfTableView cellForRow:(NSUInteger)row {

    SNFTableViewCell *cell = [snfTableView dequeueReusableCellWithIdentifier:kSNFCollectionViewCellIdentifier];
    if (!cell) {
        cell = [[SNFTableViewCell alloc] initWithReuseIdentifier:kSNFCollectionViewCellIdentifier
                                                        cellType:SNFTableViewCellTypeView];
    }

    SNFTweet *tweet = [[SNFTwitterDataSource sharedDataSource] dataItems][row];
    cell.tweet = tweet;

    return cell;
}

#pragma mark - SNFTableViewDelegate

- (CGFloat)snfTableView:(SNFTableView *)snfTableView heightForRow:(NSUInteger)row {
    // Note: using static height here to keep things simple.
    // Otherwise the values would need to be cached properly in order to
    // ensure high scrolling performance and such.
    return 90.0f;
}

- (void)snfTableView:(SNFTableView *)snfTableView didSelectRow:(NSUInteger)row {

    // todo just displaying a dummy default view controller to show that the cell selection has been received in the controller
    UIViewController *dummyDetailView = [[UIViewController alloc] init];
    dummyDetailView.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:dummyDetailView animated:YES];

}

#pragma mark - UIViewControllerRotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.snfTableView.frame = self.view.frame;
    [self.snfTableView reloadData];
}

#pragma mark - SNFDefaultDataSourceDelegate

- (void)didUpdateDataSourceSuccessfully:(SNFDataSourcePackage *)package {
    [self.snfTableView reloadData];
}

- (void)updateDidFailWith:(SNFDataSourcePackage *)package {
    [self.snfTableView reloadData];
}

@end
