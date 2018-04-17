//
//  StudentClass+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/17.
//
//

#import "StudentClass+CoreDataProperties.h"

@implementation StudentClass (CoreDataProperties)

+ (NSFetchRequest<StudentClass *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StudentClass"];
}

@dynamic classId;
@dynamic name;
@dynamic relationship;

@end
