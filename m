Date: Mon, 22 Feb 2016 22:02:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160222210227.GG7398@hermes.click-hack.org>
References: <20160216175837.GC9806@deathstar> <56C56C98.4020501@sigmatek.at>
 <20160218071030.GA20063@deathstar> <56C57320.8060002@sigmatek.at>
 <20160218161047.GA10005@deathstar>
 <20160222175341.GA22349@deathstar> <56CB4DF8.2010802@siemens.com>
 <20160222190431.GB22349@deathstar> <56CB5E84.1010803@siemens.com>
 <20160222205139.GA7819@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160222205139.GA7819@deathstar>
Subject: Re: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: mwelling79@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Mon, Feb 22, 2016 at 02:51:39PM -0600, Michael Welling wrote:
> On Mon, Feb 22, 2016 at 08:16:20PM +0100, Jan Kiszka wrote:
> > On 2016-02-22 20:04, Michael Welling wrote:
> > > On Mon, Feb 22, 2016 at 07:05:44PM +0100, Jan Kiszka wrote:
> > >> On 2016-02-22 18:53, Michael Welling wrote:
> > >>> On Thu, Feb 18, 2016 at 10:10:48AM -0600, Michael Welling wrote:
> > >>>> On Thu, Feb 18, 2016 at 08:30:40AM +0100, Wolfgang Netbal wrote:
> > >>>>>
> > >>>>>
> > >>>>> Am 2016-02-18 um 08:10 schrieb Michael Welling:
> > >>>>>> On Thu, Feb 18, 2016 at 08:02:48AM +0100, Wolfgang Netbal wrote:
> > >>>>>>>
> > >>>>>>> Am 2016-02-16 um 18:58 schrieb Michael Welling:
> > >>>>>>>> On Tue, Feb 16, 2016 at 06:39:50AM +0100, Wolfgang Netbal wrote:
> > >>>>>>>>> Am 2016-02-15 um 18:41 schrieb Michael Welling:
> > >>>>>>>>>> I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.
> > >>>>>>>>>>
> > >>>>>>>>>> The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.
> > >>>>>>>>>>
> > >>>>>>>>>> When I run the cross-link demo the system hangs after an error in read_task.
> > >>>>>>>>>>
> > >>>>>>>>>> Here is the output that I get:
> > >>>>>>>>>> main : write-file opened
> > >>>>>>>>>> main : write-config written
> > >>>>>>>>>> main : read-file opened
> > >>>>>>>>>> main : read-config written
> > >>>>>>>>>> main : write-task created
> > >>>>>>>>>> main : read-task created
> > >>>>>>>>>> main : starting write-task
> > >>>>>>>>>> main : strating read-task
> > >>>>>>>>>>  Nr |   write-irq    |    irq->read    |   write->read   |
> > >>>>>>>>>> ----------------------------------------------------------
> > >>>>>>>>>> read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
> > >>>>>>>>>> main : /dev/rtdm/rtser1 (read) -> closed
> > >>>>>>>>>> read_task: exit
> > >>>>>>>>>>
> > >>>>>>>>>> Any ideas why this would happen?
> > >>>>>>>>>>
> > >>>>>>>>>> I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.
> > >>>>>>>>> Dear Michael,
> > >>>>>>>>>
> > >>>>>>>>> I added a patch on December where I extended the IMX UART driver to support
> > >>>>>>>>> open firmware, maybe my patch can help you to find your issue.
> > >>>>>>>>> I posted the patch in the mailing list, you can find it here
> > >>>>>>>>> https://xenomai.org/pipermail/xenomai/2015-December/035655.html
> > >>>>>>>>>
> > >>>>>>>>> Kind regards
> > >>>>>>>>> Wolfgang
> > >>>>>>> Sorry Michael,
> > >>>>>>>
> > >>>>>>> My patch working for xenomai 2.6.4 file ksrc/drivers/serial/rt_imx_uart.c
> > >>>>>> I am pretty sure that there is another patch applied previous.
> > >>>>>>
> > >>>>>> If you look at your patch you see German comments and open firmware code that
> > >>>>>> is obviously not in the v2.6.4 on the git repository.
> > >>>>>>
> > >>>>>> https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/serial/rt_imx_uart.c?h=v2.6.4
> > >>>>>>
> > >>>>> I posted my patch, because I thought that Wolfgang Grandegger the author of
> > >>>>> the driver may check it and include it to the xenomai if it is useable for
> > >>>>> other users.
> > >>>>>
> > >>>>
> > >>>> Yes but the patch does not apply to the driver in the source tree.
> > >>>> Please provide the driver that you have after the patch.
> > >>>
> > >>> Any ideas out there?
> > >>>
> > >>
> > >> Are you now referring to the incomplete patch or your original problem
> > >> again?
> > > 
> > > The original problem is my primary concern. I would not mind having another
> > > version of the driver to test against as well.
> > > 
> > >>
> > >> For the latter case, I would recommend debugging the error code, ie.
> > >> what threw this at you. In Xenomai context, -EPERM often means that the
> > >> caller is requesting some (potentially) blocking service without being a
> > >> real-time task. But, of course, also the driver itself may decide to
> > >> raise this for whatever reasons.
> > > 
> > > Here is the snippet of code from the user app that concerns me:
> > > .
> > > .
> > >         printf(" Nr |   write->irq    |    irq->read    |   write->read   |\n");
> > >         printf("-----------------------------------------------------------\n");
> > > 
> > >         /*
> > >          * We are in secondary mode now due to printf, the next
> > >          * blocking Xenomai or driver call will switch us back
> > >          * (here: RTSER_RTIOC_WAIT_EVENT).
> > >          */
> > > 
> > >         while (1) {
> > >                 /* waiting for event */
> > >                 err = ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
> > > .
> > > .
> > > 
> > > So is the comment no longer true with Xenomai 3?
> > 
> > No, that would be a bug.
> > 
> > > 
> > > Here is the content of the corresponding ioctl in the driver:
> > > .
> > > .
> > >         case RTSER_RTIOC_WAIT_EVENT: {
> > >                 struct rtser_event ev = { .rxpend_timestamp = 0 };
> > >                 rtdm_toseq_t timeout_seq;
> > > 
> > >                 if (!rtdm_in_rt_context())
> > >                         return -ENOSYS;
> > > 
> > >                 /* Only one waiter allowed, stop any further attempts here. */
> > >                 if (test_and_set_bit(0, &ctx->ioc_event_lock))
> > >                         return -EBUSY;
> > > 
> > >                 rtdm_toseq_init(&timeout_seq, ctx->config.event_timeout);
> > > 
> > >                 rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
> > > 
> > >                 while (!ctx->ioc_events) {
> > >                         /* Only enable error interrupt
> > >                            when the user waits for it. */
> > >                         if (ctx->config.event_mask & RTSER_EVENT_ERRPEND) {
> > >                                 ctx->ier_status |= IER_STAT;
> > > #ifdef FIXME
> > >                                 rt_imx_uart_reg_out(mode, base, IER,
> > >                                                  ctx->ier_status);
> > > #endif
> > >                         }
> > > 
> > >                         rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
> > > 
> > >                         err = rtdm_event_timedwait(&ctx->ioc_event,
> > >                                                    ctx->config.event_timeout,
> > >                                                    &timeout_seq);
> > >                         if (err) {
> > >                                 /* Device has been closed? */
> > >                                 if (err == -EIDRM)
> > >                                         err = -EBADF;
> > >                                 goto wait_unlock_out;
> > >                         }
> > > 
> > >                         rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
> > >                 }
> > > 
> > >                 ev.events = ctx->ioc_events;
> > >                 ctx->ioc_events &=
> > >                     ~(RTSER_EVENT_MODEMHI | RTSER_EVENT_MODEMLO);
> > > 
> > >                 ev.last_timestamp = ctx->last_timestamp;
> > >                 ev.rx_pending = ctx->in_npend;
> > > 
> > >                 if (ctx->in_history)
> > >                         ev.rxpend_timestamp = ctx->in_history[ctx->in_head];
> > > 
> > >                 rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
> > > 
> > >                 if (rtdm_fd_is_user(fd))
> > >                         err =
> > >                             rtdm_safe_copy_to_user(fd, arg, &ev,
> > >                                                    sizeof(struct
> > >                                                           rtser_event));
> > >                         else
> > >                                 memcpy(arg, &ev, sizeof(struct rtser_event));
> > > 
> > > wait_unlock_out:
> > >                 /* release the simple event waiter lock */
> > >                 clear_bit(0, &ctx->ioc_event_lock);
> > >                 break;
> > >         }
> > > .
> > > .
> > > 
> > > So either rtdm_event_timedwait or rtdm_safe_copy_to_user is returing -EPERM.
> > 
> > Or things terminate earlier / later in the ioctl dispatching path.
> > 
> > > Looking at the documentation rtdm_safe_copy_to_user does not appear to return -EPERM.
> > > 
> > > Looking at the documentation rtdm_event_timedwait:
> > > -EPERM may be returned if an illegal invocation environment is detected.
> > > 
> > > So are we stuck in secondary mode?
> > 
> > Probably.
> > 
> > > Ideas?
> > 
> > You will not get around debugging more information out of your setup.
> > Use tracing, use well-placed printk.
> 
> So I put a pr_err where I expected the driver was failing:
> 
> 			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
> 
> 			err = rtdm_event_timedwait(&ctx->ioc_event,
> 				ctx->config.event_timeout,
> 				&timeout_seq);
> 			if (err) {
> +				pr_err("Just as I expected rtdm_event_timedwait failed %d\n", err);
> 				/* Device has been closed? */
> 				if (err == -EIDRM)
> 					err = -EBADF;
> 				goto wait_unlock_out;
> 			}
> 
> Then I found something unexpected:
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
> [ 1600.173441] Just as I expected rtdm_event_timedwait failed -110
> read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation not permitted
> main : /dev/rtdm/rtser1 (read) -> closed
> 
> -110 is -ETIMEDOUT not -EPERM.
> 
> So then I figured hey that would make sense if the cable is not looped
> back. So I made sure I had the NULL modem loop correctly going to the
> two ports in question.
> 
> root@somimx6:/sys/bus/platform/drivers/imx-uart# /usr/xenomai/demo/cross-link 
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
>   0 |18446744046287090290 |     27423201660 |          740334
>   1 |18446744046287079290 |     27423200326 |          728000
>   2 |18446744046287078623 |     27423200993 |          728000
>   3 |18446744046287080623 |     27423199659 |          728666
>   4 |18446744046287078623 |     27423201326 |          728333
>   5 |18446744046287079622 |     27423200994 |          729000
>   6 |18446744046287078289 |     27423200660 |          727333
>   7 |18446744046287077956 |     27423201326 |          727666
>   8 |18446744046287079956 |     27423201327 |          729667
>   9 |18446744046287080623 |     27423199660 |          728667
>  10 |18446744046287078623 |     27423199660 |          726667
>  11 |18446744046287078956 |     27423203994 |          731334
>  12 |18446744046287078956 |     27423200326 |          727666
>  13 |18446744046287078623 |     27423202327 |          729334
>  14 |18446744046287078290 |     27423200659 |          727333
>  15 |18446744046287078623 |     27423200993 |          728000
>  16 |18446744046287079290 |     27423201326 |          729000
>  17 |18446744046287081290 |     27423199659 |          729333
>  18 |18446744046287077957 |     27423200993 |          727334
> .
> .
> .
> 
> Why in the world would -ETIMEDOUT come out as Operation not permitted?

Because EPERM is -1. ioctl return -1 upon error and the "real" error
status is found in errno. So, in fact, the test should check errno
if err is not 0.

-- 
					    Gilles.
https://click-hack.org

