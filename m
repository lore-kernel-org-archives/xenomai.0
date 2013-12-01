MIME-Version: 1.0
In-Reply-To: <CAB8-diJhHwSrKa1zYmSCGowOXVN_Rb2e2wPU0WkkLR+29pgV1g@mail.gmail.com>
References: <CAB8-diJhHwSrKa1zYmSCGowOXVN_Rb2e2wPU0WkkLR+29pgV1g@mail.gmail.com>
Date: Sun, 1 Dec 2013 20:36:35 +0800
Message-ID: <CAB8-diLQdOUdk88=hJxwp6Vu+tFZn1r0hwBSwrXsYBKBWh=1Ow@mail.gmail.com>
From: sf sdf <amfarmr@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fail to load the xeno_16550A real time serial port
 driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry for the mistake,

/sbin/modprobe xeno_16550A io=0x070  irq=61 start_index=0 baud_base=115200
/sbin/modprobe xeno_16550A mem=0x481a8000 irq=61 baud_base=115200

should be placed with

/sbin/modprobe xeno_16550A io=0x150  irq=90 start_index=0 baud_base=115200
/sbin/modprobe xeno_16550A mem=0x48024000 irq=90 baud_base=115200

and the errors remained unchanged.


2013/12/1 sf sdf <amfarmr@gmail.com>

> Hello,
>
> I am using debian(3.8.13xenomai-bone28) on Beaglebone Black. I got some
> errors in loading the xeno_16550A real time serial port driver on
> Beaglebone Black.
>
> dmesg|grep tty
>
>> [    0.000000] Kernel command line: console=ttyO0,115200n8
>> capemgr.enable_partno=BB-UART1,BB-UART2,BB-UART5,BB-SPIDEV0,BB-SPIDEV1,BB-CANBUS1
>> root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait fixrtc ip=
>> [    0.880381] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a
>> OMAP UART0
>> [    1.689899] console [ttyO0] enabled
>> [    2.583705] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 89) is a
>> OMAP UART1
>> [    2.700468] 48024000.serial: ttyO2 at MMIO 0x48024000 (irq = 90) is a
>> OMAP UART2
>> [    2.824139] 481aa000.serial: ttyO5 at MMIO 0x481aa000 (irq = 62) is a
>> OMAP UART5
>
>
> According to the information above, uart2's mmio is 0x48024000 and irq =
> 90.
>
> From other documentations, I found this definition:
>
> Pin Name         DT Offset
> UART2_TXD    0x154
> UART2_RXD    0x150
>
>
> Then I execute some commands below according to
> http://www.xenomai.org/index.php/16550A, but it dosen't work!
>
>
> *setserial /dev/ttyO2*
>
>> /dev/ttyO2, UART: undefined, Port: 0x0000, IRQ: 90
>
>
> *setserial /dev/ttyO2 uart none*
>
>> Cannot set serial info: Invalid argument
>
>
> */sbin/modprobe xeno_16550A io=0x150  irq=90 start_index=0
> baud_base=115200*
>
>> ERROR: could not insert 'xeno_16550A': Device or resource busy
>
>
> */sbin/modprobe xeno_16550A mem=*0x48024000* irq=90 baud_base=115200*
>
> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.027662] Internal error: : 1028 [#1] SMP ARM
>> Segmentation fault
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.100983] Process modprobe (pid: 2084, stack limit =
>> 0xdf2a0240)
>> root@arm:/home/debian#
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.107432] Stack: (0xdf2a1e40 to 0xdf2a2000)
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.111989] 1e40: bf025000 00000000 00000000 bf0228e8 df2a1f58
>> 00000000 00000001 bf022930
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.120530] 1e60: 00000000 bf025000 0000001c c0008998 bf025000
>> 00000000 00000001 bf0228e8
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.129073] 1e80: bf0228e8 df2a1f58 00000000 00000001 bf022930
>> 00000001 de4edcc0 c008b148
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.137613] 1ea0: bf0228f4 00007fff c008703c c015f438 c0088638
>> 00000028 00000000 bf0228f4
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.146155] 1ec0: bf022a3c 00000116 c06a64b4 e09dd2b8 df2a1eec
>> b6f872d0 ffffffff c0921db4
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.154695] 1ee0: 5f5f0065 c069b0d8 e09df000 b6d8d000 00000379
>> 00000000 00000000 00000000
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.163233] 1f00: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.171774] 1f20: 00000000 00000000 00000000 00000000 000000d2
>> b6d87000 000063f9 b6f872d0
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.180314] 1f40: 00000080 c000dd08 df2a0000 00000000 00000000
>> c008b4c4 e09d9000 000063f9
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.188854] 1f60: e09dcde0 e09dcca9 e09ded00 00002b34 00003684
>> 00000000 00000000 00000000
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.197394] 1f80: 0000001f 00000020 00000014 00000018 0000000c
>> 00000000 00000000 b6f87308
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.205936] 1fa0: b6f87268 c000db40 00000000 b6f87308 b6d87000
>> 000063f9 b6f872d0 00000002
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.214477] 1fc0: 00000000 b6f87308 b6f87268 00000080 00000000
>> b6f872d0 000063f9 00000000
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.223018] 1fe0: 00040000 bec683c4 b6f3eb07 b6ec1d94 80000010
>> b6d87000 00000000 00000000
>> Message from syslogd@arm at Sep 27 01:45:52 ...
>>  kernel:[  145.282094] Code: 1a000002 e5d03000 e6ef0073 ea000001
>> (e7d20001)
>
>
>
> Regards,
> Ricky Qs
>
