//
//  ArticleCell.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell

@property(nonatomic,strong)UIImageView *customImageView;
@property(nonatomic,strong)UILabel *customLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong) UIButton* btnDetails;

@property(weak, nonatomic) NSLayoutConstraint* topArticleConstraint;
@property(weak, nonatomic) NSLayoutConstraint* bottomArticleConstraint;
@property(weak, nonatomic) NSLayoutConstraint* articleViewHeightConstraint;

@end
