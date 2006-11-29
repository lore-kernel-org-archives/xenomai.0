Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <456D66F4.7050100@domain.hid>
References: <456C3EF9.30102@domain.hid> <456C8961.7060906@domain.hid>
	<456C97B9.1000402@domain.hid> <456D4C7D.2040100@domain.hid>
	<456D4ED4.5040405@domain.hid> <456D5399.4040901@domain.hid>
	<456D5871.6040401@domain.hid> <456D60D7.4090202@domain.hid>
	<456D66F4.7050100@domain.hid>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 19:38:41 +0100
Message-Id: <1164825521.4973.273.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-11-29 at 11:54 +0100, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> > 
> >>Gilles Chanteperdrix wrote:
> >>
> >>>Jan Kiszka wrote:
> >>>
> >>>>OK. So you are suggesting to read out the affinity mask from task_struct
> >>>>instead of passing it as an additional argument?
> >>>>
> >>>
> >>>Unless I am wrong, it is the way it currently works.
> >>>
> >>
> >>Yes, for the posix skin. But native is different due to the spilt-up
> >>create/start and its own affinity API. And that caused problems when
> >>applying nkaffinity.
> >>
> >>Nevertheless, I should try to combine the cleanup of xnshadow_map with
> >>passing the mask ALWAYS in task_struct. Let's see how this works out,
> >>most likely with less patching.
> > 
> > 
> > sched_setaffinity is 2.6 only. So we would have to push the mask
> > application into kernel space for the native skin anyway. Hmm.
> > 
> > What are posix skin users supposed to do over 2.4?
> 
> 
> Right, I did not think about the 2.4 kernel, but I am not sure there are
> many people using the 2.4 kernel on SMP machines anyway.

Ack. 2.4 backports are provided to help people who do not want to double
jump from <some-rtos> to Xenomai _and_ from 2.4 to 2.6 in the same move
for upgrading some embedded setup; they can move to Xenomai keeping
their good old system software if they wish, then move to 2.6 if they
wish so later, once the dust has settled. People interested by
multi-cores and/or big irons of some sort should obviously go for 2.6.

> 
> As for the native skin, it already allows to pass the affinity to
> rt_task_create, using T_CPU.
> 
> 
> > Upgrade to 2.6? BTW, do you plan to support pthread_attr_setaffinity_np somehow?
> 
> pthread_attr_setaffinity_np is implemented in kernel space, and the
> pthread_attr_t is passed unchanged by __wrap_pthread_create to
> __real_pthread_create. So pthread_attr_setaffinity_np should be already
> working provided that you use a libc that supports it.
> 
> > 
> > Jan
> > 
> 
> 
-- 
Philippe.



