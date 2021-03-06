//
//  MainViewController.h
//  iOSTutorial
//
//  Created by Omar Guzmán on 2/24/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTManager.h"
#import <JGProgressHUD.h>
#import "ProductDetailViewController.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView * tblProducts;
@property (strong, nonatomic) NSMutableArray * arrProducts;
@property (nonatomic, strong) ProductDetailViewController * productDetailViewController;
@end

