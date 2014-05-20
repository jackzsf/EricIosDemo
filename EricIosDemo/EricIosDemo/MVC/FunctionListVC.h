//
//  FunctionListVC.h
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *listTable;
    NSMutableArray  *dataArray;
}

@end
