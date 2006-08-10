Message-ID: <44DAED87.3040506@domain.hid>
Date: Thu, 10 Aug 2006 10:25:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] -110 error on rt_task_send...
	bug?
References: <44D7EDCF.9010409@domain.hid>	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>	<b647ffbd0608090442q638115acw788da87969792cfb@domain.hid>
	<200608091709.57319.schwab@domain.hid>
In-Reply-To: <200608091709.57319.schwab@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: andrewg@domain.hid, xenomai@xenomai.org

Hi Dmitry,

some comments on the patch, but I still haven't run it. The basic idea
is sane, but we have to wait for Philippe's comments of course.

Ulrich Schwab wrote:
> On Wednesday 09 August 2006 13:42, Dmitry Adamushko wrote:
>> So could anyone test this patch and let me know if it works?
>>
>> Note : I haven't compiled it even as I don't have a proper environment. But
>> the changes are pretty simple so it should be ok.
> I just did run the test program supplied by Vincent after applying Your patch
> (against 2.2.0)
> It did work !
> Only one small typo was in the patch, it is fixed in the attached patch 
> version.
> 
>> There was actually yet another problem mmm... who cares to delete a sender
>> from the msendq?
>>
>> Now should be ok or maybe I'm completely wrong and see the things which do
>> not exist at all :)
>>
>> p.s. I cc'ed "xenomai-core" as it may involve further discussions and it's
>> the right place indeed.
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urp xenomai-a/include/nucleus/synch.h xenomai-b/include/nucleus/synch.h
> --- xenomai-a/include/nucleus/synch.h	2006-07-20 11:09:01.000000000 +0200
> +++ xenomai-b/include/nucleus/synch.h	2006-08-09 12:53:37.044217000 +0200
> @@ -28,6 +28,7 @@
>  #define XNSYNCH_NOPIP   0x0
>  #define XNSYNCH_PIP     0x2
>  #define XNSYNCH_DREORD  0x4
> +#define XNSYNCH_FOWNER	0x20	/* Fixed owner */
>  
>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>  
> diff -urp xenomai-a/ksrc/nucleus/synch.c xenomai-b/ksrc/nucleus/synch.c
> --- xenomai-a/ksrc/nucleus/synch.c	2006-06-15 14:15:25.000000000 +0200
> +++ xenomai-b/ksrc/nucleus/synch.c	2006-08-09 13:28:55.199081000 +0200
> @@ -37,6 +37,14 @@
>  #include <nucleus/module.h>
>  #include <nucleus/ltt.h>
>  
> +/* temporarily here */
> +static inline void xnsynch_set_owner_internal(xnsynch_t *synch, xnthread_t *thread)
> +{
> +	if (!testbits(synch->status, XNSYNCH_FOWNER))
> +		synch->owner = thread;
> +}
> +
> +

I don't think we should use this inline function after the changes I'm
suggesting below. There will be too many exceptions from this pattern,
and the code is more readable with this unrolled.

>  /*! 
>   * \fn void xnsynch_init(xnsynch_t *synch, xnflags_t flags);
>   * \brief Initialize a synchronization object.
> @@ -181,7 +189,7 @@ void xnsynch_sleep_on(xnsynch_t *synch, 
>  
>  				if (testbits(synch->status, XNSYNCH_PENDING)) {
>  					/* Ownership is still pending, steal the resource. */
> -					synch->owner = thread;
> +					xnsynch_set_owner_internal(synch, thread);
>  					__clrbits(thread->status,
>  						  XNRMID | XNTIMEO | XNBREAK);
>  					goto grab_ownership;

Mmm, given the fixed ownership, should we ever enter this code path
under XNSYNCH_FOWNER? Is there a scenario with XNSYNCH_FOWNER |
XNSYNCH_PENDING? If yes, I would say: fix that one. Then the change
above is no longer required.

