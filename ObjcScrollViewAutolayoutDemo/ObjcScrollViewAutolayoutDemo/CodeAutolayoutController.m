//
//  CodeAutolayoutController.m
//  ObjcScrollViewAutolayoutDemo
//
//  Created by huangyibiao on 15/10/21.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "CodeAutolayoutController.h"
#import <Masonry/Masonry.h>

@implementation CodeAutolayoutController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.view.backgroundColor = [UIColor whiteColor];
  
  __weak __typeof(self) weakSelf = self;
  
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:scrollView];

  // 放一个说明标签
  UILabel *tipLabel = [[UILabel alloc] init];
  tipLabel.backgroundColor = [UIColor redColor];
  tipLabel.numberOfLines = 0;
  tipLabel.textColor = [UIColor whiteColor];
  tipLabel.textAlignment = NSTextAlignmentLeft;
  [scrollView addSubview:tipLabel];
  [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.mas_equalTo(10);
    // 注意：这里直接使用weakSelf.view，相当于weakSelf.view.mas_right
    // 另外：由于要与weakSelf.view.mas_right距离10像素，因此这里值为-10。
    make.right.mas_equalTo(weakSelf.view).offset(-10);
  }];
  tipLabel.text = @"这个标签是使用Masonry完成的纯代码自动布局。这个标签的约束添加方式为：使左、上与父视图的左、上分别相等，使右边与self.view的右边的相距-10，就可以确定其宽。这里不能使用使右等于scrollview的右，因为scrollview是可以滚动的，其右是不确定的。";
  
  UILabel *codeLabel = [[UILabel alloc] init];
  codeLabel.backgroundColor = [UIColor redColor];
  codeLabel.numberOfLines = 0;
  codeLabel.textColor = [UIColor whiteColor];
  codeLabel.textAlignment = NSTextAlignmentLeft;
  [scrollView addSubview:codeLabel];
  [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    // 使与tipLabel的左、右分别对齐 ，也就确定了宽
    make.left.right.mas_equalTo(tipLabel);
    
    make.top.mas_equalTo(tipLabel.mas_bottom).offset(40);
    // 注意：这里直接使用weakSelf.view，相当于weakSelf.view.mas_right
    // 另外：由于要与weakSelf.view.mas_right距离10像素，因此这里值为-10。
  }];
codeLabel.text = @"本标签的约束添加方式为：使左、右与上面的标签的左、右分别对齐，由此就可确定左、右和宽，再使顶部top等于上面的标签的bottom再加上40个像素。\n欢迎扫一扫我的微信公众号二维码，关注公众号，或者直接搜索iOSDevShares。若想加QQ群，请加：324400294";
  
  UIImageView *codeImageView = [[UIImageView alloc] init];
  codeImageView.image = [UIImage imageNamed:@"微信公众号.jpg"];
  [scrollView addSubview:codeImageView];
  [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(weakSelf.view);
    make.top.mas_equalTo(codeLabel.mas_bottom).offset(20);
    make.size.mas_equalTo(CGSizeMake(250, 250));
  }];
  
  // 由于图片过大，需要限制。如果是图片刚好，可以不设置大小的约束，使用下面的方式。
//  [codeImageView sizeToFit];
  
  // 平分两个控件
  UILabel *avgLabel1 = [[UILabel alloc] init];
  avgLabel1.backgroundColor = [UIColor redColor];
  avgLabel1.numberOfLines = 0;
  avgLabel1.textColor = [UIColor whiteColor];
  avgLabel1.textAlignment = NSTextAlignmentCenter;
  [scrollView addSubview:avgLabel1];
avgLabel1.text = @"本控件的约束添加方式为：使left与父视图的left相距10像素，使top=上面的图片的bottom再加40像素，使right=右边这个标签的left再减去20个像素（间隔），使height=80。";
  
  UILabel *avgLabel2 = [[UILabel alloc] init];
  avgLabel2.backgroundColor = [UIColor redColor];
  avgLabel2.numberOfLines = 0;
  avgLabel2.textColor = [UIColor whiteColor];
  avgLabel2.textAlignment = NSTextAlignmentCenter;
  [scrollView addSubview:avgLabel2];
  avgLabel2.text = @"本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。";
  
  [avgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.top.mas_equalTo(codeImageView.mas_bottom).offset(40);
    make.right.mas_equalTo(avgLabel2.mas_left).offset(-20);
  }];
  [avgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(weakSelf.view.mas_right).offset(-10);
    make.width.top.mas_equalTo(avgLabel1);
  }];
  
  // 使用edges使点满整个self.view
  [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(weakSelf.view);
    
    // 如果这两个标签的内容都是不确定的，也就是不确定哪个的内容更多，那么可以这么设置。
    // 这样就可以保证使用内容最多的标签作为scrollview的contentSize参考。
    // 用于确定scrollview的contentSize.height
    make.bottom.mas_greaterThanOrEqualTo(avgLabel1.mas_bottom).offset(40);
    make.bottom.mas_greaterThanOrEqualTo(avgLabel2.mas_bottom).offset(40);
  }];
}

@end
