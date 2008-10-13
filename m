Message-ID: <48F34673.8060906@domain.hid>
Date: Mon, 13 Oct 2008 15:00:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F2118A.7010608@domain.hid> <48F34501.6040802@domain.hid>
In-Reply-To: <48F34501.6040802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using SIGWINCH to trigger priority change.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> (*) Btw, if you happen to export the current thread state via the shared heap to
> userland for the fast mutexes, I guess that we could to use it as well to
> implement a smarter pthread_setschedparam/rt_task_set_priority, doing something
> like:
> 
> 	if (in_secondary_mode(ptid))
> 		__real_pthread_setschedparam(...);
> 	else
> 		XENOMAI_SKINCALL(...);
> 
> When running in secondary mode, we should be able to rely on the automatic
> propagation the nucleus does in do_setsched_event(), if the underlying priority
> scale is POSIX-compatible, which will work for the native skin as well.

If we export the thread state to user-space there are many things we can
do from user-space, such as disabling preemption for instance.

-- 
                                                 Gilles.

