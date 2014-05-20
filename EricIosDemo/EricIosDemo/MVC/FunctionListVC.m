//
//  FunctionListVC.m
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "FunctionListVC.h"
#import "FunctionModel.h"

@interface FunctionListVC ()

@end

#define SexCellHeight 40

@implementation FunctionListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RootView", @"");
    
//    [self initLeftBarButton];
    [self getData];
    [self initTableView];
}

#pragma mark -GetData
-(void)getData
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentDirectory stringByAppendingPathComponent:@"FuncListInfo.plist"];
//    [dataArray writeToFile:path atomically:YES];
    
    //从plist中读取文件
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"FuncListInfo" ofType:@"plist"];
    NSMutableArray *dicArr = [[NSMutableArray alloc] initWithContentsOfFile:pathStr];
    dataArray = [FunctionModel dicArrToModelArr:dicArr];
    
    NSLog(@"pathStr is %@,dataArray is %@",pathStr,dataArray);
}

#pragma mark -initTableView
-(void)initTableView
{
    listTable = [[UITableView alloc] initWithFrame:Frame(0, 0, CIA.scWidth, CIA.scHeightWithoutStateAndNav) style:UITableViewStylePlain];
    listTable.delegate = self;
    listTable.dataSource = self;
    if (CIA.isIOS7) {
        listTable.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        
    }
    [self.view addSubview:listTable];
}

-(void)leftBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableview dataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SexCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"normal_Cell";
    UITableViewCell *indexCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexCell == nil)
    {
        indexCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        indexCell.backgroundColor = WhiteColor;
        indexCell.textLabel.frame = Frame(140, 0, 200, 20);
    }
    FunctionModel *indexModel = [dataArray objectAtIndex:indexPath.row];
    indexCell.textLabel.text = indexModel.name;
    
    return indexCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FunctionModel *indexModel = [dataArray objectAtIndex:indexPath.row];
    switch (indexModel.functionTag)
    {
        case TagSqlite:
        {
            NSLog(@"TagSqlite...");
        }
            break;
        case TagCoreData:
        {
            NSLog(@"TagCoreData...");
        }
            break;
        case TagASI:
        {
            NSLog(@"TagASI...");
        }
            break;
        case TagQueue:
        {
            NSLog(@"TagQueue...");
        }
            break;
        case TagGCD:
        {
            NSLog(@"TagGCD...");
        }
            break;
        case TagBlock:
        {
            NSLog(@"TagBlock...");
        }
            break;
        case TagMultiThread:
        {
            NSLog(@"TagMultiThread...");
        }
            break;
            
        default:
            break;
    }
}
@end
