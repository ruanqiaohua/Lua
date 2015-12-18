//
//  AppDelegate.m
//  Lua
//
//  Created by ruanqiaohua on 15/12/15.
//  Copyright © 2015年 ruanqiaohua. All rights reserved.
//

#import "AppDelegate.h"
#import "wax.h"
#import "ZipArchive.h"
#import "ViewController.h"

#define USE_DYNAMICUPDATE //更新
#define WAX_PATCH_URL @"https://github.com/ruanqiaohua/Lua/raw/master/Lua/patch.zip"

@interface AppDelegate ()

@end

@implementation AppDelegate

#ifdef USE_DYNAMICUPDATE
- (id)init {
    if(self = [super init]) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
        [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
        
        NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", dir, dir];
        setenv(LUA_PATH, [pp UTF8String], 1);
    }
    return self;
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef USE_DYNAMICUPDATE
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有新的更新可用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil] show];
#else
    wax_start("init.lua", nil);
#endif
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == [alertView firstOtherButtonIndex]) {
        // you probably want to change this url before run
        NSURL *patchUrl = [NSURL URLWithString:WAX_PATCH_URL];
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:patchUrl] returningResponse:NULL error:NULL];
        if(data) {
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *patchZip = [doc stringByAppendingPathComponent:@"patch.zip"];
            [data writeToFile:patchZip atomically:YES];
            
            NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
            [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            
            ZipArchive *zip = [[ZipArchive alloc] init];
            [zip UnzipOpenFile:patchZip];
            [zip UnzipFileTo:dir overWrite:YES];
            
            NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", dir, dir];
            setenv(LUA_PATH, [pp UTF8String], 1);
            wax_start("init", nil);
            self.window.rootViewController = [[ViewController alloc]init];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"加载失败"] delegate:nil cancelButtonTitle:@"tryAgain" otherButtonTitles:nil] show];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
