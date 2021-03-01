Subject: Re: Weird semaphore/timeout behaviour with gdbserver
References: <35a5-60392380-18f-48dc0d80@57279928>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70abfb5d-6869-f49e-5e64-8b23daac055e@siemens.com>
Date: Mon, 1 Mar 2021 18:28:47 +0100
MIME-Version: 1.0
In-Reply-To: <35a5-60392380-18f-48dc0d80@57279928>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 26.02.21 17:36, François Legal wrote:
> Le Vendredi, Février 26, 2021 17:17 CET, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>  
>> Le Vendredi, Février 26, 2021 09:08 CET, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>>  
>>> Le Jeudi, Janvier 21, 2021 22:42 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 19.01.21 18:41, François Legal via Xenomai wrote:
>>>>> Le Vendredi, Janvier 08, 2021 19:35 CET, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>>>>>  
>>>>>> Hello,
>>>>>>
>>>>>> Working on ARMv7 with linux 4.4 and xenomai 3.1, I get a strange behaviour when using GDB.
>>>>>> There seem to be troubles with threads pending on semaphores, which do not wake up when sem is posted nor when the timedwait is over.
>>>>>> It does not seem to make a problem with all the semaphores on the software, but at program startup, the behaviour is pretty constant.
>>>>>>
>>>>>> If I start the same program from shell, thread activation works flawlessly.
>>>>>>
>>>>>> ANybody can give a hint on this ?
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> François
>>>>>>
>>>>>>
>>>>>  
>>>>> I've got another case with pulse semaphores with timeout, that outline the same behaviour without gdbserver.
>>>>> I've got 2 threads and 2 pulse semaphores. Thread1 (priority 60) successively pends (with 30s timeout) on SEM1 then posts SEM2, while thread2 (priority 52) posts SEM1 then pends (forever) on SEM2. Both semaphores are initialized at 0.
>>>>> I can see from debug log that Thread1 pends on SEM1, then thread2 posts SEM1 and pends SEM2, then thread1 posts SEM2, then thread2 posts SEM1 then pends SEM2, then thread1 pends SEM1, then nothing happens anymore. I thought thread1 should be unblocked (either by thread2 posting SEM1, or by the 30s timeout) but that never happens.
>>>>>
>>>>> What am I getting wrong here ?
>>>>>
>>>>
>>>> These scenarios are hairy without test cases. Can you derive something
>>>> simple, portable from your problems? There is testsuite/smokey/gdb/gdb.c
>>>> for full automated tests, but already something we can compile and run
>>>> locally here, gdb manually operated, would be fine. It would also allow
>>>> to cross-check on x86 and arm64 to see if this is arch-specific.
>>>>
>>>> Jan
>>>>
>>>> -- 
>>>> Siemens AG, T RDA IOT
>>>> Corporate Competence Center Embedded Linux
>>>  
>>>  
>>> Sorry to reply so late on this, but I've been busy on some other stuff.I tried to write a simple piece of code that reproduces the problem, but with no luck. In the simple case, the sems work as intended (and thus do not need to honor the timeout).
>>> I'm not sure how I can find the answer on this. Also is there any way to check the state of shored objects like semaphores, mutexes, ...
>>> I read the registry should provide this, but I not able to get more entries than what already present in /proc/xenomai/ (heaps, threads and version)
>>>
>>> François
>>>
>>>
>>  
>> I believe I found out why my semaphores behave oddly when under GDB. I checked /proc/xenomai/sched/stats, and saw that almost all of my threads have the 0x400000 bit set (#define XNDBGSTOP 0x00400000 /**< Stopped for synchronous debugging */)
>>
>> So I believe that's perfectly normal for the semaphores not to timeout, because the threads are stopped.
>>
>> What I wonder now, is why this bit got set for all but one thread in the project.
>>
>> Thanks
>>
>> François
>>
>>
>  
> And if I check the same with the simple app I created, I don't see the XNDBGSTOP bit being automagically set when running with GDB

The basic idea behind this bit is that, when some RT thread hits a debug
condition, all other RT threads in the process are stopped immediately
by Xenomai - rather than letting gdb and ptrace to that by sending
non-RT signals. That shall allow to debug the process in a state that
comes closer to what was reality when the break condition occurred. That
is also one aspect the the gdb smokey test validates.

I'm still not sure if you see normal behavior or something odd, though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

