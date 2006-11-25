Subject: Re: [Xenomai-core] Limiting Xenomai tasks to one certain core in a
	dual core system
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45685D6D.7010802@domain.hid>
References: <13096879.1164184060512.JavaMail.ngmail@domain.hid>
	<45640F06.5000005@domain.hid>	<456426A7.3030305@domain.hid>
	<45682250.7070403@domain.hid>  <45685D6D.7010802@domain.hid>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 19:13:55 +0100
Message-Id: <1164478436.4973.157.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sat, 2006-11-25 at 16:12 +0100, Jan Kiszka wrote:

[...]

> OK, after reading a bit more in what I was hacking on, I'm starting to
> understand the CPU selection mechanisms of shadow threads. Here comes
> version 3 of the patch. Now it actually forces all threads to the
> desired CPUs.
> 
> The reason why I failed with previous approaches could even be a SMP bug
> of the original code. The Linux affinity of a shadow thread was only set
> if no u_completion has been passed to xnshadow_map - which affected
> native threads e.g. So I reordered the code, and it works.
> 

The root issue is why LO_START_REQ which normally sets the affinity at
the end of the create -> start protocol did not get a chance to run.
Likely that the newly mapped thread was still in a runnable state when
tested from xnshadow_start(), which might be due to a kernel preemption
artefact.

> I also changed the policy of /proc/xenoami/affinity. It will now only
> override the mapping if the user didn't provide an explicit mask. I
> think this provides more flexibility.
> 
> Comment?

[...]

>  	const unsigned nr_cpus = xnarch_num_online_cpus();
> @@ -910,7 +912,7 @@ int xnpod_start_thread(xnthread_t *threa
>  		return -EBUSY;
>  
>  	if (xnarch_cpus_empty(affinity))
> -		affinity = XNARCH_CPU_MASK_ALL;
> +		affinity = nkaffinity;

This is fairly significant API change that should be loudly documented,
especially because its behaviour now depends on a new variable.

>  
>  	xnlock_get_irqsave(&nklock, s);
>  
> Index: xenomai/ksrc/nucleus/shadow.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -853,20 +853,17 @@ int xnshadow_map(xnthread_t *thread, xnc
>  	xnshadow_thrptd(current) = thread;
>  	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
>  
> +	affinity = thread->affinity;
> +	if (xnarch_cpus_empty(affinity))
> +		affinity = nkaffinity;

This won't work as expected. The thread->affinity info should not be
used in the xnshadow_map() context, because it has not been set yet
(xnshadow_map() should be seen as the equivalent to xnpod_init_thread()
for shadow threads). This information is set by the nucleus by a call to
xnpod_start_thread(), so one step later in the task spawn protocol.
Luckily, it seems to be zeroed in your test, but it has not been
initialized yet.

> +	set_cpus_allowed(current, affinity);
> +

This should be ok to pin the newly mapped task to a CPU early on, even
in the auto-start configuration, but that case, we should kill the now
redundant set_cpus_allowed() from LO_START_REQ. Actually, we would be
better of killing LO_START_REQ entirely, since it would not make sense
anymore, compared to a regular WAKEUP request.

-- 
Philippe.



