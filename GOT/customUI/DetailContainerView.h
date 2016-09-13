//
//  DetailContainerView.h
//  GOT
//
//  Created by Dragos Marinescu on 10/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleItem.h"

@interface DetailContainerView : UIView
@property(nonatomic,strong) UIImageView* avatarImageView;
@property(nonatomic,strong) UITextView* articleLabel;
@property(nonatomic,strong) ArticleItem* item;
@end
