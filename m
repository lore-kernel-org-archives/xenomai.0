MIME-Version: 1.0
In-Reply-To: <1525870225626.46003@kth.se>
References: <1525870225626.46003@kth.se>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 23 May 2018 21:45:03 -0400
Message-ID: <CALLqZ8RrZOUeC++B=vmKR56AHNrT=fv5ODvr3R12ZCxFiJW_BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RPi zero: high resolution clock not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gustav Johansson <gusjohan@kth.se>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I have the ipipe support for the bcm2835 done, I'll submit the patch
shortly.  Once that's in the ipipe-arm tree we can start building
xenomai for the rpi zero.

On Wed, May 9, 2018 at 8:50 AM, Gustav Johansson <gusjohan@kth.se> wrote:
> Hi!
>
>
> I have managed to boot RPI zero with Cobalt on kernel version 4.9.51, with ipipe #4.
>
> Im using the mainline. I used config multi_v7_defconfig and chose armv6 from there.
>
> Im using the device tree bcm2835-rpi-zero.dtb
>
>
> During the boot I receives errors:
>
> [    0.000027] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
> [    0.000074] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
> [    0.000698] Interrupt pipeline (release #4)
> [    0.069805] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.107627] PTP clock support registered
> [    0.111409] clocksource: Switched to clocksource timer
> [    0.180098] [Xenomai] scheduling class idle registered.
> [    0.180287] [Xenomai] scheduling class rt registered.
> [    0.180527] I-pipe: high-resolution clock not working
> [    0.180726] [Xenomai] init failed, code -19
> [    0.207251] clk: couldn't get clock 0 for /soc/pwm@7e20c000
> [    0.572597] i2c-bcm2835 20805000.i2c: Could not read clock-frequency property
> [    5.063088] systemd[1]: System time before build time, advancing clock.
> [    6.685798] systemd[1]: Mounting RPC Pipe File System...
>
>
> So the error tells me that the high-resolution clock is not working and Xenomai failed the init with error code -19.
>
>
> The boot continues and I can use it as regular but /proc/xenomai does not exist.
>
>
> Any ideas on ways I can make it work? I have included the dmesg log and kernel config.
>
>
> Regards,
>
> Gustav
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: dmesg.log
> Type: text/x-log
> Size: 17028 bytes
> Desc: dmesg.log
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180509/b1515c4f/attachment.bin>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ATT07561.config
> Type: application/octet-stream
> Size: 134322 bytes
> Desc: ATT07561.config
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180509/b1515c4f/attachment.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

