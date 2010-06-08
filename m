MIME-Version: 1.0
In-Reply-To: <AANLkTilFOvO35eIb2FTbNDwaM6NmoyovMQRQzJFgvoaW@mail.gmail.com>
References: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>
	<4C0CA863.9000304@domain.hid>
	<AANLkTikBDx1yyP8FNq630jRJvbYTPurM0GFggHkg3T2Z@mail.gmail.com>
	<4C0CF184.1010306@domain.hid>
	<AANLkTilFOvO35eIb2FTbNDwaM6NmoyovMQRQzJFgvoaW@mail.gmail.com>
Date: Tue, 8 Jun 2010 10:46:19 +0800
Message-ID: <AANLkTimOs2xET0UQd7G5tXpTsab1GLWdD3qLi51MBqfI@mail.gmail.com>
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

Hi Wolfgang,

I overlooked the irq thing. If I look at the /proc/xenomai/irq
I see this when cross-link is not running:
everett@domain.hid$ cat irq
everett@domain.hid$ cat irq
IRQ         CPU0
300:       11671         [timer]
322:           0         [virtual]

when cross-link is running:
everett@domain.hid$ cat irq
IRQ         CPU0
  3:        1320         rtser1
  4:         165         rtser0
300:       14785         [timer]
322:         500         [virtual]
The IRQ 3 and 4 numbers are increasing rapidly. So it seems to be
working fine. What a normal time lag is expect between write
and read for X86 machine?

Thanks,

Everett

On Tue, Jun 8, 2010 at 9:32 AM, Everett Wang <everteq@domain.hid> wrote:
> Hi Wolfgang,
>
> Thanks for your quick email. :-)
>
> On Mon, Jun 7, 2010 at 9:17 PM, Wolfgang Grandegger <wg@domain.hid> w=
rote:
>> On 06/07/2010 02:07 PM, Everett Wang wrote:
>>> I am so glad that Wolfgang is able to help giving suggestions. Thanks
>>> a lot. That is very useful for new users. :-)
>>>
>>> On Mon, Jun 7, 2010 at 4:05 PM, Wolfgang Grandegger <wg@domain.hid>=
 wrote:
