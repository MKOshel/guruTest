//
//  GOTArticleDetailVC.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleItem.h"

@interface GOTArticleDetailVC : UIViewController
@property (nonatomic,strong) UIImageView* imageView;
@property (nonatomic,strong) UIImage* avatarImage;
@property (nonatomic,strong) ArticleItem* articleItem;
@end
