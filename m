From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 15 Dec 2014 13:29:19 +0000
Message-ID: <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>
References: <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
 <20141211144711.GD21808@hermes.click-hack.org>
 <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
 <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>
 <20141211163807.GD27793@hermes.click-hack.org>
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>,
 <20141215132315.GK11058@hermes.click-hack.org>
In-Reply-To: <20141215132315.GK11058@hermes.click-hack.org>
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

>> > it seems to me as APC interrupts on ipipe got lost. I have added two c=
ounters:=0A=
>> > One increments in schedule_linux_call() when a request for a specific =
application=0A=
>> > task is queued. Another one is incremented in lostage_handler() when t=
he=0A=
>> > specific task was waked up. When I output the counter's values after t=
asks have=0A=
>> > freezed the counter of lostage_handler is exactly one value less than=
=0A=
>> > schedule_linux_call's counter.=0A=
>> >=0A=
>> > And then, when I wake-up APC thread manually all freezed tasks continu=
e for a=0A=
>> > moment, until all are freezing again.=0A=
>>=0A=
>> As said above waking APC thread using=0A=
>>=0A=
>>   wake_up_process(rthal_apc_servers[smp_processor_id()]);=0A=
>>=0A=
>> does reactivate all Xenomai threads for scheduling. Incontrast using=0A=
>>=0A=
>>   rthal_apc_schedule(lostage_apc);=0A=
>>=0A=
>> does not help. So it seems as APC interrupt is pending but won't be  exe=
cuted.=0A=
>>=0A=
>> Any idea?=0A=
>=0A=
> Do you have the same issue if you run a kernel patched with Xenomai=0A=
> and without the PREEMPT_RT patch?=0A=
=0A=
No, without PREEMPT_RT the problem did not yet occur.=0A=
=0A=
Regards,=0A=
Christoph=0A=

