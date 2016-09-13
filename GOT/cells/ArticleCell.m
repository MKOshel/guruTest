//
//  ArticleCell.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "ArticleCell.h"



@implementation ArticleCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        _customImageView = [[UIImageView alloc] init];
        _customImageView.layer.masksToBounds = YES;
        _customImageView.layer.cornerRadius = 30;
        _customImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_customImageView];
        
        
        
        UIView* articleView = [[UIView alloc]init];
        articleView.translatesAutoresizingMaskIntoConstraints = NO;
        articleView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:articleView];

        _customLabel = [[UILabel alloc] init];
        _customLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _customLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _customLabel.numberOfLines = 0;
        [articleView setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisVertical];
        [articleView addSubview:_customLabel];
        
        _btnDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnDetails.titleLabel.text = @"Details >>>";
        _btnDetails.tintColor = [UIColor blackColor];
        [_btnDetails setImage:[UIImage imageNamed:@"Hearts-50"] forState:UIControlStateNormal];
        _btnDetails.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_btnDetails];
        //[_btnDetails setHidden:YES];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_customImageView, _customLabel,_titleLabel,self.contentView,articleView,_btnDetails);

        //btn details
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_btnDetails]"   options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_btnDetails]-10-|"   options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_btnDetails(50)]|"   options:0 metrics:nil views:views]];
        
        //article view
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[articleView]-0-|"   options:0 metrics:nil views:views]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[articleView]-0-|"   options:0 metrics:nil views:views]];
        
        
        //image view VF
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_customImageView]" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_customImageView]" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_customImageView(60)]" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_customImageView(60)]|" options:0 metrics:nil views:views]];
        //custom label VF
        [articleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_customLabel(250)]"  options:0 metrics:nil views:views]];
        [articleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-75-[_customLabel]-0-|"   options:0 metrics:nil views:views]];
        [articleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_customLabel]-0-|"   options:0 metrics:nil views:views]];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-75-[_titleLabel]"  options:0 metrics:nil views:views]];

    }

    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
