//
//  Books+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "Books+CoreDataProperties.h"

@implementation Books (CoreDataProperties)

+ (NSFetchRequest<Books *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Books"];
}

@dynamic bookName;
@dynamic price;

@end
