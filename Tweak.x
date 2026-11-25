#import <UIKit/UIKit.h>
#import "Avatar.h"

@interface CreditHandler : NSObject
+ (void)dismiss:(UIButton *)sender;
+ (void)openSnap:(UIButton *)sender;
@end

@implementation CreditHandler
+ (void)dismiss:(UIButton *)sender {
    UIView *overlay = sender.superview.superview;
    [UIView animateWithDuration:0.2 animations:^{
        overlay.alpha = 0;
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
    }];
}
+ (void)openSnap:(UIButton *)sender {
    [UIPasteboard generalPasteboard].string = @"ibrahim_zebar07";
    NSURL *url = [NSURL URLWithString:@"https://www.snapchat.com/add/ibrahim_zebar07"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
@end

static UILabel *makeLabel(NSString *text, CGFloat size, UIFontWeight weight, UIColor *color, CGRect frame) {
    UILabel *l = [[UILabel alloc] initWithFrame:frame];
    l.text = text;
    l.font = [UIFont systemFontOfSize:size weight:weight];
    l.textColor = color;
    l.textAlignment = NSTextAlignmentCenter;
    l.numberOfLines = 0;
    return l;
}

static UIButton *makeButton(NSString *title, UIColor *bg, UIColor *fg, CGRect frame) {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = frame;
    b.backgroundColor = bg;
    b.layer.cornerRadius = frame.size.height / 2;
    [b setTitle:title forState:UIControlStateNormal];
    [b setTitleColor:fg forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    return b;
}

static UIView *makeCircle(CGRect frame, UIColor *color, CGFloat alpha) {
    UIView *c = [[UIView alloc] initWithFrame:frame];
    c.backgroundColor = [color colorWithAlphaComponent:alpha];
    c.layer.cornerRadius = frame.size.width / 2;
    return c;
}

static void showCredit(UIWindow *host) {
    UIColor *accent = [UIColor colorWithRed:1.0 green:0.27 blue:0.27 alpha:1];
    UIColor *cardBg = [UIColor colorWithWhite:0.11 alpha:1];

    UIView *overlay = [[UIView alloc] initWithFrame:host.bounds];
    overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];

    CGFloat w = MIN(host.bounds.size.width - 48, 320);
    CGFloat h = 396;
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    card.center = CGPointMake(host.bounds.size.width / 2, host.bounds.size.height / 2);
    card.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    card.backgroundColor = cardBg;
    card.layer.cornerRadius = 28;
    card.clipsToBounds = YES;
    [overlay addSubview:card];

    [card addSubview:makeCircle(CGRectMake(w - 120, 150, 170, 170), accent, 0.14)];
    [card addSubview:makeCircle(CGRectMake(-55, 190, 150, 150), accent, 0.10)];
    [card addSubview:makeCircle(CGRectMake(30, 200, 56, 56), accent, 0.16)];
    [card addSubview:makeCircle(CGRectMake(w - 68, 250, 28, 28), accent, 0.20)];

    UIView *band = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 90)];
    band.backgroundColor = accent;
    [card addSubview:band];

    UIView *avatar = [[UIView alloc] initWithFrame:CGRectMake((w - 82) / 2, 49, 82, 82)];
    avatar.backgroundColor = [UIColor colorWithWhite:0.17 alpha:1];
    avatar.layer.cornerRadius = 41;
    avatar.layer.borderWidth = 5;
    avatar.layer.borderColor = cardBg.CGColor;
    avatar.clipsToBounds = YES;
    [card addSubview:avatar];

    NSData *imgData = [[NSData alloc] initWithBase64EncodedString:kAvatarB64 options:0];
    UIImage *img = imgData ? [UIImage imageWithData:imgData] : nil;
    if (img) {
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 82, 82)];
        photo.image = img;
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;
        [avatar addSubview:photo];
    } else {
        [avatar addSubview:makeLabel(@"IZ", 24, UIFontWeightSemibold, accent, CGRectMake(0, 0, 82, 82))];
    }

    CGFloat pad = 20;
    CGFloat iw = w - pad * 2;

    [card addSubview:makeLabel(@"هاتییە دروستکرن ژلایێ", 14, UIFontWeightRegular,
        [UIColor colorWithWhite:0.6 alpha:1], CGRectMake(pad, 138, iw, 20))];

    [card addSubview:makeLabel(@"Ibrahim Zebare", 24, UIFontWeightSemibold,
        [UIColor whiteColor], CGRectMake(pad, 160, iw, 32))];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((w - 40) / 2, 204, 40, 3)];
    line.backgroundColor = accent;
    line.layer.cornerRadius = 1.5;
    [card addSubview:line];

    [card addSubview:makeLabel(@"ژ بۆ پتر پێزانینان، ل سناپچاتێ نامەیەکێ فرێکە", 15, UIFontWeightRegular,
        [UIColor colorWithWhite:0.85 alpha:1], CGRectMake(pad, 216, iw, 44))];

    UIButton *snap = makeButton(@"👻  @ibrahim_zebar07",
        [UIColor colorWithRed:1.0 green:0.99 blue:0.0 alpha:1],
        [UIColor blackColor], CGRectMake(pad, 270, iw, 46));
    [snap addTarget:[CreditHandler class] action:@selector(openSnap:) forControlEvents:UIControlEventTouchUpInside];
    [card addSubview:snap];

    UIButton *ok = makeButton(@"OK", accent, [UIColor whiteColor], CGRectMake(pad, 326, iw, 50));
    [ok addTarget:[CreditHandler class] action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [card addSubview:ok];

    overlay.alpha = 0;
    card.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [host addSubview:overlay];
    [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium] impactOccurred];
    [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8
        options:0 animations:^{
        overlay.alpha = 1;
        card.transform = CGAffineTransformIdentity;
    } completion:nil];
}

static void tryShow(void) {
    static BOOL shown = NO;
    if (shown) return;

    UIWindow *win = nil;
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if ([scene isKindOfClass:[UIWindowScene class]]) {
            UIWindowScene *ws = (UIWindowScene *)scene;
            for (UIWindow *w in ws.windows) {
                if (w.isKeyWindow) { win = w; break; }
            }
            if (!win) win = ws.windows.firstObject;
            if (win) break;
        }
    }
    if (!win) return;

    shown = YES;
    showCredit(win);
}

__attribute__((constructor)) static void credit_init(void) {
    [[NSNotificationCenter defaultCenter]
        addObserverForName:UIApplicationDidBecomeActiveNotification
        object:nil
        queue:[NSOperationQueue mainQueue]
        usingBlock:^(NSNotification *note) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)),
                dispatch_get_main_queue(), ^{
                tryShow();
            });
        }];
}
