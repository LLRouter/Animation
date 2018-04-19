//
//  BooksEntity+CoreDataProperties.h
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "BooksEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BooksEntity (CoreDataProperties)

+ (NSFetchRequest<BooksEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *bookName;
@property (nullable, nonatomic, copy) NSNumber *price;

@end

NS_ASSUME_NONNULL_END
