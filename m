From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 14 May 2015 15:34:33 -0400
Message-ID: <20150514193433.GG6169@csclub.uwaterloo.ca>
References: <20150513203301.GC6169@csclub.uwaterloo.ca>
 <20150513203743.GG3759@hermes.click-hack.org>
 <20150513203833.GD6169@csclub.uwaterloo.ca>
 <20150514162351.GE6169@csclub.uwaterloo.ca>
 <20150514162831.GH3759@hermes.click-hack.org>
 <20150514164745.GF6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150514164745.GF6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 14, 2015 at 12:47:45PM -0400, Lennart Sorensen wrote:
> OK, that makes sense.
> 
> Turning off the DCC (which I really have no need for) makes it get a
> bit further before gettings stuck, so I think the timer being stuck is
> indeed the correct theory to investigate.  Odd how 3.12 this worked fine.
> 
> [    2.383692] VFS: Disk quotas dquot_6.5.2
> [    2.392599] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    2.411815] msgmni has been set to 1486
> [    2.421043] alg: self-tests for aes-generic (aes) passed
> [    2.432651] alg: self-tests for crc32c-generic (crc32c) passed
> [    2.445092] alg: self-tests for crct10dif-generic (crct10dif) passed
> [    2.458414] alg: No test for stdrng (krng)
> [    2.467837] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> [    2.483130] io scheduler noop registered
> [    2.491314] io scheduler deadline registered (default)
> [    2.502613] io scheduler cfq registered
> [    2.516676] pinctrl-single 4a003400.pinmux: 281 pins at pa fc003400 size 1124
> [    2.535869] pbias_mmc_omap5: 1800 <--> 3000 mV at 3000 mV 
> [    2.770821] Serial: 8250/16550 driver, 16 ports, IRQ sharing disabled
> [    2.797902] 4806a000.serial: ttyS0 at MMIO 0x4806a000 (irq = 296, base_baud = 3000000) is a 8250
> [    2.817855] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 297, base_baud = 3000000) is a 8250
> [    2.836028] console [ttyS2] enabled
> [    2.836028] console [ttyS2] enabled
> [    2.850309] bootconsole [earlycon0] disabled
> [    2.850309] bootconsole [earlycon0] disabled
> [    2.870425] 48420000.serial: ttyS6 at MMIO 0x48420000 (irq = 298, base_baud = 3000000) is a 8250
> [    2.889154] omap8250 48422000.serial: mode_gpio_request return -16
> [    2.901601] omap8250: probe of 48422000.serial failed with error -16
> [    2.914812] pru_rs485_init
> [    2.921743] omap_rng 48090000.rng: OMAP Random Number Generator ver. 20
> [    2.940130] libphy: Fixed MDIO Bus: probed
> [    2.950381] usbcore: registered new interface driver cdc_wdm
> [    2.962063] usbcore: registered new interface driver usb-storage
> [    2.975517] omap_rtc 48838000.rtcss: rtc core: registered 48838000.rtcss as rtc0
> [    2.991612] i2c /dev entries driver
> [    3.000692] device-mapper: uevent: version 1.0.3
> [    3.011097] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
> 
> and there it gets stuck again.
> 
> I will try to figure out what is wrong with the timer tick when the
> ipipe patch is applied.

I managed to confirm that jiffies is in fact stuck at the boot time
-300000 value.  Now if I could only track down what code is supposed to
increment it.  The code I found (do_timer called by xtime_update) does
not appear to get called by anyone.

-- 
Len Sorensen

