Message-ID: <47D7E528.9060704@domain.hid>
Date: Wed, 12 Mar 2008 15:14:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47D6CD29.4020700@domain.hid>	<2ff1a98a0803111127p7868350axa976c68714cf4f05@domain.hid>	<47D6DD05.2040007@domain.hid>
	<47D6E7D8.90908@domain.hid>
In-Reply-To: <47D6E7D8.90908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] What have I misunderstood
	about	condition	variables
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Anders Blomdell wrote:
> OK, found the bug (not mine!).

No, it's mine. Actually, you fixed two of them, since nested locks would not be
released properly when entering cond_wait. Will merge, thanks.

 I suggest something like this:
> 
> --- ksrc/skins/native/cond.c.orig       2008-03-11 20:42:52.000000000 +0100
> +++ ksrc/skins/native/cond.c    2008-03-11 21:00:10.000000000 +0100
> @@ -438,13 +438,20 @@
> 
>  int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
>  {
> -       int err, kicked = 0;
> +       /* We can't use rt_mutex_release since that might reschedule
> +          before we do our xnsynch_sleep_on, hence most of of the code
> +          is duplicated here */
> +       int err = 0, kicked = 0;
>         xnthread_t *thread;
>         spl_t s;
> +       int lockcnt;
> 
>         if (timeout == TM_NONBLOCK)
>                 return -EWOULDBLOCK;
> 
> +       if (xnpod_unblockable_p())
> +               return -EPERM;
> +
>         xnlock_get_irqsave(&nklock, s);
> 
>         cond = xeno_h2obj_validate(cond, XENO_COND_MAGIC, RT_COND);
> @@ -454,10 +461,26 @@
>                 goto unlock_and_exit;
>         }
> 
> -       err = rt_mutex_release(mutex);
> +       mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
> 
> -       if (err)
> +       if (!mutex) {
> +               err = xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
> +               goto unlock_and_exit;
> +       }
> +
> +       if (xnpod_current_thread() != xnsynch_owner(&mutex->synch_base)) {
> +               err = -EPERM;
>                 goto unlock_and_exit;
> +       }
> +
> +       lockcnt = mutex->lockcnt; /* Leave even if mutex is nested */
> +
> +       mutex->lockcnt = 0;
> +
> +       if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
> +               mutex->lockcnt = 1;
> +               /* Scheduling deferred */
> +       }
> 
>         thread = xnpod_current_thread();
> 
> @@ -474,6 +497,8 @@
> 
>         rt_mutex_acquire(mutex, TM_INFINITE);
> 
> +       mutex->lockcnt = lockcnt; /* Adjust lockcnt */
> +
>         if (kicked)
>                 xnthread_set_info(thread, XNKICKED);
> 
> 
> 
> 


-- 
Philippe.

