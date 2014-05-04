//
//  SNFViewController.m
//  Shopnow Fancy
//
//  Created by Jörg Polakowski on 03/05/14.
//  Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFViewController.h"

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFViewController ()

@property(strong) UICollectionView *collectionView;


@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
