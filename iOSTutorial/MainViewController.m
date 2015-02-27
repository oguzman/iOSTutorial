//
//  MainViewController.m
//  iOSTutorial
//
//  Created by Omar Guzmán on 2/24/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tblProducts;
@synthesize arrProducts;
@synthesize productDetailViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Catalogo..."];
    [tblProducts setDelegate:self];
    [tblProducts setDataSource:self];
    [self doCallProductsService];
    //todo: add loader
}

-(void)doCallProductsService
{
    //here
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    arrProducts = [[NSMutableArray alloc] init];
    [RESTManager sendData:nil toService:@"products" withMethod:@"GET" isTesting:NO withAccessToken:[[defaults objectForKey:@"userInfo"] objectForKey:@"access_token"] toCallBack:^(id result){
        arrProducts = result;
        [tblProducts reloadData];
        //todo: remove loader
    }];
    //NOOOOOO, pq. se salio del hilo (bloque)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrProducts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CellProduct";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = nil;
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSMutableDictionary * dictProduct = [arrProducts objectAtIndex:indexPath.row];
    [[cell textLabel] setTextColor:[UIColor colorWithRed:95.0f/255.0 green:95.0f/255.0 blue:95.0f/255 alpha:1.0f]];
    cell.textLabel.text = [dictProduct objectForKey:@"description"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * dictProduct = [arrProducts objectAtIndex:indexPath.row];
    productDetailViewController = [[ProductDetailViewController alloc] init];
    productDetailViewController.dictProduct = dictProduct;
    [self.navigationController pushViewController:productDetailViewController animated:YES];
}






























@end
