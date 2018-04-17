//
//  Student+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/17.
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
@dynamic relationship;

@end
