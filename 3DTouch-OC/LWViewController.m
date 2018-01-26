//
//  LWViewController.m
//  3DTouch-OC
//
//  Created by 张星星 on 16/10/27.
//  Copyright © 2016年 张星星. All rights reserved.
//  https://www.jianshu.com/p/40ffc1ba294a
//

#import "LWViewController.h"
#import "PhoneInfoManager.h"
#import "BaseViewController.h"
@interface LWViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /**
     *  如果支持3DTouch，就添加3DTouch的代理
     */
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    
//    _lbl.text = [NSString stringWithFormat:@"****妈妈再也不用担心我装逼了****\n\n我的设备: %@\n\n我的内存: %.2f MB\n\n我的储空间: %qi GB\n\n********************************",[PhoneInfoManager getCurrentDeviceModel],[PhoneInfoManager logMemoryInfo],[PhoneInfoManager freeDiskSpaceInBytes]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint) point
{
    /**
     轻按
     
     - returns: 要显示的VC
     */
    BaseViewController *vc = [[BaseViewController alloc] init];
    vc.view.frame = self.view.frame;
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:vc.view.frame];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    lbl.font = [UIFont systemFontOfSize:50.0];
    lbl.text = [NSString stringWithFormat:@"不要这么使劲的戳人家嘛\n\n⁄(⁄ ⁄•⁄ω⁄•⁄ ⁄)⁄\n\n淫家只是一台可以摸的iPhone了啦"];
    vc.view = lbl;
    
    /**
     *  轻按显示VC大小范围
     *
     *  @param 0.0f   显示宽度(0为不限制？)
     *  @param 450.0f 显示高度
     *
     *  @return vc
     */
    vc.preferredContentSize = CGSizeMake(0.0f,300.0f);
    
    /**
     *  触摸和轻按中间的过度模糊层（rect为0就没有这个效果啦！！！系统会去掉，设为float最小值会全覆盖）
     *
     *  @param CGFLOAT_MIN float最小值
     *  @param CGFLOAT_MIN float最小值
     *  @param CGFLOAT_MIN float最小值
     *  @param CGFLOAT_MIN float最小值
     *
     *  @return 模糊层范围
     */
    CGRect rect = CGRectMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN ,CGFLOAT_MIN);
    context.sourceRect = rect;
    
    return vc;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    
    /**
     *  重按push进去，然后3秒后移除
     */
    [self showViewController:viewControllerToCommit sender:self];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [viewControllerToCommit dismissViewControllerAnimated:YES completion:^{
        }];
    });
}



@end
