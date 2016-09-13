//
//  DetailContainerView.m
//  GOT
//
//  Created by Dragos Marinescu on 10/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "DetailContainerView.h"

@implementation DetailContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_avatarImageView];

        _articleLabel= [[UITextView alloc]init];
        _articleLabel.textColor = [UIColor blackColor];
        _articleLabel.scrollEnabled = YES;
        _articleLabel.editable = NO;
        _articleLabel.userInteractionEnabled = YES;
        _articleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _articleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_articleLabel];
        NSDictionary *views = NSDictionaryOfVariableBindings(_avatarImageView,_articleLabel);

        NSLayoutConstraint *imageViewWidth    = [NSLayoutConstraint
                                      constraintWithItem:_avatarImageView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:1.0f
                                      constant:0];
        [self addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[_avatarImageView]" options:0 metrics:nil views:views][0]];
        [self addConstraint:imageViewWidth];
        
        
   
        
        NSLayoutConstraint *top      = [NSLayoutConstraint
                                      constraintWithItem:_articleLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:_avatarImageView
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:10];
        NSLayoutConstraint *left     = [NSLayoutConstraint
                                       constraintWithItem:_articleLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                       attribute:NSLayoutAttributeLeading
                                       multiplier:1.0f
                                       constant:30];
        NSLayoutConstraint *right     = [NSLayoutConstraint
                                        constraintWithItem:_articleLabel
                                        attribute:NSLayoutAttributeTrailing
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeTrailing
                                        multiplier:1.0f
                                        constant:-30];
        
        [self addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_articleLabel(300)]" options:0 metrics:nil views:views][0]];
   
        
        [self addConstraints:@[top,left,right]];
        
        
    }
    return self;
}
@end
