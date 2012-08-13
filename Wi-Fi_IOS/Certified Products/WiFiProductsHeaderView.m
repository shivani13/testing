//
//  ProductsHeaderView.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/28/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiProductsHeaderView.h"

@implementation WiFiProductsHeaderView
@synthesize headerTitleLabel;
@synthesize section;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 300, 22)];
        
        [self addSubview:headerTitleLabel];
        
        UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHeader:)]autorelease];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)didTapHeader:(UITapGestureRecognizer *)gesture {
    [delegate updateTableViewWithData:[NSNumber numberWithInteger:section]];
}

- (void)dealloc {
    [headerTitleLabel release];
    [super dealloc];
}
@end
