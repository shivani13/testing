//
//  ArticleListModel.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/16/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//
@protocol ArticleListDelegate <NSObject>

- (void) reloadTableView;

@end

#import <Foundation/Foundation.h>

@interface WiFiArticleListModel : NSObject<NSURLConnectionDelegate,NSXMLParserDelegate>{
    NSMutableData *response;
}

@property (assign,nonatomic) id<ArticleListDelegate>delegate;

@property (retain, nonatomic) NSString *articleListUrl;
@property (assign, nonatomic) BOOL isTitle;
@property (assign, nonatomic) BOOL isUrl;
@property (assign, nonatomic) BOOL isSummary;
@property (assign, nonatomic) BOOL isEntry;
@property (assign, nonatomic) BOOL isContent;

@property (assign, nonatomic) NSMutableArray *articleTitles;
@property (assign, nonatomic) NSMutableArray *articleLinks;
@property (assign, nonatomic) NSMutableArray *articleSummaries;
@property (assign, nonatomic) NSMutableArray *articleContent;
@property (assign, nonatomic) NSMutableArray *articleImageUrl;

@property (assign, nonatomic) NSMutableString *presentSummary;
@property (assign, nonatomic) NSMutableString *presentContent;

- (id) initWithArticleListUrl:(NSString *)url;
- (void) startUrlConnection;
- (void)startParsing;
@end
