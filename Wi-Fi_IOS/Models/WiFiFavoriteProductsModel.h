//
//  FavoriteProducts.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/25/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WiFiFavoriteProductsModel : NSManagedObject

@property (nonatomic, retain) NSString * certificationUrl;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * certificationId;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * product;

@end
