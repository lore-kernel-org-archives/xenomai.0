From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Wed, 17 Dec 2014 22:40:34 +0000
Message-ID: <a884eaf52700404fb2b907c543910154@EX132MBOX1A.de2.local>
References: <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>
 <20141215132315.GK11058@hermes.click-hack.org>
 <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>
 <20141215142021.GL11058@hermes.click-hack.org>
 <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>
 <20141215151954.GN11058@hermes.click-hack.org>
 <322873cb03ce4d91b6217ebf8e3ef714@EX132MBOX1A.de2.local>
 <20141217132235.GA4096@hermes.click-hack.org>,
 <20141217154630.GA2282@hermes.click-hack.org>
In-Reply-To: <20141217154630.GA2282@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > After some research I have ended up now in APC'c thread handling =0A=
>> > (see code snipped below, out of ksrc/arch/generic/hal.c). From my =0A=
>> > point of view there could be occur the "lost wakeup problem". That =0A=
>> > means in detail that rthal_kicker() calls wakeup when rthal_apc_thread=
() =0A=
>> > has returned from rthal_apc_handler() but not yet called set_current_s=
tate(). =0A=
>> > After that, when kicker has finished, the APC thread calls set_current=
_state() =0A=
>> > and goes to sleep. Thus, the wakeup is lost. Or do I overlook somethin=
g?  =0A=
>> > Maybe we should use a waitqueue here?=0A=
>> >=0A=
>> >=0A=
>> > static int rthal_apc_thread(void *data)=0A=
>> > {=0A=
>> >     unsigned cpu =3D (unsigned)(unsigned long)data;=0A=
>> >=0A=
>> >     set_cpus_allowed(current, cpumask_of_cpu(cpu));=0A=
>> >     sigfillset(&current->blocked);=0A=
>> >     current->flags |=3D PF_NOFREEZE;=0A=
>> >     /* Use highest priority here, since some apc handlers might=0A=
>> >        require to run as soon as possible after the request has been=
=0A=
>> >        pended. */=0A=
>> >     rthal_setsched_root(current, SCHED_FIFO, MAX_RT_PRIO - 1);=0A=
>> >=0A=
>> >     while (!kthread_should_stop()) {=0A=
>> >         set_current_state(TASK_INTERRUPTIBLE);=0A=
>> >         schedule();=0A=
>>=0A=
>> You can obtain the same effect as with a wait queue by replacing the=0A=
>> schedule() above with:=0A=
>>=0A=
>>         if (rthal_apc_pending[cpu] =3D=3D 0)=0A=
>>            schedule();=0A=
>         else=0A=
>             set_current_state(TASK_RUNNING);=0A=
=0A=
Thanks for the hint, I like your approach. There we do not need to allocate=
 a=0A=
waitqueue resource. Moreover the task wont be scheduled for every wakup cal=
l =0A=
but only as often as required. I will check if my application runs stable n=
ow with=0A=
that fix. If true I will publish the patch here.=0A=
=0A=
Regards,=0A=
Christoph=0A=
 =

