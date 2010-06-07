MIME-Version: 1.0
In-Reply-To: <4C0CA863.9000304@domain.hid>
References: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>
	<4C0CA863.9000304@domain.hid>
Date: Mon, 7 Jun 2010 20:07:58 +0800
Message-ID: <AANLkTikBDx1yyP8FNq630jRJvbYTPurM0GFggHkg3T2Z@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

I am so glad that Wolfgang is able to help giving suggestions. Thanks
a lot. That is very useful for new users. :-)

On Mon, Jun 7, 2010 at 4:05 PM, Wolfgang Grandegger <wg@domain.hid> wro=
te:
> On 06/05/2010 04:22 AM, Everett Wang wrote:
>> Hi All,
>>
>> I am playing around with xenomai and RTDM serial driver on a
>> 1.7Ghz Pentium-M machine running xenomai 2.5.3. The example cross-link
>> produced this result:
>>
>> main : starting read-task
>> =A0Nr | =A0 write->irq =A0 =A0| =A0 =A0irq->read =A0 =A0| =A0 write->rea=
d =A0 |
>> -----------------------------------------------------------
>> =A0 0 | =A0 =A0 =A0 =A0 =A0118948 | =A0 =A0 =A0 =A0 =A0614135 | =A0 =A0 =
=A0 =A0 =A0733083
>> =A0 1 | =A0 =A0 =A0 =A0 =A0115598 | =A0 =A0 =A0 =A0 =A0614281 | =A0 =A0 =
=A0 =A0 =A0729879
>> =A0 2 | =A0 =A0 =A0 =A0 =A0108917 | =A0 =A0 =A0 =A0 =A0614982 | =A0 =A0 =
=A0 =A0 =A0723899
>> =A0 3 | =A0 =A0 =A0 =A0 =A0106101 | =A0 =A0 =A0 =A0 =A0616560 | =A0 =A0 =
=A0 =A0 =A0722661
>> =A0 4 | =A0 =A0 =A0 =A0 =A0113457 | =A0 =A0 =A0 =A0 =A0614971 | =A0 =A0 =
=A0 =A0 =A0728428
>> =A0 5 | =A0 =A0 =A0 =A0 =A0110358 | =A0 =A0 =A0 =A0 =A0614265 | =A0 =A0 =
=A0 =A0 =A0724623
>> =A0 6 | =A0 =A0 =A0 =A0 =A0106499 | =A0 =A0 =A0 =A0 =A0614406 | =A0 =A0 =
=A0 =A0 =A0720905
>> =A0 7 | =A0 =A0 =A0 =A0 =A0110363 | =A0 =A0 =A0 =A0 =A0615015 | =A0 =A0 =
=A0 =A0 =A0725378
>> =A0 8 | =A0 =A0 =A0 =A0 =A0115478 | =A0 =A0 =A0 =A0 =A0614840 | =A0 =A0 =
=A0 =A0 =A0730318
>> =A0 9 | =A0 =A0 =A0 =A0 =A0110766 | =A0 =A0 =A0 =A0 =A0614168 | =A0 =A0 =
=A0 =A0 =A0724934
>> =A010 | =A0 =A0 =A0 =A0 =A0108986 | =A0 =A0 =A0 =A0 =A0616435 | =A0 =A0 =
=A0 =A0 =A0725421
>> =A011 | =A0 =A0 =A0 =A0 =A0108030 | =A0 =A0 =A0 =A0 =A0614299 | =A0 =A0 =
=A0 =A0 =A0722329
>> =A012 | =A0 =A0 =A0 =A0 =A0109369 | =A0 =A0 =A0 =A0 =A0614420 | =A0 =A0 =
=A0 =A0 =A0723789
>> =A013 | =A0 =A0 =A0 =A0 =A0105862 | =A0 =A0 =A0 =A0 =A0614456 | =A0 =A0 =
=A0 =A0 =A0720318
>> =A014 | =A0 =A0 =A0 =A0 =A0110428 | =A0 =A0 =A0 =A0 =A0616301 | =A0 =A0 =
=A0 =A0 =A0726729
>>
>> Is 0.7 millisecond between write and read a reasonable number?
>
> No, at least not for a baudrate of 115200. Does the "latency" test
> report reasonable latency figures? And how did you load xeno_16550A.ko?
>
The latency test seems very reasonable:
4 microseconds when I try to open several browers at the
same time:

