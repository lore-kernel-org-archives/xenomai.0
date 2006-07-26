Subject: Re: [Xenomai-help] How can I now when it will be next periodic
	task release point?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C6929C.5030804@domain.hid>
References: <200607251735.35500.lbocseg@domain.hid> <44C6929C.5030804@domain.hid>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 12:08:19 +0200
Message-Id: <1153908500.4946.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-07-25 at 23:52 +0200, Jan Kiszka wrote:
> Rodrigo Rosenfeld Rosas wrote:
> > I want to capture and process images each 300 ms. The processing routines take 
> > a (fixed, but unknown) time. I'd like to request a new image about 50 ms 
> > before next release point, like this:
> > 
> > for(;;)
> > {
> > 	rt_task_wait_period(NULL);
> > 	ProcessImage();
> > 	rt_task_sleep(XXX); // until 50 ms before next release point
> > 	RequestNewImage();
> > }
> > 
> > I could use rt_task_inquire() if RT_TASK_INFO was documented. From 
> > source-code:
> >   RTIME relpoint;             /* !< Periodic release point. */
> > 
> > The question is which release point? Next or the last reached?
> 
> Looks like you managed to dig out dead/broken code here: RT_TASK.timer,
> the timer returned in relpoint, is nowhere else used than in
> rt_task_inquire.
> 
> > Anyway, a new function like rt_task_getnextrelpoint() would be very welcome...
> > 
> > rt_task_sleep(rt_task_getnextrelpoint() - 50*1000*1000);
> 
> See my attached patch. It should fix rt_task_inquire in a way that meets
> your requirements. It also clarifies the doc. Only compile tested.
> 
> Philippe, is it correct?
> 

Indeed it is, applied; thanks.

> Jan
> plain text document attachment
> (return-ptimer-in-rt_task_inquire.patch)
> Index: include/native/task.h
> ===================================================================
> --- include/native/task.h	(Revision 1374)
> +++ include/native/task.h	(Arbeitskopie)
> @@ -76,7 +76,7 @@ typedef struct rt_task_info {
>  
>      unsigned status;		/* !< Status. */
>  
> -    RTIME relpoint;		/* !< Periodic release point. */
> +    RTIME relpoint;		/* !< Next periodic release point. */
>  
>      char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
>  
> @@ -109,8 +109,6 @@ typedef struct rt_task {
>  #define link2rtask(laddr) \
>  ((RT_TASK *)(((char *)laddr) - (int)(&((RT_TASK *)0)->link)))
>  
> -    xntimer_t timer;
> -
>      xnthread_t thread_base;
>  
>      char rname[XNOBJECT_NAME_LEN]; /* !< Name in registry. Not the same as
> Index: ChangeLog
> ===================================================================
> --- ChangeLog	(Revision 1374)
> +++ ChangeLog	(Arbeitskopie)
> @@ -1,3 +1,8 @@
> +2006-07-25  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* include/native/task.h, ksrc/native/task.c: Kill unused timer field
> +	in RT_TASK. Return ptimer of the underlying thread on rt_task_inquire.
> +
>  2006-07-23  Jan Kiszka  <jan.kiszka@domain.hid>
>  
>  	* ksrc/skins/native/Makefile: Fixed typo that messed up modularised
> Index: ksrc/skins/native/task.c
> ===================================================================
> --- ksrc/skins/native/task.c	(Revision 1374)
> +++ ksrc/skins/native/task.c	(Arbeitskopie)
> @@ -1118,7 +1118,7 @@ int rt_task_inquire(RT_TASK *task, RT_TA
>  	info->bprio = xnthread_base_priority(&task->thread_base);
>  	info->cprio = xnthread_current_priority(&task->thread_base);
>  	info->status = xnthread_status_flags(&task->thread_base);
> -	info->relpoint = xntimer_get_date(&task->timer);
> +	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
>  
>        unlock_and_exit:
>  
-- 
Philippe.



