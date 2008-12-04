Message-ID: <49380A1C.2000701@domain.hid>
Date: Thu, 04 Dec 2008 17:49:32 +0100
From: Wolfgang Grandegger <wg@domain.hid>
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
	<4937F961.1080605@domain.hid> <493805E3.30404@domain.hid>
	<49380498.9040505@domain.hid>
In-Reply-To: <49380498.9040505@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Grandegger wrote:
>>>> Gilles Chanteperdrix wrote:
>> [...deletions...]
>>>>> That is not expected. But this brings me back to my initial question, do
>>>>> you have to work with a real world application that runs without issuing
>>>>> any syscall ?
>>>> If a add long nanosleeps, e.g. 100, 10 or 1 ms, cancellation works but
>>>> it fails with short nanosleeps. A syscall seems not sufficient. I have
>>>> the impression that pthread_cancel needs some time in secondary mode to
>>> When calling nanosleep, the threads spends on time in secondary mode. I
>> What do you mean? nanosleep switches to secondary mode?
> 
> I meant spends "no" time in secondary mode. nanosleep does not switch to
> secondary mode.
> 
>>> think the problem is rather that only asynchronous cancelation (meaning
>>> cancelation with a signal) works. Setting the cancelation bit somehow
>>> gets lost.
>>>
>>>> do it's duties, e.g. mark the thread as canceled. Would it make sense to
>>>> wrap pthread_cancel, and friends to the corresponding kernel functions
>>>> in ksrc/skins/posix?
>>>> Is there a way to force a thread switching to secondary mode?
>>> No, there is no way to force a thread to switch to secondary mode, the
>>> xnshadow_relax call explicitely requires to be called by the target
>>> thread. Before I wrap pthread_cancel, I would really like to understand
>>> why setting a bit with pthread_cancel and testing it with
>>> pthread_testcancel does not work.
>>>
>>> What is the trace of your test when run:
>>> - on ARM
>>> - with root thread priority inheritance,
>>> - with USE_EXPLICIT_SCHED and USE_TEST_CANCEL, and CANCEL_TYPE set to
>>> PTHREAD_CANCEL_DEFERRED
>>> - posting a semaphore in ctrl_func before calling nanosleep, and waiting
>>> for that semaphore in main before creating the calc_func thread.
>> The calc_thread is not canceled and a segmentation fault happens.
>> Canceling the calc_thread does *not* work if it's running in primrary
>> mode, nor on ARM, nor on PowerPC. It does work when calc_thread does run
>> in secondary mode, which happened with USE_EXPLICIT_SCHED not set. If
>> you want do to some tests, I could send you my revised test program.
>> My conclusion is that pthread_cancel can not be used to cancel busy
>> realtime threads. I'm going to re-write the program using the native
>> skin and rt_task_delete.
> 
> Yes, but what interests me is how it fails, that is seeing the trace of
> your program.

With pthread_cancel you do not see too much because the rt_printf
messages do not get printed:

-bash-3.2# ./cancel-test
Real-Time debugging started
ctrl_func: started at count 0
Now starting calc_thread (ctrl_started=1)
Segmentation fault

If I comment out pthread_cancel, I get:

-bash-3.2# ./cancel-test
Real-Time debugging started
ctrl_func: started at count 0
Now starting calc_thread (ctrl_started=1)
calc_func: counting till 50
ctrl_func: sleeping for 2sec 500000000ns
calc_func: at count 0
calc_func: at count 1
calc_func: at count 2
calc_func: at count 3
calc_func: at count 4
calc_func: at count 5
calc_func: at count 6
calc_func: at count 7
calc_func: at count 8
calc_func: at count 9
calc_func: at count 10
calc_func: at count 11
calc_func: at count 12
calc_func: at count 13
calc_func: at count 14
calc_func: at count 15
calc_func: at count 16
calc_func: at count 17
calc_func: at count 18
calc_func: at count 19
calc_func: at count 20
calc_func: at count 21
calc_func: at count 22
calc_func: at count 23
ctrl_func: cancel at count 24
ctrl_func: stopped at count 24
calc_func: at count 24
calc_func: at count 25
calc_func: at count 26
calc_func: at count 27
calc_func: at count 28
calc_func: at count 29
calc_func: at count 30
calc_func: at count 31
calc_func: at count 32
calc_func: at count 33
calc_func: at count 34
calc_func: at count 35
calc_func: at count 36
calc_func: at count 37
calc_func: at count 38
calc_func: at count 39
calc_func: at count 40
calc_func: at count 41
calc_func: at count 42
calc_func: at count 43
calc_func: at count 44
calc_func: at count 45
calc_func: at count 46
calc_func: at count 47
calc_func: at count 48
calc_func: at count 49
calc_func: stopped at count 50
Unexpected thread status
main terminating in 2 seconds...

Wolfgang.


