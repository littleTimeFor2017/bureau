package com.lixc.bureau.entity;

public class Department extends Paginator {
    private int id;

    private  String name;

    /**
     * 签收状态
     * 0：未签收
     * 1：已签收
     */
    private int status;

    /**
     * 是否被文章发布
     */
    private String checked;

    public String isChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
