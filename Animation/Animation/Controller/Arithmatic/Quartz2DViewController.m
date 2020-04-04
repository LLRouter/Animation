//
//  Quartz2DViewController.m
//  Animation
//
//  Created by dfw on 2018/4/13.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "Quartz2DViewController.h"
#import "Quartz2dView.h"
#import "YJBannerView.h"

@interface Quartz2DViewController ()<NSXMLParserDelegate>
{
    __weak id reference;
}

@end

@implementation Quartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = UIColor.whiteColor;
    
    NSString *str = [NSString stringWithFormat:@"sunnyxx"];    // str是一个autorelease对象，设置一个weak的引用来观察它
         reference = str;
    
    //SAX 解析
    NSXMLParser * parser = [[NSXMLParser alloc] init];
    parser.delegate = self;
    [parser parse];
    
    //GDataXml 是DOM解析
    
    Quartz2dView *quartz = [[Quartz2dView alloc] init];
    quartz.frame = self.view.frame;
    [self.view addSubview:quartz];
}
//1.开始解析XML文档
-(void)parserDidStartDocument:(nonnull NSXMLParser *)parser
{
}
//2.开始解析XML中某个元素的时候调用，比如<video>
-(void)parser:(nonnull NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict
{
    //可在此方法中做字典转模型操作，参数attributeDict存放着元素的属性
}
//3.当某个元素解析完成之后调用，比如</video>
-(void)parser:(nonnull NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
}
//4.XML文档解析结束
-(void)parserDidEndDocument:(nonnull NSXMLParser *)parser
{
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"333---%@", reference);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"111---%@", reference); // Console: sunnyxx
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"22----%@", reference); // Console: (null)
    
}
-(void)dealloc
{
    NSLog(@"44----%@", reference);
}


@end
