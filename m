MIME-Version: 1.0
In-Reply-To: <5AF7623E.8020101@freyder.net>
References: <5AF7623E.8020101@freyder.net>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 12 May 2018 22:30:45 -0400
Message-ID: <CALLqZ8Sb_qmi-wgw1g2sEQvBSyAaszO9SPyChsX5bZ87z_RupQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RTDM serial illicit call from head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'll try to answer part of this. The detection of a cross domain call
would come form the ipipe code in the kernel.  This is being called
because the ipipe debug flags are on and it's detecting the switch
from the root domain and then causing a panic so we can see the stack
trace.
I'm not sure why the ioctl call is causing this.  It looks like when
we try to get the clock rate we start to access a normal Linux service
which causes the stall and triggers the panic you see in your logs.
I'm assuming in your write you aren't accessing a normal Linux
resource so we don't see the attempt to switch domains and therefore
no panic.
Panics in general happen because the system is in a "bad" state, in
this scenario it's not really "bad" we are just detecting the mode
switch and then getting enough information to fix the issue.  This is
why your system seems sane, but if you hit a worse panic then your
system may not be stable enough to do anything.

-Greg

On Sat, May 12, 2018 at 5:53 PM, Steve Freyder <steve@freyder.net> wrote:
> Greetings again,
>
> Xenomai 3.0.6, armv7, imx6, imx_uart rtdm driver
>
> I've seen many postings about this, and about symbol wrapping, etc, etc.
> I'm still
> not understanding something very basic here, I'm sure.
>
> When I run a program built with --alchemy (no --posix) skin, and I execute
> these lines
> of code (error checking is omitted here but being done in the real program
> and not failing):
>
> #define SER_BAUD        9600            /**< Baud rate for SYNC interface */
> #define SYNC_DEVICE     "rtser0"        /**< serial device used for SYNC */
>
> static const struct rtser_config sync_config = {
>         .config_mask       = 0xFFFF,
>         .baud_rate         = SER_BAUD,
>         .parity            = RTSER_NO_PARITY,
>         .data_bits         = RTSER_8_BITS,
>         .stop_bits         = RTSER_1_STOPB,
>         .handshake         = RTSER_NO_HAND,
>         .fifo_depth        = RTSER_FIFO_DEPTH_1,
>         .rx_timeout        = RTSER_TIMEOUT_NONE,
>         .tx_timeout        = 1e9,
>         .event_timeout     = 1e9,
>         .timestamp_history = RTSER_DEF_TIMESTAMP_HISTORY,
>         .event_mask        = RTSER_EVENT_RXPEND,
> };
>
> fd = __RT(open)(SYNC_DEVICE,0) ;
>
>     err = __RT(ioctl)(fd, RTSER_RTIOC_SET_CONFIG, &sync_config);
>
> I get this traceback (once only per system boot):
>
> ------------------------------------------------------------------------
> [  411.088376] I-pipe: Detected illicit call from head domain 'Xenomai'
> [  411.088376]         into a regular Linux service
> [  411.100666] CPU: 1 PID: 875 Comm: rtserE Not tainted
> 4.1.18_C01571-15S00-00.000.zimg+83fdace666 #1
> [  411.109644] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  411.116189] Backtrace:
> [  411.118694] [<80014a64>] (dump_backtrace) from [<80014c9c>]
> (show_stack+0x20/0x24)
> [  411.126280]  r7:00000000 r6:00000080 r5:00000000 r4:80b81c94
> [  411.132072] [<80014c7c>] (show_stack) from [<806b5f3c>]
> (dump_stack+0xa0/0xc4)
> [  411.139326] [<806b5e9c>] (dump_stack) from [<800ab000>]
> (ipipe_root_only+0x11c/0x188)
> [  411.147171]  r9:80c58300 r8:00000000 r7:80c45380 r6:80b34e6c r5:600d0013
> r4:809abba4
> [  411.155073] [<800aaee4>] (ipipe_root_only) from [<8001f5ac>]
> (ipipe_test_and_stall_root+0x18/0xc0)
> [  411.164046]  r10:bc5c0024 r9:00000000 r8:40480201 r7:00000005 r6:00002580
> r5:80bc154c
> [  411.172023]  r4:80ba5c9c r3:00000000
> [  411.175675] [<8001f594>] (ipipe_test_and_stall_root) from [<806b8274>]
> (mutex_trylock+0x40/0x1ec)
> [  411.184561]  r7:00000005 r6:00002580 r5:80bc154c r4:80ba5c9c
> [  411.190358] [<806b8234>] (mutex_trylock) from [<80580d78>]
> (clk_prepare_lock+0x1c/0xfc)
> [  411.198376]  r7:00000005 r6:00002580 r5:bece7e50 r4:bec36480
> [  411.204164] [<80580d5c>] (clk_prepare_lock) from [<80581e8c>]
> (clk_core_get_rate+0x1c/0x70)
> [  411.212530]  r5:bece7e50 r4:bec36480
> [  411.216180] [<80581e70>] (clk_core_get_rate) from [<80581f04>]
> (clk_get_rate+0x24/0x28)
> [  411.224198]  r5:bece7e50 r4:bc5c2000
> [  411.227863] [<80581ee0>] (clk_get_rate) from [<7f08d2c4>]
> (rt_imx_uart_ioctl+0xa88/0xe5c [xeno_imx_uart])
> [  411.237464] [<7f08c83c>] (rt_imx_uart_ioctl [xeno_imx_uart]) from
> [<8010779c>] (rtdm_fd_ioctl+0xc0/0x218)
> [  411.247048]  r10:00011638 r9:00000000 r8:40480201 r7:00000005 r6:bc5c0000
> r5:600d0013
> [  411.255025]  r4:80c58300
> [  411.257609] [<801076e0>] (rtdm_fd_ioctl) from [<8010dc70>]
> (CoBaLt_ioctl+0x18/0x1c)
> [  411.265280]  r3:00011638 r2:00011638 r1:40480201
> [  411.269989]  r10:bf648800 r9:c0943008 r8:8010dc58 r7:80b34e6c r6:00000001
> r5:00000052
> [  411.277964]  r4:bece7fb0
> [  411.280548] [<8010dc58>] (CoBaLt_ioctl) from [<8011efc4>]
> (ipipe_syscall_hook+0x174/0x380)
> [  411.288839] [<8011ee50>] (ipipe_syscall_hook) from [<800ad6d8>]
> (__ipipe_notify_syscall+0xa4/0x3e0)
> [  411.297899]  r10:bf648800 r9:80c45380 r8:80b34e6c r7:bf649800 r6:80c45380
> r5:00000001
> [  411.305873]  r4:200d0013
> [  411.308464] [<800ad634>] (__ipipe_notify_syscall) from [<80010868>]
> (pipeline_syscall+0x8/0x24)
> [  411.317177]  r10:00000002 r9:bece6000 r8:80010928 r7:000f0042 r6:00000005
> r5:40480201
> [  411.325153]  r4:00011638
> ------------------------------------------------------------------------
>
> If I do not execute the ioctl call, and I instead call:
>
>     err = __RT(write)(fd,"x",1) ;
>
> I do not get the traceback, and the write is successful.  This tells me that
> ioctl() path
> has some kind of check in it that the write() path doesn't have.  Is the
> detection of a
> cross-domain call something that an RTDM driver is doing or is this
> something at a higher
> level making these checks?
>
> What's more, I've seen many comments that this is a problem scenario, and
> that it will put
> the system into a "bad state".  But all of my testing says that this is
> completely benign
> and everything is working as I expect it to.  It can't be both ways - which
> way is it, and
> why?
>
> Thanks in advance,
> Steve
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