>>>> On 06/05/2010 04:22 AM, Everett Wang wrote:
>>>>> Hi All,
>>>>>
>>>>> I am playing around with xenomai and RTDM serial driver on a
>>>>> 1.7Ghz Pentium-M machine running xenomai 2.5.3. The example cross-lin=
k
>>>>> produced this result:
>>>>>
>>>>> main : starting read-task
>>>>> =A0Nr | =A0 write->irq =A0 =A0| =A0 =A0irq->read =A0 =A0| =A0 write->=
read =A0 |
>>>>> -----------------------------------------------------------
>>>>> =A0 0 | =A0 =A0 =A0 =A0 =A0118948 | =A0 =A0 =A0 =A0 =A0614135 | =A0 =
=A0 =A0 =A0 =A0733083
>>>>> =A0 1 | =A0 =A0 =A0 =A0 =A0115598 | =A0 =A0 =A0 =A0 =A0614281 | =A0 =
=A0 =A0 =A0 =A0729879
>>>>> =A0 2 | =A0 =A0 =A0 =A0 =A0108917 | =A0 =A0 =A0 =A0 =A0614982 | =A0 =
=A0 =A0 =A0 =A0723899
>>>>> =A0 3 | =A0 =A0 =A0 =A0 =A0106101 | =A0 =A0 =A0 =A0 =A0616560 | =A0 =
=A0 =A0 =A0 =A0722661
>>>>> =A0 4 | =A0 =A0 =A0 =A0 =A0113457 | =A0 =A0 =A0 =A0 =A0614971 | =A0 =
=A0 =A0 =A0 =A0728428
>>>>> =A0 5 | =A0 =A0 =A0 =A0 =A0110358 | =A0 =A0 =A0 =A0 =A0614265 | =A0 =
=A0 =A0 =A0 =A0724623
>>>>> =A0 6 | =A0 =A0 =A0 =A0 =A0106499 | =A0 =A0 =A0 =A0 =A0614406 | =A0 =
=A0 =A0 =A0 =A0720905
>>>>> =A0 7 | =A0 =A0 =A0 =A0 =A0110363 | =A0 =A0 =A0 =A0 =A0615015 | =A0 =
=A0 =A0 =A0 =A0725378
>>>>> =A0 8 | =A0 =A0 =A0 =A0 =A0115478 | =A0 =A0 =A0 =A0 =A0614840 | =A0 =
=A0 =A0 =A0 =A0730318
>>>>> =A0 9 | =A0 =A0 =A0 =A0 =A0110766 | =A0 =A0 =A0 =A0 =A0614168 | =A0 =
=A0 =A0 =A0 =A0724934
>>>>> =A010 | =A0 =A0 =A0 =A0 =A0108986 | =A0 =A0 =A0 =A0 =A0616435 | =A0 =
=A0 =A0 =A0 =A0725421
>>>>> =A011 | =A0 =A0 =A0 =A0 =A0108030 | =A0 =A0 =A0 =A0 =A0614299 | =A0 =
=A0 =A0 =A0 =A0722329
>>>>> =A012 | =A0 =A0 =A0 =A0 =A0109369 | =A0 =A0 =A0 =A0 =A0614420 | =A0 =
=A0 =A0 =A0 =A0723789
>>>>> =A013 | =A0 =A0 =A0 =A0 =A0105862 | =A0 =A0 =A0 =A0 =A0614456 | =A0 =
=A0 =A0 =A0 =A0720318
>>>>> =A014 | =A0 =A0 =A0 =A0 =A0110428 | =A0 =A0 =A0 =A0 =A0616301 | =A0 =
=A0 =A0 =A0 =A0726729
>>>>>
>>>>> Is 0.7 millisecond between write and read a reasonable number?
>>>>
>>>> No, at least not for a baudrate of 115200. Does the "latency" test
>>>> report reasonable latency figures? And how did you load xeno_16550A.ko=
?
>>>>
>>> The latency test seems very reasonable:
>>> 4 microseconds when I try to open several browers at the
>>> same time:
>>>
>>> mini:/usr/xenomai/share/xenomai/testsuite/klatency# ./run
>>> *
>>> *
>>> * Type ^C to stop this application.
>>> *
>>> *
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: in-kernel periodic task
>>> =3D=3D All results in microseconds
>>> warming up...
>>> RTT| =A000:00:01 =A0(in-kernel periodic task, 100 us period, priority 9=
9)
>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
>>> RTD| =A0 =A0 =A0-0.722| =A0 =A0 =A0-0.618| =A0 =A0 =A0 0.755| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.755
>>> RTD| =A0 =A0 =A0-0.721| =A0 =A0 =A0-0.616| =A0 =A0 =A0 0.803| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.803
>>> RTD| =A0 =A0 =A0-0.708| =A0 =A0 =A0-0.616| =A0 =A0 =A0 0.876| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.876
>>> RTD| =A0 =A0 =A0-0.722| =A0 =A0 =A0-0.616| =A0 =A0 =A0 0.854| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.876
>>> RTD| =A0 =A0 =A0-0.708| =A0 =A0 =A0-0.617| =A0 =A0 =A0 0.954| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.954
>>> RTD| =A0 =A0 =A0-0.709| =A0 =A0 =A0-0.615| =A0 =A0 =A0 0.682| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.722| =A0 =A0 =A0 0.954
>>> RTD| =A0 =A0 =A0-0.724| =A0 =A0 =A0-0.595| =A0 =A0 =A0 0.918| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.724| =A0 =A0 =A0 0.954
>>> RTD| =A0 =A0 =A0-0.728| =A0 =A0 =A0-0.477| =A0 =A0 =A0 2.785| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.728| =A0 =A0 =A0 2.785
>>> RTD| =A0 =A0 =A0-0.725| =A0 =A0 =A0-0.526| =A0 =A0 =A0 2.721| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.728| =A0 =A0 =A0 2.785
>>> RTD| =A0 =A0 =A0-0.729| =A0 =A0 =A0-0.512| =A0 =A0 =A0 2.609| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 2.785
>>> RTD| =A0 =A0 =A0-0.726| =A0 =A0 =A0-0.485| =A0 =A0 =A0 4.483| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.726| =A0 =A0 =A0-0.479| =A0 =A0 =A0 4.142| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.723| =A0 =A0 =A0-0.542| =A0 =A0 =A0 2.735| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.728| =A0 =A0 =A0-0.580| =A0 =A0 =A0 1.896| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.728| =A0 =A0 =A0-0.540| =A0 =A0 =A0 2.196| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.726| =A0 =A0 =A0-0.566| =A0 =A0 =A0 1.831| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.711| =A0 =A0 =A0-0.607| =A0 =A0 =A0 1.768| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.712| =A0 =A0 =A0-0.591| =A0 =A0 =A0 1.050| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.721| =A0 =A0 =A0-0.615| =A0 =A0 =A0 1.116| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.712| =A0 =A0 =A0-0.612| =A0 =A0 =A0 0.694| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> RTD| =A0 =A0 =A0-0.721| =A0 =A0 =A0-0.614| =A0 =A0 =A0 0.782| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> ^CRTT| =A000:00:22 =A0(in-kernel periodic task, 100 us period, priority=
 99)
