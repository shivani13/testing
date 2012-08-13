//
//  MMProductCompanies.h
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFiProductsHeaderView.h"

@interface WiFiProductCompaniesViewController : UIViewController<HeaderViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    NSMutableArray *productCompanyArray_;
    NSMutableArray *jsonCompnayArray;
    WiFiProductsHeaderView *headerView_;
    NSNumber *expandedHeader;
    
    NSMutableArray *jsonSpecification;
    NSMutableArray *productSpecification_;
}

@property (nonatomic, retain) IBOutlet WiFiProductsHeaderView *headerView;
@property (nonatomic, retain) NSMutableArray *expandedHeadersArray;

@property (nonatomic, retain) NSString *finalId;
@property (nonatomic, retain) IBOutlet UITableView *productCompanyListTable;
@property (nonatomic, retain) IBOutlet UISearchBar *searchProdComp;
- (void) productCompany: (NSString *) url;
- (void)getCompanyProducts:(NSString *)url;
@end
