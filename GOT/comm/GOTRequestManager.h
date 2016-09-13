//
//  GOTRequestManager.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleItem.h"


@protocol ArticlesDelegate <NSObject>
@required
-(void)didReceiveGOTArticles:(NSArray*)articles;
@optional
-(void)didReceiveErrorOnDownloadingArticles:(NSError*)error;
@end

@interface GOTRequestManager : NSObject
+(GOTRequestManager*)sharedInstance;
@property(strong,nonatomic) id<ArticlesDelegate> delegate;
@property(strong,nonatomic) NSString* basepathURL;

-(void)getArticlesWithCount:(NSString*)count;
-(void)getFullArticleForItem:(ArticleItem*)item
                    response:(void(^)(id result, NSError* error))responseBlock;
-(void)getThumbnailForItem:(ArticleItem*)item
                  response:(void(^)(id result, NSError* error))responseBlock;


@end
