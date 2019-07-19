package com.lixc.bureau.entity;

import lombok.Data;

@Data
public class User {

    private Integer id;

    private String userName;

    private String password;

    /**
     * 所属部门的ID
     */
    private int depId;

    private String dep_name;

    private String role_name;


}
