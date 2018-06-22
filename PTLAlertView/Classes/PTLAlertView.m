//
//  PTLAlertView.m
//  PTLAlertView
//
//  Created by soliloquy on 2018/1/15.
//  Copyright © 2018年 soliloquy. All rights reserved.
//

#import "PTLAlertView.h"

#define kScreenBounds ([UIScreen mainScreen].bounds)
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)
#define rgb(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1])
/// 按钮高度
#define BUTTON_HEIGHT 40
/// 标题高度
#define TITLE_HEIGHT 40


@interface PTLAlertView()

/** title */
@property (nonatomic, copy) NSString *title;
/** message */
@property (nonatomic, copy) NSString *message;
/** 取消 */
@property (nonatomic, copy) NSString *cancelButtonTitle;
/** 其他按钮标题 */
@property (nonatomic, strong) NSMutableArray *otherButtonTitleArray;
/** 所有按钮Title */
@property (nonatomic, strong) NSMutableArray *allButtonTitlesArr;
/** 遮罩View */
@property (nonatomic, strong) UIView *shadeView;
/** 标题 Label */
@property (nonatomic, strong) UILabel *titleLabel;
/** message Label */
@property (nonatomic, strong) UILabel *messageLabel;
/** 所有按钮 */
@property (nonatomic, strong) NSMutableArray *allButtons;
/** otherView */
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation PTLAlertView

