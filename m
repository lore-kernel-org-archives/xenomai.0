Message-ID: <4784BCDD.9000404@domain.hid>
Date: Wed, 09 Jan 2008 13:23:57 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <f8f856500801070737s2934e741i99717c5b2a2d3d88@domain.hid>	
	<47827A59.1050806@domain.hid>
	<f8f856500801090304l13ffa333p53a35f82cc8ed957@domain.hid>
In-Reply-To: <f8f856500801090304l13ffa333p53a35f82cc8ed957@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai latency tests on MPC8xx
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: fabien <fabien.fb@domain.hid>
Cc: xenomai@xenomai.org

fabien wrote:
> Hello, first thank for your advices Wolfgang.
> 
> 2008/1/7, Wolfgang Grandegger <wg@domain.hid>:
>> fabien wrote:
>>> Here, there is some xenomai tests on a MPC855T, could you comment
>>> these results please ?
>>> Are they correct ?
[...deletions...]
> First, it's nice to see that all tests passed without oops, system hang
>> or large latency figures. Your results are reasonable for your test
>> scenario. I remember similar results on my TQM860L module under Linux
>> 2.4.25. Your target is a very low-end PowerPC system with little cache
>> (min latency is rather close to max latency) and it's already a pain to
>> run Linux 2.6 on it. But you should apply more load and run the test
>> much longer to get realistic worst case latency figures, which are
>> likely higher then the values listed above. I usually use "while ls; do
>> ls; done" in a telnet window, "ping -f <host-ip>" and the cache
>> calibrator to produce high load. And do not forget to add "cat
>> /proc/xenomai/latency" to the above figures.
>>
>> Wolfgang,
>>
>>
> 
> I did the same test with :
> a ping -f
> telnet session : while ls; do ls; done
> and a dd if=/dev/zero of=/dev/null
> 
> And i got the following results :
> ./latency -t0 -p1000 -T500
> RTS|      86.400|     131.200|     229.440|       0|    00:08:21/00:08:20
> 
> # cat /proc/xenomai/latency
> 4160
> 
> ./latency -t1 -p1000 -T500
> RTS|      63.040|      92.998|     180.480|       0|    00:08:21/00:08:20
> 
> ./latency -t2 -p1000 -T500
> RTS|      20.480|      36.130|     123.200|       0|    00:08:21/00:08:20
> 
> # ./cyclictest -t5 -l 30000 -q
> T: 0 (  563) P:99 I:    1000 C:   30000 Min:      97 Act:     142 Avg:
>     150 Max:     216
> T: 1 (  564) P:98 I:    1500 C:   30000 Min:      95 Act:     142 Avg:
>     228 Max:     574
> T: 2 (  565) P:97 I:    2000 C:   30000 Min:     102 Act:     141 Avg:
>     335 Max:     776
> T: 3 (  566) P:96 I:    2500 C:   30000 Min:      96 Act:     138 Avg:
>     303 Max:     964
> T: 4 (  567) P:95 I:    3000 C:   30000 Min:     123 Act:     143 Avg:
>     481 Max:    1458
> 
> # ./switchbench -n100000 -p 1000
> == Sampling period: 1000 us
> == Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|     140.480|     176.000|     276.480|           0
> 
> # ./switchtest -T30 -n
> == Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
> RTT|  00:00:03
> RTH|ctx switches|-------total
> RTD|         666|         666
> RTD|           3|         669
> RTD|          15|         684
> RTD|          12|         696
> 
> I think the tests are correct ?

Yes, and the results are reasonable, apart from the last one...

> exept for the latter that is catastrophic .... just when i applied the ping -f
> What do you think about this results ?

... likely because the system is overloaded with 30 tasks.

Wolfgang.

