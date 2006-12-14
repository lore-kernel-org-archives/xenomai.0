Subject: Re: Antwort: [Xenomai-core] [PATCH] pSOS tm_-calls
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFB99D2CFA.75345C31-ONC1257244.005930E7@domain.hid>
References: <OFB99D2CFA.75345C31-ONC1257244.005930E7@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 23:20:21 +0100
Message-Id: <1166134822.23946.208.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-12-14 at 18:13 +0100, Thomas Necker wrote:
> > Here come some patches that add the following functions to the pSOS 
> direct 
> > syscall interface:  tm_wkafter,  tm_cancel, tm_evafter, tm_get, tm_set

The user-space part looks fine. There are a few issues in the syscall
wrappers, I'm detailing them here for reference before merging the fixed
version. Thanks.

> diff -Nau --exclude='*.bak' --exclude='*.proj' --exclude Makefile xenomai-orig/ksrc/skins/psos+/syscall.c xenomai-2.3/ksrc/skins/psos+/syscall.c
> --- xenomai-orig/ksrc/skins/psos+/syscall.c	2006-12-11 09:52:10.968999000 +0100
> +++ xenomai-2.3/ksrc/skins/psos+/syscall.c	2006-12-13 16:34:28.208863000 +0100
> @@ -26,6 +26,7 @@
>  #include <psos+/syscall.h>
>  #include <psos+/queue.h>
>  #include <psos+/sem.h>
> +#include <psos+/tm.h>
>  
>  /*
>   * By convention, error codes are passed back through the syscall
> @@ -957,6 +958,106 @@
>  	return sm_v((u_long)sem);
>  }
>  
> +/*
> + * u_long tm_wkafter(u_long ticks)
> + */
> +
> +static int __tm_wkafter(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	u_long	ticks, err;
> +
> +	ticks	= __xn_reg_arg1(regs);
> +
> +	err = tm_wkafter(ticks);
> +
> +	return err;
> +}
> +
> +/*
> + * u_long tm_cancel(u_long tmid)
> + */
> +
> +static int __tm_cancel(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	xnhandle_t handle = __xn_reg_arg1(regs);
> +	psostm_t *tm;
> +
> +	tm = (psostm_t *)xnregistry_fetch(handle);
> +
> +	if (!tm)
> +		return ERR_OBJID;
> +
> +	return tm_cancel((u_long)tm);
> +}
> +
> +/*
> + * u_long tm_evafter(u_long ticks, u_long events, u_long *tmid_r)
> + */
> +
> +static int __tm_evafter(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	u_long ticks, events, tmid, err;
> +
> +	psostm_t *tm;

The above two lines need to be swapped.

> +	if (!__xn_access_ok
> +	    (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tmid)))
> +		return -EFAULT;
> +

The pointer to check for writability is stored in arg3, not arg4.

> +	ticks = __xn_reg_arg1(regs);
> +	events = __xn_reg_arg2(regs);
> +
> +	err = tm_evafter(ticks, events, &tmid);
> +
> +	if (err == SUCCESS) {
> +		tm = (psossem_t *)tmid;

Wrong cast.

> +		/* Copy back the registry handle. */
> +		tmid = tm->handle;
> +		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg3(regs), &tmid,
> +				  sizeof(tmid));
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * u_long tm_get(u_long *date_r, u_long *time_r, u_long *ticks_r)
> + */
> +
> +static int __tm_get(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	u_long	date, time, ticks, err;
> +
> +	err = tm_get(date, time, ticks);
> +	if (err == SUCCESS) {
> +		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &date,
> +				  sizeof(date));
> +		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &time,
> +				  sizeof(time));
> +		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &ticks,
> +				  sizeof(ticks));

All three pointers have to be checked for writability first, before attempting
to write stuff to potentially silly addresses.

> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * u_long tm_set(u_long date, u_long time, u_long ticks)
> + */
> +
> +static int __tm_set(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	u_long	date, time, ticks, err;
> +
> +	date = __xn_reg_arg1(regs);
> +	time = __xn_reg_arg2(regs);
> +	ticks = __xn_reg_arg3(regs);
> +
> +	err = tm_set(date, time, ticks);

No need for the err variable here. Tail call to tm_set()
would look better.

> +
> +	return err;
> +}
> +
> +
>  static xnsysent_t __systab[] = {
>  	[__psos_t_create] = {&__t_create, __xn_exec_init},
>  	[__psos_t_start] = {&__t_start, __xn_exec_any},
> @@ -986,6 +1087,11 @@
>  	[__psos_sm_delete] = {&__sm_delete, __xn_exec_any},
>  	[__psos_sm_p] = {&__sm_p, __xn_exec_primary},
>  	[__psos_sm_v] = {&__sm_v, __xn_exec_any},
> +	[__psos_tm_wkafter] = {&__tm_wkafter, __xn_exec_primary},		//tbc

It's ok. tm_wkafter sleeps, so we _must_ run over the primary context
for that to happen safely.

> +	[__psos_tm_cancel] = {&__tm_cancel, __xn_exec_any},		//tbc

It's ok too. tm_cancel does not refer in any way to the current Xenomai
thread, so it can be called from any context (e.g. the Linux one, which
is mapped to the "root" Xenomai thread, which is not a real Xenomai
thread, but a placeholder for the Linux kernel).

> +	[__psos_tm_evafter] = {&__tm_evafter, __xn_exec_primary},		//tbc

Ok again. tm_evafter calls tm_start_event_timer, which in turn
attempts to identify the current pSOS task for setting the timer's owner
field. For this information to be available, a pSOS task must be a
valid Xenomai RT thread, so we need to run in primary mode for
that to be true.

> +	[__psos_tm_get] = {&__tm_get, __xn_exec_any},		//tbc

No problem. Nothing refers to the current thread in this code.

> +	[__psos_tm_set] = {&__tm_set, __xn_exec_any},		//tbc

Same as tm_get.

>  	[__psos_rn_create] = {&__sm_delete, __xn_exec_lostage},
>  };
>  
> diff -Nau --exclude='*.bak' --exclude='*.proj' --exclude Makefile xenomai-orig/ksrc/skins/psos+/tm.c xenomai-2.3/ksrc/skins/psos+/tm.c
> --- xenomai-orig/ksrc/skins/psos+/tm.c	2006-12-11 09:52:09.499044000 +0100
> +++ xenomai-2.3/ksrc/skins/psos+/tm.c	2006-12-14 17:18:02.376988000 +0100
> @@ -62,6 +62,10 @@
>  
>  	ev_send((u_long)tm->owner, tm->events);
>  
> +#ifdef CONFIG_XENO_OPT_REGISTRY
> +	xnregistry_remove(tm->handle);
> +#endif /* CONFIG_XENO_OPT_REGISTRY */
> +
>

We need to move this to tm_destroy_internal instead, because
it's the global cleanup routine, and it needs to get rid of all
handles as part of its housekeeping chores.

  	if (xntimer_interval(&tm->timerbase) == XN_INFINITE)
>  		tm_destroy_internal(tm);
>  }
> @@ -94,6 +98,23 @@
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> +#ifdef CONFIG_XENO_OPT_REGISTRY
> +	{
> +		static unsigned long tm_ids;
> +		u_long err;
> +
> +		sprintf(tm->name, "anon%lu", tm_ids++);
> +
> +		err = xnregistry_enter(tm->name, tm, &tm->handle, 0);

Please, pass NULL and never zero as the null pointer.

> +
> +		if (err) {
> +			tm->handle = XN_NO_HANDLE;
> +			tm_cancel((u_long)tm);
> +			return err;
> +		}
> +	}
> +#endif /* CONFIG_XENO_OPT_REGISTRY */
> +
>  	return SUCCESS;
>  }
>  
> @@ -218,8 +239,10 @@
>  
>  u_long tm_evafter(u_long ticks, u_long events, u_long *tmid)
>  {
> -	if (xnpod_primary_p())
> +	if (xnpod_unblockable_p())
>  		return -EPERM;
> +//	if (xnpod_primary_p())
> +//		return -EPERM;

The test for primary context was inverted in the original code
(my mistake), it should read:

-	if (xnpod_primary_p()) 
+	if (!xnpod_primary_p())

i.e. the error case is some non-primary context calling us.
xnpod_unblockable() works because it reverses the assertion.
Here, the test for primary is better, because xnpod_unblockable()
would prevent any thread holding the scheduler lock from calling the
routine, which is wrong, since tm_evafter does not sleep.

On a more general note, please don't leave commented code, unless
there is a really, really, really, really good reason for that, and
in that case only, prefer #if 0/#endif constructs over comments for
keeping it out from the compilation process. It's much easier to
spot later on when cleaning up the code and/or working again on pending
issues.

>  
>  	return tm_start_event_timer(ticks, XN_INFINITE, events, tmid);
>  }
> @@ -247,6 +270,10 @@
>  		goto unlock_and_exit;
>  	}
>  
> +#ifdef CONFIG_XENO_OPT_REGISTRY
> +	xnregistry_remove(tm->handle);
> +#endif /* CONFIG_XENO_OPT_REGISTRY */
> +

Same comment than previously about tm_destroy_internal and
the handle removal.

>  	tm_destroy_internal(tm);
>  
>        unlock_and_exit:
> 

-- 
Philippe.



