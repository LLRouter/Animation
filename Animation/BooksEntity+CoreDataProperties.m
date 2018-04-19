//
//  BooksEntity+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "BooksEntity+CoreDataProperties.h"

@implementation BooksEntity (CoreDataProperties)

+ (NSFetchRequest<BooksEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BooksEntity"];
}

@dynamic bookName;
@dynamic price;

@end
