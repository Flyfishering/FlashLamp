//
//  PopView.m
//  FlashLamp
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PopView.h"

@implementation PopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    
    return self;
}

//创建子view
- (void)createSubViews{
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.flashButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 - 40, self.frame.size.height/2.0 - 20, 80, 40)];
    self.flashButton.layer.cornerRadius = 20.0;
    [self.flashButton setTitle:@"闪光灯" forState:UIControlStateNormal];
    self.flashButton.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.flashButton];
}



@end
