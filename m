Message-ID: <4936C9CA.1090507@domain.hid>
Date: Wed, 03 Dec 2008 19:02:50 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
	<49355B5D.8070802@domain.hid> <49355A59.4050600@domain.hid>
	<49357C02.1090001@domain.hid> <49365C69.5040807@domain.hid>
	<49366B2B.4050705@domain.hid> <493689EB.8000300@domain.hid>
In-Reply-To: <493689EB.8000300@domain.hid>
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
>>>>> Wolfgang Grandegger wrote:
>>>>>> Hi Gilles,
>>>>>>
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Now, the question is, do you realistically plan to write an application
>>>>>>>>>> which makes no syscall in its real-time loop?
>>>>>>>>> Unlikely, but it may happen in case of programming errors. Anyhow, the
>>>>>>>>> pthreads will run legacy code and it would be a pain to add
>>>>>>>>> pthread_testcancel where necessary. But maybe there is a more elegant
>>>>>>>>> and simple solution to do a defined exit/abort.
>>>>>>>> In case of programming error, enable the xenomai watchdog, it will
>>>>>>>> forcibly kill the problematic thread.
>>>>>>> To give you a more complete answer: most blocking functions are
>>>>>>> cancellation points in the PTHREAD_CANCEL_DEFERRED case, so, you
>>>>>>> probably do not need to add pthread_testcancel at all. The only
>>>>>>> exception is pthread_mutex_lock: this way, cancellation happens for well
>>>>>>> defined mutex states, and you may install cleanup handlers with
>>>>>>> pthread_cleanup_push/pthread_cleanup_pop if ever a thread may be
>>>>>>> destroyed while holding a mutex. With PTHREAD_CANCEL_ASYNCHRONOUS, the
>>>>>>> situation is not that clean.
>>>>>> Well, there seems something wrong with it, also PTHREAD_CANCEL_DEFERRED
>>>>>> with pthread_testcancel does not work reliably and consistently and it
>>>>>> still behaves different on my ARM and PowerPC systems. I have attached
>>>>>> my revised test program allowing to enable/disable various method of
>>>>>> thread creation, setup and cancellation. They all work fine with the
>>>>>> Linux POSIX libraries. With Xenomai, only a few work as expected on my
>>>>>> ARM and PowerPC test systems.
>>>>> Could you explain us exactly what happens
>>>> OK, with the definitions
>>>>
>>>>   //#define USE_SIGXCPU
>>>>   //#define USE_EXPLICIT_SCHED
>>>>   #define CANCEL_TYPE PTHREAD_CANCEL_DEFERRED
>>>>   //#define CANCEL_TYPE PTHREAD_CANCEL_ASYNCHRONOUS
>>>>   #define USE_TEST_CANCEL
>>>>
>>>> I get on my ARM MX31ADS system:
>>>>
>>>>   -bash-3.2# ./cancel-test
>>>>   Real-Time debugging started
>>>>   Segmentation fault
>>>>
>>>> The program behaves differently when running under gdb but the
>>>> segmentation fault happens somewhere in pthread_cancel. It works better
>>>> on my PowerPC TQM5200 system:
>>>>
>>>>   -bash-3.2# ./cancel-test
>>>>   Real-Time debugging started
>>>>   ctrl_func: started at count 0
>>>>   ctrl_func: sleeping for 2sec 500000000ns
>>>>   calc_func: counting till 50
>>>>   calc_func: at count 0
>>>>   calc_func: at count 1
>>>>   calc_func: at count 2
>>>>   calc_func: at count 3
>>>>   calc_func: at count 4
>>>>   calc_func: at count 5
>>>>   calc_func: at count 6
>>>>   calc_func: at count 7
>>>>   calc_func: at count 8
>>>>   calc_func: at count 9
>>>>   calc_func: at count 10
>>>>   calc_func: at count 11
>>>>   calc_func: at count 12
>>>>   calc_func: at count 13
>>>>   calc_func: at count 14
>>>>   calc_func: at count 15
>>>>   calc_func: at count 16
>>>>   calc_func: at count 17
>>>>   calc_func: at count 18
>>>>   calc_func: at count 19
>>>>   calc_func: at count 20
>>>>   calc_func: at count 21
>>>>   calc_func: at count 22
>>>>   ctrl_func: cancel at count 23
>>>>   ctrl_func: stopped at count 23
>>>>   main terminating in 2 seconds...
>>>>
>>>> But the messages from calc_func are display before the task gets
>>>> actually canceled, which I do not understand. On ARM, it behaves similar
>>>> if I disable explicit setting of the cancellation type:
>>>>
>>>>   //#define USE_SIGXCPU
>>>>
>>>>   //#define USE_EXPLICIT_SCHED
>>>>
>>>>   //#define CANCEL_TYPE PTHREAD_CANCEL_DEFERRED
>>>>
>>>>   //#define CANCEL_TYPE PTHREAD_CANCEL_ASYNCHRONOUS
>>>>
>>>>   #define USE_TEST_CANCEL
>>>>
>>>>
>>>> Enabling/disabling other options does not work as expected either, like
>>>> using USE_EXPLICIT_SCHED. The cancellation does then not work any more.
>>> The problem is that the way you create threads is racy, you do not know
>>> in which order the two tasks are created, and if ever calc_func is
>>> created before ctrl_func, it will use all the cpu and ctrl_func will not
>>> have a chance to interrupc calc_func.
>> I already put some sleep or ctrl-thread-is-up test before creating
>> calc_thread, which did not help. Also the output above indicates that
>> ctrl_thread did start before calc_thread.
> 
> Unless I am wrong the output above indicates that the test works... What

Yes, on PowerPC it works.

> I am talking about is the cases where the test does not work, especially
>  when USE_EXPLICIT_SCHED is not set.

Right. But I never observed something different. Here is the output from
a previous mail:

  -bash-3.2# ./cancel-test
  Real-Time debugging started
  ctrl_func: policy=1 prio=39
  ctrl_func: started at count 0
  ctrl_func: sleeping for 2sec 500000000ns
  **** nothing showed for 5 seconds ***
  calc_func: policy=1 prio=38
  calc_func: counting till 50
  calc_func: at count 0
  ...
  calc_func: at count 22
  ctrl_func: cancel at count 23
  calc_func: at count 23
  ...
  calc_func: at count 49
  calc_func: stopped at count 50

  Segmentation fault (core dumped)

Running under gdb shows:

  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x4885d4b0 (LWP 1127)]
  0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
  (gdb) where
  #0  0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
  #1  0x10001d64 in ctrl_func (parm=0x0) at cancel-test.c:104
  #2  0x0ffa98e4 in __pthread_trampoline ()
     from /home/wolf/xenomai/lib/libpthread_rt.so.1
  #3  0x0ff42a6c in start_thread () from /lib/libpthread.so.0
  #4  0x0fdd18a0 in clone () from /lib/libc.so.6
  Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Is pthread_cancel used from the Linux pthread library? And
pthread_testcancel() as well?

Wolfgang.



