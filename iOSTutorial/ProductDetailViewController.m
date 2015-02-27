//
//  ProductDetailViewController.m
//  iOSTutorial
//
//  Created by Omar Guzmán on 2/26/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize lblCategory, txtProductDescription, lblProductName, dictProduct;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [lblProductName setText:[dictProduct objectForKey:@"description"]];
    txtProductDescription.text = [dictProduct objectForKey:@"description_sub_family"];
    lblCategory.text = [dictProduct objectForKey:@"description_category"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
