package com.hxzy.pojo;

import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Component;

@Component
public class Msg
{
    private int code;
    private String message;
    private PageInfo pageInfo;

    public int getCode()
    {
        return code;
    }

    public void setCode(int code)
    {
        this.code = code;
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public PageInfo getPageInfo()
    {
        return pageInfo;
    }

    public void setPageInfo(PageInfo pageInfo)
    {
        this.pageInfo = pageInfo;
    }

    @Override
    public String toString()
    {
        return "Msg{" + "code=" + code + ", message='" + message + '\'' + ", pageInfo=" + pageInfo + '}';
    }
}
