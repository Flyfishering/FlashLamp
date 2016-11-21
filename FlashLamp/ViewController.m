//
//  ViewController.m
//  FlashLamp
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "PopView.h"
@import AVFoundation;//加入AVFoundation模块，这种写法就不用再项目里面加frame库文件了
@interface ViewController ()
@property (nonatomic, strong) PopView *popView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UILabel *inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    inforLabel.text  = @"向上滑动打开闪光灯";
    inforLabel.textColor = [UIColor lightGrayColor];
    inforLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    inforLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:inforLabel];

    //添加popView
    self.popView = [[PopView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:self.popView];
 
    //添加滑动手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(popSubViews)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    
    //点击闪光灯按钮 添加事件
    [self.popView.flashButton addTarget:self action:@selector(openLight:) forControlEvents:UIControlEventTouchUpInside];
    
}





- (void)openLight:(UIButton *)sender{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //修改前必须先锁定
    [device lockForConfiguration:nil];
    
    //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
    if ([device hasFlash]) {
        
        if (device.flashMode == AVCaptureFlashModeOff) {
            device.flashMode = AVCaptureFlashModeOn;
            device.torchMode = AVCaptureTorchModeOn;
        } else if (device.flashMode == AVCaptureFlashModeOn) {
            device.flashMode = AVCaptureFlashModeOff;
            device.torchMode = AVCaptureTorchModeOff;
        }
        
    }
    [device unlockForConfiguration];
}


//弹出popView
- (void)popSubViews{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.popView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);
    } completion:^(BOOL finished) {
        
    }];
}

//收回 弹出的popview
- (void)dismissPopView{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.popView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
    } completion:^(BOOL finished) {
        
    }];
}

//当点击 非popview区域 收回popView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (touches.anyObject.view == self.popView) {

    }else{

        [self dismissPopView];
    }
}




@end
