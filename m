Message-ID: <49358003.1080705@domain.hid>
Date: Tue, 02 Dec 2008 19:35:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
	<49355B5D.8070802@domain.hid> <49355A59.4050600@domain.hid>
	<49357C02.1090001@domain.hid>
In-Reply-To: <49357C02.1090001@domain.hid>
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
>>> Hi Gilles,
>>>
>>> Gilles Chanteperdrix wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>>>> Now, the question is, do you realistically plan to write an application
>>>>>>> which makes no syscall in its real-time loop?
>>>>>> Unlikely, but it may happen in case of programming errors. Anyhow, the
>>>>>> pthreads will run legacy code and it would be a pain to add
>>>>>> pthread_testcancel where necessary. But maybe there is a more elegant
>>>>>> and simple solution to do a defined exit/abort.
>>>>> In case of programming error, enable the xenomai watchdog, it will
>>>>> forcibly kill the problematic thread.
>>>> To give you a more complete answer: most blocking functions are
>>>> cancellation points in the PTHREAD_CANCEL_DEFERRED case, so, you
>>>> probably do not need to add pthread_testcancel at all. The only
>>>> exception is pthread_mutex_lock: this way, cancellation happens for well
>>>> defined mutex states, and you may install cleanup handlers with
>>>> pthread_cleanup_push/pthread_cleanup_pop if ever a thread may be
>>>> destroyed while holding a mutex. With PTHREAD_CANCEL_ASYNCHRONOUS, the
>>>> situation is not that clean.
>>> Well, there seems something wrong with it, also PTHREAD_CANCEL_DEFERRED
>>> with pthread_testcancel does not work reliably and consistently and it
>>> still behaves different on my ARM and PowerPC systems. I have attached
>>> my revised test program allowing to enable/disable various method of
>>> thread creation, setup and cancellation. They all work fine with the
>>> Linux POSIX libraries. With Xenomai, only a few work as expected on my
>>> ARM and PowerPC test systems.
>> Could you explain us exactly what happens
> 
> OK, with the definitions
> 
>   //#define USE_SIGXCPU
>   //#define USE_EXPLICIT_SCHED
>   #define CANCEL_TYPE PTHREAD_CANCEL_DEFERRED
>   //#define CANCEL_TYPE PTHREAD_CANCEL_ASYNCHRONOUS
>   #define USE_TEST_CANCEL
> 
> I get on my ARM MX31ADS system:
> 
>   -bash-3.2# ./cancel-test
>   Real-Time debugging started
>   Segmentation fault
> 
> The program behaves differently when running under gdb but the
> segmentation fault happens somewhere in pthread_cancel. It works better
> on my PowerPC TQM5200 system:

If you want to get the real pc of a segmentation fault on arm, you can
enable "verbose user faults" in the kernel hacking menu and boot the
kernel with user_debug=29, the kernel will then dump the value of the
registers upon segmentation fault. You can also trigger a backtrace dump
by registering a signal handler for the SIGSEGV signal. Note however that:
- the backtrace will lack the inner function call;
- such a signal handler should end with:
signal(sig, SIG_DFL);
raise(sig);
Otherwise you will end up with a lockup.

> 
>   -bash-3.2# ./cancel-test
>   Real-Time debugging started
>   ctrl_func: started at count 0
>   ctrl_func: sleeping for 2sec 500000000ns
>   calc_func: counting till 50
>   calc_func: at count 0
>   calc_func: at count 1
>   calc_func: at count 2
>   calc_func: at count 3
>   calc_func: at count 4
>   calc_func: at count 5
>   calc_func: at count 6
>   calc_func: at count 7
>   calc_func: at count 8
>   calc_func: at count 9
>   calc_func: at count 10
>   calc_func: at count 11
>   calc_func: at count 12
>   calc_func: at count 13
>   calc_func: at count 14
>   calc_func: at count 15
>   calc_func: at count 16
>   calc_func: at count 17
>   calc_func: at count 18
>   calc_func: at count 19
>   calc_func: at count 20
>   calc_func: at count 21
>   calc_func: at count 22
>   ctrl_func: cancel at count 23
>   ctrl_func: stopped at count 23
>   main terminating in 2 seconds...
> 
> But the messages from calc_func are display before the task gets
> actually canceled, which I do not understand.

How do you know that ? I mean messages printed with rt_printf are
printed with a delay, and messages printed with printf are only printed
when the buffer is flushed (which probably happens upon exit in your case).

Also, does the "switchtest" test work on these platforms ? switchtest
uses pthread_cancel and pthread_join too.


 On ARM, it behaves similar
> if I disable explicit setting of the cancellation type:
> 
>   //#define USE_SIGXCPU
> 
>   //#define USE_EXPLICIT_SCHED
> 
>   //#define CANCEL_TYPE PTHREAD_CANCEL_DEFERRED
> 
>   //#define CANCEL_TYPE PTHREAD_CANCEL_ASYNCHRONOUS
> 
>   #define USE_TEST_CANCEL
> 
> 
> Enabling/disabling other options does not work as expected either, like
> using USE_EXPLICIT_SCHED. The cancellation does then not work any more.

Could you try to call pthread_getschedparam to check whether the threads
priority is correct?

> I'm also puzzled why pthread_setschedparam() does make a mode switch
> to secondary mode (sometimes).

That is normal. The glibc caches threads priority value, so we have to
call __real_pthread_setschedparam to update them. This issue has been
solved differently on trunk, but unfortunately, we can not backport this
modification on v2.4.x branch.

-- 
                                                 Gilles.

