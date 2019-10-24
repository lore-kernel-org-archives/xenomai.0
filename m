Subject: Re: Process load balancing among CPU
References: <32d2a7d6-c915-2cd1-3c74-c005a53fc708@numalliance.com>
 <c1ecb9c1-407b-dfa0-e1f4-12f786ccde54@web.de>
 <e656ac41-3313-1efb-447a-9fcb0e3ba9da@numalliance.com>
 <e8932933-70d7-096e-eb72-083836b28104@web.de>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <a5302983-26c1-b17a-4ca3-890c995d9bf5@numalliance.com>
Date: Thu, 24 Oct 2019 16:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <e8932933-70d7-096e-eb72-083836b28104@web.de>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Le 24/10/2019 =C3=A0 12:28, Jan Kiszka a =C3=A9crit=C2=A0:
> On 24.10.19 12:21, St=C3=A9phane Ancelot wrote:
>> Le 24/10/2019 =C3=A0 12:13, Jan Kiszka a =C3=A9crit=C2=A0:
>>> On 24.10.19 10:00, St=C3=A9phane Ancelot via Xenomai wrote:
>>>> Hi,
>>>>
>>>> In our system, I noticed maybe a setup problem, or a xenomai related
>>>> setup problem regarding user processes.
>>>>
>>>> I have 2 user tasks that does not use RT (but xenomai shared memory
>>>> access), I noticed that if these both tasks were consuming 50% of th=
e
>>>> CPU they were not migrated on other cpus.
>>>>
>>>> There is no CPU affinity setup in these programs , so I kept the ker=
nel
>>>> scheduler doing its job.
>>>>
>>>> Is this a bad kernel setting or xenomai setting=C2=A0 to allow proce=
ss cpu
>>>> migration for user processes ?
>>> There is - by design - no automatic load balancing for Xenomai thread=
s.
>>> The common case is static schedules /wrt RT task for each CPU.
>> This is not an RT thread, this is a userspace non rt task linking
>> xenomai heap shared memory.
>>
>> having a look at this page, the documentation states=C2=A0 cpu_affinit=
y
>> Defaults to any online CPU.
> As long as that non-RT task is in Linux mode and has an affinity mask
> that is not reduced to the single core, Linux will happily load-balance
> it. But if that task went through shadowing by Xenomai, its affinity
> mask was likely reduced.

A tunable should permit to change it, but it has no effect

 =C2=A0=C2=A0=C2=A0 cpu_set_t cpus;
 =C2=A0=C2=A0=C2=A0 CPU_ZERO(&cpus);
 =C2=A0=C2=A0=C2=A0 CPU_SET(0,&cpus);
 =C2=A0=C2=A0=C2=A0 CPU_SET(1,&cpus);
 =C2=A0=C2=A0=C2=A0 CPU_SET(2,&cpus);
 =C2=A0=C2=A0=C2=A0 CPU_SET(3,&cpus);

 =C2=A0=C2=A0=C2=A0 set_config_tunable(cpu_affinity,cpus);

> Jan
