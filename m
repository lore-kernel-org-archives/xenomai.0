From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Wed, 17 Dec 2014 12:24:23 +0000
Message-ID: <322873cb03ce4d91b6217ebf8e3ef714@EX132MBOX1A.de2.local>
References: <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>
 <20141211163807.GD27793@hermes.click-hack.org>
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>
 <20141215132315.GK11058@hermes.click-hack.org>
 <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>
 <20141215142021.GL11058@hermes.click-hack.org>
 <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>,
 <20141215151954.GN11058@hermes.click-hack.org>
In-Reply-To: <20141215151954.GN11058@hermes.click-hack.org>
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

=0A=
After some research I have ended up now in APC'c thread handling (see code =
snipped below, out of ksrc/arch/generic/hal.c). From my point of view there=
 could be occur the "lost wakeup problem". That means in detail that rthal_=
kicker() calls wakeup when rthal_apc_thread() has returned from rthal_apc_h=
andler() but not yet called set_current_state(). After that, when kicker ha=
s finished, the APC thread calls set_current_state() and goes to sleep. Thu=
s, the wakeup is lost. Or do I overlook something?  Maybe we should use a w=
aitqueue here?=0A=
=0A=
=0A=
static int rthal_apc_thread(void *data)=0A=
{=0A=
    unsigned cpu =3D (unsigned)(unsigned long)data;=0A=
=0A=
    set_cpus_allowed(current, cpumask_of_cpu(cpu));=0A=
    sigfillset(&current->blocked);=0A=
    current->flags |=3D PF_NOFREEZE;=0A=
    /* Use highest priority here, since some apc handlers might=0A=
       require to run as soon as possible after the request has been=0A=
       pended. */=0A=
    rthal_setsched_root(current, SCHED_FIFO, MAX_RT_PRIO - 1);=0A=
=0A=
    while (!kthread_should_stop()) {=0A=
        set_current_state(TASK_INTERRUPTIBLE);=0A=
        schedule();=0A=
        rthal_apc_handler(0, NULL);=0A=
    }=0A=
=0A=
    __set_current_state(TASK_RUNNING);=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
void rthal_apc_kicker(unsigned virq, void *cookie)=0A=
{=0A=
    wake_up_process(rthal_apc_servers[smp_processor_id()]);=0A=
}=0A=
=0A=
Regards,=0A=
Christoph=

