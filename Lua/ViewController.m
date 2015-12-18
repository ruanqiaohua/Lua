//
//  ViewController.m
//  Lua
//
//  Created by ruanqiaohua on 15/12/15.
//  Copyright © 2015年 ruanqiaohua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/lua/tiegui.jpg",[self docutmentPath]];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString *)docutmentPath
{
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return doc;
}

#pragma mark - <UITableViewDataSource>

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
