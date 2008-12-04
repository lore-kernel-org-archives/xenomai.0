Message-ID: <4937F961.1080605@domain.hid>
Date: Thu, 04 Dec 2008 16:38:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
	<49355B5D.8070802@domain.hid> <49355A59.4050600@domain.hid>
	<49357C02.1090001@domain.hid> <49365C69.5040807@domain.hid>
	<49366B2B.4050705@domain.hid> <493689EB.8000300@domain.hid>
	<4936C9CA.1090507@domain.hid> <4936C897.1000406@domain.hid>
	<4936D1E7.4070006@domain.hid>
	<4936D0B9.6070102@domain.hid> <4936D63F.50501@domain.hid>
	<4936D63B.3050603@domain.hid> <4936DBC1.6030303@domain.hid>
	<4936DBC6.9080805@domain.hid> <4936E5EA.1060008@domain.hid>
	<4936E5EB.9080404@domain.hid> <4937F76D.7040906@domain.hid>
In-Reply-To: <4937F76D.7040906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Wolfgang Grandegger wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>>>>> Running under gdb shows:
>>>>>>>>>>>
>>>>>>>>>>>   Program received signal SIGSEGV, Segmentation fault.
>>>>>>>>>>>   [Switching to Thread 0x4885d4b0 (LWP 1127)]
>>>>>>>>>>>   0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
>>>>>>>>>>>   (gdb) where
>>>>>>>>>>>   #0  0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
>>>>>>>>>>>   #1  0x10001d64 in ctrl_func (parm=0x0) at cancel-test.c:104
>>>>>>>>>>>   #2  0x0ffa98e4 in __pthread_trampoline ()
>>>>>>>>>>>      from /home/wolf/xenomai/lib/libpthread_rt.so.1
>>>>>>>>>>>   #3  0x0ff42a6c in start_thread () from /lib/libpthread.so.0
>>>>>>>>>>>   #4  0x0fdd18a0 in clone () from /lib/libc.so.6
>>>>>>>>>>>   Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>>>>>>>>>>>
>>>>>>>>>>> Is pthread_cancel used from the Linux pthread library? And
>>>>>>>>>>> pthread_testcancel() as well?
>>>>>>>>>> Yes, and I guess, as you said, that it happens because calc_func is dead
>>>>>>>>>> when you try and cancel it.
>>>>>>>>> Yep, but it should not crash.
>>>>>>>> The spec says:
>>>>>>>> The pthread_cancel() function may fail if:
>>>>>>>>
>>>>>>>> [ESRCH]
>>>>>>>>     No thread could be found corresponding to that specified by the
>>>>>>>> given thread ID.
>>>>>>>>
>>>>>>>>
>>>>>>>> So, it is a "may", returning ESRCH, as Xenomai does in kernel-space, is
>>>>>>>> not mandatory.
>>>>>>> I also got the return value ESRCH in another test. Nevertheless, a crash
>>>>>>> is not the expected behaviour, to say the least. Here pthread_cancel()
>>>>>>> obvoiusly get's interrupted and the calc_thread continues. Is it
>>>>>>> possible that pthread_cancel() switches to secondary mode?
>>>>>> pthread_cancel switches to secondary mode if it has to send a signal (if
>>>>>> cancellation is in asynchronous mode, this happens when the target
>>>>>> thread is blocked inside a blocking call). But this should not be a
>>>>>> problem with RPI.
>>>>> I disabled priority coupling in the kernel and it did not help or harm.
>>>>> This test uses PTHREAD_CANCEL_DEFERRED, which is  also the default, if
>>>>> I understood correctly.
>>>> You should definitely enable priority coupling. Even if you use
>>>> PTHREAD_CANCEL_DEFERRED, when you call a blocking call, the cancellation
>>>> is switched for the time of the blocking call to asynchronous. But since
>>>> you do not call any blocking call, I agree that pthread_cancel should
>>>> not switch to secondary mode, it should just set a bit in some TCB
>>>> attached to the target thread.
>>>>
>>>>>> But the problem you should focus on is why the scheduler does not let
>>>>>> pthread_cancel run earlier.
>>>>> Don't know what you mean. The calc_func gets preempted and the ctrl_func
>>>>> calls pthread_cancel as expected...
>>>>>
>>>>>   calc_func: at count 20
>>>>>   calc_func: at count 21
>>>>>   calc_func: at count 22
>>>>>   ctrl_func: cancel at count 23
>>>>>   ^^^^^^^^^
>>>>>   calc_func: at count 23
>>>>>
>>>>> But then it stops somehow in pthread_cancel and calc_func continues to run.
>>>> Yes, but since "ctrl_func: stopped at count 23" does not appear, it
>>>> means that ctrl_func is somehow blocked in pthread_cancel.
>>>>
>>>> Does the test work if calc_func calls nanosleep instead of
>>>> create_load_100ms ?
>>> Yes.
>> So, pthread_cancel works even for threads running in primary mode, when
>> they issue xenomai syscalls.
>>
>>> I'm getting closer now, I think, I hope. pthread_cancel seems only to
>>> work if calc_thread runs in secondary mode. If I set policy and priority
>>> at the beginning of the thread function, nor pthread_setschedparam nor
>>> clock_gettime switches to primary mode and therefore calc_thread runs in
>>> secondary mode. If I add explicit
>>> pthread_set_mode_np(0, PTHREAD_PRIMARY), pthread_cancel is not able to
>>> terminate the calc_thread anymore, even with pthread_testcancel.
>> That is not expected. But this brings me back to my initial question, do
>> you have to work with a real world application that runs without issuing
>> any syscall ?
> 
> If a add long nanosleeps, e.g. 100, 10 or 1 ms, cancellation works but
> it fails with short nanosleeps. A syscall seems not sufficient. I have
> the impression that pthread_cancel needs some time in secondary mode to

When calling nanosleep, the threads spends on time in secondary mode. I
think the problem is rather that only asynchronous cancelation (meaning
cancelation with a signal) works. Setting the cancelation bit somehow
gets lost.

> do it's duties, e.g. mark the thread as canceled. Would it make sense to
> wrap pthread_cancel, and friends to the corresponding kernel functions
> in ksrc/skins/posix?
> Is there a way to force a thread switching to secondary mode?

No, there is no way to force a thread to switch to secondary mode, the
xnshadow_relax call explicitely requires to be called by the target
thread. Before I wrap pthread_cancel, I would really like to understand
why setting a bit with pthread_cancel and testing it with
pthread_testcancel does not work.

What is the trace of your test when run:
- on ARM
- with root thread priority inheritance,
- with USE_EXPLICIT_SCHED and USE_TEST_CANCEL, and CANCEL_TYPE set to
PTHREAD_CANCEL_DEFERRED
- posting a semaphore in ctrl_func before calling nanosleep, and waiting
for that semaphore in main before creating the calc_func thread.

> It might happen that an application does not block due to overload.

IMO, we do not care much about these cases, the watchdog is there to
catch them.

-- 
                                                 Gilles.

