---- Author LIU,SHOU YUNG
-- Date:11/9/2015
-- Purpose: CSE Lab15 
-- Function Trigger
CREATE TRIGGER adjustCourseSeats ON CourseEnrollment
AFTER INSERT,DELETE,UPDATE 
AS 
	DECLARE @oldCourseId AS INT, @newCourseId AS INT,@originalCourseSeats AS INT
	--only insert action
	IF EXISTS(SELECT * FROM INSERTED) AND NOT EXISTS(SELECT * FROM DELETED)
	BEGIN
			SELECT @newCourseId = CourseId FROM INSERTED
			SELECT @originalCourseSeats = OpenSeats FROM Courses WHERE CourseId = @newCourseId
			UPDATE Courses
			SET  OpenSeats = @originalCourseSeats -1
			WHERE CourseId = @newCourseId
	END
	--only delete action
	IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS(SELECT * FROM INSERTED)
	BEGIN
			SELECT @newCourseId = CourseId FROM DELETED
			SELECT @originalCourseSeats = OpenSeats FROM Courses WHERE CourseId = @newCourseId
			UPDATE Courses
				SET  OpenSeats = @originalCourseSeats +1
				WHERE CourseId = @newCourseId
	END
	--update action
	IF EXISTS(SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
	BEGIN
		-- The student is not enrolled in this course, so the originalCourse openseats should plus 1
		SELECT @oldCourseId = CourseId FROM DELETED 
		SELECT @originalCourseSeats = OpenSeats FROM Courses WHERE CourseId = @oldCourseId
		UPDATE Courses 
			SET OpenSeats = @originalCourseSeats + 1
			WHERE CourseId = @oldCourseId

		-- The student is enrolled in new course, so the open seats should minus 1
		SELECT @newCourseId = CourseId FROM INSERTED
		SELECT @originalCourseSeats = OpenSeats FROM Courses WHERE CourseId = @newCourseId
		UPDATE Courses
			SET OpenSeats = @originalCourseSeats -1
			WHERE CourseId = @newCourseId 
	END;