package com.hxzy.utils;

import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class JedisUtil
{
    private static JedisPool pool;
    static {


        //读取配置文件信息
        InputStream in = JedisUtil.class.getClassLoader().getResourceAsStream("jedis.properties");
        Properties properties = new Properties();
        try
        {
            properties.load(in);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }


        //配置redis缓冲池
        GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
        poolConfig.setMaxIdle(30);
        poolConfig.setMaxTotal(50);
        poolConfig.setMinIdle(10);

        pool  = new JedisPool(poolConfig,properties.getProperty("redis.uri"),Integer.parseInt(properties.getProperty("redis.port")));

    }

    public static Jedis getJedis()
    {
        return pool.getResource();
    }

}
