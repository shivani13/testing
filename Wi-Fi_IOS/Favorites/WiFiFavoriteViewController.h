//
//  SearchViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/14/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "WiFiArticleListModel.h"
@interface WiFiFavoriteViewController : UIViewController<NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate>


@property (retain, nonatomic) IBOutlet UISegmentedControl *favoriteSegmentedControl;
@property (retain, nonatomic) IBOutlet UITableView *favoriteTableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController *fetchedProductsResultsController;


- (IBAction)favoriteSegmentedControlValueChanged:(id)sender;


@end
