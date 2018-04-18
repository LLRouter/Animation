//
//  Student+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic studentAge;
@dynamic studentId;
@dynamic studentName;
@dynamic sex;
@dynamic relationship;

@end
