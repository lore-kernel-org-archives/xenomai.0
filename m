Message-ID: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
Date: Thu, 20 Jul 2006 23:17:08 +0200
From: "Julien Heyman" <bidsonux@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30163_7538881.1153430228917"
Subject: [Xenomai-help] Beginner's question / testsuite / latency
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

------=_Part_30163_7538881.1153430228917
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am currently trying to evaluate Xenomai, and my current setup is :
VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
When I run the latency part of the testsuite (in a console under KDE), I get
results that I cannot understand, so I probably did something wrong
(execution trace included below).
I get reasonable values during the first seconds, then all of a sudden
latencies begin to rise, continuously, to very large values.
- I did check that DMA transfer is activated on my HD.
- I did select "Enable SMI workaround" + "Globally disable SMI" in the
Xenomai
options while configuring the kernel.
- I have disabled power management at BIOS level and disabled ACPI support
and
CPU frequency scaling during kernel configuration.
- I checked that I don't have anything called "legacy USB" in my BIOS. I do
have an "OnChip USB" option enable in the BIOS though.

Any advice would be appreciated !

Thanks
Julien Heyman


*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       6.209|       8.110|      17.561|       0|       6.209|
17.561
RTD|       6.348|       8.131|      17.861|       0|       6.209|
17.861
RTD|       6.625|       8.121|      17.154|       0|       6.209|
17.861
RTD|       4.170|       8.033|      15.746|       0|       4.170|
17.861
RTD|       5.984|       8.341|      16.936|       0|       4.170|
17.861
RTD|       6.292|       8.142|      18.502|       0|       4.170|
18.502
RTD|       6.359|       8.117|      17.467|       0|       4.170|
18.502
RTD|       6.326|       8.125|      16.633|       0|       4.170|
18.502
RTD|       6.277|       8.121|      17.071|       0|       4.170|
18.502
RTD|       6.228|       8.123|      16.869|       0|       4.170|
18.502
RTD|       6.543|       8.129|      15.752|       0|       4.170|
18.502
RTD|       3.975|       8.016|      20.269|       0|       3.975|
20.269
RTD|       6.489|       8.344|      17.735|       0|       3.975|
20.269
RTD|       6.359|       8.123|      19.026|       0|       3.975|
20.269
RTD|       6.470|       8.119|      16.908|       0|       3.975|
20.269
RTD|       6.517|       8.114|      16.339|       0|       3.975|
20.269
RTD|       6.498|       8.125|      17.992|       0|       3.975|
20.269
RTD|       6.341|       8.129|      15.409|       0|       3.975|
20.269
RTD|       4.222|       8.076|      15.973|       0|       3.975|
20.269
RTD|       3.846|       8.144|      16.597|       0|       3.846|
20.269
RTD|       6.537|       8.269|      17.257|       0|       3.846|
20.269
RTT|  00:00:22  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       6.507|       8.127|      17.570|       0|       3.846|
20.269
RTD|       6.425|       8.117|      16.685|       0|       3.846|
20.269
RTD|       6.468|       8.123|      16.136|       0|       3.846|
20.269
RTD|       6.539|       8.116|      15.332|       0|       3.846|
20.269
RTD|       6.288|       8.123|      16.475|       0|       3.846|
20.269
RTD|       3.956|       8.003|      16.638|       0|       3.846|
20.269
RTD|       6.369|       8.348|      23.399|       0|       3.846|
23.399
RTD|       6.717|       8.078|      20.682|       0|       3.846|
23.399
RTD|       6.476|       8.074|      15.698|       0|       3.846|
23.399
RTD|       6.684|      98.523|     197.536|       1|       3.846|
197.536
RTD|     106.358|     108.116|     195.011|       1|       3.846|
197.536
RTD|     106.977|     379.307|     425.585|       4|       3.846|
425.585
RTD|     407.091|    -125.220|     719.171|       7|       3.846|
719.171
RTD|     704.716|     174.537|    1039.347|      10|       3.846|
1039.347
RTD|    1006.644|     383.889|    1264.521|      12|       3.846|
1264.521
RTD|    1206.574|    -131.780|    1524.619|      15|       3.846|
1524.619
RTD|    1506.889|     347.804|    2016.462|      20|       3.846|
2016.462
RTD|    2006.521|    -227.764|    2289.891|      22|       3.846|
2289.891
RTD|    2207.046|      61.305|    2584.121|      25|       3.846|
2584.121
RTD|    2506.565|     361.086|    2812.531|      28|       3.846|
2812.531
RTD|    2807.104|    -233.460|    3108.830|      30|       3.846|
3108.830
RTT|  00:00:43  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|    3004.451|      55.669|    3335.249|      33|       3.846|
3335.249
RTD|    3306.822|    -365.740|    3778.314|      37|       3.846|
3778.314
RTD|    3706.558|     -50.325|    4051.165|      40|       3.846|
4051.165
RTD|    4006.912|     249.305|    4374.872|      43|       3.846|
4374.872
RTD|    4306.933|    -256.007|    4646.662|      46|       3.846|
4646.662
RTD|    4607.066|      43.525|    4948.757|      49|       3.846|
4948.757
RTD|    4906.711|    -373.215|    5318.661|      53|       3.846|
5318.661
RTD|    5306.813|      25.979|    5796.758|      57|       3.846|
5796.758
RTD|    5706.867|     337.037|    6031.390|      60|       3.846|
6031.390
---|------------|------------|------------|--------|-------------------------
RTS|       3.846|      21.697|    6031.390|      60|    00:00:51/00:00:51

