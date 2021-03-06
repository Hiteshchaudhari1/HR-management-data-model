CREATE SCHEMA hr;

CREATE TABLE hr.asset_inventory ( 
	asset_id             bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	asset_name           varchar(50)   ,
	asset_description    varchar(100)   ,
	asset_insurance_id   varchar(100)   ,
	asset_expiry_date    date   ,
	CONSTRAINT pk_employee_eqipment_id PRIMARY KEY ( asset_id )
 );

CREATE INDEX idx_asset_inventory_asset_id ON hr.asset_inventory ( asset_id );

CREATE INDEX idx_asset_inventory_asset_name ON hr.asset_inventory ( asset_name );

COMMENT ON TABLE hr.asset_inventory IS 'this table will track the whole assets which company currently have in total.';

CREATE TABLE hr.asset_inventory_history ( 
	asset_id             bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	asset_name           varchar(50)   ,
	asset_description    varchar(100)   ,
	aseet_insurance_id   varchar(100)   ,
	liable_employee_id   bigserial   ,
	returned_date        date   ,
	assigned_date        date   ,
	hr_approver_id       bigserial   ,
	CONSTRAINT pk_employee_eqipment_id_0 PRIMARY KEY ( asset_id )
 );

CREATE INDEX idx_asset_inventory_history_asset_id ON hr.asset_inventory_history ( asset_id );

CREATE INDEX idx_asset_inventory_history_asset_name ON hr.asset_inventory_history ( asset_name );

CREATE TABLE hr.category ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	categoty_name        varchar(50)   ,
	CONSTRAINT pk_ticekt_category_id PRIMARY KEY ( id )
 );

CREATE TABLE hr.company ( 
	company_id           bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	branch_id            bigserial   ,
	city                 varchar(25)   ,
	country              char(25)   ,
	"state"              char(50)   ,
	street_number_name   varchar(50)   ,
	postal_code          integer   ,
	company_name         varchar(50)   ,
	CONSTRAINT pk_company_company_id PRIMARY KEY ( company_id ),
	CONSTRAINT unq_company_branch_id UNIQUE ( branch_id ) 
 );

CREATE INDEX compositekey_comanyid_branchid ON hr.company ( company_id, branch_id );

COMMENT ON TABLE hr.company IS 'single organization can have different sub companies like \n Volkswagen owns companies like Audi,BentleyPorsche etc.\neach subcompany can have its branches at different locations. to make a table entries unique,  branch_id will be composite key of company_id+Branch_id.';

CREATE TABLE hr.designation ( 
	designation_id       bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	designation_name     varchar(25)   ,
	CONSTRAINT pk_designation_designation_id PRIMARY KEY ( designation_id )
 );

CREATE INDEX idx_designation_designation_id ON hr.designation ( designation_id );

CREATE TABLE hr.desk_allocation ( 
	desk_id              varchar  NOT NULL ,
	branch_id            bigserial   ,
	status               varchar(10)   ,
	CONSTRAINT pk_desk_allocation_desk_id PRIMARY KEY ( desk_id )
 );

CREATE INDEX idx_desk_allocation_status ON hr.desk_allocation ( status );

CREATE TABLE hr.employee_history ( 
	employee_id          bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	first_name           varchar(50)   ,
	last_name            varchar(50)   ,
	address              varchar(150)   ,
	city                 varchar(25)   ,
	country              char(25)   ,
	postal_code          integer   ,
	mobile_number        integer   ,
	alternate_contact_number integer   ,
	educational_background varchar(25)   ,
	designation_id       integer   ,
	work_experience      bigserial   ,
	experience_in        text   ,
	employee_dept_id     bigserial   ,
	branch_id            bigserial   ,
	nationality          varchar(25)   ,
	desk_id              varchar   ,
	payroll_id           bigserial   ,
	no_of_paid_leaves    bigserial   ,
	employee_manager_id  bigserial   ,
	employee_status      bool   ,
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	payslip              varchar(100)   ,
	employee_hr_id       bigserial   ,
	CONSTRAINT pk_employee_history_id PRIMARY KEY ( id ),
	CONSTRAINT unq_employee_history_employee_id UNIQUE ( employee_id ) 
 );

