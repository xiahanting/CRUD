import com.hxzy.utils.JedisUtil;
import org.junit.Test;
import redis.clients.jedis.Jedis;

public class TestJedis
{
    @Test
    public void test()
    {
        Jedis jedis = JedisUtil.getJedis();

        jedis.set("we","大佬");
        System.out.println(jedis.get("we"));

    }
}
