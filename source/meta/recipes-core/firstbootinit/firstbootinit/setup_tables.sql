-- start of file (setup_tables.sql) --

-----------------------------
-- device_up (uplink data) --
-----------------------------

create table device_up (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	frequency bigint not null,
	dr smallint not null,
	adr boolean not null,
	f_cnt bigint not null,
	f_port smallint not null,
	tags hstore not null,
	data bytea not null,
	rx_info jsonb not null,
	object jsonb not null
);

create index idx_device_up_received_at on device_up(received_at);
create index idx_device_up_dev_eui on device_up(dev_eui);
create index idx_device_up_application_id on device_up(application_id);
create index idx_device_up_frequency on device_up(frequency);
create index idx_device_up_dr on device_up(dr);
create index idx_device_up_tags on device_up(tags);


-----------------------------------
-- device_status (device status) --
-----------------------------------

create table device_status (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	margin smallint not null,
	external_power_source boolean not null,
	battery_level_unavailable boolean not null,
	battery_level numeric(5, 2) not null,
	tags hstore not null
);

create index idx_device_status_received_at on device_status(received_at);
create index idx_device_status_dev_eui on device_status(dev_eui);
create index idx_device_status_application_id on device_status(application_id);
create index idx_device_status_tags on device_status(tags);


------------------------
-- device_join (join) --
------------------------

create table device_join (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	dev_addr bytea not null,
	tags hstore not null
);

create index idx_device_join_received_at on device_join(received_at);
create index idx_device_join_dev_eui on device_join(dev_eui);
create index idx_device_join_application_id on device_join(application_id);
create index idx_device_join_tags on device_join(tags);


----------------------
-- device_ack (ACK) --
----------------------

create table device_ack (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	acknowledged boolean not null,
	f_cnt bigint not null,
	tags hstore not null
);

create index idx_device_ack_received_at on device_ack(received_at);
create index idx_device_ack_dev_eui on device_ack(dev_eui);
create index idx_device_ack_application_id on device_ack(application_id);
create index idx_device_ack_tags on device_ack(tags);


--------------------------
-- device_error (Error) --
--------------------------

create table device_error (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	type varchar(100) not null,
	error text not null,
	f_cnt bigint not null,
	tags hstore not null
);

create index idx_device_error_received_at on device_error(received_at);
create index idx_device_error_dev_eui on device_error(dev_eui);
create index idx_device_error_application_id on device_error(application_id);
create index idx_device_error_tags on device_error(tags);


--------------------------------
-- device_location (Location) --
--------------------------------

create table device_location (
	id uuid primary key,
	received_at timestamp with time zone not null,
	dev_eui bytea not null,
	device_name varchar(100) not null,
	application_id bigint not null,
	application_name varchar(100) not null,
	altitude double precision not null,
	latitude double precision not null,
	longitude double precision not null,
	geohash varchar(12) not null,
	tags hstore not null,

	-- this field is currently not populated
	accuracy smallint not null
);

create index idx_device_location_received_at on device_location(received_at);
create index idx_device_location_dev_eui on device_location(dev_eui);
create index idx_device_location_application_id on device_location(application_id);
create index idx_device_location_tags on device_location(tags);

-----------------------------------------------------------------
-- grant all privileges to chirpstack_as_events on every table --
-----------------------------------------------------------------

grant all privileges on table device_up to chirpstack_as_events;
grant all privileges on table device_status to chirpstack_as_events;
grant all privileges on table device_join to chirpstack_as_events;
grant all privileges on table device_ack to chirpstack_as_events;
grant all privileges on table device_error to chirpstack_as_events;
grant all privileges on table device_location to chirpstack_as_events;

-- end of file (setup_tables.sql) --
