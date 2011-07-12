Message-ID: <4E1C8508.5010400@domain.hid>
Date: Tue, 12 Jul 2011 19:31:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid> <4E1C302A.8050309@domain.hid>
	<4E1C3301.2030203@domain.hid> <4E1C3672.1030104@domain.hid>
	<4E1C36EE.70803@domain.hid> <4E1C38CE.7090202@domain.hid>
	<4E1C3A5D.3020700@domain.hid> <4E1C44B4.50106@domain.hid>
In-Reply-To: <4E1C44B4.50106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/12/2011 02:57 PM, Jan Kiszka wrote:
>  			xnlock_put_irqrestore(&nklock, s);
>  			xnpod_schedule();
>  		}
> @@ -1036,6 +1043,7 @@ redo:
>  	 * to process this signal anyway.
>  	 */
>  	if (rthal_current_domain == rthal_root_domain) {
> +		XENO_BUGON(NUCLEUS, xnthread_test_info(thread, XNATOMIC));

Misleading dead code again, XNATOMIC is cleared not ten lines above.

>  		if (XENO_DEBUG(NUCLEUS) && (!signal_pending(this_task)
>  		    || this_task->state != TASK_RUNNING))
>  			xnpod_fatal
> @@ -1044,6 +1052,8 @@ redo:
>  		return -ERESTARTSYS;
>  	}
>  
> +	xnthread_clear_info(thread, XNATOMIC);

Why this? I find the xnthread_clear_info(XNATOMIC) right at the right
place at the point it currently is.

> +
>  	/* "current" is now running into the Xenomai domain. */
>  	thread->gksched = NULL;
>  	sched = xnsched_finish_unlocked_switch(thread->sched);
> @@ -2650,6 +2660,8 @@ static inline void do_sigwake_event(struct task_struct *p)
>  
>  	xnlock_get_irqsave(&nklock, s);
>  
> +	xnthread_clear_info(thread, XNATOMIC);
> +

Ditto.

-- 
                                                                Gilles.

