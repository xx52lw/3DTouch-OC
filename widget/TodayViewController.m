//
//  TodayViewController.m
//  widget
//
//  Created by liwei on 2018/1/24.
//  Copyright © 2018年 张星星. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TodayViewController
- (IBAction)homeClick:(id)sender {
    
    [self.extensionContext openURL:[NSURL URLWithString:@"liwei://1"] completionHandler:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.preferredContentSize = CGSizeMake(0,120);
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
#endif
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh-mm-ss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    //网络请求图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageDate = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://a1.jikexueyuan.com/home/201508/03/3697/55bee50b58c8b.jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageDate];
            self.imageView.image = image;
        });
    });
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh-mm-ss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.demo.widget.name"];
    [userDefaults setObject:dateStr forKey:@"nowDate"];
    
    //通过NSFileManager共享数据
    
    NSData *dateData = [dateStr dataUsingEncoding:NSUTF8StringEncoding];
    [self saveDataByNSFileManager:dateData];
    
    completionHandler(NCUpdateResultNewData);
}

-(BOOL)saveDataByNSFileManager:(NSData *)data
{
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.demo.widget.name"];
    containerURL = [containerURL URLByAppendingPathComponent:@"widget"];
    BOOL result = [data writeToURL:containerURL atomically:YES];
    return result;
}

-(NSData *)readDataByNSFileManager
{
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.demo.widget.name"];
    containerURL = [containerURL URLByAppendingPathComponent:@"widget"];
    NSData *value = [NSData dataWithContentsOfURL:containerURL];
    return value;
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    switch (activeDisplayMode) {
        case NCWidgetDisplayModeCompact:
            self.preferredContentSize = CGSizeMake(maxSize.width,100);
            //ios10以后，widget的关闭时高度为固定值，设置没效果。
            break;
        case NCWidgetDisplayModeExpanded:
            self.preferredContentSize = CGSizeMake(maxSize.width,100);
            break;
        default:
            break;
    }
    
}
#endif

@end
