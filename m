MIME-Version: 1.0
Date: Wed, 3 Jun 2015 10:15:27 +0200
Message-ID: <CAD6zzE=h4mKzL0Vpwgq30=64VDCBs+L0ab9LL-ft-3wYeAbLVw@mail.gmail.com>
From: Marco Baracchi <cormabara@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, paul_c@tuxcnc.org

Message: 1

Date: Wed, 20 May 2015 11:11:20 +0100

From: Paul <paul_c@tuxcnc.org>

To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Subject: Re: [Xenomai] hrtimer negative next event

Message-ID: <201505201111.20347.paul_c@tuxcnc.org>

Content-Type: text/plain;  charset="iso-8859-1"

On Wednesday 20 May 2015, Marco Baracchi wrote:

> We are using kernel *linux 3.0.35*, branch *imx_3.0.35_4.1.0* with

> patches *adeos-xenomai

> 2.6.4* for *mxc* on a freescale imx6 single core and we have ?a

> problem with hrtimer: sometimes after a couple of hour our periodic

> task inside Xenomai blocks. checking inside /proc path we ?found:

> ---------------------------------------------------------------------

>----------------------------------------------------------------------

>-------------------

>

> ~$ cat /proc/timer_list

> Timer List Version: v0.6

> HRTIMER_MAX_CLOCK_BASES: 3

> now at 23036522464643 nsecs

>

> cpu: 0

> ?clock 0:

> ? .base: ? ? ? 80bac120

> ? .index: ? ? ?0

> ? .resolution: 10000000 nsecs

> ? .get_time: ? ktime_get

> active timers:

> ?#0: <8da95ad0>, hrtimer_wakeup, S:01

> * # expires at 21797170078601-21797175078598 nsecs [in -1239352386042

> to -1239347386045 nsecs]*

[...]

>-------------------

>

> seems the hrclock receive a negative next event.


If you look at the print_timer() function found in

kernel/time/timer_list.c, the last two values are cast to a long long.

Nothing to worry about, but perhaps an issue that should be addressed
via the linux kernel mailing list.


THank you for answer,

Sorry for incomplete informatons, we suppose the hrtimer is really locked
because looking inside /proc/interrupts


--------------------------------------------------------------------------------
> cat /proc/interrupts


           CPU0
 34:          1       GIC  sdma
 35:          0       GIC  VPU_JPG_IRQ
 37:          0       GIC  imx-ipuv3
 38:          6       GIC  imx-ipuv3
 44:          0       GIC  VPU_CODEC_IRQ
 50:          0       GIC  vdoa
 51:          0       GIC  snvs_rtc
 55:         65       GIC  mmc1
 57:       2638       GIC  mmc0
 58:         75       GIC  IMX-uart
 59:         45       GIC  IMX-uart
 63:          0       GIC  spi_imx
 66:       5327       GIC  spi_imx
 68:        221       GIC  imx-i2c
 69:          0       GIC  imx-i2c
 72:       2550       GIC  usb_wakeup, fsl ehci pre interrupt, ehci_hcd:usb2
 75:          0       GIC  usb_wakeup, fsl-usb2-otg, fsl ehci pre
interrupt, ehci_hcd:usb1, fsl-usb2-udc
 82:          0       GIC  asrc

* 87:   12309122       GIC  i.MX Timer Tick*

121:          0       GIC  dvfs
147:          0       GIC  mxc_hdmi_cec
150:     512252       GIC  enet
456:          0      GPIO  pfuze
Err:          0


at line

87:   12309122       GIC  i.MX Timer Tick

the number of tick doesn't increment, so we suppose no timer irq was handled
