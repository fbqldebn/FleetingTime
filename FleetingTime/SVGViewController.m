//
//  SVGViewController.m
//  FleetingTime
//
//  Created by 许爱爱 on 2018/8/5.
//  Copyright © 2018年 X. All rights reserved.
//

#import "SVGViewController.h"
#import "SVGKImage.h"
#import "SVGKLayeredImageView.h"
@interface SVGViewController ()

@end

@implementation SVGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SVG";
    self.view.backgroundColor = [UIColor whiteColor];
    
    

    NSString *svgName = @"Cycling_Lambie.svg";
    SVGKImage *svgImage = [SVGKImage imageNamed:svgName];
    SVGKLayeredImageView *svgView = [[SVGKLayeredImageView alloc] initWithSVGKImage:svgImage];
    svgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:svgView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
