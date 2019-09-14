drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_archives;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_archives
(
	id bigint not null
		constraint ods_bio_car_archives_pk
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	device_id bigint,
	device_classcode varchar(500),
	yzid_type varchar(500),
	gps_id bigint,
	code varchar(500),
	name varchar(500),
	car_number varchar(500),
	car_capacity smallint,
	car_use varchar(500),
	car_owner varchar(500),
	buy_date timestamp,
	examination_date timestamp,
	car_team varchar(500),
	team_number varchar(500),
	together_star timestamp,
	together_end timestamp,
	overspeed smallint,
	status integer,
	deleted boolean,
	allowed_dry boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_archives_camera;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_archives_camera
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	car_archives_id bigint,
	camera_id bigint,
	status integer,
	deleted boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_archives_driver;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_archives_driver
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	car_archives_id bigint,
	driver_id bigint,
	driver_default boolean,
	status integer,
	deleted boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_arrange;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_arrange
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	process_id varchar(100),
	driver_id bigint,
	car_id bigint,
	car_number varchar(100),
	car_seat_qty smallint,
	car_ride_qty smallint,
	biz_type smallint,
	arrange_leave_time timestamp,
	actual_leave_time timestamp,
	complete_time timestamp,
	car_status integer,
	process_instance_id varchar(100),
	task_receive_status smallint,
	remark varchar(500),
	deleted boolean,
	driver_name varchar(255),
	process_name varchar(255),
	type smallint,
	food_arrange_id bigint
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_dry_setting;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_dry_setting
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	status integer,
	deleted boolean,
	dry_code varchar(50),
	device_classcode varchar(500),
	car_use varchar(500),
	dry_temperature integer,
	dry_duration integer,
	dry_pre_duration integer
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_person_ref;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_person_ref
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	arrange_id bigint,
	person_id bigint,
	deleted boolean,
	pending_id bigint,
	person_name varchar(255),
	in_status smallint,
	off_status smallint,
	in_time timestamp,
	off_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_process_line;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_process_line
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	process_id varchar(100),
	process_name varchar(500),
	process_type varchar(500),
	flow_line string,
	deleted boolean,
	status integer
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_process_node;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_process_node
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	parent_id bigint,
	location_id bigint,
	location_name varchar(500),
	sort integer
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_start_stop;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_start_stop
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	parent_id bigint,
	start_id bigint,
	start_name varchar(500),
	stop_id bigint,
	stop_name varchar(500)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_category;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_category
(
	id bigint not null
			primary key,
	parent_id bigint,
	category_name varchar(500) not null,
	category_code varchar(500) not null,
	remark string not null,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	app_id bigint not null,
	tenant_id bigint not null,
	deleted boolean,
	category_type varchar(255) not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_data_dict;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_data_dict
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	code varchar(255),
	name varchar(500),
	category_id bigint not null,
	tag varchar(255),
	remark varchar(255)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_data_dict_item;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_data_dict_item
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	dict_id bigint not null,
	order_idx smallint,
	label varchar(255),
	value varchar(500)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_pending_person;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_pending_person
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	person_id bigint,
	biz_type smallint,
	reason_id smallint,
	plan_time timestamp,
	ride_location_id bigint,
	destination_id bigint,
	arrange_status integer,
	remark varchar(500),
	deleted boolean,
	person_name varchar(255),
	ride_location_name varchar(255),
	destination_name varchar(255)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_person_state;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_person_state
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	status smallint,
	deleted boolean,
	code varchar(255),
	value varchar(64),
	remark varchar(255)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_person_task_tag;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_person_task_tag
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	status smallint,
	deleted boolean,
	parent_id bigint,
	code varchar(255),
	value varchar(255),
	remark varchar(255)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_person_task_tag_ref;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_person_task_tag_ref
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	employee_id bigint not null,
	tag_id bigint not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_sampling_record;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_sampling_record
(
	id bigint not null
			primary key,
	location_id bigint,
	location_name varchar(255),
	sampling_num varchar(255),
	sampling_type_id bigint,
	sampling_type_name varchar(255),
	user_id bigint,
	user_name varchar(50),
	process_instance_id varchar(64),
	task_instance_id varchar(64),
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint not null,
	app_id bigint,
	deleted boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_person_state_ref;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_person_state_ref
(
	id bigint not null
			primary key,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	deleted boolean,
	employee_id bigint not null,
	state_id bigint not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_biz_task;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_biz_task
(
	id bigint not null
			primary key,
	task_type integer,
	name varchar(50) not null,
	task_category bigint,
	extension json,
	description string,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	task_scene_id bigint not null,
	title varchar(100),
	code varchar(255),
	task_seq integer not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_flow_info;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_flow_info
(
	id bigint not null
			primary key,
	flow_id varchar(64),
	name varchar(100) not null,
	flow_def_key varchar(100) not null,
	version varchar(50),
	level char(2),
	status smallint not null,
	bpmn_def_file string not null,
	tag varchar(20),
	category_id varchar(1000),
	create_user varchar(50),
	modify_user varchar(50),
	create_time timestamp,
	modify_time timestamp,
	tenant_id bigint,
	deleted boolean,
	description varchar(255) not null,
	extension_info json
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_flow_node_info;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_flow_node_info
(
	id bigint not null
			primary key,
	flow_def_key varchar(100),
	name varchar(100) not null,
	flow_node_key varchar(50) not null,
	space_id bigint,
	description string,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_execute;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_execute
(
	id bigint not null
			primary key,
	excutor_id bigint,
	status smallint,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	task_instance_id bigint,
	ref_info json,
	tac_task_instance_id bigint,
	real_start_time timestamp,
	real_end_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_instance;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_instance
(
	id bigint not null
			primary key,
	biz_task_id bigint,
	tac_task_id bigint,
	excutor_type smallint,
	excutor_role_id bigint,
	flow_instance_id varchar(64),
	flow_task_id varchar(64),
	flow_def_key varchar(64),
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	excute_times integer,
	excute_max_times integer,
	space_id bigint,
	flow_node_key varchar(64),
	task_status smallint
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_relation;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_relation
(
	id bigint not null
			primary key,
	role_id bigint,
	material_id bigint,
	device_type bigint,
	space_id bigint,
	flow_def_key varchar(64),
	flow_node_key varchar(64),
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_relationship;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_relationship
(
	task_relation_id bigint not null,
	biz_task_id bigint not null,
	tenant_id bigint,
		primary key (task_relation_id, biz_task_id)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_runtime_variable;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_runtime_variable
(
	id bigint not null
			primary key,
	instance_type varchar(50),
	instance_id varchar(64),
	name varchar(50) not null,
	var_type varchar(100),
	value string,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_step;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_step
(
	id bigint not null
			primary key,
	task_id bigint,
	name varchar(50) not null,
	step_type smallint,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	description string,
	seq integer
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_step_action;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_step_action
(
	id bigint not null
			primary key,
	ref_id bigint not null,
	type integer,
	action_code varchar(50) not null,
	action_url varchar(100) not null,
	form_id varchar(64),
	remarks string,
	create_user varchar(100),
	modify_user varchar(100),
	create_time timestamp,
	modify_time timestamp,
	tenant_id bigint,
	deleted boolean,
	action_name varchar(50)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_step_instance;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_step_instance
(
	id bigint not null
			primary key,
	task_execute_id bigint,
	task_step_id bigint,
	tac_task_step_id bigint,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	step_status smallint not null,
	seq integer
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_step_rule;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_step_rule
(
	id bigint not null
			primary key,
	task_step_id bigint,
	rule_category bigint,
	name varchar(50) not null,
	ruc_rule_id bigint,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_task_variable;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_task_variable
(
	id bigint not null
			primary key,
	`key` varchar(50),
	var_type varchar(100),
	belonger_type varchar(50),
	belonger_id bigint,
	description string,
	create_user varchar(500) not null,
	modify_user varchar(500),
	create_time timestamp not null,
	modify_time timestamp,
	tenant_id bigint not null,
	deleted boolean not null,
	value varchar(500),
	name varchar(100)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_enter_check;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_enter_check
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50),
	car_type smallint,
	process_instance_id varchar(100) not null,
	yz_id varchar(100) not null,
	device_type smallint,
	space_id bigint,
	space_name varchar(50),
	verify_time timestamp,
	pass_type smallint not null,
	check_time timestamp,
	check_status smallint,
	check_not_pass_reason_id varchar(3000),
	check_not_pass_remark varchar(500),
	file_id varchar(3000),
	deleted boolean,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_wash;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_wash
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50),
	car_type smallint,
	process_instance_id varchar(100) not null,
	yz_id varchar(100) not null,
	device_type varchar(50),
	space_id bigint,
	space_name varchar(50),
	wash_start_time timestamp,
	wash_end_time timestamp,
	wash_water_volume integer,
	require_drain_time integer,
	actual_drain_time integer,
	check_status smallint,
	check_not_pass_reason_id varchar(3000),
	check_not_pass_remark varchar(500),
	file_id varchar(3000),
	drain_start_time timestamp,
	drain_end_time timestamp,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean,
	check_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_antisepsis;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_antisepsis
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50),
	car_type varchar(50),
	process_instance_id varchar(100) not null,
	yz_id varchar(100) not null,
	device_type smallint,
	space_id bigint,
	space_name varchar(50),
	antisepsis_start_time timestamp,
	antisepsis_end_time timestamp,
	require_drain_time integer,
	actual_drain_time integer,
	check_status smallint,
	check_not_pass_reason_id varchar(3000),
	check_not_pass_remark varchar(500),
	file_id varchar(3000),
	drain_start_time timestamp,
	drain_end_time timestamp,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean,
	check_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_drying;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_drying
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50),
	car_type varchar(50),
	process_instance_id varchar(100) not null,
	yz_id varchar(100) not null,
	device_type smallint,
	space_id bigint,
	space_name varchar(50),
	drying_start_time timestamp,
	drying_end_time timestamp
			unique,
	drying_effect_duration integer,
	temperature json,
	end_time timestamp,
	open_time timestamp,
	close_time timestamp,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_operate_person_record;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_operate_person_record
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	account_id bigint not null,
	name varchar(50) not null,
	role_id bigint not null,
	role_name varchar(50) not null,
	process_instance_id varchar(100) not null,
	start_time timestamp,
	end_time timestamp,
	operate_type smallint not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_move;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_move
(
	id bigint not null
			primary key,
	app_id bigint not null,
	tenant_id bigint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50),
	car_type varchar(50),
	process_instance_id varchar(100) not null,
	yz_id varchar(100) not null,
	device_type smallint,
	space_id bigint,
	space_name varchar(50),
	move_start_time timestamp,
	move_end_time timestamp,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_alarm;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_alarm
(
	id bigint not null
			primary key,
	process_instance_id varchar(100) not null,
	alarm_time timestamp,
	type smallint not null,
	car_id bigint not null,
	car_number varchar(50) not null,
	car_type varchar(50) not null,
	driver_id bigint not null,
	driver_name varchar(50) not null,
	process_id bigint not null,
	task_type smallint,
	status smallint not null,
	handle_time timestamp,
	handle_user varchar(50),
	app_id bigint not null,
	tenant_id bigint not null,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean,
	remark varchar(1000),
	coordinate varchar(100)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_exit_entry;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_exit_entry
(
	id bigint not null
			primary key,
	process_instance_id varchar(64) not null,
	task_instance_id bigint,
	user_id bigint,
	user_name varchar(50),
	isolation_start_time timestamp,
	isolation_end_time timestamp,
	isolation_entry_time timestamp,
	isolation_exit_time timestamp,
	isolation_center_id bigint,
	isolation_center_name varchar(255),
	bracelet_number varchar(30),
	bracelet_status smallint,
	arranged boolean,
	step_executed smallint,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint,
	deleted boolean,
	app_id bigint,
	process_status smallint
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_isolation_apply;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_isolation_apply
(
	id bigint not null
			primary key,
	process_instance_id varchar(64),
	approve_process_instance_id varchar(64),
	task_instance_id varchar(64),
	user_id bigint,
	user_name varchar(50),
	approve_user_id bigint,
	approve_user_name varchar(50),
	company_id bigint,
	company_name varchar(128),
	org_id bigint,
	org_name varchar(128),
	position varchar(128),
	user_type_code varchar(50),
	user_type_name varchar(255),
	destination_id bigint,
	destination_name varchar(500),
	isolation_start_time timestamp,
	start_point_id bigint,
	start_point_name varchar(500),
	approve_status smallint,
	remark varchar(500),
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint,
	app_id bigint,
	deleted boolean,
	process_status smallint,
	approve_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_takeshower;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_takeshower
(
	id bigint not null
			primary key,
	process_instance_id varchar(64) not null,
	task_instance_id varchar(64),
	user_id bigint,
	user_name varchar(50),
	isolation_center_id bigint,
	isolation_center_name varchar(255),
	bathroom_id bigint,
	bathroom_name varchar(255),
	entry_time timestamp,
	exit_time timestamp,
	valid_duration bigint,
	practical_duration bigint,
	valid_water double precision,
	practical_water double precision,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint,
	app_id bigint,
	deleted boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_alarm_record;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_alarm_record
(
	id bigint not null
			primary key,
	flow_instance_id varchar(100),
	task_execute_id bigint,
	step_instance_id bigint,
	user_id bigint,
	role_id bigint,
	alarm_content varchar(3000),
	rule_content varchar(1000),
	alarm_status smallint,
	alarm_handler_time timestamp,
	alarm_handler_user_id bigint,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint,
	app_id bigint,
	deleted boolean,
	notice_id bigint,
	alarm_type smallint,
	alarm_channel smallint,
	alarm_title varchar(255),
	alarm_handler_user_name varchar(50)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_car_change;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_car_change
(
	id bigint not null
			primary key,
	process_instance_id varchar(100) not null,
	reason_id bigint not null,
	remark varchar(500),
	file_id varchar(1000),
	car_id bigint not null,
	car_number varchar(50) not null,
	change_car_id bigint not null,
	change_car_number varchar(50) not null,
	app_id bigint not null,
	tenant_id bigint not null,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean,
	notice_role_id bigint not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_line_change;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_line_change
(
	id bigint not null
			primary key,
	process_instance_id varchar(100) not null,
	reason_id bigint not null,
	remark varchar(500),
	file_id varchar(1000),
	car_id bigint not null,
	car_number varchar(50) not null,
	line_id bigint not null,
	line_name varchar(50) not null,
	app_id bigint not null,
	tenant_id bigint not null,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	deleted boolean,
	notice_role_id bigint not null
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_sop;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_sop
(
	id bigint not null
			primary key,
	task_scene_id bigint,
	task_scene_name varchar(255),
	operation_name varchar(255),
	operation_head_image string,
	operation_head_desc string,
	operation_describe string,
	image_url string,
	usage smallint,
	create_user varchar(255),
	create_time timestamp,
	modify_user varchar(255),
	modify_time timestamp,
	tenant_id bigint,
	app_id integer,
	deleted boolean
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_operate_log;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_operate_log
(
	id bigint not null
			primary key,
	tenant_id bigint not null,
	app_id bigint not null,
	deleted boolean,
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	operator varchar(30),
	operator_name varchar(50),
	operate_time timestamp,
	operate_type varchar(30),
	operate_method varchar(200),
	description varchar(200),
	method_args string,
	result_str string,
	app_name varchar(30)
);
drop table if exists dev_bigdata_bio_antiasf.ods_detection_sample_record;
create table if not exists dev_bigdata_bio_antiasf.ods_detection_sample_record
(
	id bigint not null,
	location_id bigint,
	location_name varchar(255),
	detection_sample_code varchar(255),
	sampling_type_id bigint,
	sampling_type_name varchar(255),
	user_id bigint,
	user_name varchar(50),
	process_instance_id varchar(64),
	task_instance_id varchar(64),
	create_user varchar(50),
	create_time timestamp,
	modify_user varchar(50),
	modify_time timestamp,
	tenant_id bigint not null,
	app_id bigint,
	deleted boolean,
	center_id bigint,
	detection_sample_source_code varchar(64),
	sample_category_code varchar(64),
	detection_item_code varchar(64),
	org_name varchar(255),
	dept_name varchar(255),
	target_name varchar(255),
	detection_result varchar(64),
	detection_result_url varchar(1000)
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_food_arrange;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_food_arrange
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	process_id varchar(100),
	driver_id bigint,
	driver_reserve_id bigint,
	car_id bigint,
	car_number varchar(100),
	biz_type smallint,
	first_arrange_leave_time varchar(20),
	remark varchar(500),
	deleted boolean,
	driver_name varchar(255),
	driver_reserve_name varchar(255),
	process_name varchar(255),
	second_arrange_leave_time varchar(20),
	third_arrange_leave_time varchar(20),
	first_exe_status smallint,
	second_exe_status smallint,
	third_exe_status smallint,
	earlier_time integer,
	enabled boolean,
	line_id bigint,
	line_name varchar(1000),
	arrange_leave_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_food_receive;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_food_receive
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	space_id bigint,
	process_instance_id varchar(100),
	security_id bigint,
	security_name varchar(50),
	deleted boolean,
	space_name varchar(100),
	receive_food_time timestamp
);
drop table if exists dev_bigdata_bio_antiasf.ods_bio_food_send;
create table if not exists dev_bigdata_bio_antiasf.ods_bio_food_send
(
	id bigint not null
			primary key,
	create_user varchar(500),
	create_time timestamp,
	modify_user varchar(500),
	modify_time timestamp,
	app_id bigint,
	tenant_id bigint,
	process_instance_id varchar(100),
	space_id bigint,
	space_name varchar(100),
	deleted boolean,
	scan_code_time timestamp
);
