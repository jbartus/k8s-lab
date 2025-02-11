
USE blog;

INSERT INTO users (name) VALUES ('Author One'), ('Author Two'), ('Author Three');

INSERT INTO posts (title, body, author) VALUES 
('Post One', 'This is the body of post one.', 1),
('Post Two', 'This is the body of post two.', 2),
('Post Three', 'This is the body of post three.', 3),
('Post Four', 'This is the body of post four.', 1),
('Post Five', 'This is the body of post five.', 2);