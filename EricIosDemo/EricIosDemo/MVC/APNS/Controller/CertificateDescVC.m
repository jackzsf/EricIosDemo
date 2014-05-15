//
//  CertificateDescVC.m
//  EricIosDemo
//
//  Created by Eric on 14-5-15.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "CertificateDescVC.h"

@interface CertificateDescVC ()

@end

@implementation CertificateDescVC

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
    
    [self addDescLabel];
}

#pragma mark -initView
-(void)addDescLabel
{
    descLabel = [[UILabel alloc] init];
    descLabel.frame = CGRectMake(0, 0, 320, 568);
    descLabel.text = @"将p12证书文件转换成pem证书文件。在终端里运行以下命令转换：\nopenssl pkcs12 -in MyApnsCert.p12 -out MyApnsCert.pem -nodes";
    
    [self.view addSubview:descLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
