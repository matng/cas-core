insert into module values(1,'menu','菜单管理','菜单管理',1,1),
						 (2,'cms','内容管理','内容管理',2,1),
						 (3,'res','资源管理','资源管理',3,1),
						 (4,'power','权限管理','权限管理',4,1),
						 (5,'sys','系统管理','系统管理',5,1);
/* 内容管理 */
set @contentModuleId = 2;
/*资源管理*/
set @resModuleId = 3;
/*权限管理*/
set @roleModuleId = 4;
/*系统管理*/
set @sysModuleId = 5;

/*内容管理*/
insert into menu values (null,@contentModuleId,'company','公司动态',0,null,null,null,0,0),
(null,@contentModuleId,'news','行业新闻',0,null,null,null,0,0),
(null,@contentModuleId,'ser','服务',0,null,null,null,0,0),
(null,@contentModuleId,'pro','产品',0,null,null,null,0,0);

/*资源管理*/
insert into menu values (null,@resModuleId,'gallery','图片',0,null,null,null,0,0),
(null,@resModuleId,'flash','FLASH',0,null,null,null,0,0),
(null,@resModuleId,'video','影音',0,null,null,null,0,0),
(null,@resModuleId,'file','文件',0,null,null,null,0,0);

/*权限管理*/
insert into menu values (null,@roleModuleId,'role','角色管理',0,null,null,null,0,0);

/*系统管理*/
insert into menu values (null,@sysModuleId,'module','模块管理',0,null,null,null,0,0),
(null,@sysModuleId,'submenu','菜单管理',0,null,null,null,0,0),
(null,@sysModuleId,'tmp','模板管理',0,null,null,null,0,0),
(null,@sysModuleId,'user','用户管理',0,null,null,null,0,0),
(null,@sysModuleId,'link','友情链接',0,null,null,null,0,0),
(null,@sysModuleId,'log','日志管理',0,null,null,null,0,0);

select id into @roleResourceId from menu where menuCode='role';

insert into user values(null,'admin','0d9ca2c1f411d35d456187f7bd8223f77bb809528532987e4e74f890','admin','男','13800000000','matng@139.com',1);
insert into userrole value(null,1,1);
insert into role values(null,'管理员','系统管理',1);
insert into power values(null,'admin',1,'power',1,1),
						(null,'admin',1,'role:r',@roleResourceId,1),
						(null,'admin',1,'role:c',@roleResourceId,1),
						(null,'admin',1,'role:u',@roleResourceId,1),
						(null,'admin',1,'role:d',@roleResourceId,1);