>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
>>> RTD| =A0 =A0 =A0-0.724| =A0 =A0 =A0-0.610| =A0 =A0 =A0 1.213| =A0 =A0 =
=A0 0| =A0 =A0 =A0-0.729| =A0 =A0 =A0 4.483
>>> ---|------------|------------|------------|--------|-------------------=
------
>>> RTS| =A0 =A0 =A0-0.729| =A0 =A0 =A0-0.554| =A0 =A0 =A0 4.483| =A0 =A0 =
=A0 0| =A0 =A000:00:24/00:00:24
>>> mini:/usr/xenomai/share/xenomai/testsuite/klatency#
>>>
>>> The user space latency is also reasonable at 10 microseconds:
>>> mini:/usr/xenomai/share/xenomai/testsuite/latency# ./run
>>> *
>>> *
>>> * Type ^C to stop this application.
>>> *
>>> *
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: periodic user-mode task
>>> =3D=3D All results in microseconds
>>> warming up...
>>> RTT| =A000:00:01 =A0(periodic user-mode task, 100 us period, priority 9=
9)
>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--l=
at worst
>>> RTD| =A0 =A0 =A00.245| =A0 =A0 =A00.391| =A0 =A0 =A02.736| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.245| =A0 =A0 =A02.736
>>> RTD| =A0 =A0 =A00.132| =A0 =A0 =A00.663| =A0 =A0 =A07.012| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 =A07.012
>>> RTD| =A0 =A0 =A00.248| =A0 =A0 =A00.871| =A0 =A0 =A06.954| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 =A07.012
>>> RTD| =A0 =A0 =A00.245| =A0 =A0 =A00.650| =A0 =A0 =A05.741| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 =A07.012
>>> RTD| =A0 =A0 =A00.213| =A0 =A0 =A01.009| =A0 =A0 10.657| =A0 =A0 =A0 0|=
 =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.247| =A0 =A0 =A00.902| =A0 =A0 =A08.936| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.177| =A0 =A0 =A00.776| =A0 =A0 =A06.978| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.246| =A0 =A0 =A00.735| =A0 =A0 =A07.571| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.245| =A0 =A0 =A00.918| =A0 =A0 =A08.821| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.132| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.127| =A0 =A0 =A00.387| =A0 =A0 =A03.423| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.127| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.138| =A0 =A0 =A00.429| =A0 =A0 =A02.977| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.127| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.096| =A0 =A0 =A00.357| =A0 =A0 =A03.100| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.096| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.133| =A0 =A0 =A00.357| =A0 =A0 =A03.019| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.096| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.132| =A0 =A0 =A00.356| =A0 =A0 =A02.246| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.096| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.140| =A0 =A0 =A00.382| =A0 =A0 =A05.711| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.096| =A0 =A0 10.657
