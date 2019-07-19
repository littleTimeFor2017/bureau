package com.lixc.bureau.util;

import lombok.Data;

/**
 * 返回结果标准类
 */
@Data
public class Json  implements java.io.Serializable{

    private  static final long serialVersionUID = -6448049639282426090L;

    private  boolean success;

    private Object object;

    private String message;
}
