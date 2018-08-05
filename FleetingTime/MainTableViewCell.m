//
//  MainTableViewCell.m
//  FleetingTime
//
//  Created by 许爱爱 on 2018/8/4.
//  Copyright © 2018年 X. All rights reserved.
//

#import "MainTableViewCell.h"
#import <Masonry.h>
#import "Define.h"

@interface MainTableViewCell()

@property(nonatomic,weak)UIImageView *leftImageView;
@property(nonatomic,weak)UIImageView *rightImageView;

@end

@implementation MainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self createView];
    }
    return self;
}
-(void)createView
{
    UIImageView *leftImageView = [[UIImageView alloc]init];
    leftImageView.layer.masksToBounds = YES;
    leftImageView.userInteractionEnabled = YES;
    leftImageView.layer.cornerRadius = 5;
    leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:leftImageView];
    self.leftImageView = leftImageView;
    
    UIImageView *rightImageView = [[UIImageView alloc]init];
    rightImageView.layer.masksToBounds = YES;
    rightImageView.layer.cornerRadius = 5;
    rightImageView.userInteractionEnabled = YES;
    rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:rightImageView];
    self.rightImageView = rightImageView;
    
    CGFloat imgWidth = kSizeScale(165);
    CGFloat imgHeight = kSizeScale(150);
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imgWidth);
        make.height.mas_equalTo(imgHeight);
        make.top.equalTo(leftImageView.superview).offset(10);
        make.bottom.equalTo(leftImageView.superview);
        make.left.equalTo(leftImageView.superview).offset((SCREENWIDTH-imgWidth*2)/3);
    }];
    
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imgWidth);
        make.height.mas_equalTo(imgHeight);
        make.top.equalTo(leftImageView.superview).offset(10);
        make.bottom.equalTo(leftImageView.superview);
        make.left.equalTo(leftImageView.mas_right).offset((SCREENWIDTH-imgWidth*2)/3);
    }];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLeft:)];
    [leftImageView addGestureRecognizer:gr];
    
    UITapGestureRecognizer *gr1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRight:)];
    [rightImageView addGestureRecognizer:gr1];
}

-(void)setLeftImage:(NSString *)leftImageString rightImage:(NSString *)rightImageString
{
//    self.leftImageView.backgroundColor = [UIColor redColor];
    self.leftImageView.image = [UIImage imageNamed:leftImageString];
    self.rightImageView.image = [UIImage imageNamed:rightImageString];
}

-(void)tapLeft:(UITapGestureRecognizer *)gr
{
    [gr.view layoutIfNeeded];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect1 = [gr.view convertRect:gr.view.frame fromView:self.contentView];//获取button在contentView的位置
    CGRect rect2 = [gr.view convertRect:rect1 toView:window];
    if(self.cellBlock){
        self.cellBlock(1000,rect2);
    }
}

-(void)tapRight:(UITapGestureRecognizer *)gr
{
     [gr.view layoutIfNeeded];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect1 = [gr.view convertRect:gr.view.frame fromView:self.contentView];//获取button在contentView的位置
    CGRect rect2 = [gr.view convertRect:rect1 toView:window];
    if(self.cellBlock){
        self.cellBlock(2000,rect2);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
