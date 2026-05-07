
create database sample_db --To create db

use sample_db --to use any db

alter database sample_db --to rename db name
modify name = new_db;

alter database sample_db -- changing database mode
set readonly

drop database sample_db --to drop database

alter database sample_db --to drop that db which is in use
set single_user
with rollback immediate;
drop database sample_db

