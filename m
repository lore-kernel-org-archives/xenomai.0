MIME-Version: 1.0
Date: Sun, 6 Jul 2014 12:19:48 +0800
Message-ID: <CABqyFP_DMH3t3Dp+AZPzXHXQb_j_VHkAjMMuBeLJ-5BTPPfk4g@mail.gmail.com>
From: Ruika You <crazylinuxcnc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Latency can be negative ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,
I build xenomai 2.6.3 base on ipipe stable 3.14.0 as linux kernel in my
i386 PC. Everything seems work well, until i try to test latency. It is
quite strange when negative  value occur. Any idea? My test result as
follow:
~/ sudo /usr/xemai/bin/latency -T 25
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|     -1.071|      5.432|     16.586|       0|     0|     -1.071|
16.586
RTD|     -1.070|      5.011|     16.319|       0|     0|     -1.071|
16.586
RTD|     -1.049|      7.018|     17.541|       0|     0|     -1.071|
17.541
RTD|     -1.062|      4.744|     14.313|       0|     0|     -1.071|
17.541
RTD|     -1.056|      1.428|     18.174|       0|     0|     -1.071|
18.174
RTD|     -1.056|      1.532|     17.110|       0|     0|     -1.071|
18.174
RTD|     -1.063|      7.057|     16.202|       0|     0|     -1.071|
18.174
RTD|     -1.071|      5.558|     15.868|       0|     0|     -1.071|
18.174
RTD|     -1.049|      6.770|     16.422|       0|     0|     -1.071|
18.174
RTD|     -1.060|      4.163|     16.869|       0|     0|     -1.071|
18.174
RTD|     -0.642|      6.926|     19.265|       0|     0|     -1.071|
19.265
RTD|     -1.004|      7.261|     16.229|       0|     0|     -1.071|
19.265
RTD|     -0.669|      6.799|     13.354|       0|     0|     -1.071|
19.265
RTD|     -1.048|      6.923|     18.178|       0|     0|     -1.071|
19.265
RTD|     -1.063|      0.958|     14.334|       0|     0|     -1.071|
19.265
RTD|     -1.056|      1.346|     18.233|       0|     0|     -1.071|
19.265
RTD|     -0.606|      6.773|     17.621|       0|     0|     -1.071|
19.265
RTD|     -0.695|      7.141|     22.111|       0|     0|     -1.071|
22.111
RTD|     -1.078|      4.893|     12.838|       0|     0|     -1.078|
22.111
RTD|     -1.038|      8.287|     19.084|       0|     0|     -1.078|
22.111
RTD|     -1.061|      1.977|     14.817|       0|     0|     -1.078|
22.111
RTT|  00:00:23  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|     -1.071|      3.479|     17.803|       0|     0|     -1.078|
22.111
RTD|     -0.342|      6.817|     14.638|       0|     0|     -1.078|
22.111
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -1.078|      5.143|     22.111|       0|     0|
00:00:25/00:00:25

Thanks!
Best regards!
Chengxi