#pragma mark - init
- (instancetype _Nullable )initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.title = [title copy] ?: @"提示";
        self.message = [message copy] ?: @"";
        self.cancelButtonTitle = [cancelButtonTitle copy] ?: @"取消";
        
        if (otherButtonTitles)
        {
            va_list args;
            va_start(args, otherButtonTitles);
            [self.otherButtonTitleArray addObject:otherButtonTitles];
            NSString *otherString;
            while ((otherString = va_arg(args, NSString *)))
            {
                //依次取得所有参数
                [self.otherButtonTitleArray addObject:otherString];
            }
            va_end(args);
        }
        
        [self.allButtonTitlesArr addObjectsFromArray:self.otherButtonTitleArray];
        [self.allButtonTitlesArr addObject:self.cancelButtonTitle];

        
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI {
    
    self.backgroundColor = [UIColor yellowColor];
    [self.shadeView addSubview:self];
    [self addSubview:self.bgView];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    
    
    [self.bgView addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.messageLabel];
    
    
    [self.bgView addSubview:self.bottomView];
    [self.bottomView addSubview:self.stackView];
    
    
    for (NSInteger i = 0; i < self.allButtonTitlesArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [btn setTitleColor:rgb(38, 204, 206) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.allButtonTitlesArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [self.allButtons addObject:btn];
        [self.stackView addArrangedSubview:btn];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = kScreenWidth * 0.8;
    CGFloat x = (kScreenWidth-w)/2;
    
    CGFloat topH = 0;
    CGFloat titleH = TITLE_HEIGHT;
    CGFloat marge1 = 20;
    self.titleLabel.frame = CGRectMake(0, 0, w, titleH);
    
    CGFloat msgX = 10;
    CGFloat msgW = w - 2 * msgX;
    
    CGFloat msgH = [self sizeWithFont:_messageTextFont ?: [UIFont systemFontOfSize:15] maxSize:CGSizeMake(msgW, MAXFLOAT) string:self.message].height;
    
    if (msgH > 400) {
        msgH = 400;
    }
    
    self.messageLabel.frame = CGRectMake(msgX, CGRectGetMaxY(self.titleLabel.frame)+marge1, msgW, msgH);
    
    topH = titleH + msgH + marge1;

    self.topView.frame = CGRectMake(0, 0, w, topH);
    
    CGFloat bottomH = 0;
    CGFloat marge2 = 20;
    
    for(NSInteger i = 0; i < self.allButtonTitlesArr.count; i++) {
        
        if (self.allButtonTitlesArr.count > 2) { // 纵向排
            bottomH = BUTTON_HEIGHT * self.allButtonTitlesArr.count;
        }else {
            bottomH = BUTTON_HEIGHT;
            self.stackView.axis = UILayoutConstraintAxisHorizontal;
        }
        CGFloat bottomY = CGRectGetMaxY(self.topView.frame)+marge2;
        self.bottomView.frame = CGRectMake(0, bottomY, w, bottomH);
        self.stackView.frame = self.bottomView.bounds;
    }
    
    CGFloat y1 = (kScreenHeight-(bottomH+topH))/2;
    CGFloat yH = bottomH+topH+marge2;
    self.frame = CGRectMake(x, y1, w, yH);
    self.bgView.frame = self.bounds;
}


- (void)show {
    
    self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    [UIView animateWithDuration:0.25 animations:^{
        [self dissmiss];
        self.transform = CGAffineTransformIdentity;
        [[UIApplication sharedApplication].keyWindow addSubview:self.shadeView];
    } completion:^(BOOL finished) {
    }];
}

- (void)dissmiss {
    NSEnumerator *subviewsEnum = [[UIApplication sharedApplication].keyWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if (subview.tag == 1000) {
            [subview removeFromSuperview];
        }
    }
}


- (void)selectButtonClick:(UIButton *)btn {
    
    NSInteger cancelBtnIndex = ((UIButton *)self.allButtons[btn.tag]).tag;
    if (cancelBtnIndex == self.allButtons.count-1) {
        [self dissmiss];
        return;
    }
    
    if (self.selctBtnBlock) {
        self.selctBtnBlock(btn.tag, btn.currentTitle);
        self.selctBtnBlock = nil;
        [self dissmiss];
    }
}

#pragma mark - private faction
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}


#pragma mark - getter/setter
-(void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor {
    if (!titleBackgroundColor) return;
    _titleBackgroundColor = titleBackgroundColor;
    self.titleLabel.backgroundColor = titleBackgroundColor;
    
}

-(void)setTitleTextColor:(UIColor *)titleTextColor {
    if (!titleTextColor) return;
    _titleTextColor = titleTextColor;
    self.titleLabel.textColor = titleTextColor;
}

-(void)setTitleTextFont:(UIFont *)titleTextFont {
    if (!titleTextFont) return;
    _titleTextFont = titleTextFont;
    self.titleLabel.font = titleTextFont;
}

-(void)setMessageTextColor:(UIColor *)messageTextColor {
    if (!messageTextColor) return;
    _messageTextColor = messageTextColor;
    self.messageLabel.textColor = messageTextColor;
}

-(void)setMessageTextFont:(UIFont *)messageTextFont {
    if (!messageTextFont) return;
    _messageTextFont = messageTextFont;
    self.messageLabel.font = messageTextFont;
}

-(void)setCancelBtnTextColor:(UIColor *)cancelBtnTextColor {
    if (!cancelBtnTextColor) return;
    _cancelBtnTextColor = cancelBtnTextColor;
    
    UIButton *cancelBtn = self.allButtons.lastObject;
    if (cancelBtn != nil) {
        [cancelBtn setTitleColor:cancelBtnTextColor forState:UIControlStateNormal];
    }
}

-(void)setCancelBtnTextFont:(UIFont *)cancelBtnTextFont {
    if (!cancelBtnTextFont) return;
    _cancelBtnTextFont = cancelBtnTextFont;
    
    UIButton *cancelBtn = self.allButtons.lastObject;
    if (cancelBtn != nil) {
        cancelBtn.titleLabel.font = cancelBtnTextFont;
    }
}

-(void)setOtherBtnTextColor:(UIColor *)otherBtnTextColor {
    if (!otherBtnTextColor) return;
    _otherBtnTextColor = otherBtnTextColor;
    
    // 最后一个是cancel button 故不设置
    for (NSInteger i = 0; i < self.allButtons.count-1; i ++) {
        UIButton *otherBtn = self.allButtons[i];
        if (otherBtn != nil) {
            [otherBtn setTitleColor:otherBtnTextColor forState:UIControlStateNormal];
        }
    }
}

-(void)setOtherBtnTextFont:(UIFont *)otherBtnTextFont {
    if (!otherBtnTextFont) return;
    _otherBtnTextFont = otherBtnTextFont;
    
    for (NSInteger i = 0; i < self.allButtons.count-1; i ++) {
        UIButton *otherBtn = self.allButtons[i];
        if (otherBtn != nil) {
            otherBtn.titleLabel.font = otherBtnTextFont;
        }
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc]init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 1;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}


-(NSMutableArray *)allButtons {
    
    if (!_allButtons) {
        _allButtons = [[NSMutableArray alloc]init];
    }
    return _allButtons;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = rgb(38, 204, 206);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = self.message;
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = _messageTextFont ?: [UIFont systemFontOfSize:15];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.backgroundColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

-(UIView *)shadeView {
    if (!_shadeView) {
        _shadeView = [[UIView alloc]initWithFrame:kScreenBounds];
        _shadeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        _shadeView.tag = 1000;
    }
    return _shadeView;
}

-(NSMutableArray *)allButtonTitlesArr {
    if (!_allButtonTitlesArr) {
        _allButtonTitlesArr = [[NSMutableArray alloc]init];
    }
    return _allButtonTitlesArr;
}

-(NSMutableArray *)otherButtonTitleArray {
    if (!_otherButtonTitleArray) {
        _otherButtonTitleArray = [[NSMutableArray alloc]init];
    }
    return _otherButtonTitleArray;
}


@end
