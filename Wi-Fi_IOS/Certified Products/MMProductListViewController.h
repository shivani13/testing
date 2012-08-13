//
//  MMProductListViewController.h
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMProductListViewController : UIViewController
@property(nonatomic, retain) NSArray *productList;
@property (nonatomic,retain) NSArray *idList;
@property (nonatomic, retain) IBOutlet UITableView *productListTable;
@property (nonatomic, retain) IBOutlet UISearchBar *searchProList;
@end
