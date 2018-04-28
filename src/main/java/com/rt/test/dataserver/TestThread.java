package com.rt.test.dataserver;

import java.io.UnsupportedEncodingException;

public class TestThread extends Thread {

    private int i;

    public TestThread(int i) {
        this.i = i;
    }

    @Override
    public void run() {
        try {
            if (i % 250 == 0) {
                MacOnlineTest.url();
            } else {
                MacOnlineTest.url2();
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
