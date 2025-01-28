
------------------------- TRIGGERS -------------------------
CREATE TABLE professor_audit (
    audit_id INT IDENTITY,
    professor_id INT,
    changed_column NVARCHAR(50),
    old_value NVARCHAR(50),
    new_value NVARCHAR(50),
    change_datetime DATETIME,
    CONSTRAINT PK_professor_audit_id PRIMARY KEY(audit_id),
    CONSTRAINT FK_professor_audit FOREIGN KEY(professor_id) REFERENCES professor(id)
);

GO

CREATE TRIGGER trg_professor_audit ON professor
AFTER UPDATE
AS
BEGIN
    IF (UPDATE(name) OR UPDATE(surname) OR UPDATE(email))
    BEGIN
        INSERT INTO professor_audit (professor_id, changed_column, old_value, new_value, change_datetime)
        SELECT
            i.id,
            'name',
            d.name,
            i.name,
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.id = d.id
        WHERE i.name <> d.name;

        INSERT INTO professor_audit (professor_id, changed_column, old_value, new_value, change_datetime)
        SELECT
            i.id,
            'surname',
            d.surname,
            i.surname,
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.id = d.id
        WHERE i.surname <> d.surname;

        INSERT INTO professor_audit (professor_id, changed_column, old_value, new_value, change_datetime)
        SELECT
            i.id,
            'email',
            d.email,
            i.email,
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.id = d.id
        WHERE i.email <> d.email;
    END
END;

go
CREATE TABLE department_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    department_id INT,
    old_awards NVARCHAR(500),
    new_awards NVARCHAR(500),
    update_date DATETIME,
    CONSTRAINT FK_department_audit_department FOREIGN KEY (department_id) REFERENCES department(id)
)

go
CREATE TRIGGER LogDepartmentAwardUpdates
ON department
AFTER UPDATE
AS
BEGIN
    IF UPDATE(awards)
    BEGIN
        INSERT INTO department_audit (department_id, old_awards, new_awards, update_date)
        SELECT inserted.id, deleted.awards, inserted.awards, GETDATE()
        FROM inserted
        JOIN deleted ON inserted.id = deleted.id
        WHERE inserted.awards <> deleted.awards;
    END
END;
go



CREATE TRIGGER PreventSubjectDeletionIfUsed
ON subject
INSTEAD OF DELETE
AS
BEGIN
    -- Check if the subject is currently used in any lessons
    IF EXISTS (SELECT 1 FROM lesson WHERE subject_id IN (SELECT id FROM deleted))
    BEGIN
        RAISERROR ('Cannot delete a subject that is currently in use in lessons.', 16, 1);
        RETURN;
    END

    -- Check if the subject is assigned to any departments
    IF EXISTS (SELECT 1 FROM subject_department WHERE subject IN (SELECT id FROM deleted))
    BEGIN
        RAISERROR ('Cannot delete a subject that is currently assigned to a department.', 16, 1);
        RETURN;
    END

    -- If the subject is not in use, proceed with the deletion
    DELETE FROM subject WHERE id IN (SELECT id FROM deleted);
END;

go