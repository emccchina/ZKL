//
//  Utities.m
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import "Utities.h"
#import <CommonCrypto/CommonDigest.h>
#import "JGProgressHUD.h"
#import "AppDelegate.h"


@implementation Utities

+ (UIImage*)backImage:(BOOL)direction
{
    CGFloat width = 40;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:235.0/255.0 green:247.0/255.0 blue:239.0/255.0 alpha:1.0];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 4);
    CGFloat radius = direction ? -5 : 5;
    CGContextMoveToPoint(context, width/2+radius, width/2- 3*radius);
    CGContextAddLineToPoint(context, width/2-radius*3/2, width/2);
    CGContextAddLineToPoint(context, width/2+radius, width/2+3*radius);
//    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage*)homeAddImage
{
    CGFloat width = 40;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:235.0/255.0 green:247.0/255.0 blue:239.0/255.0 alpha:1.0];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 4);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:251.0/255.0 green:153.0/255.0 blue:39.0/255.0 alpha:1.0].CGColor);
    CGContextAddArc(context, width/2, width/2, width/2, 0, 2*M_PI, 1);
    CGContextDrawPath(context, kCGPathFill);
    CGFloat radius = 5;
    CGContextSetLineWidth(context, 4);
    CGContextMoveToPoint(context, radius, width/2);
    CGContextAddLineToPoint(context, width-radius, width/2);
    
    CGContextMoveToPoint(context, width/2, radius);
    CGContextAddLineToPoint(context, width/2, width - radius);
    //    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (CGSize)sizeWithUIFont:(UIFont*)font string:(NSString*)string
{
    if (string == nil) {
        return CGSizeZero;
    }
    
    return [string sizeWithAttributes:@{NSFontAttributeName: font}];
    
}

+ (CGSize)sizeWithUIFont:(UIFont*)font string:(NSString*)string rect:(CGSize)size
{
    if (string == nil) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
}

+ (CGSize)sizeWithUIFont:(UIFont*)font string:(NSString*)string rect:(CGSize)size space:(CGFloat)space
{
    if (string == nil) {
        return CGSizeZero;
    }
    //设置行间距
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    //        style.minimumLineHeight = 30.f;
    //        style.maximumLineHeight = 30.f;
    //        NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style};
    [style setLineSpacing:space];
    
    return [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil].size;
    
}

+ (UIBarButtonItem*)barButtonItemWithSomething:(id)some target:(id)target action:(SEL)sel
{
    UIBarButtonItem *item = nil;
//    if ([some isKindOfClass:[UIImage class]]) {
        UIButton *view  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [view setBackgroundImage:(UIImage*)some forState:UIControlStateNormal];
        [view addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:view];
//    }else{
//        item = [[UIBarButtonItem alloc] initWithTitle:(NSString *)some style:UIBarButtonItemStyleDone target:target action:sel];
//        item.tintColor = [UIColor whiteColor];
//    }
    return item;
}

+ (CATransition *)getAnimation:(NSInteger)mytag{
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    switch (mytag) {
        case 1:
            animation.type = kCATransitionFade;
            break;
        case 2:
            animation.type = kCATransitionPush;
            break;
        case 3:
            animation.type = kCATransitionReveal;
            break;
        case 4:
            animation.type = kCATransitionMoveIn;
            break;
        case 5:
            animation.type = @"cube";
            break;
        case 6:
            animation.type = @"suckEffect";
            break;
        case 7:
            animation.type = @"oglFlip";
            break;
        case 8:
            animation.type = @"rippleEffect";
            break;
        case 9:
            animation.type = @"pageCurl";
            break;
        case 10:
            animation.type = @"pageUnCurl";
            break;
        case 11:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case 12:
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    
    
    int i = (int)rand()%4;
    switch (i) {
            
        case 0:
            animation.subtype = kCATransitionFromLeft;
            break;
        case 1:
            animation.subtype = kCATransitionFromBottom;
            break;
        case 2:
            animation.subtype = kCATransitionFromRight;
            break;
        case 3:
            animation.subtype = kCATransitionFromTop;
            break;
        default:
            break;
    }
    return animation;
}


+ (NSString*)filePathName:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//需要的路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *temDirectory = [documentsDirectory stringByAppendingPathComponent:@"r/"];
    BOOL isDict = YES;
    if (![fileManager fileExistsAtPath:temDirectory isDirectory:&isDict]) {
        [fileManager createDirectoryAtPath:temDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (void)setUserDefaults:(id)object key:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)getUserDefaults:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key] ? : @"";
}

+ (NSString*)md5AndBase:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSData* data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    NSString *hash = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return hash;
    
}

+ (void)errorPrint:(NSError*)error vc:(UIViewController*)vc
{
#ifdef DEBUG
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSLog(@"%@,%@,%@",[vc class],error, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
    
}
+ (void)showMessageOnWindow:(NSString*)message
{
    JGProgressHUD *bottomHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleExtraLight];
    bottomHUD.useProgressIndicatorView = NO;
    bottomHUD.userInteractionEnabled = NO;
    bottomHUD.textLabel.text = message;
    bottomHUD.position = JGProgressHUDPositionBottomCenter;
    bottomHUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = 200.0f,
        .left = 0.0f,
        .right = 0.0f,
    };
    
    [bottomHUD showInView:[[UIApplication sharedApplication].delegate window]];
    
    [bottomHUD dismissAfterDelay:1.0f];
}

+ (UIView*)viewAddContraintsParentView:(UIView*)parentView subNibName:(NSString*)subNibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:subNibName owner:parentView options:nil];
    UIView *subView = nib[0];
    CGFloat space = 0;
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addSubview:subView];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1 constant:space]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1 constant:space]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:parentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:subView attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:parentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:subView attribute:NSLayoutAttributeRight multiplier:1 constant:space]];
    return subView;
}

+ (void)presentLoginVC:(UIViewController*)parentVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublicStoryboard" bundle:nil];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [parentVC.navigationController.view.layer addAnimation:[Utities getAnimation:5] forKey:nil];
    [parentVC.navigationController pushViewController:vc animated:YES];
}

@end
