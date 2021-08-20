Subject: Re: cobalt_assert_nrt should use __cobalt_pthread_kill
References: <DB9PR05MB77239BFB7BA2E64E825FF123F6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
 <cdab0109-de16-94ac-8dbf-3730ca7e46f2@siemens.com>
 <DB9PR05MB7723D7FEF361FED17FE59FD6F6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
 <af676aea-4603-8b63-c79b-287b113e2896@siemens.com>
 <DB9PR05MB7723A667EA6BF755219E741BF6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ef4a0fae-766a-e3af-2b7e-e1a826c528c9@siemens.com>
Date: Fri, 20 Aug 2021 08:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <DB9PR05MB7723A667EA6BF755219E741BF6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 19.08.21 18:54, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 19. August 2021 17:42
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: cobalt_assert_nrt should use __cobalt_pthread_kill
>>
>>
>>
>> CAUTION: External email. Do not click on links or open attachments unless you
>> know the sender and that the content is safe.
>>
>> On 19.08.21 17:24, Lange Norbert wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Donnerstag, 19. August 2021 12:54
>>>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>>>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>>>> Subject: Re: cobalt_assert_nrt should use __cobalt_pthread_kill
>>>>
>>>>
>>>>
>>>> CAUTION: External email. Do not click on links or open attachments
>>>> unless you know the sender and that the content is safe.
>>>>
>>>> On 19.08.21 11:56, Lange Norbert via Xenomai wrote:
>>>>> Hello,
>>>>>
>>>>> I have some small slight issue with the cobalt_assert_nrt function,
>>>>> incase a violation is detected the thread should get a signal, but
>>>>> the implementation will implicitly get a signal during the execution
>>>>> of
>>>> pthread_kill, see:
>>>>>
>>>>>
>>>>> #0  getpid () at ../sysdeps/unix/syscall-template.S:60
>>>>> #1  0x00007fc1dc4fa0d6 in __pthread_kill (threadid=<optimized out>,
>>>>> signo=24) at ../sysdeps/unix/sysv/linux/pthread_kill.c:53
>>>>> #2  0x00007fc1dc8b2470 in callAssertFunction () at
>>>>> /home/lano/git/preload_checkers/src/pchecker.h:199
>>>>> #3  malloc () at
>>>>> /home/lano/git/preload_checkers/src/pchecker_heap_glibc.c:220
>>>>> #4 <actual instrumented function>
>>>>>
>>>>> You see, the signal should happen with the pc of #2, not from the
>>>> implementation of glibc (or whatever c library).
>>>>> So the function should be changed to:
>>>>>
>>>>> void cobalt_assert_nrt(void)
>>>>> {
>>>>>             if (cobalt_should_warn())
>>>>>                         __cobalt_pthread_kill(pthread_self(),
>>>>> SIGDEBUG); }
>>>>>
>>>>> (or even replaced with the raw syscall ?)
>>>>>
>>>>
>>>> Hmm, that's similar to an assert causing a lengthy trace, not failing
>>>> directly at the place where the assert was raised:
>>>>
>>>> #0  0x00007ffff7a3918b in raise () from /lib64/libc.so.6
>>>> #1  0x00007ffff7a3a585 in abort () from /lib64/libc.so.6
>>>> #2  0x00007ffff7a3185a in __assert_fail_base () from /lib64/libc.so.6
>>>> #3  0x00007ffff7a318d2 in __assert_fail () from /lib64/libc.so.6
>>>> #4  0x0000000000400524 in main () at assert.c:5
>>>>
>>>> What is your practical problem with the current implementation? Do
>>>> you expect a specific SIGDEBUG reason?
>>>
>>> A better stacktrace. (I actually cut the trace in the signal handler
>>> in case of hitting an __assert_fail)
>>
>> The backtrace should still point to the right function that caused the migration.
>> I miss cobalt_assert_nrt() in your backtrace though, but that should have
>> nothing to do with how it is implemented. Are you actually using
>> cobalt_assert_nrt() from libcobalt?
> 
> Yes, but I dlsym it.
> I would prefer if the cobalt_assert_nrt would be the start of the trace.
> 

That it always does under normal constraints - please check your local
setup, this is not a generic problem. It's your pchecker.h:199 which
issues the syscall directly, rather than calling cobalt_assert_nrt().
Maybe that's because of lazy symbol resolution?

>>
>>> BTW, __cobalt_pthread_kill(pthread_self(), SIGDEBUG) doesn’t seem to do a
>> thing, doesn’t handle SIGDEBUG?
>>>
>>
>> It only triggers the signal (in one way or another...). Handling is up to the
>> application. If you don't handle that, the application is terminated, obviously.
> 
> The application continues running. But I did not try with __cobalt_pthread_kill(pthread_self(), SIGDEBUG)
> but XENOMAI_SYSCALL2(sc_cobalt_thread_kill, thread, sig).
> Means the cobalt syscall is not handling the signal.

A syscall does not handle signals.

By calling the cobalt version of pthread_kill, you queue the signal for
synchronous RT processing (sigwait).

> 
> So for to satisfy my OCD toggling off/on the modeswitch signals would be correct I guess
> 
> pthread_setmode_np(PTHREAD_WARNSW, 0, NULL);
> pthread_kill(pthread_self(), SIGDEBUG);
> pthread_setmode_np(0, PTHREAD_WARNSW, NULL);
> 
> or even just using a linux syscall:
> 
> getpid();

A syscall will remain the source of the signal, no change on the origin
of the backtrace.

> 
> Point being that right now you trap alteast twice

That is a different point. So far, you were complaining about getting a
wrong backtrace which is not caused by triggering a SIGDEBUG twice. If
you want to prevent a duplicate event, triggering a syscall only or
disabling the warning for the syscall itself can be options. But I
consider this really a minor issue.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

