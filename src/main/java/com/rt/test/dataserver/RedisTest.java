package com.rt.test.dataserver;


public class RedisTest {

   /* Jedis jedis = RedisPool.getInstance().getJedis();

    @Test
    public void testShow() {

        Set<String> keys = jedis.keys("*");
        for (String key:keys) {
            System.out.println(key);
        }

    }

    @Test
    public void test() {
        // 添加数据
        for (int i = 0;i < 100;i++) {
            for (int j = 0;j < 100;j++) {
                jedis.lpush("test_" + i,"testData_" + j);
            }
        }

        long start = System.currentTimeMillis();
        // 删除数据
        jedis.lrem("test_100",1,"testData_50");
        long end = System.currentTimeMillis();
        System.out.println(end - start);
    }

    @Test
    public void testList() {
        List<String> lrange = jedis.lrange("test_13",0,-1);
        System.out.println(lrange);
    }

    @Test
    public void testTime() {
        // 构造2万条线索
        List<String> clueModels = new ArrayList<String>();
        for (int i = 0;i < 20000;i++) {

            clueModels.add("测试-" + i);
        }
        // 构造100个条数据
        // 添加数据
        
         * for (int i = 0;i < 100;i++) { for (int j = 0;j < 100;j++) {
         * jedis.lpush("data_"+i,"测试-" + j); } }
         
        // 比对
        long pre = System.currentTimeMillis();

        // 从redis里面取list
            List<String> urls = jedis.lrange("test_13",0,-1);
            for (int i = 0;i < 100;i++) {
                String url = urls.get(i);
                for (int j = 0;j < 20000;j++) {
                    String clueCode = clueModels.get(j);
                    //if (url.contains(clueCode)) {
                        System.out.println(url);
                    //}
                }
            }
        System.out.println(System.currentTimeMillis() - pre);
    }
    */
    // 测试一个线程往redis里面塞数据，一个线程从redis里面取数据进行线索比对
    // 比对结果存储到告警表
}
