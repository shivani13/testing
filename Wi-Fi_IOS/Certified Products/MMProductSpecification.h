//
//  MMProductSpecification.h
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMProductSpecification : UIViewController{
    NSMutableArray *jsonSpecification;
    NSMutableArray *productSpecification_;
    
}
@property (nonatomic, retain) NSString *comSpec;
@property (nonatomic, retain) IBOutlet UITableView *specificationTable;
@property (nonatomic, retain) IBOutlet UISearchBar *searchProSpec;

- (void) specification;
@end