CREATE INDEX idx_employee_history_first_name ON hr.employee_history ( first_name );

CREATE INDEX idx_employee_history_last_name ON hr.employee_history ( last_name );

CREATE TABLE hr.employee_salary_history ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	payslip              varchar(250)   ,
	increment_history    float8   ,
	grade                varchar(5)   ,
	increment_year       date   ,
	employee_id          bigserial   ,
	CONSTRAINT pk_employee_payroll_hostory_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_employee_salary_history_payslip ON hr.employee_salary_history ( payslip );

CREATE INDEX idx_employee_salary_history_employee_id ON hr.employee_salary_history ( employee_id );

CREATE TABLE hr.employee_type ( 
	emp_type_id          bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	employee_type_name   varchar(100)   ,
	emp_type_description text   ,
	CONSTRAINT pk_employee_type_emp_type_id PRIMARY KEY ( emp_type_id )
 );

COMMENT ON TABLE hr.employee_type IS 'employee types would be : \ninternal employees,\nconsultant employees,\ninternship/thesis employees,\nExternal employees etc.';

CREATE TABLE hr.external_company_contract ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	company_name         varchar(50)   ,
	company_location     varchar(50)   ,
	contract_duration    float8   ,
	number_of_consultants integer   ,
	contract_amount      float8   ,
	contract_with        bigserial   ,
	CONSTRAINT pk_external_company_contract_id PRIMARY KEY ( id ),
	CONSTRAINT unq_external_company_contract_contract_with UNIQUE ( contract_with ) 
 );

COMMENT ON TABLE hr.external_company_contract IS 'any contract with outside company for the purpose of software purchase agreement or man power will be recorded in this table.';

CREATE TABLE hr.external_company_contract_history ( 
	id                   bigserial  NOT NULL ,
	company_name         varchar(50)   ,
	company_location     varchar(50)   ,
	contract_duration    float8   ,
	number_of_consultants integer   ,
	contract_amount      float8   ,
	contract_with        bigserial   ,
	history_id           bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	CONSTRAINT pk_external_company_contract_history_history_id PRIMARY KEY ( history_id )
 );

CREATE TABLE hr.job_openings ( 
	job_id               bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	job_position         varchar   ,
	job_description      text   ,
	is_active            bool   ,
	no_of_employee_required integer   ,
	required_work_experience text   ,
	skill_set            text   ,
	CONSTRAINT pk_job_openings_job_id PRIMARY KEY ( job_id )
 );

CREATE INDEX idx_job_openings_job_id ON hr.job_openings ( job_id );

CREATE TABLE hr.leave_type ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	type_of_leave        varchar(25)   ,
	leave_description    varchar(50)   ,
	no_of_leaves         integer   ,
	CONSTRAINT pk_leave_type_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_leave_type_id ON hr.leave_type ( id );

COMMENT ON TABLE hr.leave_type IS 'leave types would be :\nfor eg. paid leaves, sick leaves, comp-off.';

CREATE TABLE hr.public_holiday ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	date_of_holiday      date   ,
	occasion             varchar(25)   ,
	company_state        varchar   ,
	CONSTRAINT pk_public_holiday_id PRIMARY KEY ( id )
 );

CREATE TABLE hr.salary_increment ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	grade                varchar(5)   ,
	%increment           float8   ,
	CONSTRAINT pk_person_salary_increment_id PRIMARY KEY ( id )
 );

COMMENT ON TABLE hr.salary_increment IS 'it will be a master table where data would be like :\nGrade A -- 30%,\nGrade B -- 20%,\nGrade C -- 5%\nand indivisual employee will get a grade in employee tatble and his yearly increment will be done as per his grade and % increment decided for that grade by organziational management.';

CREATE TABLE hr.aspirants ( 
	aspirant_id          integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	fisrt_name           varchar(100)   ,
	last_name            varchar(100)   ,
	job_id               bigserial   ,
	work_experience      integer   ,
	status               char(5)   ,
	comments             text   ,
	job_location         varchar(25)   ,
	hr_id                bigserial   ,
	date_of_application  date   ,
	educational_background text   ,
	employee_id          bigserial   ,
	CONSTRAINT pk_aspirants_aspirant_id PRIMARY KEY ( aspirant_id )
 );

