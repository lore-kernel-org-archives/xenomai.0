Subject: Re: Process load balancing among CPU
References: <32d2a7d6-c915-2cd1-3c74-c005a53fc708@numalliance.com>
 <c1ecb9c1-407b-dfa0-e1f4-12f786ccde54@web.de>
 <e656ac41-3313-1efb-447a-9fcb0e3ba9da@numalliance.com>
 <e8932933-70d7-096e-eb72-083836b28104@web.de>
 <a5302983-26c1-b17a-4ca3-890c995d9bf5@numalliance.com>
 <VI1PR05MB591782B439FBA39C480BB938F66A0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <201098e0-5032-b0f2-1f9d-2e62653708c9@numalliance.com>
Date: Thu, 24 Oct 2019 17:04:42 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591782B439FBA39C480BB938F66A0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: xenomai@xenomai.org


Le 24/10/2019 =C3=A0 16:27, Lange Norbert via Xenomai a =C3=A9crit=C2=A0:
> Nothing has an effect, as the cobalt setup routine binds the main threa=
d to the single core.
> See: https://xenomai.org/pipermail/xenomai/2019-August/041381.html
>
> Every thread you spawn will inherit the same affinity mask (with a sing=
le bit set), and all options (tunables, cmdline) affect the mask *before*=
 the setup then  picks the current core as mask.
> You will need to reset the affinity mask yourself.
>
> Kind regards, Norbert
>
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of St=C3=A9phane
>> Ancelot via Xenomai
>> Sent: Donnerstag, 24. Oktober 2019 16:01
>> To: Jan Kiszka <jan.kiszka@web.de>; xenomai@xenomai.org
>> Subject: Re: Process load balancing among CPU
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> Le 24/10/2019 =C3=A0 12:28, Jan Kiszka a =C3=A9crit :
>>> On 24.10.19 12:21, St=C3=A9phane Ancelot wrote:
>>>> Le 24/10/2019 =C3=A0 12:13, Jan Kiszka a =C3=A9crit :
>>>>> On 24.10.19 10:00, St=C3=A9phane Ancelot via Xenomai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> In our system, I noticed maybe a setup problem, or a xenomai
>>>>>> related setup problem regarding user processes.
>>>>>>
>>>>>> I have 2 user tasks that does not use RT (but xenomai shared memor=
y
>>>>>> access), I noticed that if these both tasks were consuming 50% of
>>>>>> the CPU they were not migrated on other cpus.
>>>>>>
>>>>>> There is no CPU affinity setup in these programs , so I kept the
>>>>>> kernel scheduler doing its job.
>>>>>>
>>>>>> Is this a bad kernel setting or xenomai setting  to allow process
>>>>>> cpu migration for user processes ?
>>>>> There is - by design - no automatic load balancing for Xenomai thre=
ads.
>>>>> The common case is static schedules /wrt RT task for each CPU.
>>>> This is not an RT thread, this is a userspace non rt task linking
>>>> xenomai heap shared memory.
>>>>
>>>> having a look at this page, the documentation states  cpu_affinity
>>>> Defaults to any online CPU.
>>> As long as that non-RT task is in Linux mode and has an affinity mask
>>> that is not reduced to the single core, Linux will happily
>>> load-balance it. But if that task went through shadowing by Xenomai,
>>> its affinity mask was likely reduced.
That did it :

cpu_set_t my_set;
CPU_ZERO(&my_set);
CPU_SET(0,&my_set);
CPU_SET(1,&my_set);
..
if (sched_setaffinity(0, sizeof(cpu_set_t), &my_set) < 0) {
     perror("sched_setaffinity");
}

>> A tunable should permit to change it, but it has no effect
>>
>>       cpu_set_t cpus;
>>       CPU_ZERO(&cpus);
>>       CPU_SET(0,&cpus);
>>       CPU_SET(1,&cpus);
>>       CPU_SET(2,&cpus);
>>       CPU_SET(3,&cpus);
>>
>>       set_config_tunable(cpu_affinity,cpus);
>>
>>> Jan
> ________________________________
>
> This message and any attachments are solely for the use of the intended=
 recipients. They may contain privileged and/or confidential information =
or other information protected from disclosure. If you are not an intende=
d recipient, you are hereby notified that you received this email in erro=
r and that any review, dissemination, distribution or copying of this ema=
il and any attachment is strictly prohibited. If you have received this e=
mail in error, please contact the sender and delete the message and any a=
ttachment from your system.
>
> ANDRITZ HYDRO GmbH
>
>
> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Co=
rporation
>
> Firmensitz/ Registered seat: Wien
>
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>
> Firmenbuchnummer/ Company registration: FN 61833 g
>
> DVR: 0605077
>
> UID-Nr.: ATU14756806
>
>
> Thank You
> ________________________________
