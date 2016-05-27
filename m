Date: Fri, 27 May 2016 13:36:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160527113618.GD21367@hermes.click-hack.org>
References: <CAJ2oMhL-7pF+3ZCHy_yA1OiFo-O327PGwL=Sy8g9-h8JZ0YNDw@mail.gmail.com>
 <20160526162808.GB2842@hermes.click-hack.org>
 <CAJ2oMhL3Ds0oe6NbvpMFSnmckpCdiisoxqTF9kqHuGe-LosxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhL3Ds0oe6NbvpMFSnmckpCdiisoxqTF9kqHuGe-LosxnA@mail.gmail.com>
Subject: Re: [Xenomai] "watchdog triggered" error & irq interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Thu, May 26, 2016 at 07:52:20PM +0300, Ran Shalit wrote:
> On Thu, May 26, 2016 at 7:28 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, May 26, 2016 at 06:57:49PM +0300, Ran Shalit wrote:
> >> Hello,
> >>
> >> On testing interrupt within kernel it seems to work ok.
> >> I then moved to userspace rt thread waiting on events coming from the
> >> rtfm kernel driver (witch signals with rtd_event_signal)
> >>
> >> But then I get the following errors:
> >>
> >> dma0chan1-copy0: #15195: got completion callback, but status is 'in progress'
> >> dma0chan3-copy0: #14335: test timed out
> >> dma0chan3-copy0: #14336: got completion callback, but status is 'in progress'
> >> Xenomai: watchdog triggered -- signaling runaway thread 'rtdm'
> >> [sched_delayed] sched: RT throttling activated
> >> Xenomai: RTDM: closing file descriptor 0.
> >> CPU time limit exceeded
> >>
> >> I understand that it mean that cpu is probably in busy wait.
> >> The interrupt is done on raising edge, and I configure it as following:
> >> rtdm driver:
> >> ========
> >> ret = rtdm_irq_request(&ctx->irq_handle,
> >>  91, PFI_IRQHandler, RTDM_IRQTYPE_EDGE,
> >>  DRVNAM, ctx);
> >>
> >> userspace real-time thread
> >> ===============
> >>
> >> while (1) {
> >>     rt_printf("11\n");
> >>     if (ioctl(file_desc, RTTST_RTIOC_GPIOIRQ_WAIT_IRQ))
> >>     {
> >>            rt_printf("failed!");

You should break from the loop here, otherwise if the ioctl
constantly fails, you will have an endless loop (and the message
will never be printed).

> >>      };
> >>      rt_printf("22\n");
> >
> > If what follows is what is necessary to acknowledge the irq at the
> > device level, it has to be done in the interrupt handler. Otherwise
> > when the interrupt handler has finished executing, interrupts are
> > enabled, and the interrupt triggers again, leaving no chance to the
> > interrupt handler to run. Alternatively, you may want to disable the
> > interrupt line in the interrupt handler and reenable it after the
> > thread has run. Note however that it increases the time necessary to
> > handle the interrupt and may result in lost interrupts (if they
> > happen while the line is masked).
> 
> That followed code is not for acknoweledging the irq but just for
> reading timer ticks.

Well, Xenomai provides functions for that which will more clearly
indicate your intent to those reading your code.

> The irq handler in rtdm driver handles the raising edge:
> 
> static int PFI_IRQHandler(rtdm_irq_t *irq_handle)
> {
> struct rtdm_test_context *ctx;
> 
> ctx = rtdm_irq_get_arg(irq_handle, struct rtdm_test_context);
>   rtdm_event_signal(&ctx->irq_event);
>    return RTDM_IRQ_HANDLED;
> }
> 
> I suppose that cpu (zynq) should
> disable the interrupt becuase it is defined as raising edge in device tree:
> 
> fpga_device_tree@80000000 {
> compatible = "xillybus,xillybus_lite_of-1.00.a";
> reg = < 0x80000000 0x400000 >;
> interrupts = < 0 59 1 >;
> interrupt-parent = <&ps7_scugic_0>;
> } ;
> 
> How can I be sure that the issue is that the interrupts are not acknowledged ?

RTDM itself does not take the device tree settings into account. So,
if Linux does not do it if you do not call request_irq, nobody took
these settings into account. In order to be sure, I would check the
interrupt controller registers to see if it is correctly configured
in rising edge mode.

> >> https://drive.google.com/folderview?id=0B22GsWueReZTS3RaV3gzRk9aZzQ&usp=sharing
> >
> > This code is crap. If you want people to review your code, please
> > make it short and remove the cruft that you do not use, and remove
> > the dead code too. As I already told you, you should start from the
> > "skeleton" code, not from the RTDM test driver which is a unit test
> > for the RTDM API.
> 
> That's Right...
> I made many many tests moving from one attitude to another, failing in
> all this trials.
> I've also tried to use interrupts in userspace (user_irq.c
> example),

Don't. Handling interrupts in user-space is a bad idea.

> but could not get any interrupt with that method, so I moved back to
> rtdm driver, although doing it all in userspace, if it worked, could
> be better.

I do not really care, if you want me to read your code, send short
and readable code.

-- 
					    Gilles.
https://click-hack.org

