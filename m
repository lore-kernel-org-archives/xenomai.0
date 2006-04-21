Message-ID: <44490B3D.2060600@domain.hid>
Date: Fri, 21 Apr 2006 18:41:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>	<4448B81E.3090605@domain.hid>	<17480.63623.600656.828303@domain.hid>	<4448FE86.4050503@domain.hid>
	<17481.417.382690.108221@domain.hid>
In-Reply-To: <17481.417.382690.108221@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > > What about keeping SCHED_RR as the default scheduling policy and
>  > > requiring users to manually select SCHED_NORMAL in thread creation
>  > > attributes in order to create hybrid threads with pthread_create ?
>  > > 
>  > 
>  > No objection a priori, but what would this buy us?
> 
> As a user, I would expect pthread_create and pthread_setschedparam to
> allow the same scheduling policies and priorities.
> 

Is your concern about having the POSIX skin in kernel space currently 
assuming that SCHED_OTHER == SCHED_RR, which would be different than 
Linux's perception in that case?

However, I really think that we should not rely on implicit rules when 
we could avoid it (e.g. SCHED_RR as default), especially when those 
rules are going to be most often overlooked (people are rather used to 
default to SCHED_NORMAL/OTHER in the Linux sense).

What I suggested was to let people create normal threads using 
pthread_create (likely conforming to the SCHED_OTHER policy), then use 
the redirected pthread_setschedparam syscall (i.e. always applied to the 
current thread) to promote them as Xenomai shadows, but leave them in 
their original scheduling class. The same goes for rt_task_shadow. This 
would be explicit actions that would not leave much room for "surprises".

-- 

Philippe.

