//
//  IMLoginViewController.m
//  xmpp_im
//
//  Created by winter on 2017/8/22.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "IMLoginViewController.h"
#import "XMPPManager.h"
#import "IMUser.h"
#import "NearbyViewController.h"
#import "AppDelegate.h"

@interface IMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation IMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (IBAction)login:(UIButton *)sender
{
    if (_accountTextField.text.length && _pwdTextField.text.length)
    {
        IMUser *user = [IMUser imUserWithUserId:_accountTextField.text name:nil logo:@"/user/logo.jpg"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"正在登录...";
        [[XMPPManager sharedManager] connectWithJID:[user toXmppJid] password:self.pwdTextField.text completion:^(XMPPStream *xmppStream, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
            if (!error)
            {
                // 跳转页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    NearbyViewController *nearby = [[NearbyViewController alloc] init];
                    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:nearby];
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    delegate.window.rootViewController = navi;
                });
            }
            
            errorAlert(error);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
