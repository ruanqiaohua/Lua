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
#import "AFNetworking.h"

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
    [self requestData];
}

- (void)requestData
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *patchZip = [doc stringByAppendingPathComponent:@"patch.zip"];
    [[NSFileManager defaultManager] removeItemAtPath:patchZip error:NULL];

    [self downloadPatchZip:^(BOOL success) {
        if (success) {
            NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
            [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            //解压
            ZipArchive *zip = [[ZipArchive alloc] init];
            [zip UnzipOpenFile:patchZip];
            [zip UnzipFileTo:dir overWrite:YES];
            NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", dir, dir];
            setenv(LUA_PATH, [pp UTF8String], 1);
            wax_start("init", nil);
            [_loading stopAnimating];
            [UIApplication sharedApplication].keyWindow.rootViewController = [ViewController new];
        }else {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"加载失败" preferredStyle:UIAlertControllerStyleAlert];
            __weak typeof(self) weakSelf = self;
            UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf requestData];
            }];
            [alertVC addAction:cancelBtn];
            [self showDetailViewController:alertVC sender:self];
        }
    }];
}

- (void)downloadPatchZip:(void(^)(BOOL success))success
{
    _progressView.progress = 0.0;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:WAX_PATCH_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat progress = [[NSString stringWithFormat:@"%.0f",downloadProgress.fractionCompleted] floatValue];
        _progressView.progress = progress;
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            success(NO);
        }else {
            success(YES);
        }
    }];
    [downloadTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
