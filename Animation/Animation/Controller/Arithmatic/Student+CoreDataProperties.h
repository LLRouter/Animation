//
//  Student+CoreDataProperties.h
//  
//
//  Created by dfw on 2018/4/16.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *studentName;
@property (nonatomic) int32_t studentAge;
@property (nonatomic) int16_t studentId;

@end

NS_ASSUME_NONNULL_END
