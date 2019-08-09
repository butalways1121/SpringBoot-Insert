# SpringBoot-Insert
SpringBoot连接数据库并插入数据
## 创建数据库表
在test数据库下新建test表如下,有id和name两个属性，其中id设为自增：
![](https://raw.githubusercontent.com/butalways1121/img-Blog/master/8.png)
<!-- more -->
## 新建项目
Eclipse中创建Maven Project，输入相应的包名及项目名，这里的项目名是Insert，包名为com,接着使用如下代码替换pom.xml里面的内容:
```
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>1.0.0</groupId>
	<artifactId>dms-get-ecall</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>jar</packaging>

	<name>springboot-restful</name>
	<url>http://maven.apache.org</url>

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<java.version>1.7</java.version>
		<mybatis-spring-boot>1.2.0</mybatis-spring-boot>
	</properties>

	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>1.5.9.RELEASE</version>
		<relativePath />
	</parent>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<optional>true</optional>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<!-- Spring Boot Mybatis 依赖 -->
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>${mybatis-spring-boot}</version>
		</dependency>
		<!-- MySQL 连接驱动依赖 -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
		</dependency>
	</dependencies>
	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<fork>true</fork>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>
```
在src/main下新建resources文件夹，新建application.properties文件，将如下内容复制并修改相关信息，主要内容是数据库的连接配置，包括url、数据库用户名、密码和之前创建的数据库表名：
```
banner.charset=UTF-8
server.tomcat.uri-encoding=UTF-8
spring.http.encoding.charset=UTF-8
spring.http.encoding.enabled=true
spring.http.encoding.force=true
spring.messages.encoding=UTF-8

server.port=8083
spring.datasource.url=jdbc:mysql://数据库地址:3306/test?useUnicode=true&characterEncoding=utf8&useSSL=false
spring.datasource.username=数据库用户名
spring.datasource.password=数据库密码
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```
将com.Insert下的App.java代码更新如下：
```
package com.Select;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Hello world!
 *
 */
@SpringBootApplication
public class App 
{
    public static void main( String[] args )
    {
    	SpringApplication.run(App.class, args);
        System.out.println( "Hello World!" );
    }
}

```
创建后的项目结构如下：
![](https://raw.githubusercontent.com/butalways1121/img-Blog/master/9.png)
完成之后右键项目，选择Maven/Update Projects更新项目。
## 创建项目
### entity层
在src/main/java下新建entity包，创建User实体类，该实体类封装的变量对应test数据库表中的属性，代码如下:
```
package com.Insert.entity;


//创建test表对应的实体类
public class User {
	private int id;
	private String name;
	public User(String name2) {
		// TODO Auto-generated constructor stub
		this.name = name2;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
```
### dao层
在src/main/java下新建dao包,新建UserDao接口，实现对数据库的插入操作：
```
package com.Insert.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.Insert.entity.User;

//交给springboot管理的注解
@Repository
public class UserDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
 
	public void Insert(User user) {
		// TODO Auto-generated method stub
		jdbcTemplate.update("insert into test(name) values(?)", user.getName());
	}
}
```
### service层
在src/main/java下新建service包，新建UserService接口，添加要用到的方法：
```
package com.Insert.service;

import com.Insert.entity.User;

public interface UserService {
	void Insert(User user);
}
```
在src/main/java下新建serviceimpl包,新建UserServiceImpl类来实现接口，重写UserService中声明的方法：
```
package com.Insert.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Insert.dao.UserDao;
import com.Insert.entity.User;
import com.Insert.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDao userDao;

	@Override
	public void Insert(User user) {
		// TODO 自动生成的方法存根
		userDao.Insert(user);
	}
	
}
```
### controller层
在src/main/java下新建controller包，新建UserController类来实现调用:
```
package com.Insert.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Insert.entity.User;
import com.Insert.serviceimpl.UserServiceImpl;

@RestController
public class UserController {
	@Autowired
	private UserServiceImpl userservice;
	
	@RequestMapping("/insert")
	public String Insert(String name) {
		User user = new User(name);
		userservice.Insert(user);
		return "insert successfully!";
	}
}
```
***
至此，整个项目已搭建完毕，整体的框架如下：
![](https://raw.githubusercontent.com/butalways1121/img-Blog/master/10.png)
## 测试运行
右键App.java，选择运行方式-Java应用程序，如果控制台会出现Hello World！则表明映射成功，并且能正常运行。然后打开postman设置相关信息如下，点击send之后会成功显示insert successfully！：
![](https://raw.githubusercontent.com/butalways1121/img-Blog/master/11.png)
接着去数据库查看数据是否成功插入（运行了好多次）：
![](https://raw.githubusercontent.com/butalways1121/img-Blog/master/12.png)
***
## OVER！
