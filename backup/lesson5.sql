CREATE TABLE folders (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INTEGER REFERENCES folders(id)
);

INSERT INTO Folders (name, parent_id) VALUES
('Documents', NULL),
('Adobe', 1),
('Audition', 2),
('Commons', 2),
('Downloads', 1),
('My Albums', 1),
('2024', 6),
('2025', 6);

WITH RECURSIVE Folder_path AS (
    SELECT id, name, parent_id, name AS path
    FROM Folders
    WHERE parent_id IS NULL

    UNION ALL

    SELECT Folders.id, Folders.name, Folders.parent_id, Folder_path.path || '/' || Folders.name
    FROM Folders
    JOIN Folder_path ON Folders.parent_id = Folder_path.id
)
SELECT * FROM Folder_path;