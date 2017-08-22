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
        
        [[XMPPManager sharedManager] connectWithJID:[user toXmppJid] password:self.pwdTextField.text completion:^(XMPPStream *xmppStream, NSError *error) {
            
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
