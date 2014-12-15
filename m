From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 15 Dec 2014 15:11:45 +0000
Message-ID: <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>
References: <20141211144711.GD21808@hermes.click-hack.org>
 <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
 <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>
 <20141211163807.GD27793@hermes.click-hack.org>
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>
 <20141215132315.GK11058@hermes.click-hack.org>
 <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>,
 <20141215142021.GL11058@hermes.click-hack.org>
In-Reply-To: <20141215142021.GL11058@hermes.click-hack.org>
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
>> >> > it seems to me as APC interrupts on ipipe got lost. I have added tw=
o counters:=0A=
>> >> > One increments in schedule_linux_call() when a request for a specif=
ic application=0A=
>> >> > task is queued. Another one is incremented in lostage_handler() whe=
n the=0A=
>> >> > specific task was waked up. When I output the counter's values afte=
r tasks have=0A=
>> >> > freezed the counter of lostage_handler is exactly one value less th=
an=0A=
>> >> > schedule_linux_call's counter.=0A=
>> >> >=0A=
>> >> > And then, when I wake-up APC thread manually all freezed tasks cont=
inue for a=0A=
>> >> > moment, until all are freezing again.=0A=
>> >>=0A=
>> >> As said above waking APC thread using=0A=
>> >>=0A=
>> >>   wake_up_process(rthal_apc_servers[smp_processor_id()]);=0A=
>> >>=0A=
>> >> does reactivate all Xenomai threads for scheduling. Incontrast using=
=0A=
>> >>=0A=
>> >>   rthal_apc_schedule(lostage_apc);=0A=
>> >>=0A=
>> >> does not help. So it seems as APC interrupt is pending but won't be  =
executed.=0A=
>> >>=0A=
>> >> Any idea?=0A=
>> >=0A=
>> > Do you have the same issue if you run a kernel patched with Xenomai=0A=
>> > and without the PREEMPT_RT patch?=0A=
>>=0A=
>> No, without PREEMPT_RT the problem did not yet occur.=0A=
>=0A=
> Have you tried to follow the path from rthal_apc_schedule to=0A=
> rthal_apc_handler to see where the notification gets lost?=0A=
=0A=
I am about to do that. Unfortunately I am not very familiar with ipipe=0A=
implementation. Do you know if there are some tracing or debug =0A=
features that could help me here?=0A=
=0A=
> Also note that calling wake_up_process from primary mode is not a=0A=
> good idea.=0A=
=0A=
Thank for the hint. Actually I had used wake_up_process() only from 2nd =0A=
domain to test if this APC thread was broken or not.=0A=
=0A=
Thanks and regards,=0A=
Christoph=0A=

