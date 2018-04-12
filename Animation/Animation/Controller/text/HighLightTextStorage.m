//
//  HighLightTextStorage.m
//  Animation
//
//  Created by dfw on 2017/11/14.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "HighLightTextStorage.h"

@interface HighLightTextStorage()
{
    NSMutableAttributedString *_backingStore;
}

@end

@implementation HighLightTextStorage
- (instancetype)init
{
    self = [super init];
    if (self) {
        _backingStore = [[NSMutableAttributedString alloc] init];
    }
    return self;
}
- (void)processEditing
{
    //正则表达
    static NSRegularExpression *iExpression;
    iExpression = iExpression ?: [NSRegularExpression regularExpressionWithPattern:@"((http|ftp|https)://)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?" options:0 error:NULL];
    
    // [a-zA-z]+://[^\s]*
    // 首先清除之前的所有高亮
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    // 其次遍历所有的样式匹配项并高亮它们
    [iExpression enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        // Add red highlight color
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
    }];
    
    /*
     请注意仅仅使用 edited range 是不够的。例如，当手动键入 iWords，只有一个单词的第三个字符被键入后，正则表达式才开始匹配。但那时 editedRange 仅包含第三个字符，因此所有的处理只会影响这一个字符。通过重新处理整个段落可以解决这个问题，这样既完成高亮功能，又不会太过影响性能
     
     */
    [super processEditing];
}

- (NSString *)string
{
    return [_backingStore string];
}
- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location
                             effectiveRange:range];
}
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    NSLog(@"replaceCharactersInRange:%@ withString:%@",NSStringFromRange(range), str);
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    [self endEditing];
    
}
- (void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range
{
    NSLog(@"setAttributes:%@ range:%@", attrs, NSStringFromRange(range));
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

@end
