//
//  ViewController.m
//  Textfield and keyboard
//
//  Created by Natalia Estrella on 4/10/16.
//  Copyright © 2016 Natalia Estrella. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWillShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomConstraint.constant = keyboardFrame.size.height;
    [self animateKeyboardWithInfo:info];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    self.bottomConstraint.constant = 0;
    [self animateKeyboardWithInfo:[aNotification userInfo]];
}

- (void)animateKeyboardWithInfo:(NSDictionary*) info
{
    UIViewAnimationCurve animationCurve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | (animationCurve << 16)
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

@end
