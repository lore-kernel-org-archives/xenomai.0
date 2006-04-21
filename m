Message-ID: <44491B68.5080905@domain.hid>
Date: Fri, 21 Apr 2006 19:50:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>	<4448B81E.3090605@domain.hid>	<17480.63623.600656.828303@domain.hid>	<4448FE86.4050503@domain.hid>	<17481.417.382690.108221@domain.hid>	<44490B3D.2060600@domain.hid>
	<17481.6439.664844.663463@domain.hid>
In-Reply-To: <17481.6439.664844.663463@domain.hid>
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
>  > What I suggested was to let people create normal threads using 
>  > pthread_create (likely conforming to the SCHED_OTHER policy), then use 
>  > the redirected pthread_setschedparam syscall (i.e. always applied to the 
>  > current thread) to promote them as Xenomai shadows, but leave them in 
>  > their original scheduling class. The same goes for rt_task_shadow. This 
>  > would be explicit actions that would not leave much room for "surprises".
> 
> If I understand correctly, you mean that one should not be able to
> create real-time threads with pthread_create. My question was about what
> to do of explicit scheduling parameters passed to pthread_create through
> thread creation attributes.

Nope, this is obviously not what I meant... :o>

This is how one would create hybrids, without changing anything else to
the current interface:

     pthread_attr_init(&attr);
     ...
     pthread_attr_setschedpolicy(&attr,SCHED_OTHER);
     ...
     pthread_create(...,&attr,&foo,NULL);

and,

void *foo (void *cookie)
{
	/* The following call maps a shadow thread to "current", but 
       	    currently only accepts SCHED_FIFO, and would be changed to 
                            	    allow SCHED_OTHER/NORMAL. */
	pthread_setschedparam(...,SCHED_OTHER,...);
	/* OR, for the native API */
	rt_task_shadow(...,pri=0,...);
}

-- 

Philippe.

