//
//  ArticleItem.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "ArticleItem.h"

@implementation ArticleItem



-(NSString*)getFullArticleURL:(ArticleItem*)article baseURL:(NSString*)base
{
    NSString* wiki_url = [article.title stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return [NSString stringWithFormat:@"%@/%@",base,wiki_url];
}

@end
