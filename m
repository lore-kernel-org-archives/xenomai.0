Subject: Re: Cobalt Preemption of kernel update_fast_timekeeper can cause
 deadlocks
References: <f4c18591165c4b919c85ac90a756af9f@andritz.com>
 <159d2a96-fb82-b974-7958-79367a00a546@xenomai.org>
 <cdc2d93e-3d5b-0d5b-bf17-1a813e0622e2@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <264d7453-7832-f647-9df4-45197a67bbb8@xenomai.org>
Date: Wed, 19 Dec 2018 14:47:15 +0100
MIME-Version: 1.0
In-Reply-To: <cdc2d93e-3d5b-0d5b-bf17-1a813e0622e2@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 12/19/18 1:44 PM, Jan Kiszka wrote:
> On 19.12.18 13:09, Philippe Gerum via Xenomai wrote:
>> On 12/19/18 11:20 AM, Lange Norbert via Xenomai wrote:
>>> There is a deadlock issue that haunted me for several weeks,
>>> it is caused by the kernels update of the user-visible
>>> timekeeping structures used by the VDSO clock_gettime functions.
>>>
>>> The kernel regularly updates a Timestamp structure, which is
>>> accessible in user-mode,
>>> it does so by something akin to a rw-lock in update_fast_timekeeper.
>>>
>>> If cobalt preempts the core during holding the lock, any thread
>>> trying to read the time
>>> will continue to spin. (This alone is an issue IMHO).
>>> If the cobalt thread itself now call the vDSO function as reader,
>>> it will spin on the lock and block the lock from getting released.
>>>
>>>
>>> Either the update_fast_timekeeper funtion should not be preemptible
>>> by cobalt,
>>> or the spin-lock on reading could fallback to the syscall after a
>>> certain amount of retries.
>>>
>>> The later is probably easier to implement, but then could randomly
>>> demote cobalt threads.
>>> (on the other hand, this would be always a demotion on platforms
>>> without the vdso function)
>>>
>>
>> update_vsyscall() is locking the write-side. If the analysis is
>> correct, this patch may help at the expense of a some cycles more
>> spent uninterruptible:
>>
>> diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> b/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> index 9fb89b6e88c3..e9baa57e8385 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> @@ -32,11 +32,14 @@ void update_vsyscall(struct timekeeper *tk)
>>   {
>>       int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
>>       struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
>> +    unsigned long flags;
>>         /* Mark the new vclock used. */
>>       BUILD_BUG_ON(VCLOCK_MAX >= 32);
>>       WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 <<
>> vclock_mode));
>>   +    flags = hard_cond_local_irq_save();
>> +
>>       gtod_write_begin(vdata);
>>         /* copy vsyscall data */
>> @@ -77,6 +80,8 @@ void update_vsyscall(struct timekeeper *tk)
>>         gtod_write_end(vdata);
>>   +    hard_cond_local_irq_restore(flags);
>> +
>>       if (tk->tkr_mono.clock == &clocksource_tsc)
>>           ipipe_update_hostrt(tk);
>>   }
>>
> 
> This should rather be an application bug: An RT (Xenomai) thread is
> apparently using Linux gettimeofday & Co. (glibc) from RT context.

Yes, it definitely is. But the issue is with coping with legacy.
CLOCK_HOST_REALTIME is indeed the best way around this.

 That
> was never supported, we rather have RT services for that
> (CLOCK_HOST_REALTIME).
> 
> We may think about detecting such cases better, though. Norbert, are you
> using native/alchemy APIs?
> 


-- 
Philippe.

