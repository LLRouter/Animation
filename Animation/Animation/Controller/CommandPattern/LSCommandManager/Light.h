//
//  Light.h
//  Animation
//
//  Created by Mr.L on 2018/12/12.
//  Copyright © 2018 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Light : NSObject

/**  */
@property(nonatomic, strong)NSString *name;

-(instancetype)initWithName:(NSString *)name;

-(void)on;
-(void)off;

@end

NS_ASSUME_NONNULL_END
