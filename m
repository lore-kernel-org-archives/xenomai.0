Message-ID: <4546494d0604191120r75d3d5bbs40e37292121f01ed@domain.hid>
Date: Thu, 20 Apr 2006 02:20:31 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6786_26047250.1145470831028"
Subject: [Xenomai-help] Will Linux kernel lose timer ticks when RT thread is
	running
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_6786_26047250.1145470831028
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hi,

When a real-time thread is running, the Linux kernel will lose Timer Tick
(and lose timer interrupts), is this the expected behavior?
If yes, in this case,  no interrupts will be passed to Linux domain? This
may cause some services depending on timing in Linux domain do not work
correctly. In another thread I read:

"
I do not know if it is what you mean, but when running Xenomai, your
tasks are supposed to suspend sufficiently frequently to leave Linux
tick normally. This means that if you configured CONFIG_HZ=100, your
real-time activity (including kernel-space tasks and user-space tasks in
primary mode) is supposed to take a break at least once every 1/100
second.
--
                                           Gilles Chanteperdrix.
"
Is this the best solution? Since there may be possibility that a real-time
thread keep running for severl hundred ms (e.g, processing large block of
data).


I tried to run a test on Xenomai-2.1.0 on Blackfin. This test looks like:

In a user space RT task (created with rt_task_create()), it does:

"
    read_proc(); // Read "/proc/interrupts" and "/proc/uptime"

    for(;;)
    {

        fprintf(stderr, "+++++++++ start test +++++++++++++++\n");
        read_proc();
        fprintf(stderr, "-------- sleep for 2 sec-----\n");
        sleep(2);
        fprintf(stderr, "-------- start spin ---------\n");
        start_tsc = rt_timer_tsc();

        for (cnt = 0; cnt < 6000; cnt++)
                rt_timer_spin(1000000); // in ns

        diff = rt_timer_tsc() - start_tsc;
        fprintf(stderr, "spin for %d msec\n", rt_timer_tsc2ns(diff) /
1000000);
        read_proc();
        fprintf(stderr, "+++++++++ end test +++++++++++++++++\n");

        getchar();
    }
"

The thread calls rt_timer_spin(), which calls instruction "R0 = 0 (X)"
repeatedly until the specified time is reached. In this case, the thread
spins for 6 seconds.

Here is the test result:

+++++++++ start test +++++++++++++++
-----------------
14:          0   rtc
21:          0   BFIN_UART_RX
22:       5182   BFIN_UART_TX
23:      33531   BFIN Timer Tick
27:       1165   eth0
30:          1   timer_latency
Err:          0

335.41 0.31
-----------------
-------- sleep for 2 sec-----
-------- start spin ---------
spin for 6025 msec
-----------------
14:          0   rtc
21:          0   BFIN_UART_RX
22:       5385   BFIN_UART_TX
23:      33732   BFIN Timer Tick
27:       1165   eth0
30:          1   timer_latency
Err:          0

337.42 0.31
-----------------
+++++++++ end test +++++++++++++++++

>From the test result, " 23:  BFIN Timer Tick", changed from "33531" to
"33732", that is "201 * 10 ＝ 2010 ms". And the "up time" is changed
from "335.41 to 337.42", although in fact that "2 + 6 = 8 sec" has
passed.


Thanks,

-Li Yi (Adam)

------=_Part_6786_26047250.1145470831028
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div id="idOWAReplyText88403" dir="ltr">
<div dir="ltr"><font face="宋体,Simsun" color="#000000" size="2">Hi,</font></div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr"><font size="2">When a real-time thread is running, the Linux kernel will lose Timer Tick (and lose timer interrupts), is this the expected behavior? </font>
<div dir="ltr">&nbsp;</div>
<div dir="ltr"><font size="2">If yes, in this case,&nbsp; no interrupts will be&nbsp;passed to Linux domain? This may cause some services depending on timing in Linux domain do not work correctly. In another thread I read:</font></div>

