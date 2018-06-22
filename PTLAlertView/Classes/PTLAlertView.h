//
//  PTLAlertView.h
//  PTLAlertView
//
//  Created by soliloquy on 2018/1/15.
//  Copyright © 2018年 soliloquy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelctBtnBlock)(NSInteger, NSString*_Nullable);

@interface PTLAlertView : UIView
NS_ASSUME_NONNULL_BEGIN
/** title背景颜色 */
@property (nonatomic, strong) UIColor *titleBackgroundColor;
/** title字体颜色 */
@property (nonatomic, strong) UIColor *titleTextColor;
/** title字体大小 */
@property (nonatomic, strong) UIFont *titleTextFont;
/** message字体颜色 */
@property (nonatomic, strong) UIColor *messageTextColor;
/** message字体大小 */
@property (nonatomic, strong) UIFont *messageTextFont;
/** cancel Button 字体颜色 */
@property (nonatomic, strong) UIColor *cancelBtnTextColor;
/** cancel Button 字体大小 */
@property (nonatomic, strong) UIFont *cancelBtnTextFont;
/** other Button 字体颜色 */
@property (nonatomic, strong) UIColor *otherBtnTextColor;
/** other Button 字体大小 */
@property (nonatomic, strong) UIFont *otherBtnTextFont;


NS_ASSUME_NONNULL_END

@property (nonatomic, copy) SelctBtnBlock _Nullable selctBtnBlock;
- (instancetype _Nullable )initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;
@end