CREATE INDEX idx_aspirants_fisrt_name ON hr.aspirants ( fisrt_name );

CREATE INDEX idx_aspirants_aspirant_id ON hr.aspirants ( aspirant_id );

CREATE INDEX idx_aspirants_last_name ON hr.aspirants ( last_name );

CREATE INDEX idx_aspirants_date_of_application ON hr.aspirants ( date_of_application );

COMMENT ON TABLE hr.aspirants IS 'for a particular job opening, if internal company employee applies then employee Id column will be filled. \nfor a fresh outsider applicant, employee ID will be blank.';

CREATE TABLE hr.asset_liability ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	asset_id             bigserial   ,
	liable_employee_id   bigserial   ,
	issued_date          timestamp   ,
	returned_date        timestamp   ,
	approval_status      bool   ,
	CONSTRAINT pk_asset_liability_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_asset_liability_liable_employee_id ON hr.asset_liability ( liable_employee_id );

CREATE INDEX idx_asset_liability_approval_status ON hr.asset_liability ( approval_status );

COMMENT ON TABLE hr.asset_liability IS 'this table will track the issuing of asset to a particulatr employee.';

CREATE TABLE hr.department ( 
	dept_id              bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	dept_name            varchar(50)   ,
	employee_id_hod      bigserial   ,
	team_building_budget float8   ,
	CONSTRAINT pk_department_dept_id PRIMARY KEY ( dept_id )
 );

CREATE INDEX idx_department_dept_id ON hr.department ( dept_id );

CREATE INDEX idx_department_dept_id_0 ON hr.department ( dept_id );

CREATE INDEX idx_department_dept_name ON hr.department ( dept_name );

CREATE TABLE hr.employee ( 
	employee_id          bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	first_name           varchar(50)   ,
	last_name            varchar(50)   ,
	address              varchar(150)   ,
	city                 varchar(25)   ,
	country              char(25)   ,
	postal_code          integer   ,
	nationality          varchar(25)   ,
	mobile_number        integer   ,
	alternate_contact_number integer   ,
	educational_background varchar(25)   ,
	employee_dob         date   ,
	designation_id       integer   ,
	work_experience      bigserial   ,
	experience_in        text   ,
	employee_dept_id     bigserial   ,
	branch_id            bigserial   ,
	desk_id              varchar   ,
	payroll_id           bigserial   ,
	no_of_paid_leaves    bigserial   ,
	employee_manager_id  bigserial   ,
	employee_status      bool   ,
	annual_bonus_amount  float8   ,
	date_of_bonous_released date   ,
	bonus_approver_id    bigserial   ,
	employee_hr_id       bigserial   ,
	grade_id             bigserial   ,
	CONSTRAINT pk_person_id PRIMARY KEY ( employee_id )
 );

CREATE INDEX idx_employee_employee_id ON hr.employee ( employee_id );

CREATE INDEX idx_employee_employee_id_0 ON hr.employee ( employee_id );

CREATE INDEX idx_employee_last_name ON hr.employee ( last_name );

CREATE INDEX idx_employee_designation_id ON hr.employee ( designation_id );

CREATE INDEX idx_employee_employee_dept_id ON hr.employee ( employee_dept_id );

CREATE INDEX idx_employee_branch_id ON hr.employee ( branch_id );

CREATE INDEX idx_employee_grade_id ON hr.employee ( grade_id );

COMMENT ON TABLE hr.employee IS '1. employee organziational hirarchy will be maintained by self looping to this table using employee_manager_Id and employee_Hr_Id.\n2. annual bonus will be updated in at the end of financial year(or may be if company decide to give bonus half yearly).\n3. on separation, the employee_status will be deactivated. employee data will be soft-deleted to keep the history.';