<div dir="ltr"><font size="2">&nbsp;</font></div>
<div dir="ltr"><font size="2">&quot;</font></div>
<div dir="ltr"><font color="#550055">I do not know if it is what you mean, but when running Xenomai, your<br>tasks are supposed to suspend sufficiently frequently to leave Linux<br>tick normally. This means that if you configured CONFIG_HZ=100, your
<br>real-time activity (including kernel-space tasks and user-space tasks in<br>primary mode) is supposed to take a break at least once every 1/100<br>second.<br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
</font>&nbsp;</div>
<div dir="ltr">&quot;</div>
<div dir="ltr">Is this the best solution? Since there may be possibility that a real-time thread keep running for severl hundred ms (e.g, processing large block of data).</div></div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr"><font face="宋体" size="2">I tried to run a test on Xenomai-2.1.0 on Blackfin. This test looks like:</font></div>
<div dir="ltr"><font face="宋体" size="2"></font>&nbsp;</div>
<div dir="ltr"><font size="2">In a user space RT task (created with rt_task_create()), it does:<br><br>&quot;<br>&nbsp;&nbsp;&nbsp; read_proc(); // Read &quot;/proc/interrupts&quot; and &quot;/proc/uptime&quot;<br><br>&nbsp;&nbsp;&nbsp; for(;;)<br>&nbsp;&nbsp;&nbsp; {
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;+++++++++ start test +++++++++++++++\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_proc();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;-------- sleep for 2 sec-----\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(2);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;-------- start spin ---------\n&quot;);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_tsc = rt_timer_tsc();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cnt = 0; cnt &lt; 6000; cnt++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_timer_spin(1000000); // in ns<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff = rt_timer_tsc() - start_tsc;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;spin for %d msec\n&quot;, rt_timer_tsc2ns(diff) /
<br>1000000);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_proc();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;+++++++++ end test +++++++++++++++++\n&quot;);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; getchar();<br>&nbsp;&nbsp;&nbsp; }<br>&quot;<br><br>The thread calls rt_timer_spin(), which calls instruction &quot;R0 = 0 (X)&quot;
<br>repeatedly until the specified time is reached. In this case, the thread<br>spins for 6 seconds.<br><br>Here is the test result:<br><br>+++++++++ start test +++++++++++++++<br>-----------------<br>14:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; rtc
<br>21:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; BFIN_UART_RX<br>22:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5182&nbsp;&nbsp; BFIN_UART_TX<br>23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33531&nbsp;&nbsp; BFIN Timer Tick<br>27:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1165&nbsp;&nbsp; eth0<br>30:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; timer_latency<br>Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br>335.41 0.31<br>-----------------<br>
-------- sleep for 2 sec-----<br>-------- start spin ---------<br>spin for 6025 msec<br>-----------------<br>14:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; rtc<br>21:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; BFIN_UART_RX<br>22:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5385&nbsp;&nbsp; BFIN_UART_TX<br>23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33732&nbsp;&nbsp; BFIN Timer Tick
<br>27:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1165&nbsp;&nbsp; eth0<br>30:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; timer_latency<br>Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br>337.42 0.31<br>-----------------<br>+++++++++ end test +++++++++++++++++<br><br>From the test result, &quot; 23:&nbsp; BFIN Timer Tick&quot;, changed from &quot;33531&quot; to
<br>&quot;33732&quot;, that is &quot;201 * 10 ＝ 2010 ms&quot;. And the &quot;up time&quot; is changed<br>from &quot;335.41 to 337.42&quot;, although in fact that &quot;2 + 6 = 8 sec&quot; has<br>passed.<br><br></font></div>

<div dir="ltr">&nbsp;</div>
<div dir="ltr"><font size="2">Thanks,</font></div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr"><font size="2">-Li Yi (Adam)</font>&nbsp;</div></div><br><br>

------=_Part_6786_26047250.1145470831028--