------=_Part_30163_7538881.1153430228917
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am currently trying to evaluate Xenomai, and my current setup is :<br>VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.<br>I am using Xenomai-2.1.0 over a <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://2.6.17.4/" target="_blank">
2.6.17.4</a> kernel.<br>When I run the latency part of the testsuite (in a console under KDE), I get<br>results that I cannot understand, so I probably did something wrong<br>(execution trace included below).<br>I get reasonable values during the first seconds, then all of a sudden
<br>latencies begin to rise, continuously, to very large values.<br>- I did check that DMA transfer is activated on my HD.<br>- I did select &quot;Enable SMI workaround&quot; + &quot;Globally disable SMI&quot; in the Xenomai
<br>options while configuring the kernel.<br>- I have disabled power management at BIOS level and disabled ACPI support and<br>CPU frequency scaling during kernel configuration.<br>- I checked that I don't have anything called &quot;legacy USB&quot; in my BIOS. I do
<br>have an &quot;OnChip USB&quot; option enable in the BIOS though.<br><br>Any advice would be appreciated !<br><br>Thanks<br>Julien Heyman<br><br><br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Sampling period: 100 us
<br>== Test mode: periodic user-mode task<br>== All results in microseconds<br>warming up...<br>RTT| &nbsp;00:00:01 &nbsp;(periodic user-mode task, 100 us period)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
<br>RTD| &nbsp; &nbsp; &nbsp; 6.209| &nbsp; &nbsp; &nbsp; 8.110| &nbsp; &nbsp; &nbsp;17.561| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 6.209| &nbsp; &nbsp; &nbsp;17.561<br>RTD| &nbsp; &nbsp; &nbsp; 6.348| &nbsp; &nbsp; &nbsp; 8.131| &nbsp; &nbsp; &nbsp;17.861| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 6.209| &nbsp; &nbsp; &nbsp;17.861<br>RTD| &nbsp; &nbsp; &nbsp; 6.625| &nbsp; &nbsp; &nbsp; 8.121| &nbsp; &nbsp; &nbsp;17.154| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 
6.209| &nbsp; &nbsp; &nbsp;17.861<br>RTD| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp; 8.033| &nbsp; &nbsp; &nbsp;15.746| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;17.861<br>RTD| &nbsp; &nbsp; &nbsp; 5.984| &nbsp; &nbsp; &nbsp; 8.341| &nbsp; &nbsp; &nbsp;16.936| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;17.861<br>RTD| &nbsp; &nbsp; &nbsp; 6.292| &nbsp; &nbsp; &nbsp; 8.142| &nbsp; &nbsp; &nbsp;18.502|
 &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 6.359| &nbsp; &nbsp; &nbsp; 8.117| &nbsp; &nbsp; &nbsp;17.467| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 6.326| &nbsp; &nbsp; &nbsp; 8.125| &nbsp; &nbsp; &nbsp;16.633| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 6.277| &nbsp; &nbsp; &nbsp; 
