//
//  ProductsHeaderView.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/28/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HeaderViewDelegate;

@interface WiFiProductsHeaderView : UIView {
    id<HeaderViewDelegate> delegate;
}

@property (assign) NSInteger section;
@property (nonatomic, strong) id<HeaderViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UILabel *headerTitleLabel;

@end

@protocol HeaderViewDelegate <NSObject>

- (void)updateTableViewWithData: (NSNumber *)section;

@end