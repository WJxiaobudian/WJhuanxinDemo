//
//  SendMessageView.h
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonClicked)(NSString *sendMessage);
@interface SendMessageView : UIView

@property (nonatomic, copy) buttonClicked buttonClicked;

@end
