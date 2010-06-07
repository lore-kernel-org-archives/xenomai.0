Message-ID: <4C0CF184.1010306@domain.hid>
Date: Mon, 07 Jun 2010 15:17:56 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>	<4C0CA863.9000304@domain.hid>
	<AANLkTikBDx1yyP8FNq630jRJvbYTPurM0GFggHkg3T2Z@mail.gmail.com>
In-Reply-To: <AANLkTikBDx1yyP8FNq630jRJvbYTPurM0GFggHkg3T2Z@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM rs232 strange behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

On 06/07/2010 02:07 PM, Everett Wang wrote:
> I am so glad that Wolfgang is able to help giving suggestions. Thanks
> a lot. That is very useful for new users. :-)
> 
> On Mon, Jun 7, 2010 at 4:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> On 06/05/2010 04:22 AM, Everett Wang wrote:
>>> Hi All,
>>>
>>> I am playing around with xenomai and RTDM serial driver on a
>>> 1.7Ghz Pentium-M machine running xenomai 2.5.3. The example cross-link
>>> produced this result:
>>>
>>> main : starting read-task
>>>  Nr |   write->irq    |    irq->read    |   write->read   |
>>> -----------------------------------------------------------
>>>   0 |          118948 |          614135 |          733083
>>>   1 |          115598 |          614281 |          729879
>>>   2 |          108917 |          614982 |          723899
>>>   3 |          106101 |          616560 |          722661
>>>   4 |          113457 |          614971 |          728428
>>>   5 |          110358 |          614265 |          724623
>>>   6 |          106499 |          614406 |          720905
>>>   7 |          110363 |          615015 |          725378
>>>   8 |          115478 |          614840 |          730318
>>>   9 |          110766 |          614168 |          724934
>>>  10 |          108986 |          616435 |          725421
>>>  11 |          108030 |          614299 |          722329
>>>  12 |          109369 |          614420 |          723789
>>>  13 |          105862 |          614456 |          720318
>>>  14 |          110428 |          616301 |          726729
>>>
>>> Is 0.7 millisecond between write and read a reasonable number?
>>
>> No, at least not for a baudrate of 115200. Does the "latency" test
>> report reasonable latency figures? And how did you load xeno_16550A.ko?
>>
> The latency test seems very reasonable:
> 4 microseconds when I try to open several browers at the
> same time:
> 
> mini:/usr/xenomai/share/xenomai/testsuite/klatency# ./run
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      -0.722|      -0.618|       0.755|       0|      -0.722|       0.755
> RTD|      -0.721|      -0.616|       0.803|       0|      -0.722|       0.803
> RTD|      -0.708|      -0.616|       0.876|       0|      -0.722|       0.876
> RTD|      -0.722|      -0.616|       0.854|       0|      -0.722|       0.876
> RTD|      -0.708|      -0.617|       0.954|       0|      -0.722|       0.954
> RTD|      -0.709|      -0.615|       0.682|       0|      -0.722|       0.954
> RTD|      -0.724|      -0.595|       0.918|       0|      -0.724|       0.954
> RTD|      -0.728|      -0.477|       2.785|       0|      -0.728|       2.785
> RTD|      -0.725|      -0.526|       2.721|       0|      -0.728|       2.785
> RTD|      -0.729|      -0.512|       2.609|       0|      -0.729|       2.785
> RTD|      -0.726|      -0.485|       4.483|       0|      -0.729|       4.483
> RTD|      -0.726|      -0.479|       4.142|       0|      -0.729|       4.483
> RTD|      -0.723|      -0.542|       2.735|       0|      -0.729|       4.483
> RTD|      -0.728|      -0.580|       1.896|       0|      -0.729|       4.483
> RTD|      -0.728|      -0.540|       2.196|       0|      -0.729|       4.483
> RTD|      -0.726|      -0.566|       1.831|       0|      -0.729|       4.483
> RTD|      -0.711|      -0.607|       1.768|       0|      -0.729|       4.483
> RTD|      -0.712|      -0.591|       1.050|       0|      -0.729|       4.483
> RTD|      -0.721|      -0.615|       1.116|       0|      -0.729|       4.483
> RTD|      -0.712|      -0.612|       0.694|       0|      -0.729|       4.483
> RTD|      -0.721|      -0.614|       0.782|       0|      -0.729|       4.483
> ^CRTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      -0.724|      -0.610|       1.213|       0|      -0.729|       4.483
> ---|------------|------------|------------|--------|-------------------------
> RTS|      -0.729|      -0.554|       4.483|       0|    00:00:24/00:00:24
> mini:/usr/xenomai/share/xenomai/testsuite/klatency#
> 
> The user space latency is also reasonable at 10 microseconds:
> mini:/usr/xenomai/share/xenomai/testsuite/latency# ./run
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|      0.245|      0.391|      2.736|       0|     0|      0.245|      2.736
> RTD|      0.132|      0.663|      7.012|       0|     0|      0.132|      7.012
> RTD|      0.248|      0.871|      6.954|       0|     0|      0.132|      7.012
> RTD|      0.245|      0.650|      5.741|       0|     0|      0.132|      7.012
> RTD|      0.213|      1.009|     10.657|       0|     0|      0.132|     10.657
> RTD|      0.247|      0.902|      8.936|       0|     0|      0.132|     10.657
> RTD|      0.177|      0.776|      6.978|       0|     0|      0.132|     10.657
> RTD|      0.246|      0.735|      7.571|       0|     0|      0.132|     10.657
> RTD|      0.245|      0.918|      8.821|       0|     0|      0.132|     10.657
> RTD|      0.127|      0.387|      3.423|       0|     0|      0.127|     10.657
> RTD|      0.138|      0.429|      2.977|       0|     0|      0.127|     10.657
> RTD|      0.096|      0.357|      3.100|       0|     0|      0.096|     10.657
> RTD|      0.133|      0.357|      3.019|       0|     0|      0.096|     10.657
> RTD|      0.132|      0.356|      2.246|       0|     0|      0.096|     10.657
> RTD|      0.140|      0.382|      5.711|       0|     0|      0.096|     10.657
> RTD|      0.131|      0.361|      2.041|       0|     0|      0.096|     10.657
> ^C---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|      0.096|      0.596|     10.657|       0|     0|    00:00:16/00:00:16
> mini:/usr/xenomai/share/xenomai/testsuite/latency#
> 
> I load driver using this before running cross-link examples:
> 
> setserial /dev/ttyS0 uart none
> setserial /dev/ttyS1 uart none
> insmod /lib/modules/2.6.32.11-xeno/kernel/drivers/xenomai/serial/xeno_16550A.ko
> io=0x3f8,0x2f8 irq=4,3 tx_fifo=10,20 start_index=0

