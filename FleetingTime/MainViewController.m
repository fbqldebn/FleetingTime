//
//  MainViewController.m
//  FleetingTime
//
//  Created by 许爱爱 on 2018/8/4.
//  Copyright © 2018年 X. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "Define.h"
#import "MainModel.h"
#import <Masonry.h>
#import "SVGViewController.h"

static NSString *const kMainCell = @"mainCell";
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *mainTableView;

@property (nonatomic, strong) UIImageView *bigImageView;// 大图视图
@property (nonatomic, strong) UIView *bgView;// 阴影视图
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *desArray;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign) CGRect imageFrame;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流年";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, kSizeScale(40.0), kSizeScale(39/2.0));
    [rightBtn setTitle:@"SVG" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    rightBtn.titleLabel.text = @"SVG";
//    rightBtn.titleLabel.textColor = [UIColor blackColor];
//    rightBtn.backgroundColor = [UIColor yellowColor];
    [rightBtn addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightNumItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightNumItem;
    
    
    [self createData];
    [self createView];
    // Do any additional setup after loading the view.
}

-(void)pushView
{
    SVGViewController *vc = [[SVGViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)createData
{
    self.modelArray = [NSMutableArray array];
    for (int i = 0; i<self.imgArray.count; i++) {
        MainModel *model = [[MainModel alloc]init];
        model.imageString = self.imgArray[i];
        model.titleString = self.titleArray[i];
        model.desString = self.desArray[i];
        [self.modelArray addObject:model];
    }
}

-(void)createView{
    UITableView *mainTableView = [[UITableView alloc]init];
    mainTableView.backgroundColor = [UIColor clearColor];
    [mainTableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:kMainCell];
    mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    mainTableView.rowHeight = UITableViewAutomaticDimension;
    mainTableView.estimatedRowHeight = kSizeScale(110);
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    self.mainTableView = mainTableView;
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.mainTableView.superview.mas_safeAreaLayoutGuideTop);
        }else{
            make.top.equalTo(self.mainTableView.superview.mas_top).offset([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height);
        }
        make.left.right.equalTo(self.mainTableView.superview);
        make.bottom.equalTo(self.mainTableView.superview).offset(-10);
    }];

}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.imgArray.count%2==0){
        return self.imgArray.count/2;
    }else{
        return self.imgArray.count/2+1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMainCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    MainModel *leftModel = self.modelArray[indexPath.row];
    NSString *left = leftModel.imageString;
    MainModel *rightModel = [[MainModel alloc]init];
   
    if(self.imgArray.count%2==0){
        if(self.imgArray.count>(indexPath.row+self.imgArray.count/2)){
            rightModel = self.modelArray[indexPath.row+self.imgArray.count/2];
        }
    }else{
        if(self.imgArray.count>(indexPath.row+self.imgArray.count/2+1)){
            rightModel = self.modelArray[indexPath.row+self.imgArray.count/2+1];
        }
    }
    
     NSString *right = rightModel.imageString;
    [cell setLeftImage:left rightImage:right];
    __weak __typeof__(self) weakSelf = self;
    cell.cellBlock = ^(NSInteger index,CGRect rect){
         __strong __typeof(self) strongSelf = weakSelf;
        strongSelf.imageFrame = rect;
        if(index == 1000){
            [strongSelf openImage:leftModel frame:rect];
        }else{
            [strongSelf openImage:rightModel frame:rect];
        }
    };
    
    return cell;
}


-(void)openImage:(MainModel *)model frame:(CGRect)imageFrame
{
    [self bgView];
    [self bigImageView];
    [self.bgView addSubview:self.bigImageView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.desLabel];
    self.titleLabel.text = model.titleString;
    self.desLabel.text = model.desString;
    CGSize size = [UIImage imageNamed:model.imageString].size;
    if(size.width>size.height){
        if(size.width>SCREENWIDTH){
            size.width = SCREENWIDTH;
            size.height = size.width/SCREENWIDTH*SCREENHEIGHT;
        }
    }else{
        if(size.height>SCREENHEIGHT){
            size.height = SCREENHEIGHT;
            size.width = size.height/SCREENHEIGHT*SCREENWIDTH;
        }
    }
    self.bigImageView.frame =imageFrame;
    self.bigImageView.image = [UIImage imageNamed:model.imageString];
     __weak __typeof__(self) weakSelf = self;
    // 动画到大图该有的大小
    [UIView animateWithDuration:0.3 animations:^{
        __strong __typeof(self) strongSelf = weakSelf;
        strongSelf.bigImageView.frame = CGRectMake((SCREENWIDTH-size.width)/2, (SCREENHEIGHT-size.height)/2, size.width, size.height);
    }];
}

-(void)dismissBigImage
{
    __weak __typeof__(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
         __strong __typeof(self) strongSelf = weakSelf;
        strongSelf.bigImageView.frame = strongSelf.imageFrame;
    } completion:^(BOOL finished) {
        if(finished){
              __strong __typeof(self) strongSelf = weakSelf;
             [strongSelf.bigImageView removeFromSuperview];
            [strongSelf.bgView removeFromSuperview];// 移除阴影
            strongSelf.bigImageView = nil;
            strongSelf.bgView = nil;

        }
    }];
    
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 20)];
        if(iPhoneX){
            _titleLabel.frame = CGRectMake(0, 40, SCREENWIDTH, 20);
        }
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return  _titleLabel;
}
-(UILabel *)desLabel{
    if(!_desLabel){
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-30, SCREENWIDTH, 20)];
        if(iPhoneX){
            _desLabel.frame = CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 20);
        }
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.font = [UIFont systemFontOfSize:14];
        _desLabel.textColor = [UIColor whiteColor];
    }
    return  _desLabel;
}
// 大图视图
- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        // 设置大图的点击响应，此处为收起大图
        _bigImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBigImage)];
        [_bigImageView addGestureRecognizer:imageTap];
    }
    return _bigImageView;
}

// 阴影视图
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        // 设置阴影背景的点击响应，此处为收起大图
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBigImage)];
        [_bgView addGestureRecognizer:bgTap];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    }
    return _bgView;
}

//初始化数据
-(NSMutableArray *)imgArray
{
    if(!_imgArray){
        _imgArray = [NSMutableArray array];
        for (int i = 0; i<9; i++) {
            [_imgArray addObject:[NSString stringWithFormat:@"img_%d",i]];
        }
    }
    return _imgArray;
}
-(NSMutableArray *)titleArray
{
    if(!_titleArray){
        _titleArray = [NSMutableArray arrayWithObjects:@"花环",@"礼物",@"背景",@"桃花",@"幻想",@"七夕",@"白宇",@"朱一龙",@"镇魂兄弟", nil];
        
    }
    return _titleArray;
}
-(NSMutableArray *)desArray
{
    if(!_desArray){
        _desArray =[NSMutableArray arrayWithObjects:@"一个花环",@"送你的礼物",@"镜像",@"桃花朵朵开",@"我的梦",@"浪漫而悲伤",@"我们镇魂令主",@"居老师",@"夏天",nil];
       
    }
    return _desArray;
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
