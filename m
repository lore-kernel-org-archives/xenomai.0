Message-ID: <COL105-W19CEDDAC71AEB3BEEE7B54C3480@domain.hid>
Content-Type: multipart/alternative;
	boundary="_6def1dfd-c298-4928-a954-a1cded6877f4_"
From: =?gb2312?B?19Mg0KE=?= <hapcobot@domain.hid>
Date: Wed, 17 Feb 2010 19:27:23 +0800
In-Reply-To: <mailman.63.1266404417.13819.xenomai@xenomai.org>
References: <mailman.63.1266404417.13819.xenomai@xenomai.org>
MIME-Version: 1.0
Subject: [Xenomai-help] How to solve this high latency problem
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

--_6def1dfd-c298-4928-a954-a1cded6877f4_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi, 

after I installed the xenomai-2.5.1 with kernel 2.6.32.7, I ran the latency test program at  
/usr/xenomai/share/xenomai/testsuite/latency

below is what I got. High latency (about 400 microseconds for max latency) is present.

Basically, in my configuration, I have disabled ACPI, APM, and CPU frequency scaling;
enalbed "Enable periodic timing", "Enable FPU support", and "Enable NMI watchdog".

I know that SMI workaround is important here. So I also enabled "Enable SMI workaround". Regarding "Globally disable SMI", I tried many times and found that if I enabled it, my laptop cannot boot up... Thus I have to keep it disabled, while I did not enable any other SMI options below "Globally disable SMI" in the configuration menu.

Now I am stuck here, not able to find out the solution to the problem. Could you help on this?

Another question I would like to ask: in the result of my latency test, what is the difference between "lat max" and "lat worst"? because the numbers shown there are different.

Best Regards,
Henry


== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.848|      1.020|    358.154|       3|     0|      0.848|    358.154
RTD|      0.749|      0.983|     15.540|       3|     0|      0.749|    358.154
RTD|      0.785|      1.017|    369.927|       6|     0|      0.749|    369.927
RTD|      0.745|      0.986|     11.431|       6|     0|      0.745|    369.927
RTD|      0.745|      1.014|    376.297|       9|     0|      0.745|    376.297
RTD|      0.778|      0.979|     15.137|       9|     0|      0.745|    376.297
RTD|      0.540|      1.020|    385.877|      12|     0|      0.540|    385.877
RTD|      0.842|      1.002|     11.561|      12|     0|      0.540|    385.877
RTD|      0.748|      1.014|    391.803|      15|     0|      0.540|    391.803
RTD|      0.784|      0.976|     16.482|      15|     0|      0.540|    391.803
RTD|      0.840|      1.015|    403.156|      19|     0|      0.540|    403.156
RTD|      0.583|      0.997|     16.902|      19|     0|      0.540|    403.156
RTD|      0.846|      1.029|    314.282|      22|     0|      0.540|    403.156
RTD|      0.723|      0.975|     14.964|      22|     0|      0.540|    403.156
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      0.540|      1.001|    403.156|      22|     0|    00:00:14/00:00:14

 		 	   		  
_________________________________________________________________
Hotmail: Trusted email with powerful SPAM protection.
https://signup.live.com/signup.aspx?id=60969
--_6def1dfd-c298-4928-a954-a1cded6877f4_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
Hi, <br><br>after I installed the xenomai-2.5.1 with kernel 2.6.32.7, I ran the latency test program at&nbsp; <br>/usr/xenomai/share/xenomai/testsuite/latency<br><br>below is what I got. High latency (about 400 microseconds for max latency) is present.<br><br>Basically, in my configuration, I have disabled ACPI, APM, and CPU frequency scaling;<br>enalbed "Enable periodic timing", "Enable FPU support", and "Enable NMI watchdog".<br><br>I know that SMI workaround is important here. So I also enabled "Enable SMI workaround". Regarding "Globally disable SMI", I tried many times and found that if I enabled it, my laptop cannot boot up... Thus I have to keep it disabled, while I did not enable any other SMI options below "Globally disable SMI" in the configuration menu.<br><br>Now I am stuck here, not able to find out the solution to the problem. Could you help on this?<br><br>Another question I would like to ask: in the result of my latency test, what is the difference between "lat max" and "lat worst"? because the numbers shown there are different.<br><br>Best Regards,<br>Henry<br><br><br>== Sampling period: 100 us<br>== Test mode: periodic user-mode task<br>== All results in microseconds<br>warming up...<br>RTT|&nbsp; 00:00:01&nbsp; (periodic user-mode task, 100 us period, priority 99)<br>RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.848|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.020|&nbsp;&nbsp;&nbsp; 358.154|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.848|&nbsp;&nbsp;&nbsp; 358.154<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.749|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.983|&nbsp;&nbsp;&nbsp;&nbsp; 15.540|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.749|&nbsp;&nbsp;&nbsp; 358.154<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.785|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.017|&nbsp;&nbsp;&nbsp; 369.927|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.749|&nbsp;&nbsp;&nbsp; 369.927<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.745|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.986|&nbsp;&nbsp;&nbsp;&nbsp; 11.431|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.745|&nbsp;&nbsp;&nbsp; 369.927<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.745|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.014|&nbsp;&nbsp;&nbsp; 376.297|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.745|&nbsp;&nbsp;&nbsp; 376.297<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.778|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.979|&nbsp;&nbsp;&nbsp;&nbsp; 15.137|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.745|&nbsp;&nbsp;&nbsp; 376.297<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.020|&nbsp;&nbsp;&nbsp; 385.877|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 385.877<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.842|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.002|&nbsp;&nbsp;&nbsp;&nbsp; 11.561|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 385.877<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.748|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.014|&nbsp;&nbsp;&nbsp; 391.803|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 391.803<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.784|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.976|&nbsp;&nbsp;&nbsp;&nbsp; 16.482|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 391.803<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.840|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.015|&nbsp;&nbsp;&nbsp; 403.156|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 403.156<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.583|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.997|&nbsp;&nbsp;&nbsp;&nbsp; 16.902|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 403.156<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.846|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.029|&nbsp;&nbsp;&nbsp; 314.282|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 403.156<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.723|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.975|&nbsp;&nbsp;&nbsp;&nbsp; 14.964|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp; 403.156<br>^C---|-----------|-----------|-----------|--------|------|-------------------------<br>RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.540|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.001|&nbsp;&nbsp;&nbsp; 403.156|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; 00:00:14/00:00:14<br><br> 		 	   		  <br /><hr />Hotmail: Trusted email with powerful SPAM protection. <a href='https://signup.live.com/signup.aspx?id=60969' target='_new'>Sign up now.</a></body>
</html>
--_6def1dfd-c298-4928-a954-a1cded6877f4_--

