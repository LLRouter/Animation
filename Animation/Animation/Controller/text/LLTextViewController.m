//
//  LLTextViewController.m
//  Animation
//
//  Created by dfw on 2017/11/14.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "LLTextViewController.h"
#import "HighLightTextStorage.h"
#import "LLTextContainer.h"

@interface LLTextViewController () <UITextViewDelegate,NSLayoutManagerDelegate>
{
    CAGradientLayer *_gradientlayer;
    CADisplayLink *_link;
}

@property (nonatomic, strong) UITextView *originalTextView;
@property (nonatomic, strong) UIView *otherContainerView;
@property (nonatomic, strong) UITextView *otherTextView;
@property (nonatomic) HighLightTextStorage *textStorage;

@end

@implementation LLTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _otherContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    _otherContainerView.backgroundColor = UIColor.lightGrayColor;
    _otherTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 220, 300, 100)];
    [self.view addSubview:_otherTextView];
    [self.view addSubview:_otherContainerView];
//    [self textKitLearn];
    [self createMarkupTextView];
    [_otherContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.2);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"带我去多群当前http://www.baidu.com带我去多群当前http://www.baidu.com手动的撒多大萨达萨达大叔大萨达多我气得萨达阿萨德http://www.goole.com撒旦去的寝室的群多渠道强打书到南京去哪玩你欠我的交警都跑区奇偶碰到就破去我家都件券哦碰";
    label.numberOfLines = 0;
    [label  sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_otherContainerView).offset(40);
        make.bottom.right.equalTo(self.view).offset(-20);
    }];
    
    _gradientlayer = [CAGradientLayer layer];
    _gradientlayer.colors = @[(__bridge id)[self randomColor].CGColor,(__bridge id)[self randomColor].CGColor];
    _gradientlayer.frame = label.frame;
    _gradientlayer.startPoint = CGPointMake(0, 0);
    _gradientlayer.endPoint   = CGPointMake(1, 1);
    [self.view.layer addSublayer:_gradientlayer];
    _gradientlayer.mask = label.layer;
    label.frame = _gradientlayer.bounds;
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    _link.frameInterval = 5;
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  //  [self runloopTest];
    
}
- (void)runloopTest
{
    dispatch_queue_t queue = dispatch_queue_create("testRunLoop", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%@",[self randomColor]);
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)createMarkupTextView
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSString *content = @"带我去多群当前http://www.baidu.com手动的撒多大萨达萨达大叔大萨达多我气得萨达阿萨德http://www.goole.com撒旦去的寝室的群多渠道强打书到南京去哪玩你欠我的交警都跑区奇偶碰到就破去我家都件券哦碰到就哦脾气接大排畸跑到我就迫切借我碰到就去我去外婆家泡温泉欧健我的今晚去欧派就";

    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content
                                                                           attributes:attributes];
    _textStorage = [[HighLightTextStorage alloc] init];
    [_textStorage setAttributedString:attributedString];
    
    CGRect textViewRect = CGRectMake(20, 60, 280, self.view.bounds.size.height - 100);
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.delegate = self;
    
    LLTextContainer *textContainer = [[LLTextContainer alloc] initWithSize:CGSizeMake(textViewRect.size.width, CGFLOAT_MAX)];
    [layoutManager addTextContainer:textContainer];
    [_textStorage addLayoutManager:layoutManager];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:textViewRect
                                    textContainer:textContainer];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    
}
- (void)textKitLearn
{
    NSString *kstring = @"将多个 Text Container 附加到同一个 Layout Manager 上，这样可以将一个文本分布到多个视图展现出来。下面的例子将展示这两个特性";
    NSTextStorage *sharedTextStorage = [UITextView new].textStorage;
    [sharedTextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:kstring];
    
    
    // 将一个新的 Layout Manager 附加到上面的 Text Storage 上
    NSLayoutManager *otherLayoutManager = [NSLayoutManager new];
    [sharedTextStorage addLayoutManager: otherLayoutManager];
    
    NSTextContainer *otherTextContainer = [NSTextContainer new];
    [otherLayoutManager addTextContainer: otherTextContainer];
    
    UITextView *otherTextView = [[UITextView alloc] initWithFrame:self.otherContainerView.bounds textContainer:otherTextContainer];
    otherTextView.backgroundColor = self.otherContainerView.backgroundColor;
    otherTextView.translatesAutoresizingMaskIntoConstraints = YES;
    otherTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    otherTextView.scrollEnabled = NO;
    
    [self.otherContainerView addSubview: otherTextView];
    self.otherTextView = otherTextView;
}
- (void)textColorChange
{
    _gradientlayer.colors  = @[(__bridge id)[self randomColor].CGColor,
                               (__bridge id)[self randomColor].CGColor,
                               (__bridge id)[self randomColor].CGColor,
                               (__bridge id)[self randomColor].CGColor,
                               (__bridge id)[self randomColor].CGColor];
}
- (UIColor *)randomColor
{
    CGFloat r  = arc4random_uniform(256) / 255.0;
    CGFloat g  = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
#pragma mark -- LayoutMnanger delegate
- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName
                                                  atIndex:charIndex
                                           effectiveRange:&range];
    
    return !(linkURL && charIndex > range.location && charIndex <= NSMaxRange(range));
}
- (void) labelMade
{
    //初始化NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    
    //设置字体格式和大小
    NSString *str0 = @"设置字体格式和大小";
    NSDictionary *dictAttr0 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSAttributedString *attr0 = [[NSAttributedString alloc]initWithString:str0 attributes:dictAttr0];
    [attributedString appendAttributedString:attr0];
    
    //设置字体颜色
    NSString *str1 = @"\n设置字体颜色\n";
    NSDictionary *dictAttr1 = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:dictAttr1];
    [attributedString appendAttributedString:attr1];
    
    //设置字体背景颜色
    NSString *str2 = @"设置字体背景颜色\n";
    NSDictionary *dictAttr2 = @{NSBackgroundColorAttributeName:[UIColor cyanColor]};
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:str2 attributes:dictAttr2];
    [attributedString appendAttributedString:attr2];
    
    /*
     注：NSLigatureAttributeName设置连体属性，取值为NSNumber对象（整数），1表示使用默认的连体字符，0表示不使用，2表示使用所有连体符号（iOS不支持2）。而且并非所有的字符之间都有组合符合。如 fly ，f和l会连起来。
     */
    //设置连体属性
    NSString *str3 = @"fly";
    NSDictionary *dictAttr3 = @{NSFontAttributeName:[UIFont fontWithName:@"futura" size:14],NSLigatureAttributeName:[NSNumber numberWithInteger:1]};
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:str3 attributes:dictAttr3];
    [attributedString appendAttributedString:attr3];
    
    /*!
     注：NSKernAttributeName用来设置字符之间的间距，取值为NSNumber对象（整数），负值间距变窄，正值间距变宽
     */
    
    NSString *str4 = @"\n设置字符间距";
    NSDictionary *dictAttr4 = @{NSKernAttributeName:@(4)};
    NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:str4 attributes:dictAttr4];
    [attributedString appendAttributedString:attr4];
    
    /*!
     注：NSStrikethroughStyleAttributeName设置删除线，取值为NSNumber对象，枚举NSUnderlineStyle中的值。NSStrikethroughColorAttributeName设置删除线的颜色。并可以将Style和Pattern相互 取与 获取不同的效果
     */
    
    NSString *str51 = @"\n设置删除线为细单实线,颜色为红色";
    NSDictionary *dictAttr51 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr51 = [[NSAttributedString alloc]initWithString:str51 attributes:dictAttr51];
    [attributedString appendAttributedString:attr51];
    
    
    NSString *str52 = @"\n设置删除线为粗单实线,颜色为红色";
    NSDictionary *dictAttr52 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr52 = [[NSAttributedString alloc]initWithString:str52 attributes:dictAttr52];
    [attributedString appendAttributedString:attr52];
    
    NSString *str53 = @"\n设置删除线为细单实线,颜色为红色";
    NSDictionary *dictAttr53 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr53 = [[NSAttributedString alloc]initWithString:str53 attributes:dictAttr53];
    [attributedString appendAttributedString:attr53];
    
    
    NSString *str54 = @"\n设置删除线为细单虚线,颜色为红色\n";
    NSDictionary *dictAttr54 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternDot),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr54 = [[NSAttributedString alloc]initWithString:str54 attributes:dictAttr54];
    [attributedString appendAttributedString:attr54];
    
    /*!
     NSStrokeWidthAttributeName 设置笔画的宽度，取值为NSNumber对象（整数），负值填充效果，正值是中空效果。NSStrokeColorAttributeName  设置填充部分颜色，取值为UIColor对象。
     设置中间部分颜色可以使用 NSForegroundColorAttributeName 属性来进行
     */
    //设置笔画宽度和填充部分颜色
    NSString *str6 = @"设置笔画宽度和填充颜色\n";
    NSDictionary *dictAttr6 = @{NSStrokeWidthAttributeName:@(-4),NSStrokeColorAttributeName:[UIColor greenColor]};
    NSAttributedString *attr6 = [[NSAttributedString alloc]initWithString:str6 attributes:dictAttr6];
    [attributedString appendAttributedString:attr6];
    
    //设置阴影属性，取值为NSShadow对象
    NSString *str7 = @"设置阴影属性\n";
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowBlurRadius = 1.0f;
    shadow.shadowOffset = CGSizeMake(1, 1);
    NSDictionary *dictAttr7 = @{NSShadowAttributeName:shadow};
    NSAttributedString *attr7 = [[NSAttributedString alloc]initWithString:str7 attributes:dictAttr7];
    [attributedString appendAttributedString:attr7];
    
    //设置文本特殊效果，取值为NSString类型，目前只有一个可用效果  NSTextEffectLetterpressStyle（凸版印刷效果）
    NSString *str8 = @"设置特殊效果\n";
    NSDictionary *dictAttr8 = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    NSAttributedString *attr8 = [[NSAttributedString alloc]initWithString:str8 attributes:dictAttr8];
    [attributedString appendAttributedString:attr8];
    
    //设置文本附件，取值为NSTextAttachment对象，常用于文字的图文混排
    NSString *str9 = @"文字的图文混排";
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = [UIImage imageNamed:@"pic1.jpg"];
    textAttachment.bounds = CGRectMake(0, 0, 40, 20);