8.121| &nbsp; &nbsp; &nbsp;17.071| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 6.228| &nbsp; &nbsp; &nbsp; 8.123| &nbsp; &nbsp; &nbsp;16.869| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 6.543| &nbsp; &nbsp; &nbsp; 8.129| &nbsp; &nbsp; &nbsp;15.752| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 4.170| &nbsp; &nbsp; &nbsp;18.502<br>RTD| &nbsp; &nbsp; &nbsp; 
3.975| &nbsp; &nbsp; &nbsp; 8.016| &nbsp; &nbsp; &nbsp;20.269| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.489| &nbsp; &nbsp; &nbsp; 8.344| &nbsp; &nbsp; &nbsp;17.735| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.359| &nbsp; &nbsp; &nbsp; 8.123| &nbsp; &nbsp; &nbsp;19.026| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;
20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.470| &nbsp; &nbsp; &nbsp; 8.119| &nbsp; &nbsp; &nbsp;16.908| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.517| &nbsp; &nbsp; &nbsp; 8.114| &nbsp; &nbsp; &nbsp;16.339| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.498| &nbsp; &nbsp; &nbsp; 8.125| &nbsp; &nbsp; &nbsp;17.992| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 
3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.341| &nbsp; &nbsp; &nbsp; 8.129| &nbsp; &nbsp; &nbsp;15.409| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 4.222| &nbsp; &nbsp; &nbsp; 8.076| &nbsp; &nbsp; &nbsp;15.973| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.975| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp; 8.144| &nbsp; &nbsp; &nbsp;16.597|
 &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.537| &nbsp; &nbsp; &nbsp; 8.269| &nbsp; &nbsp; &nbsp;17.257| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTT| &nbsp;00:00:22 &nbsp;(periodic user-mode task, 100 us period)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
<br>RTD| &nbsp; &nbsp; &nbsp; 6.507| &nbsp; &nbsp; &nbsp; 8.127| &nbsp; &nbsp; &nbsp;17.570| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.425| &nbsp; &nbsp; &nbsp; 8.117| &nbsp; &nbsp; &nbsp;16.685| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.468| &nbsp; &nbsp; &nbsp; 8.123| &nbsp; &nbsp; &nbsp;16.136| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 
3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.539| &nbsp; &nbsp; &nbsp; 8.116| &nbsp; &nbsp; &nbsp;15.332| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.288| &nbsp; &nbsp; &nbsp; 8.123| &nbsp; &nbsp; &nbsp;16.475| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 3.956| &nbsp; &nbsp; &nbsp; 8.003| &nbsp; &nbsp; &nbsp;16.638|
 &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;20.269<br>RTD| &nbsp; &nbsp; &nbsp; 6.369| &nbsp; &nbsp; &nbsp; 8.348| &nbsp; &nbsp; &nbsp;23.399| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;23.399<br>RTD| &nbsp; &nbsp; &nbsp; 6.717| &nbsp; &nbsp; &nbsp; 8.078| &nbsp; &nbsp; &nbsp;20.682| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;23.399<br>RTD| &nbsp; &nbsp; &nbsp; 6.476| &nbsp; &nbsp; &nbsp; 
