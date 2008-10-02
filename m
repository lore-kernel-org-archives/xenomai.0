Message-ID: <48E4F46A.5060504@domain.hid>
Date: Thu, 02 Oct 2008 18:18:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid> <48E4EE52.2000202@domain.hid>
	<48E4F172.3000400@domain.hid> <48E4F276.7040001@domain.hid>
In-Reply-To: <48E4F276.7040001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_set_priority vs. Linux priority
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Quick question $customer stumbled over: Shouldn't the user space part of
>>>> rt_task_set_priority also (or rather?) adjust the Linux priority of the
>>>> caller? My impression is yes. Actually, translating the native priority
>>>> to sched_setscheduler parameters and calling that service would be
>>>> better, no?
>>> I believe Philippe already fixed that in trunk.
>>>
>> Hmmm... but we are on trunk, just a few weeks old...
>>
>> The scenario, as far as I understood it, is that rt_task_set_priority is
>> called from primary context. But the propagation in
>> xnpod_renice_thread_inner targets relaxed contexts only. Probably that's
>> the core of the issue. We need to propagate the modification when
>> migrating next time. Maybe some flag "update Linux prio" so that we only
>> go that way when actually required.
>>
>> BTW, strike my idea of using plain sched_setscheduler - would kick us
>> out of primary mode unconditionally.
> 
> No, you should use pthread_setschedparam, and yes, it will kick us out
> of primary mode, but we decided that it was preferable to complicated
> alternatives: pthread_setschedparam is the only way for libc to be
> informed of the priority change. Libc has its only idea of what the
> priority of a thread is, so, we can not change the priority only in the
> kernel.

So we should warn the user (in the doc) that rt_task_set_priority will
leave an inconsistent priority distribution between Linux and Xenomai
behind? But what is that propagation path in xnpod_renice_thread_inner
good for then?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

