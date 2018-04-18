//
//  Student+CoreDataProperties.h
//  
//
//  Created by dfw on 2018/4/18.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *studentAge;
@property (nullable, nonatomic, copy) NSNumber *studentId;
@property (nullable, nonatomic, copy) NSString *studentName;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, retain) StudentClass *relationship;

@end

NS_ASSUME_NONNULL_END