> @@ -209,7 +217,7 @@ void xnsynch_sleep_on(xnsynch_t *synch, 
>  
>  			xnpod_suspend_thread(thread, XNPEND, timeout, synch);
>  
> -			if (unlikely(synch->owner != thread)) {
> +			if (!testbits(synch->status, XNSYNCH_FOWNER) && unlikely(synch->owner != thread)) {
>  				/* Somebody stole us the ownership while we were ready to
>  				   run, waiting for the CPU: we need to wait again for the
>  				   resource. */

(synch->owner != thread) is more likely to be unlikely ;). I would
reorder it, i.e. put the owner check to the front again.

> @@ -362,12 +370,12 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
>  	if (holder) {
>  		thread = link2thread(holder, plink);
>  		thread->wchan = NULL;
> -		synch->owner = thread;
> +		xnsynch_set_owner_internal(synch, thread);
>  		__setbits(synch->status, XNSYNCH_PENDING);

Here we are: I think we shouldn't set XNSYNCH_PENDING if XNSYNCH_FOWNER
is set.

>  		xnltt_log_event(xeno_ev_wakeup1, thread->name, synch);
>  		xnpod_resume_thread(thread, XNPEND);
>  	} else {
> -		synch->owner = NULL;
> +		xnsynch_set_owner_internal(synch, thread);
>  		__clrbits(synch->status, XNSYNCH_PENDING);
>  	}
>  
> @@ -435,7 +443,7 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
>  	nholder = poppq(&synch->pendq, holder);
>  	thread = link2thread(holder, plink);
>  	thread->wchan = NULL;
> -	synch->owner = thread;
> +	xnsynch_set_owner_internal(synch, thread);
>  	__setbits(synch->status, XNSYNCH_PENDING);

...and here again.

>  	xnltt_log_event(xeno_ev_wakeupx, thread->name, synch);
>  	xnpod_resume_thread(thread, XNPEND);
> @@ -523,7 +531,7 @@ int xnsynch_flush(xnsynch_t *synch, xnfl
>  		status = XNSYNCH_RESCHED;
>  	}
>  
> -	synch->owner = NULL;
> +	xnsynch_set_owner_internal(synch, NULL);
>  	__clrbits(synch->status, XNSYNCH_PENDING);
>  
>  	xnlock_put_irqrestore(&nklock, s);
> diff -urp xenomai-a/ksrc/skins/native/task.c xenomai-b/ksrc/skins/native/task.c
> --- xenomai-a/ksrc/skins/native/task.c	2006-07-30 10:50:49.000000000 +0200
> +++ xenomai-b/ksrc/skins/native/task.c	2006-08-09 13:32:21.917770000 +0200
> @@ -262,7 +262,7 @@ int rt_task_create(RT_TASK *task,
>  
>  #ifdef CONFIG_XENO_OPT_NATIVE_MPS
>  	xnsynch_init(&task->mrecv, XNSYNCH_FIFO);
> -	xnsynch_init(&task->msendq, XNSYNCH_PRIO | XNSYNCH_PIP);
> +	xnsynch_init(&task->msendq, XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_FOWNER);
>  	xnsynch_set_owner(&task->msendq, &task->thread_base);
>  	task->flowgen = 0;
>  #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
> @@ -2057,10 +2057,7 @@ int rt_task_reply(int flowid, RT_TASK_MC
>  		   identifier from other senders wrt to a given receiver. */
>  
>  		if (receiver->wait_args.mps.mcb_s.flowid == flowid) {
> -			/* Note that the following will cause the receiver to be
> -			   unblocked without transferring the ownership of the
> -			   msendq object, since we want the sender to keep it. */
> -			xnpod_resume_thread(&receiver->thread_base, XNPEND);
> +			xnsynch_wakeup_this_sleeper(&sender->msendq, holder);

Yeah, this somehow looks cleaner to me.

>  			break;
>  		}
>  	}
> 

Jan