Are the interrupts shared with some other devices. What does
/proc/interrupt show when you run the test? Also, the default tx_fifo
should be fine. And what does "setserial -G /dev/ttyS0" list before you
disable the device (with "uart none").

>>> I then changed the example a little: I let write task only
>>> write 4 characters and instruct read task to read 10 characters.
>>> I thought the read task will tell me when that only 4 characters
>>> is read. But to my surprise, it waited until write-task
>>> filled all 10 characters before finish reading. How can I
>>> change the code to just do the read to whatever charaters
>>> are avaliable without waiting to fill all the characters I
>>> asked for? I will use this capability to read a GPS. It's
>>> output length is unknow before reading.
>>
>> Setting the config rx timeout to RTSER_TIMEOUT_NONE should help.
>>
> Thanks for the suggestion, I will try that.
> 
>>> Most GPS can also produce a precisive time pulse when data
>>> is ready. Is it be possible to connect this to a pin in rs232 (CTS, for example)
>>> to triger a IRQ so the data can be read in a timely manner?
>>
>> That depends on the signals, I can imagine. I'm not a hardware guy but I
>> know that many GPS receiver come with a read-to-use RS232 interface.
>>
>> Wolfgang.
>>
> Yes, you are right. My GPS has a rs232 port and I am trying
> to use it. The GPS just dump out some information to the
> rs232 port every 0.1 second. I am just trying to get the information
> in a timely fashion. I thought that the extra time
> pulse from the GPS can help.

Just reading out the received data should be fine. They will generate an
interrupt anyway.

Wolfgang.

