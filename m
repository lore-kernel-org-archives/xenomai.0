References: <VE1PR04MB6477905B7CC4E6A6F5D769BEFEF99@VE1PR04MB6477.eurprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: latency: negative value?
Date: Sun, 24 Apr 2022 11:00:34 +0200
In-reply-to: <VE1PR04MB6477905B7CC4E6A6F5D769BEFEF99@VE1PR04MB6477.eurprd04.prod.outlook.com>
Message-ID: <87v8uykfew.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerry Huang <jerry.huang@nxp.com>
Cc: xenomai@xenomai.org


Jerry Huang via Xenomai <xenomai@xenomai.org> writes:

> Hi, all guys,
> Now I am using linux-dovetail/v5.15.6-dovetail1-rebase on my RDB board.
> 1 . I am running latency command, but when I running command:
> latency -t 1 -T 30
> I got the negative value:
> RTD|     -2.760|     -2.654|     -1.800|       0|     0|     -2.760|     -1.400
>
> 2. Then, I got the solution from google:
> Run command: xeno latency -T 20
> I got:
> RTD|     -1.360|     -1.235|     -0.040|       0|     0|     -1.440|      0.440
>
> 3. then I update /proc/xenomai/latency value
> echo -1440 > /proc/xenomai/latency
>
> 4. when I run xeno latency again, I got below result:
> RTD|      5.240|      5.389|      6.640|       0|     0|      5.040|      7.600
>
> 5. but when I run command again: latency -t 1 -T 30,
> I still got the negative value:
> RTD|     -2.760|     -2.652|     -1.760|       0|     0|     -2.760|     -1.400
>
> So, How to fix the issue?

The core timer needs to be calibrated, it looks like the default
calibration values are too conservative for the performances of this
board (is it from the Layerscape series?), especially for kernel
thread/irq wakeups. This may help:

https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html

> And how to check the xenomai interrupt? I remember I can get the interrupt number through "cat /proc/xenomai/irq",but now I can't find it.
>

With Dovetail underneath, you just need to look at /proc/interrupts as
usual. The 'oob' flag tells you whether the interrupt is handled by the
real-time core in out-of-band mode (real-time).

e.g. this is from an i.MX6QP SabreSD, we can see the per-CPU TWD being
handled in oob mode for high-precision timing by the real-time
domain. The proxy tick interrupt (315) is a synthetic IRQ created by
Dovetail in order to relay some timer events to the common kernel at due
date, since the real-time core manages the hardware for the whole
system.

~ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
 24:          0          0          0          0     SIRQC  24 Edge          in-band work
 25:        567        292        381        676 GIC-0  29 Edge     oob  twd
 26:          0          0          0          0       GPC  55 Level         i.MX Timer Tick
 27:          0          0          0          0       GPC  94 Level         arm-pmu
 35:         50          0          0          0       GPC  26 Level         2020000.serial
 55:          0          0          0          0       GPC  81 Level         20c0000.watchdog
 67:          0          0          0          0       GPC   2 Level         sdma
 70:       1611          0          0          0       GPC 118 Level         2188000.ethernet
 71:          0          0          0          0       GPC 119 Level         2188000.ethernet
 72:          0          0          0          0       GPC  23 Level         mmc1
 73:        146          0          0          0       GPC  24 Level         mmc2
 74:         43          0          0          0       GPC  25 Level         mmc3
 75:          0          0          0          0       GPC  36 Level         21a0000.i2c
 76:          0          0          0          0       GPC  37 Level         21a4000.i2c
 77:          2          0          0          0       GPC  38 Level         21a8000.i2c
 87:          0          0          0          0       GPC  39 Level         ahci-imx[2200000.sata]
 95:          0          0          0          0  gpio-mxc   4 Edge          Volume Up
 96:          0          0          0          0  gpio-mxc   5 Edge          Volume Down
123:          0          0          0          0  gpio-mxc   0 Edge          2198000.mmc cd
125:          0          0          0          0  gpio-mxc   2 Edge          2194000.mmc cd
184:          0          0          0          0  gpio-mxc  29 Edge          Power Button
315:        429        160        364        546     SIRQC 315 Edge          proxy tick
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:         37         40         27         23  Rescheduling interrupts
IPI3:        470        944       1352       1809  Function call interrupts
IPI4:          0          0          0          0  CPU stop interrupts
IPI5:          0          0          0          0  IRQ work interrupts
IPI6:          0          0          0          0  completion interrupts
Err:          0

-- 
Philippe.

