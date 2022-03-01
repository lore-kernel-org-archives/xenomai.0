Message-ID: <58ee662f-d3b1-eb4a-8e9a-e93d0e2485a2@siemens.com>
Date: Tue, 1 Mar 2022 21:31:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] y2038: cobalt: posix/signal: Take care of compat mode
 for sigtimedwait64
Content-Language: en-US
References: <20220221132504.55876-1-florian.bezdeka@siemens.com>
 <20220221132504.55876-4-florian.bezdeka@siemens.com>
 <8a1ce332-c142-332b-3a00-b31944d0073d@siemens.com>
 <eb4b93a1-26cc-1031-d1a7-1bfd3aa010c7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <eb4b93a1-26cc-1031-d1a7-1bfd3aa010c7@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
Cc: johannes.lauenstein@siemens.com

On 01.03.22 21:27, Florian Bezdeka wrote:
> On 01.03.22 19:28, Jan Kiszka wrote:
>> On 21.02.22 14:25, Florian Bezdeka wrote:
>>> The compat syscall was previously routed to the native entrypoint.
>>> While the timeout is always based on time64_t the siginfo has to be
>>> handled different in compat mode.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
>>> index 1c83ff4e3..3986b227b 100644
>>> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
>>> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
>>> @@ -64,6 +64,7 @@ __COBALT_CALL32emu_THUNK(sendmsg)
>>>  __COBALT_CALL32emu_THUNK(mmap)
>>>  __COBALT_CALL32emu_THUNK(backtrace)
>>>  __COBALT_CALL32emu_THUNK(mq_timedreceive64)
>>> +__COBALT_CALL32emu_THUNK(sigtimedwait64)
>>>  __COBALT_CALL32emu_THUNK(recvmmsg64)
>>>  
>>>  #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
>>
>> There are way more new 64-bit calls. Matching their original versions
>> against this header, I would say we need more thunks, no?
> 
> They are necessary only if there is special handling for compat mode
> needed. Most of the y2038 related syscalls do not need special
> handling in compat mode as "struct timespec" is now the same in both
> worlds.
> 
> I have some cleanup patches pending, which actually will reduce the
> number of compat stubs. See [1]. It seems I overlooked some header
> magic adding the compat syscalls into the syscall table at a fixed
> offset. So we do not have to care "manually".
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/florian/y2038
> 

OK, but...

>>
>> for time64func in $(git grep 64, kernel/cobalt/posix/syscall32.c | \
>>   sed 's/.*(\([^6]*\)64,.*/\1/'); do
>>     git grep -q $time64func \
>>       kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h && \
>>         echo $time64func; done
>>
>> sem_timedwait
>> clock_getres
>> clock_gettime
>> clock_settime
>> clock_nanosleep
>> mutex_timedlock
>> cond_wait_prologue
>> mq_timedsend
>> mq_timedreceive
>> sigtimedwait
>> monitor_wait
>> event_wait
>> recvmmsg
>>
>> We now have mq_timedreceive64, sigtimedwait64 and recvmmsg64 with
>> thunks. There rest is missing, no?
>>
>> Interestingly, we also have no thunk for old recvmmsg so far. Probably a
>> bug of it own.
>>

...after your cleanups, we should look at this list again. If there is a
compat function, don't there need to be thunk as well?

In the end, we urgently need testing, not only for the new time64 code
paths.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

