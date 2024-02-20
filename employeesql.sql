-- Add foreign key constraint to titles table
ALTER TABLE titles
ADD CONSTRAINT fk_title_emp
FOREIGN KEY (title_id) REFERENCES employees(emp_title);
