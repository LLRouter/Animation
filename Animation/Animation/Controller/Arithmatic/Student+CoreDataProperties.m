//
//  Student+CoreDataProperties.m
//  
//
//  Created by dfw on 2018/4/16.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic studentName;
@dynamic studentAge;
@dynamic studentId;

@end
