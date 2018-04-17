//
//  StudentClass+CoreDataProperties.h
//  
//
//  Created by dfw on 2018/4/17.
//
//

#import "StudentClass+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentClass (CoreDataProperties)

+ (NSFetchRequest<StudentClass *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *classId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Student *> *relationship;

@end

@interface StudentClass (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Student *)value;
- (void)removeRelationshipObject:(Student *)value;
- (void)addRelationship:(NSSet<Student *> *)values;
- (void)removeRelationship:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
