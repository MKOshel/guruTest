//
//  ArticleItem.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleItem : NSObject

@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* thumbnailURL;
@property(nonatomic,strong) NSString* itemDescription;
@property(nonatomic,strong) NSString* fullArticle;
@property(nonatomic,assign) BOOL isFav;

-(NSString*)getFullArticleURL:(ArticleItem*)article baseURL:(NSString*)base;
@end