//    NSDictionary *dictAttr9 = @{NSAttachmentAttributeName:textAttachment};
    NSMutableAttributedString *attr9 = [[NSMutableAttributedString alloc]initWithString:str9];
    [attr9 appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    [attributedString appendAttributedString:attr9];
    
    /*!
     添加下划线 NSUnderlineStyleAttributeName。设置下划线的颜色 NSUnderlineColorAttributeName，对象为 UIColor。使用方式同删除线一样。
     */
    //添加下划线
    NSString *str10 = @"\n添加下划线\n";
    NSDictionary *dictAttr10 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr10 = [[NSAttributedString alloc]initWithString:str10 attributes:dictAttr10];
    [attributedString appendAttributedString:attr10];

    /*!
     NSBaselineOffsetAttributeName 设置基线偏移值。取值为NSNumber （float），正值上偏，负值下偏
     */
    //设置基线偏移值 NSBaselineOffsetAttributeName
    NSString *str11 = @"添加基线偏移值\n";
    NSDictionary *dictAttr11 = @{NSBaselineOffsetAttributeName:@(-10)};
    NSAttributedString *attr11 = [[NSAttributedString alloc]initWithString:str11 attributes:dictAttr11];
    [attributedString appendAttributedString:attr11];
    
    /*!
     NSObliquenessAttributeName 设置字体倾斜度，取值为 NSNumber（float），正值右倾，负值左倾
     */
    //设置字体倾斜度 NSObliquenessAttributeName
    NSString *str12 = @"设置字体倾斜度\n";
    NSDictionary *dictAttr12 = @{NSObliquenessAttributeName:@(0.5)};
    NSAttributedString *attr12 = [[NSAttributedString alloc]initWithString:str12 attributes:dictAttr12];
    [attributedString appendAttributedString:attr12];
    
    /*!
     NSExpansionAttributeName 设置字体的横向拉伸，取值为NSNumber （float），正值拉伸 ，负值压缩
     */
    //设置字体的横向拉伸 NSExpansionAttributeName
    NSString *str13 = @"设置字体横向拉伸\n";
    NSDictionary *dictAttr13 = @{NSExpansionAttributeName:@(0.5)};
    NSAttributedString *attr13 = [[NSAttributedString alloc]initWithString:str13 attributes:dictAttr13];
    [attributedString appendAttributedString:attr13];
    
    /*!
     NSWritingDirectionAttributeName 设置文字的书写方向，取值为以下组合
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionOverride)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)]
     
     ???NSWritingDirectionEmbedding和NSWritingDirectionOverride有什么不同
     */
    //设置文字的书写方向 NSWritingDirectionAttributeName
    NSString *str14 = @"设置文字书写方向\n";
    NSDictionary *dictAttr14 = @{NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]};
    NSAttributedString *attr14 = [[NSAttributedString alloc]initWithString:str14 attributes:dictAttr14];
    [attributedString appendAttributedString:attr14];
    
    /*!
     NSVerticalGlyphFormAttributeName 设置文字排版方向，取值为NSNumber对象（整数），0表示横排文本，1表示竖排文本  在iOS中只支持0
     */
    //设置文字排版方向 NSVerticalGlyphFormAttributeName
    NSString *str15 = @"设置文字排版方向\n";
    NSDictionary *dictAttr15 = @{NSVerticalGlyphFormAttributeName:@(0)};
    NSAttributedString *attr15 = [[NSAttributedString alloc]initWithString:str15 attributes:dictAttr15];
    [attributedString appendAttributedString:attr15];
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    //行间距
    paragraph.lineSpacing = 10;
    //段落间距
    paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
    paragraph.headIndent = 10;
    
    //添加段落设置
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attributedString.length)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    scrollView.backgroundColor = [UIColor blackColor];
    [scrollView setContentSize:CGSizeMake(MAIN_WIDTH, 2000)];
    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, 300, 0)];
    label.backgroundColor = [UIColor lightGrayColor];
    //自动换行
    label.numberOfLines = 0;
    //设置label的富文本
    label.attributedText = attributedString;
    //label高度自适应
    [label sizeToFit];
    [scrollView addSubview:label];
    
}

@end
