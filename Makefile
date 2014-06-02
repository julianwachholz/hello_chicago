
PROJECT = hello_chicago

DEPS = boss bcrypt cb_admin
dep_boss = https://github.com/ChicagoBoss/ChicagoBoss.git master
dep_bcrypt = https://github.com/opscode/erlang-bcrypt.git master
dep_cb_admin = https://github.com/ChicagoBoss/cb_admin.git master

include erlang.mk
