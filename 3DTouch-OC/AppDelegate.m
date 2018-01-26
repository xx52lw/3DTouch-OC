//
//  AppDelegate.m
//  3DTouch-OC
//
//  Created by 张星星 on 16/10/27.
//  Copyright © 2016年 张星星. All rights reserved.
//

#import "AppDelegate.h"
#import "LWTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#ifdef NSFoundationVersionNumber_iOS_8_x_Max
-(void)set3DTouch:(UIApplication *)application{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"item1"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"newType" localizedTitle:@"新增功能1" localizedSubtitle:nil icon:icon1 userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"newType" localizedTitle:@"新增功能2" localizedSubtitle:nil icon:icon1 userInfo:nil];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"newType" localizedTitle:@"新增功能3" localizedSubtitle:nil icon:icon2 userInfo:nil];
    application.shortcutItems = @[item1,item2,item3];
}
#endif
// 点击图标调用
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"newType"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"3d touch" message:@"通过图标的3D touch功能进入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"back" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    [self set3DTouch:application];
#endif
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LWTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.demo.widget.name"];
    //读NSUserDefaults共享数据
    NSString *userDefaultString = [userDefaults objectForKey:@"nowDate"];
    //读fileManager共享数据
    NSString *fileString =[[NSString alloc] initWithData:[self readDataByNSFileManager] encoding:kCFStringEncodingUTF8];
    
    NSString *string = [NSString stringWithFormat:@"userDefault=%@,fileManager=%@",userDefaultString,fileString];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"widget" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"back" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    return YES;
}

-(NSData *)readDataByNSFileManager
{
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.demo.widget.name"];
    containerURL = [containerURL URLByAppendingPathComponent:@"widget"];
    NSData *value = [NSData dataWithContentsOfURL:containerURL];
    return value;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