8.074| &nbsp; &nbsp; &nbsp;15.698| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;23.399<br>RTD| &nbsp; &nbsp; &nbsp; 6.684| &nbsp; &nbsp; &nbsp;98.523| &nbsp; &nbsp; 197.536| &nbsp; &nbsp; &nbsp; 1| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; 197.536<br>RTD| &nbsp; &nbsp; 106.358| &nbsp; &nbsp; 108.116| &nbsp; &nbsp; 195.011| &nbsp; &nbsp; &nbsp; 1| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; 197.536<br>RTD| &nbsp; &nbsp; 
106.977| &nbsp; &nbsp; 379.307| &nbsp; &nbsp; 425.585| &nbsp; &nbsp; &nbsp; 4| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; 425.585<br>RTD| &nbsp; &nbsp; 407.091| &nbsp; &nbsp;-125.220| &nbsp; &nbsp; 719.171| &nbsp; &nbsp; &nbsp; 7| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; 719.171<br>RTD| &nbsp; &nbsp; 704.716| &nbsp; &nbsp; 174.537| &nbsp; &nbsp;1039.347| &nbsp; &nbsp; &nbsp;10| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;
1039.347<br>RTD| &nbsp; &nbsp;1006.644| &nbsp; &nbsp; 383.889| &nbsp; &nbsp;1264.521| &nbsp; &nbsp; &nbsp;12| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;1264.521<br>RTD| &nbsp; &nbsp;1206.574| &nbsp; &nbsp;-131.780| &nbsp; &nbsp;1524.619| &nbsp; &nbsp; &nbsp;15| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;1524.619<br>RTD| &nbsp; &nbsp;1506.889| &nbsp; &nbsp; 347.804| &nbsp; &nbsp;2016.462| &nbsp; &nbsp; &nbsp;20| &nbsp; &nbsp; &nbsp; 
3.846| &nbsp; &nbsp;2016.462<br>RTD| &nbsp; &nbsp;2006.521| &nbsp; &nbsp;-227.764| &nbsp; &nbsp;2289.891| &nbsp; &nbsp; &nbsp;22| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;2289.891<br>RTD| &nbsp; &nbsp;2207.046| &nbsp; &nbsp; &nbsp;61.305| &nbsp; &nbsp;2584.121| &nbsp; &nbsp; &nbsp;25| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;2584.121<br>RTD| &nbsp; &nbsp;2506.565| &nbsp; &nbsp; 361.086| &nbsp; &nbsp;2812.531|
 &nbsp; &nbsp; &nbsp;28| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;2812.531<br>RTD| &nbsp; &nbsp;2807.104| &nbsp; &nbsp;-233.460| &nbsp; &nbsp;3108.830| &nbsp; &nbsp; &nbsp;30| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;3108.830<br>RTT| &nbsp;00:00:43 &nbsp;(periodic user-mode task, 100 us period)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
<br>RTD| &nbsp; &nbsp;3004.451| &nbsp; &nbsp; &nbsp;55.669| &nbsp; &nbsp;3335.249| &nbsp; &nbsp; &nbsp;33| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;3335.249<br>RTD| &nbsp; &nbsp;3306.822| &nbsp; &nbsp;-365.740| &nbsp; &nbsp;3778.314| &nbsp; &nbsp; &nbsp;37| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;3778.314<br>RTD| &nbsp; &nbsp;3706.558| &nbsp; &nbsp; -50.325| &nbsp; &nbsp;4051.165| &nbsp; &nbsp; &nbsp;40| &nbsp; &nbsp; &nbsp; 
3.846| &nbsp; &nbsp;4051.165<br>RTD| &nbsp; &nbsp;4006.912| &nbsp; &nbsp; 249.305| &nbsp; &nbsp;4374.872| &nbsp; &nbsp; &nbsp;43| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;4374.872<br>RTD| &nbsp; &nbsp;4306.933| &nbsp; &nbsp;-256.007| &nbsp; &nbsp;4646.662| &nbsp; &nbsp; &nbsp;46| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;4646.662<br>RTD| &nbsp; &nbsp;4607.066| &nbsp; &nbsp; &nbsp;43.525| &nbsp; &nbsp;4948.757|
 &nbsp; &nbsp; &nbsp;49| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;4948.757<br>RTD| &nbsp; &nbsp;4906.711| &nbsp; &nbsp;-373.215| &nbsp; &nbsp;5318.661| &nbsp; &nbsp; &nbsp;53| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;5318.661<br>RTD| &nbsp; &nbsp;5306.813| &nbsp; &nbsp; &nbsp;25.979| &nbsp; &nbsp;5796.758| &nbsp; &nbsp; &nbsp;57| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;5796.758<br>RTD| &nbsp; &nbsp;5706.867| &nbsp; &nbsp; 
337.037| &nbsp; &nbsp;6031.390| &nbsp; &nbsp; &nbsp;60| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp;6031.390<br>---|------------|------------|------------|--------|-------------------------<br>RTS| &nbsp; &nbsp; &nbsp; 3.846| &nbsp; &nbsp; &nbsp;21.697| &nbsp; &nbsp;6031.390| &nbsp; &nbsp; &nbsp;60| &nbsp; &nbsp;00:00:51/00:00:51<br>

------=_Part_30163_7538881.1153430228917--

