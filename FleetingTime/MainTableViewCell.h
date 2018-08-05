//
//  MainTableViewCell.h
//  FleetingTime
//
//  Created by 许爱爱 on 2018/8/4.
//  Copyright © 2018年 X. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MainTableViewCellBlock)(NSInteger index,CGRect rect);

@interface MainTableViewCell : UITableViewCell
@property(nonatomic,copy)MainTableViewCellBlock cellBlock;

-(void)setLeftImage:(NSString *)leftImageString rightImage:(NSString *)rightImageString;
@end
