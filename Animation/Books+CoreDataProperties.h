//
//  Books+CoreDataProperties.h
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "Books+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Books (CoreDataProperties)

+ (NSFetchRequest<Books *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *bookName;
@property (nullable, nonatomic, copy) NSNumber *price;

@end

NS_ASSUME_NONNULL_END
