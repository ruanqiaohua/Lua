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
    UITableView *tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@""];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - <UITableViewDataSource>

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end