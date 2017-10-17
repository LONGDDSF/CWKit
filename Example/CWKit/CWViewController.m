//
//  CWViewController.m
//  CWKit
//
//  Created by LONGDDSF on 09/30/2017.
//  Copyright (c) 2017 LONGDDSF. All rights reserved.
//

#import "CWViewController.h"
//#import "CWFoundation.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
