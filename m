Subject: Re: Process load balancing among CPU
References: <32d2a7d6-c915-2cd1-3c74-c005a53fc708@numalliance.com>
 <c1ecb9c1-407b-dfa0-e1f4-12f786ccde54@web.de>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <e656ac41-3313-1efb-447a-9fcb0e3ba9da@numalliance.com>
Date: Thu, 24 Oct 2019 12:21:25 +0200
MIME-Version: 1.0
In-Reply-To: <c1ecb9c1-407b-dfa0-e1f4-12f786ccde54@web.de>
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


Le 24/10/2019 =C3=A0 12:13, Jan Kiszka a =C3=A9crit=C2=A0:
> On 24.10.19 10:00, St=C3=A9phane Ancelot via Xenomai wrote:
>> Hi,
>>
>> In our system, I noticed maybe a setup problem, or a xenomai related
>> setup problem regarding user processes.
>>
>> I have 2 user tasks that does not use RT (but xenomai shared memory
>> access), I noticed that if these both tasks were consuming 50% of the
>> CPU they were not migrated on other cpus.
>>
>> There is no CPU affinity setup in these programs , so I kept the kerne=
l
>> scheduler doing its job.
>>
>> Is this a bad kernel setting or xenomai setting=C2=A0 to allow process=
 cpu
>> migration for user processes ?
> There is - by design - no automatic load balancing for Xenomai threads.
> The common case is static schedules /wrt RT task for each CPU.

This is not an RT thread, this is a userspace non rt task linking=20
xenomai heap shared memory.

having a look at this page, the documentation states cpu_affinity=20
Defaults to any online CPU.

> Jan
