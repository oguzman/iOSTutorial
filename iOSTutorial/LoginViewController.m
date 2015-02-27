//
//  LoginViewController.m
//  iOSTutorial
//
//  Created by Omar Guzmán on 2/24/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtPass, txtUser, progressHud, btnLogin, isEmailValid, isUserValid;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Acceso"];
    txtPass.delegate = self;
    [txtUser setDelegate:self];
    [btnLogin setEnabled:NO];
    //_progressHud
    //self.progressHud
    progressHud = [JGProgressHUD progressHUDWithStyle:(JGProgressHUDStyleDark)];
    [[progressHud textLabel] setText:@"Logging"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doLogin:(id)sender
{
    [progressHud showInView:[self view] animated:YES];
    NSMutableDictionary * dictData = [[NSMutableDictionary alloc] initWithDictionary:@{@"admin_user": @{@"email":txtUser.text, @"password":txtPass.text}}];
    [RESTManager sendData:dictData toService:@"login" withMethod:@"POST" isTesting:NO withAccessToken:nil toCallBack:^(id result) {
        //[progressHud dismissAnimated:YES];
        NSLog(@"login status: %@", result);
        if([[result objectForKey:@"success"] intValue] == 1)
        {
            NSLog(@"Login Success...");
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary * dictUserInfo = [[NSMutableDictionary alloc] init];
            [dictUserInfo setObject:@"1" forKey:@"isUserLogged"];
            [dictUserInfo setObject:[[result objectForKey:@"user"] objectForKey:@"name"] forKey:@"userName"];
            [dictUserInfo setObject:[[result objectForKey:@"user"] objectForKey:@"email"] forKey:@"email"];
            [dictUserInfo setObject:[[result objectForKey:@"user"] objectForKey:@"access_token"] forKey:@"access_token"];
            NSLog(@" w_w %@", dictUserInfo);
            [defaults setObject:dictUserInfo forKey:@"userInfo"];
            [defaults synchronize];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidLogin" object:nil];
        }
        else
        {
            NSLog(@"Login Error...");
        }
    }];
}

-(void)doValidateInputs:(id)sender
{
    if ([txtUser.text length] > 3)
        isUserValid = YES;
    else
        isUserValid = NO;
    if([txtPass.text length] > 3)
        isEmailValid = YES;
    else
        isEmailValid = NO;
    if(isEmailValid && isUserValid)
        [btnLogin setEnabled:YES];
    else
        [btnLogin setEnabled:NO];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 0)
    {
        if ([textField.text length] > 3)
            isUserValid = YES;
        else
            isUserValid = NO;
    }
    else if(textField.tag == 1)
    {
        if([textField.text length] > 3)
            isEmailValid = YES;
        else
            isEmailValid = NO;
    }
    if(isEmailValid && isUserValid)
        [btnLogin setEnabled:YES];
    else
        [btnLogin setEnabled:NO];
    return YES;
}


@end
