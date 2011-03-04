Message-ID: <4D7135B5.5050307@domain.hid>
Date: Fri, 04 Mar 2011 19:55:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>	<4D70FC9A.7040007@domain.hid>	<AANLkTinNtpWXzaggXX_g9Z+U0TqWP6iLHW_m=FqJbtUk@domain.hid>	<4D712706.2020202@domain.hid>	<4D71282A.7060108@domain.hid>	<AANLkTi=V1J0Z8wWZw92KABdAVczYoFEPZOZHBmE8zO-a@domain.hid>
	<AANLkTimAv5kTkQH2xeKBiCjZ0uywtBq-DaXZwrDgLK9v@domain.hid>
In-Reply-To: <AANLkTimAv5kTkQH2xeKBiCjZ0uywtBq-DaXZwrDgLK9v@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai patched kernel "laggy"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Hyams <jeff.hyams@domain.hid>
Cc: xenomai@xenomai.org

Jeff Hyams wrote:
> Here's the dmesg output with quiet disabled for just the boot.  I also
> included a clean syslog from just this boot.
> 
> Also re-attached the config file so they'd all be together.
> 
> Sorry for not parsing everything out before.

The dmesg you sent does not correspond to /proc/interrupts and /proc/irq.

Anyway, you have:
[    3.345790] Xenomai: SMI-enabled chipset found
[    3.345851] Xenomai: SMI workaround failed!

So, you may have an issue with SMIs.

And you have this:
[  129.882571] irq 16: nobody cared (try booting with the "irqpoll" option)
[  129.882578] Pid: 0, comm: swapper Not tainted
2.6.32.20-xenomai-2.5.5.2 #1
[  129.882581] Call Trace:
[  129.882583]  <IRQ>  [<ffffffff810b084b>] __report_bad_irq+0x2b/0xa0
[  129.882596]  [<ffffffff810b0a4c>] note_interrupt+0x18c/0x1d0
[  129.882601]  [<ffffffff810b13cd>] handle_fasteoi_irq+0xbd/0xe0
[  129.882606]  [<ffffffff8100f022>] handle_irq+0x22/0x30
[  129.882613]  [<ffffffff81542559>] do_IRQ+0x79/0x110
[  129.882621]  [<ffffffff810b6d76>] __ipipe_sync_stage+0x226/0x22c
[  129.882623]  [<ffffffff815424e0>] ? do_IRQ+0x0/0x110
[  129.882625]  [<ffffffff810b6d7c>] ? __xirq_end+0x0/0x9d
[  129.882627]  [<ffffffff815424e0>] ? do_IRQ+0x0/0x110
[  129.882629]  [<ffffffff810b7200>] __ipipe_walk_pipeline+0x100/0x110
[  129.882634]  [<ffffffff81029cf4>] __ipipe_handle_irq+0x134/0x320
[  129.882636]  [<ffffffff810b0c10>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
[  129.882640]  [<ffffffff8100cad3>] common_interrupt+0x13/0x2c
[  129.882641]  <EOI>  [<ffffffff8102a2eb>] ? __ipipe_halt_root+0x2b/0x40
[  129.882645]  [<ffffffff810143fd>] ? default_idle+0x3d/0x90
[  129.882647]  [<ffffffff8100ae64>] ? cpu_idle+0x74/0xd0
[  129.882650]  [<ffffffff81537647>] ? start_secondary+0x19f/0x1a4
[  129.882652] handlers:
[  129.882652] [<ffffffff813da670>] (usb_hcd_irq+0x0/0xb0)
[  129.882656] [<ffffffffa0099cc0>] (mpt_interrupt+0x0/0xa00 [mptbase])
[  129.882668] [<ffffffffa0179410>] (azx_interrupt+0x0/0x170
[snd_hda_intel])
[  129.882671] Disabling IRQ #16
[  188.244706] hda-intel: IRQ timing workaround is activated for card
#0. Suggest a bigger bdl_pos_adj.

So, your system is running without an IRQ for three drivers. This may
cause, say, the keyboard driver to be in "polling" mode, and so appear
to be very slow.


-- 
                                                                Gilles.