>>> RTD| =A0 =A0 =A00.131| =A0 =A0 =A00.361| =A0 =A0 =A02.041| =A0 =A0 =A0 =
0| =A0 =A0 0| =A0 =A0 =A00.096| =A0 =A0 10.657
>>> ^C---|-----------|-----------|-----------|--------|------|-------------=
------------
>>> RTS| =A0 =A0 =A00.096| =A0 =A0 =A00.596| =A0 =A0 10.657| =A0 =A0 =A0 0|=
 =A0 =A0 0| =A0 =A000:00:16/00:00:16
>>> mini:/usr/xenomai/share/xenomai/testsuite/latency#
>>>
>>> I load driver using this before running cross-link examples:
>>>
>>> setserial /dev/ttyS0 uart none
>>> setserial /dev/ttyS1 uart none
>>> insmod /lib/modules/2.6.32.11-xeno/kernel/drivers/xenomai/serial/xeno_1=
6550A.ko
>>> io=3D0x3f8,0x2f8 irq=3D4,3 tx_fifo=3D10,20 start_index=3D0
>>
>> Are the interrupts shared with some other devices. What does
>> /proc/interrupt show when you run the test? Also, the default tx_fifo
>> should be fine. And what does "setserial -G /dev/ttyS0" list before you
>> disable the device (with "uart none").
>>
>
> I look at the bios setting. All irqs are set automatically. Window
> setup indicated no conflict of IRQs. But dmesg has this:
>
> =A0[ =A0 =A00.356143] Serial: 8250/16550 driver, 4 ports, IRQ sharing ena=
bled
> [ =A0 =A00.356143] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [ =A0 =A00.356143] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> [ =A0 =A00.359109] 00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [ =A0 =A00.359263] 00:08: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
>
> I guess the IRQ is shared with something else. But I can't finger our
> what else is using IRQ 3 and 4. The computer has only two serial
> ports.
>
> setserial -G has this:
>
> # =A0setserial -G /dev/ttyS0
> /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal skip=
_test
> # setserial -G /dev/ttyS1
> /dev/ttyS1 uart 16550A port 0x02f8 irq 3 baud_base 115200 spd_normal skip=
_test
>
> Now I load xeno_16550A.ko with default fifo.
> I also looked at the /proc/interrupt file
> during running of the cross-link
> everett@domain.hid$ cat interrupts
> =A0 =A0 =A0 =A0 =A0 CPU0
> =A00: =A0 =A0 =A018169 =A0 IO-APIC-edge =A0 =A0 =A0timer
> =A01: =A0 =A0 =A0 1492 =A0 IO-APIC-edge =A0 =A0 =A0i8042
> =A03: =A0 =A0 =A0 =A0 10 =A0 IO-APIC-edge
> =A04: =A0 =A0 =A0 =A0 =A09 =A0 IO-APIC-edge
> =A07: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge =A0 =A0 =A0parport0
> =A08: =A0 =A0 =A0 =A0 =A02 =A0 IO-APIC-edge =A0 =A0 =A0rtc0
> =A09: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 acpi
> =A010: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge =A0 =A0 =A0MPU401 UART
> =A014: =A0 =A0 =A0 7835 =A0 IO-APIC-edge =A0 =A0 =A0ide0
> =A015: =A0 =A0 =A0 6662 =A0 IO-APIC-edge =A0 =A0 =A0ide1
> =A016: =A0 =A0 =A0 9665 =A0 IO-APIC-fasteoi =A0 uhci_hcd:usb1, i915@domain.hid=
000:00:02.0
> =A017: =A0 =A0 =A0 =A0 =A01 =A0 IO-APIC-fasteoi =A0 Intel 82801DB-ICH4
> =A018: =A0 =A0 =A028708 =A0 IO-APIC-fasteoi =A0 uhci_hcd:usb4, ipw2200
> =A019: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 uhci_hcd:usb3
> =A020: =A0 =A0 =A0 3660 =A0 IO-APIC-fasteoi =A0 eth0
> =A023: =A0 =A0 =A0 =A0 =A02 =A0 IO-APIC-fasteoi =A0 ehci_hcd:usb2
> NMI: =A0 =A0 =A0 =A0 =A00 =A0 Non-maskable interrupts
> LOC: =A0 =A0 =A072987 =A0 Local timer interrupts
> SPU: =A0 =A0 =A0 =A0 =A00 =A0 Spurious interrupts
> PMI: =A0 =A0 =A0 =A0 =A00 =A0 Performance monitoring interrupts
> PND: =A0 =A0 =A0 =A0 =A00 =A0 Performance pending work
> TRM: =A0 =A0 =A0 =A0 =A00 =A0 Thermal event interrupts
> THR: =A0 =A0 =A0 =A0 =A00 =A0 Threshold APIC interrupts
> MCE: =A0 =A0 =A0 =A0 =A00 =A0 Machine check exceptions
> MCP: =A0 =A0 =A0 =A0 =A03 =A0 Machine check polls
> ERR: =A0 =A0 =A0 =A0 =A00
> MIS: =A0 =A0 =A0 =A0 =A00
>
> I can see IRQ 1, which is used by i8042, as well as local time
> interrupt are increasing. But not IRQ 3 and 4. They are
> not changing during cross-link run.
>
>>>>> I then changed the example a little: I let write task only
>>>>> write 4 characters and instruct read task to read 10 characters.
>>>>> I thought the read task will tell me when that only 4 characters
>>>>> is read. But to my surprise, it waited until write-task
>>>>> filled all 10 characters before finish reading. How can I
>>>>> change the code to just do the read to whatever charaters
>>>>> are avaliable without waiting to fill all the characters I
>>>>> asked for? I will use this capability to read a GPS. It's
>>>>> output length is unknow before reading.
>>>>
>>>> Setting the config rx timeout to RTSER_TIMEOUT_NONE should help.
>>>>
>>> Thanks for the suggestion, I will try that.
> Yes, changing the rx timeout can read 4 characters. That is now working.
>
>>>>> Most GPS can also produce a precisive time pulse when data
>>>>> is ready. Is it be possible to connect this to a pin in rs232 (CTS, f=
or example)
>>>>> to triger a IRQ so the data can be read in a timely manner?
>>>>
>>>> That depends on the signals, I can imagine. I'm not a hardware guy but=
 I
>>>> know that many GPS receiver come with a read-to-use RS232 interface.
>>>>
>>>> Wolfgang.
>>>>
>>> Yes, you are right. My GPS has a rs232 port and I am trying
>>> to use it. The GPS just dump out some information to the
>>> rs232 port every 0.1 second. I am just trying to get the information
>>> in a timely fashion. I thought that the extra time
>>> pulse from the GPS can help.
>>
>> Just reading out the received data should be fine. They will generate an
>> interrupt anyway.
>>
>> Wolfgang.
>>
> That is great. If I can get this serial IRQ to work, I don't have to
> deal with the time pulse signal. The original idea is from a book. It
> states that GPS precision time pulse should be used to drive data
> acquisition action.
>
> Thanks a lot.
>
> Everett
>