mini:/usr/xenomai/share/xenomai/testsuite/klatency# ./run
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      -0.722|      -0.618|       0.755|       0|      -0.722|       0.7=
55
RTD|      -0.721|      -0.616|       0.803|       0|      -0.722|       0.8=
03
RTD|      -0.708|      -0.616|       0.876|       0|      -0.722|       0.8=
76
RTD|      -0.722|      -0.616|       0.854|       0|      -0.722|       0.8=
76
RTD|      -0.708|      -0.617|       0.954|       0|      -0.722|       0.9=
54
RTD|      -0.709|      -0.615|       0.682|       0|      -0.722|       0.9=
54
RTD|      -0.724|      -0.595|       0.918|       0|      -0.724|       0.9=
54
RTD|      -0.728|      -0.477|       2.785|       0|      -0.728|       2.7=
85
RTD|      -0.725|      -0.526|       2.721|       0|      -0.728|       2.7=
85
RTD|      -0.729|      -0.512|       2.609|       0|      -0.729|       2.7=
85
RTD|      -0.726|      -0.485|       4.483|       0|      -0.729|       4.4=
83
RTD|      -0.726|      -0.479|       4.142|       0|      -0.729|       4.4=
83
RTD|      -0.723|      -0.542|       2.735|       0|      -0.729|       4.4=
83
RTD|      -0.728|      -0.580|       1.896|       0|      -0.729|       4.4=
83
RTD|      -0.728|      -0.540|       2.196|       0|      -0.729|       4.4=
83
RTD|      -0.726|      -0.566|       1.831|       0|      -0.729|       4.4=
83
RTD|      -0.711|      -0.607|       1.768|       0|      -0.729|       4.4=
83
RTD|      -0.712|      -0.591|       1.050|       0|      -0.729|       4.4=
83
RTD|      -0.721|      -0.615|       1.116|       0|      -0.729|       4.4=
83
RTD|      -0.712|      -0.612|       0.694|       0|      -0.729|       4.4=
83
RTD|      -0.721|      -0.614|       0.782|       0|      -0.729|       4.4=
83
^CRTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      -0.724|      -0.610|       1.213|       0|      -0.729|       4.4=
83
---|------------|------------|------------|--------|-----------------------=
--
RTS|      -0.729|      -0.554|       4.483|       0|    00:00:24/00:00:24
mini:/usr/xenomai/share/xenomai/testsuite/klatency#

The user space latency is also reasonable at 10 microseconds:
mini:/usr/xenomai/share/xenomai/testsuite/latency# ./run
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.245|      0.391|      2.736|       0|     0|      0.245|      2=
.736
RTD|      0.132|      0.663|      7.012|       0|     0|      0.132|      7=
.012
RTD|      0.248|      0.871|      6.954|       0|     0|      0.132|      7=
.012
RTD|      0.245|      0.650|      5.741|       0|     0|      0.132|      7=
.012
RTD|      0.213|      1.009|     10.657|       0|     0|      0.132|     10=
.657
RTD|      0.247|      0.902|      8.936|       0|     0|      0.132|     10=
.657
RTD|      0.177|      0.776|      6.978|       0|     0|      0.132|     10=
.657
RTD|      0.246|      0.735|      7.571|       0|     0|      0.132|     10=
.657
RTD|      0.245|      0.918|      8.821|       0|     0|      0.132|     10=
.657
RTD|      0.127|      0.387|      3.423|       0|     0|      0.127|     10=
.657
RTD|      0.138|      0.429|      2.977|       0|     0|      0.127|     10=
.657
RTD|      0.096|      0.357|      3.100|       0|     0|      0.096|     10=
.657
RTD|      0.133|      0.357|      3.019|       0|     0|      0.096|     10=
.657
RTD|      0.132|      0.356|      2.246|       0|     0|      0.096|     10=
.657
RTD|      0.140|      0.382|      5.711|       0|     0|      0.096|     10=
.657
RTD|      0.131|      0.361|      2.041|       0|     0|      0.096|     10=
.657
^C---|-----------|-----------|-----------|--------|------|-----------------=
--------
RTS|      0.096|      0.596|     10.657|       0|     0|    00:00:16/00:00:=
16
mini:/usr/xenomai/share/xenomai/testsuite/latency#

I load driver using this before running cross-link examples:

setserial /dev/ttyS0 uart none
setserial /dev/ttyS1 uart none
insmod /lib/modules/2.6.32.11-xeno/kernel/drivers/xenomai/serial/xeno_16550=
A.ko
io=3D0x3f8,0x2f8 irq=3D4,3 tx_fifo=3D10,20 start_index=3D0



>> I then changed the example a little: I let write task only
>> write 4 characters and instruct read task to read 10 characters.
>> I thought the read task will tell me when that only 4 characters
>> is read. But to my surprise, it waited until write-task
>> filled all 10 characters before finish reading. How can I
>> change the code to just do the read to whatever charaters
>> are avaliable without waiting to fill all the characters I
>> asked for? I will use this capability to read a GPS. It's
>> output length is unknow before reading.
>
> Setting the config rx timeout to RTSER_TIMEOUT_NONE should help.
>
Thanks for the suggestion, I will try that.

>> Most GPS can also produce a precisive time pulse when data
>> is ready. Is it be possible to connect this to a pin in rs232 (CTS, for =
example)
>> to triger a IRQ so the data can be read in a timely manner?
>
> That depends on the signals, I can imagine. I'm not a hardware guy but I
> know that many GPS receiver come with a read-to-use RS232 interface.
>
> Wolfgang.
>
Yes, you are right. My GPS has a rs232 port and I am trying
to use it. The GPS just dump out some information to the
rs232 port every 0.1 second. I am just trying to get the information
in a timely fashion. I thought that the extra time
pulse from the GPS can help.

Thanks a lot again for your help.

Everett