CREATE TABLE hr.employee_attendance ( 
	id                   integer  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	employee_id          bigserial   ,
	mark_in_time         timestamp   ,
	mark_out_time        timestamp   ,
	employee_type_id     bigserial   ,
	attendance_status    varchar(1)   ,
	working_hrs          integer   ,
	leave_type_id        bigserial   ,
	calender_date        date   ,
	CONSTRAINT pk_employee_attendance_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_employee_attendance_employee_id ON hr.employee_attendance ( employee_id );

CREATE INDEX idx_employee_attendance_mark_in_time ON hr.employee_attendance ( mark_in_time );

CREATE INDEX idx_employee_attendance_mark_out_time ON hr.employee_attendance ( mark_out_time );

CREATE INDEX idx_employee_attendance_attendance_status ON hr.employee_attendance ( attendance_status );

CREATE INDEX idx_employee_attendance_working_hrs ON hr.employee_attendance ( working_hrs );

CREATE INDEX idx_employee_attendance_calender_date ON hr.employee_attendance ( calender_date );

COMMENT ON TABLE hr.employee_attendance IS 'working hour will be calculated depending on employees markin and markout timing at the end of the day.\nfor public holiday the attendance status will be public holiday and full day working hours will be added for this day.\ncalender date would be each day of the year for each employee to track the attendance status for each day whether he worked full day / half day / was on leave or it was a public holiday.\nand his payroll will be calculated salary per hr - every month based on working hours';

CREATE TABLE hr.employee_reimbursement ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	employee_id          bigserial   ,
	reimbursement_amount float8   ,
	reimbursement_description varchar(50)   ,
	reimbursement_date   date   ,
	category_id          bigserial   ,
	approval_status      char(1)   ,
	CONSTRAINT pk_employee_bonus_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_employee_bonus_reimbursement_employee_id ON hr.employee_reimbursement ( employee_id );

CREATE TABLE hr.employee_type_mapping ( 
	emp_type_id          bigserial   ,
	description          varchar(50)   ,
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	consulting_comapny_id bigserial   ,
	contract_duration    varchar(50)   ,
	designation_id       bigserial   ,
	employee_id          bigint   ,
	CONSTRAINT pk_employee_type_id PRIMARY KEY ( id )
 );

COMMENT ON TABLE hr.employee_type_mapping IS 'To identify the relationship of the external employees with their respective companies.';

CREATE TABLE hr.leave_request ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	employee_id          bigserial   ,
	from_date            date   ,
	to_date              date   ,
	leave_type_id        bigserial   ,
	comments             text   ,
	leave_approval_status bool   ,
	CONSTRAINT pk_leave_request_id PRIMARY KEY ( id )
 );

COMMENT ON TABLE hr.leave_request IS 'could be a leave or a comp-off request.\ncomp-off : \nconsidering an employee works on a holiday then he/she can apply for comp-off leave which will go to manager for approval and on approval by manager, his paid leaves will be credited.';

CREATE TABLE hr.payroll ( 
	payroll_id           bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	dept_id              bigserial   ,
	salary_per_hr        float8   ,
	CONSTRAINT pk_payroll_id PRIMARY KEY ( payroll_id )
 );

CREATE INDEX idx_payroll_payroll_id ON hr.payroll ( payroll_id );

CREATE TABLE hr.ticket ( 
	id                   bigserial  NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	assigned_to_employee_id bigserial   ,
	raised_by_employee_id bigserial   ,
	ticket_description   bigserial   ,
	ticket_status        bool   ,
	ticket_tat           date   ,
	ticket_approval_status bool   ,
	approval_by          varchar(100)   ,
	CONSTRAINT pk_ticket_id PRIMARY KEY ( id )
 );

CREATE INDEX idx_ticket_id ON hr.ticket ( id );

CREATE INDEX idx_ticket_ticket_status ON hr.ticket ( ticket_status );

CREATE INDEX idx_ticket_assigned_to_employee_id ON hr.ticket ( assigned_to_employee_id );

CREATE INDEX idx_ticket_raised_by_employee_id ON hr.ticket ( raised_by_employee_id );

COMMENT ON TABLE hr.ticket IS 'approval by is an optional field.\nFor E.g :\nif employee needs any paid software to use for project purpose then first request needs to be approved by his manager.';

