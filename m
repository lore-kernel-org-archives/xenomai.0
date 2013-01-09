Message-ID: <50ED70F0.8020608@siemens.com>
Date: Wed, 09 Jan 2013 14:30:24 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50ebff2e488690.18102992@wp.pl> <50EC76E9.30002@xenomai.org>
	<50EC8A6D.2060702@web.de>
In-Reply-To: <50EC8A6D.2060702@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-08 22:06, Jan Kiszka wrote:
> On 2013-01-08 20:43, Gilles Chanteperdrix wrote:
>> On 01/08/2013 12:12 PM, Mariusz Janiak wrote:
>>
>>> Hi GIlles,
>>>
>>> As you suggested, I have prepared simple test case that demonstrate how Xenomai is utilized by OROCOS. This test case behaves exactly the same like helloword example. Scheduler is chosen before any mutex are processed, so in my opinion it is not the case which you defined. What is really surprising is that the replacing TM_NONBLOCK with TM_INFINITE, in one before last line, do magic and suppress signal generation. Furthermore, there is no call to 'rt_task_set_mode(0, T_WARNSW, NULL);' so why 
>>> signal is generated? If we enable T_WARNSW in the thread, SIGXCPU is generated when mutex is locked first time in the thread. 
>>
>>
>> I guess the test could be simpler, simply:
>>
>> rt_mutex_acquire
>> rt_task_create
>> rt_mutex_release
>> rt_mutex_acquire
>> rt_mutex_release
>>
>> Anyway, calling rt_task_create while holding a real-time mutex is itself
>> a priority inversion: any thread in primary mode waiting for the mutex
>> will now have to wait for task running in secondary mode, so may be
>> block during an unbounded amount of time. So, using a real-time mutex
>> for this is completely useless you should be using a glibc
>> pthread_mutex_t. If compiling for the posix skin, use
>> __real_pthread_mutex_lock.
>>
>> Now, how this can cause the issue you observe remains to be understood,
>> and probably requires a fix.
> 
> OK, second try: We do not update the new owner's hrescnt if we acquire a
> mutex via trylock. This applies both to rt_mutex_acquire_inner and
> pthread_mutex_trylock. Probably, this should be done in the
> corresponding syscall wrapper as both services are also used for the
> in-kernel API.

Here is the corresponding patch:
http://www.xenomai.org/pipermail/xenomai-git/2013-January/000336.html

Adding it to the inner functions turned out to be cleaner. I also queued
a patch to change the reason code when reporting a rescnt imbalance in
the future. Please review/merge.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

