//
//  ViewController.m
//  Lua
//
//  Created by ruanqiaohua on 15/12/15.
//  Copyright © 2015年 ruanqiaohua. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"
#import "wax.h"

#define WAX_PATCH_URL @"https://github.com/ruanqiaohua/Lua/raw/master/Lua/patch.zip"

@interface ViewController ()<NSURLConnectionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([self requestData]) {
        [_loading stopAnimating];
        [UIApplication sharedApplication].keyWindow.rootViewController = [ViewController new];
    }else {
        [_loading startAnimating];
        [self requestData];
    }
}

- (BOOL)requestData
{
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
        return YES;
    }
    return NO;
}


#pragma mark - <UITableViewDataSource>

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
