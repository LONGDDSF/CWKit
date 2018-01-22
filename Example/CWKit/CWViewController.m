//
//  CWViewController.m
//  CWKit
//
//  Created by LONGDDSF on 09/30/2017.
//  Copyright (c) 2017 LONGDDSF. All rights reserved.
//

#import "CWViewController.h"
//#import "CWFoundation.h"
#import "TNSelectItemListView.h"

#import "Masonry.h"

#import "TNSelectItemMenu.h"

#import "CWListView.h"

@interface CWViewController ()

@end

@implementation CWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray * mArr = [[NSMutableArray alloc] init];
    
    NSArray *arr = nil;
    
    [mArr addObject:arr];
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    
    [mDic setValue:arr forKey:@"arr"];
    [mDic setObject:arr forKey:@"arr"];
    
//    [self testSelectItemView];
    
//    [self test_menu];
    
    [self debug_listview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ------------------ title

- (void)testSelectItemView
{
    TNSelectItemListView *view = [TNSelectItemListView listView];
    
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.top.right.mas_equalTo(0);
    }];
    
    [view.tnInteractor test_reqAllData];
}

- (void)test_menu
{
    TNSelectItemMenu *menu = [[TNSelectItemMenu alloc] init];
    
    [menu setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:menu];
    
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(50);
    }];
}

- (void)debug_listview
{
    CWListView *listview = [[CWListView alloc] init];
    
    [self.view addSubview:listview];
    [listview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [listview reloadDataWithTotleCount:20 itemConfig:^(UIView *itemView, NSInteger idx) {
        
        itemView.backgroundColor = [UIColor grayColor];
    }];
}

@end
