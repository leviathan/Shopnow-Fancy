//
//  SNFViewController.h
//  Shopnow Fancy
//
//  Created by Jörg Polakowski on 03/05/14.
//  Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFTableView.h"
#import "SNFDefaultDataSource.h"

@interface SNFViewController : UIViewController <SNFTableViewDataSource, SNFTableViewDelegate,
        SNFDefaultDataSourceDelegate>

@end