ALTER TABLE hr.aspirants ADD CONSTRAINT fk_aspirants_employee FOREIGN KEY ( hr_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.aspirants ADD CONSTRAINT fk_aspirants_job_openings FOREIGN KEY ( job_id ) REFERENCES hr.job_openings( job_id );

ALTER TABLE hr.aspirants ADD CONSTRAINT fk_aspirants_employee_id FOREIGN KEY ( employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.asset_liability ADD CONSTRAINT fk_asset_id FOREIGN KEY ( asset_id ) REFERENCES hr.asset_inventory( asset_id );

ALTER TABLE hr.asset_liability ADD CONSTRAINT fk_asset_liable_employee_id FOREIGN KEY ( liable_employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.department ADD CONSTRAINT fk_department_person FOREIGN KEY ( employee_id_hod ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.desk_allocation ADD CONSTRAINT fk_desk_allocation_company FOREIGN KEY ( branch_id ) REFERENCES hr.company( branch_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_person_department FOREIGN KEY ( employee_dept_id ) REFERENCES hr.department( dept_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_person_company FOREIGN KEY ( branch_id ) REFERENCES hr.company( branch_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_employee_desk_allocation FOREIGN KEY ( desk_id ) REFERENCES hr.desk_allocation( desk_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_employee_designation FOREIGN KEY ( designation_id ) REFERENCES hr.designation( designation_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_employee_payroll FOREIGN KEY ( payroll_id ) REFERENCES hr.payroll( payroll_id );

ALTER TABLE hr.employee ADD CONSTRAINT fk_employee_salary_increment FOREIGN KEY ( grade_id ) REFERENCES hr.salary_increment( id );

ALTER TABLE hr.employee_attendance ADD CONSTRAINT fk_employee_attendance FOREIGN KEY ( employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.employee_attendance ADD CONSTRAINT fk_leave_type_id FOREIGN KEY ( leave_type_id ) REFERENCES hr.leave_type( id );

ALTER TABLE hr.employee_reimbursement ADD CONSTRAINT fk_employee_approver_id FOREIGN KEY (  ) REFERENCES hr.employee(  );

ALTER TABLE hr.employee_reimbursement ADD CONSTRAINT fk_employee_id FOREIGN KEY ( employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.employee_reimbursement ADD CONSTRAINT fk_category_id FOREIGN KEY ( category_id ) REFERENCES hr.category( id );

ALTER TABLE hr.employee_salary_history ADD CONSTRAINT fk_employee_id_history FOREIGN KEY ( employee_id ) REFERENCES hr.employee_history( employee_id );

ALTER TABLE hr.employee_type_mapping ADD CONSTRAINT fk_employee_type_designation FOREIGN KEY ( designation_id ) REFERENCES hr.designation( designation_id );

ALTER TABLE hr.employee_type_mapping ADD CONSTRAINT fk_employee_type FOREIGN KEY ( consulting_comapny_id ) REFERENCES hr.external_company_contract( contract_with );

ALTER TABLE hr.employee_type_mapping ADD CONSTRAINT fk_employee_type_employee FOREIGN KEY ( employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.employee_type_mapping ADD CONSTRAINT fk_employee_type_mapping FOREIGN KEY ( emp_type_id ) REFERENCES hr.employee_type( emp_type_id );

ALTER TABLE hr.external_company_contract ADD CONSTRAINT fk_external_company_contract FOREIGN KEY ( contract_with ) REFERENCES hr.company( branch_id );

ALTER TABLE hr.leave_request ADD CONSTRAINT fk_employee_id FOREIGN KEY ( employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.leave_request ADD CONSTRAINT fk_leave_type_id FOREIGN KEY ( leave_type_id ) REFERENCES hr.leave_type( id );

ALTER TABLE hr.payroll ADD CONSTRAINT fk_payroll_department FOREIGN KEY ( dept_id ) REFERENCES hr.department( dept_id );

ALTER TABLE hr.payroll ADD CONSTRAINT fk_payroll_company FOREIGN KEY ( payroll_id ) REFERENCES hr.company( company_id );

ALTER TABLE hr.ticket ADD CONSTRAINT fk_assigned_to_employee_id FOREIGN KEY ( assigned_to_employee_id ) REFERENCES hr.employee( employee_id );

ALTER TABLE hr.ticket ADD CONSTRAINT fk_raised_by_employee_id FOREIGN KEY ( raised_by_employee_id ) REFERENCES hr.employee( employee_id );

