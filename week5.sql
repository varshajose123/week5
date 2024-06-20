mysql> CREATE TABLE SubjectAllotments (
    ->     StudentId VARCHAR(20),
    ->     SubjectId VARCHAR(10),
    ->     Is_Valid BIT,
    ->     Valid_From TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ->     Valid_To TIMESTAMP DEFAULT NULL, -- Change default value to NULL
    ->     PRIMARY KEY (StudentId, SubjectId, Valid_From)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE SubjectRequest (
    ->     StudentId VARCHAR(20),
    ->     SubjectId VARCHAR(10),
    ->     Request_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ->     PRIMARY KEY (StudentId, SubjectId)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE UpdateSubjectAllotments(
    ->     IN p_StudentId VARCHAR(20),
    ->     IN p_SubjectId VARCHAR(10)
    -> )
    -> BEGIN
    ->     DECLARE current_subject VARCHAR(10);
    ->     DECLARE current_is_valid BIT;
    ->
    ->     -- Check if the student already has an allotment
    ->     SELECT SubjectId, Is_Valid
    ->     INTO current_subject, current_is_valid
    ->     FROM SubjectAllotments
    ->     WHERE StudentId = p_StudentId AND Is_Valid = 1;
    ->
    ->     IF current_subject IS NULL THEN
    ->         -- No current allotments, insert new subject directly
    ->         INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
    ->         VALUES (p_StudentId, p_SubjectId, 1);
    ->     ELSE
    ->         IF current_subject <> p_SubjectId THEN
    ->             -- Update the current allotment to be invalid
    ->             UPDATE SubjectAllotments
    ->             SET Is_Valid = 0, Valid_To = CURRENT_TIMESTAMP
    ->             WHERE StudentId = p_StudentId AND SubjectId = current_subject AND Is_Valid = 1;
    ->
    ->             -- Insert the new subject allotment as valid
    ->             INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
    ->             VALUES (p_StudentId, p_SubjectId, 1);
    ->         END IF;
    ->     END IF;
    ->
    ->     -- Insert the request into SubjectRequest table
    ->     INSERT INTO SubjectRequest (StudentId, SubjectId)
    ->     VALUES (p_StudentId, p_SubjectId);
    ->
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE UpdateSubjectAllotments(
    ->     IN p_StudentId VARCHAR(20),
    ->     IN p_SubjectId VARCHAR(10)
    -> )
    -> BEGIN
    ->     DECLARE current_subject VARCHAR(10);
    ->     DECLARE current_is_valid BIT;
    ->
    ->     -- Check if the student already has an allotment
    ->     SELECT SubjectId, Is_Valid
    ->     INTO current_subject, current_is_valid
    ->     FROM SubjectAllotments
    ->     WHERE StudentId = p_StudentId AND Is_Valid = 1;
    ->
    ->     IF current_subject IS NULL THEN
    ->         -- No current allotments, insert new subject directly
    ->         INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
    ->         VALUES (p_StudentId, p_SubjectId, 1);
    ->     ELSE
    ->         IF current_subject <> p_SubjectId THEN
    ->             -- Update the current allotment to be invalid
    ->             UPDATE SubjectAllotments
    ->             SET Is_Valid = 0, Valid_To = CURRENT_TIMESTAMP
    ->             WHERE StudentId = p_StudentId AND SubjectId = current_subject AND Is_Valid = 1;
    ->
    ->             -- Insert the new subject allotment as valid
    ->             INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
    ->             VALUES (p_StudentId, p_SubjectId, 1);
    ->         END IF;
    ->     END IF;
    ->
    ->     -- Insert the request into SubjectRequest table
    ->     INSERT INTO SubjectRequest (StudentId, SubjectId)
    ->     VALUES (p_StudentId, p_SubjectId);
    ->
    -> END //
