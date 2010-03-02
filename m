Message-ID: <4B8D73F9.3020309@domain.hid>
Date: Tue, 02 Mar 2010 21:24:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D55AD.9090901@domain.hid>
	<4B8D5768.7080402@domain.hid>	<4B8D57D4.3040200@domain.hid>
	<4B8D58AB.8090203@domain.hid> <4B8D58F7.80507@domain.hid>
In-Reply-To: <4B8D58F7.80507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Posix mutex unit test fails on git head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles,
>>>>>
>>>>> can you (or someone else) confirm this:
>>>>>
>>>>> # mutex-torture-posix
>>>>> simple_wait
>>>>> simple mutex_lock 1: 1 (Operation not permitted)
>>>>>
>>>>> I'm on a x86_64 target (2.6.32.8 with latest I-pipe), Xenomai is
>>>>> unpatched git head.
>>>>>
>>>> Looks like a bug in the test case: We do not wrap sched_setscheduler
>>>> which it uses, and my config does not auto-shadow main. Fix will follow.
>>> The test works here, but fails in cond_signaler, mutex_lock 2, just
>>> checked out v2.5.1 to see if we already had the bug.
>>>
>> Weird. Works for me with this fix:
>>
>> diff --git a/src/testsuite/unit/mutex-torture.c b/src/testsuite/unit/mutex-torture.c
>> index 70bda14..ebdd4f2 100644
>> --- a/src/testsuite/unit/mutex-torture.c
>> +++ b/src/testsuite/unit/mutex-torture.c
>> @@ -657,7 +657,7 @@ int main(void)
>>  	/* Set scheduling parameters for the current process */
>>  #ifdef XENO_POSIX
>>  	sparam.sched_priority = 2;
>> -	sched_setscheduler(0, SCHED_FIFO, &sparam);
>> +	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparam);
>>  #else /* __NATIVE_SKIN__ */
>>  	rt_task_shadow(&main_tid, "main_task", 2, 0);
>>  #endif /* __NATIVE_SKIN__ */
>>
>>
>> # mutex-torture-posix
>> simple_wait
>> recursive_wait
>> errorcheck_wait
>> mode_switch
>> pi_wait
>> lock_stealing
>> lock_stealing mutex_trylock: not supported
>> simple_condwait
>> recursive_condwait
>> cond_signaler, mutex_lock 2 waited 0.854 us
> 
> No, that is a bug. We should have waited 10ms, and we wait less than a us.
> 

Ok. Should be fixed by commit af93ec87f975b387243127090b578d57922b38dc.
The bug was on the same goddamn pass as the one we are trying to fix to
return proper return values to user-space.

-- 
					    Gilles.

