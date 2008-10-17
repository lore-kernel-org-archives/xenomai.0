Message-ID: <48F844D8.3060601@domain.hid>
Date: Fri, 17 Oct 2008 09:55:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20081016145757.935266172@domain.hid>	<48F76068.7050903@domain.hid>	<48F76362.4010104@domain.hid>
	<48F79F7A.2030304@domain.hid> <48F7B98D.8040000@domain.hid>
	<48F84233.1050003@domain.hid>
In-Reply-To: <48F84233.1050003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/2] Fix and improve task/thread inquire
	services
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> This series fixes the issues around rt_task_inquire I posted yesterday.
>>>>>> Additionally, it introduces an analogous services pthread_inquire_np for
>>>>>> the POSIX skin. That allows, among other things, to implement test cases
>>>>>> for the upcoming fast xnsynch/mutex patches.
>>>>> Ok. Since this applies only for debugging purpose, and displaying
>>>>> whether a task is in primary mode may be use badly by users, maybe we
>>>>> should make this service a shadow syscall, and not export any interface
>>>>> to use it. This would further avoid duplication between the native and
>>>>> posix skins.
>>>> Debugging is not the holy, exclusive business of Xenomai hackers.
>>>>
>>>> The inquire services are useful in libraries as well, when you want to
>>>> check if the caller complies to the call convention ("don't use in
>>>> primary mode", "caller's priority must not exceed X" or whatever).
>>>>
>>>> That said, I'm open for unifying the code, maybe introducing some
>>>> xnthread_inquire.
>>>>
>>> That would be much better than publishing an open interface to fiddle even more
>>> with thread modes via rt_task_set_mode(). I would definitely merge that.
>> Code refactoring is no problem, will work that out. I just want to keep
>> the user interface.
> 
> Looking into this, I come to the conclusion that xnthread_inquire is
> only then a gain if both rt_task_inquire and pthread_inquire_np use the
> same data structure layout. And that means that both need to use the
> same time encodings, not struct timespec vs. RTIME like it is now. That
> would not be beautiful, but feasible (e.g. picking __u64 as type,
> passing nanoseconds). Still, it does not yet convince me.
>

The idea behind xnthread_inquire() is not about replacing rt_task_inquire()
under the hood, but rather to get back only fundamental values, such as the
current thread status, in order to determine whether XNRELAX is set or not for
instance.

XENOMAI_SYSCALL1(__xn_sys_inquire) => xnthread_inquire(xnpod_current_thread())

> Jan
> 


-- 
Philippe.

