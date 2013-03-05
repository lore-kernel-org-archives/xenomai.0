MIME-Version: 1.0
In-Reply-To: <5135FC42.3010606@xenomai.org>
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
	<CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
	<CAMJ=MEf7VMen7ikfPFpR=4J4SksHT0yiGpOOZySxNcPfezUfcQ@mail.gmail.com>
	<5135FC42.3010606@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 5 Mar 2013 15:25:36 +0100
Message-ID: <CAMJ=MEeFUSnryBwwrgvz9wCsmgHYo3feffEm5KNsSCUXhAjF_w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Mar 5, 2013 at 3:08 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/05/2013 01:43 PM, Ronny Meeus wrote:
>>
>> On Sat, Mar 2, 2013 at 12:13 PM, Ronny Meeus <ronny.meeus@gmail.com>
>> wrote:
>>>
>>> On Fri, Mar 1, 2013 at 9:41 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>
>>>> On 03/01/2013 09:30 AM, Gilles Chanteperdrix wrote:
>>>>>
>>>>>
>>>>> On 03/01/2013 09:30 AM, Philippe Gerum wrote:
>>>>>
>>>>>> On 03/01/2013 09:26 AM, Gilles Chanteperdrix wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 03/01/2013 09:22 AM, Philippe Gerum wrote:
>>>>>>>
>>>>>>>> On 02/28/2013 09:22 PM, Thomas De Schampheleire wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Thu, Feb 28, 2013 at 9:10 PM, Gilles Chanteperdrix
>>>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 02/28/2013 08:19 PM, Ronny Meeus wrote:
>>>>>>>>>>
>>>>>>>>>>> Hello
>>>>>>>>>>>
>>>>>>>>>>> we are using the PSOS interface of Xenomai forge, running
>>>>>>>>>>> completely
>>>>>>>>>>> in user-space using the mercury code.
>>>>>>>>>>> We deploy our application on different processors, one product is
>>>>>>>>>>> running on PPC multicore (P4040, P4080, P4034) and another one on
>>>>>>>>>>> Cavium (8 core device).
>>>>>>>>>>> The Linux version we use is 2.6.32 but I would assume that this
>>>>>>>>>>> is
>>>>>>>>>>> not
>>>>>>>>>>> so relevant.
>>>>>>>>>>>
>>>>>>>>>>> Our Xenomai application is running on one of the cores (affinity
>>>>>>>>>>> is
>>>>>>>>>>> set), while the other cores are running other code.
>>>>>>>>>>>
>>>>>>>>>>> On both architectures we recently start to see issues that one
>>>>>>>>>>> thread
>>>>>>>>>>> is consuming 100% of the core on which the application is pinned.
>>>>>>>>>>> The thread that monopolizes the core is the thread internally
>>>>>>>>>>> used
>>>>>>>>>>> to
>>>>>>>>>>> manage the timers, running at the highest priority.
>>>>>>>>>>> The trigger for running into this behavior is currently unclear.
>>>>>>>>>>> If we only start a part of the application (platform management
>>>>>>>>>>> only),
>>>>>>>>>>> the issue is not observed.
>>>>>>>>>>> We see this on both an old version of Xenomai and a very recent
>>>>>>>>>>> one
>>>>>>>>>>> (pulled from the git repo yesterday).
>>>>>>>>>>>
>>>>>>>>>>> I will continue to debug this issue in the coming days and try
>>>>>>>>>>> isolate
>>>>>>>>>>> the code that is triggering it, but I can use hints from the
>>>>>>>>>>> community.
>>>>>>>>>>> Debugging is complex since once the load starts, the debugger is
>>>>>>>>>>> not
>>>>>>>>>>> reacting anymore.
>>>>>>>>>>> If I put breakpoints in the functions that are called when the
>>>>>>>>>>> timer
>>>>>>>>>>> expires (both oneshot and periodic), the process starts to clone
>>>>>>>>>>> itself and I endup with tens of them.
>>>>>>>>>>>
>>>>>>>>>>> Has anybody seen an issue like this before or does somebody has
>>>>>>>>>>> some
>>>>>>>>>>> hints on how to debug this problem?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> First enable the watchdog. It will send a signal to the
>>>>>>>>>> application
>>>>>>>>>> when
>>>>>>>>>> detecting a problem, then you can use the watchdog to trigger an
>>>>>>>>>> I-pipe
>>>>>>>>>> tracer trace when the bug happens. You will probably have to
>>>>>>>>>> increase
>>>>>>>>>> the watchdog polling frequency, in order to have a meaningful
>>>>>>>>>> trace.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I don't think an I-pipe tracer will be possible when using the
>>>>>>>>> Mercury
>>>>>>>>> core, right (xenomai-forge) ?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Correct.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I do not think so. The way I see it, you can enable the I-pipe tracer
>>>>>>> without CONFIG_XENOMAI.
>>>>>>>
>>>>>>
>>>>>> Mercury has NO pipeline in the kernel.
>>>>>>
>>>>>
>>>>> You mean mercury can not run with an I-pipe kernel?
>>>>>
>>>>
>>>> I mean it does not care about the pipeline, it does not need it. So if
>>>> this
>>>> is about observing kernel activity, then ftrace should be fine, or
>>>> possibly
>>>> perf to find out where userland spends time.
>>>>
>>>> --
>>>> Philippe.
>>>>
>>>>
>>>> _______________________________________________
>>>> Xenomai mailing list
>>>> Xenomai@xenomai.org
>>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>>
>>>
>>> Hello
>>>
>>> An update on the investigation:
>>> I was able to make this issue disappear by changing the timeout value
>>> of the smallest timers we use.
>>> We use a couple of timers with a timeout of 25ms. By enlarging these
>>> to 25sec and the problem is gone.
>>>
>>> Yesterday I was also able to see (using the"strace" tool) the process
>>> executing constantly "clone" system calls.
>>> Note that the process we use is large (2Gb) and uses an mlockall call.
>>>
>>> In
>>> http://stackoverflow.com/questions/4263958/some-information-on-timer-helper-thread-of-librt-so-1/4935895#4935895
>>> I see that a new thread is created when the timer_create is called for
>>> the first time. This thread stays alive until the program exits and is
>>> used to process the timer expiries.
>>> I have the feeling that there is an issue during the creation of this
>>> thread. For example what would happen if the clone operation takes
>>> longer than the time needed to perform the clone operation?
>>> In the past we already observed issues with the clone call that we
>>> could not explain (creation of the clone simply failed on our
>>> application while it was working fine on a smaller application).
>>>
>>> Do you guys know whether there is an impact on the clone operation by
>>> this mlockall call?
>>>
>>> I will try to make a small test application on which the issue can be
>>> reproduced.
>>>
>>> ---
>>> Ronny
>>
>>
>> I'm able to reproduce the issue on a small test build:
>>
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <sys/types.h>
>> #include <sys/mman.h>
>> #include <psos.h>
>> #include <copperplate/init.h>
>> #include <stdlib.h>
>> #include <string.h>
>>
>> static void foo (u_long a0, u_long a1, u_long a2, u_long a3)
>> {
>>          u_long ret, ev = 0, tmid,tmid2;
>>
>>          ret = tm_evevery(1,1,&tmid);
>>          ret = tm_evafter(30000,4,&tmid2);
>>          while (1) {
>>                  ret = ev_receive(0xFF,EV_ANY|EV_WAIT,0,&ev);
>>                  if (ev & 4) {
>>                          printf("%lx Restarting one-shot timer.
>> ev=%lx\n",ret,ev);
>>                          tm_evafter(30000,4,&tmid2);
>>                  }
>>                  ev = 0;
>>          }
>>          tm_wkafter(100);
>> }
>>
>> int main(int argc, char * const *argv)
>> {
>>          u_long ret, tid = 0, args[4];
>>
>>          mlockall(MCL_CURRENT | MCL_FUTURE);
>>          copperplate_init(&argc,&argv);
>>
>>          ret = t_create("TEST",97, 0, 0, 0, &tid);
>>          printf("t_create(tid=%lu) = %lu\n", tid, ret);
>>          args[0] = 1;
>>          args[1] = 2;
>>          args[2] = 3;
>>          args[3] = 4;
>>          ret = t_start(tid, 0, foo, args);
>>          printf("t_start(tid=%lu) = %lu\n", tid, ret);
>>
>>          while (1)
>>                  tm_wkafter(100);
>>          return 0;
>> }
>>
>> The TEST task starts 2 timers: one periodic and one 1shot timer.
>> Each time the one-shot timer expires, a print is done and the timer is
>> restarted.
>>
>> Observation is that once the one-shot timer expires, the application
>> starts to use 100% cpuload on one core and the application code is not
>> executed anymore. So it looks like there is constant processing in
>> either Xenomai or the library code to process the timer handling. If
>> periodic timers are used the issue is not observed.
>>
>
> I can't reproduce this bug using that test code, over glibc 2.15/x86. We
> might have a problem with SIGEV_THREAD. Which glibc release are you running?
>
> Also, do you observe the same issue with a larger event interval for the
> periodic timer (e.g. 1000 ticks)?
>
> --
> Philippe.

Philippe,
this is the output I see:

# taskset 4 /tmp/simple_tm_cancel.exe  &
#    0"000.506| WARNING: [main] Xenomai compiled with partial debug enabled,
                              high latencies expected [--enable-debug=partial]
t_create(tid=273617536) = 0
t_start(tid=273617536) = 0
0 Restarting one-shot timer. ev=6

After this I see a cpuload of 100%.
The zero on the beginning of the line is the return value of the ev_receive.

If I change the timeout value to a large value I also see the issue.
It seems to start using long as soon as the one-shot timer expires /
gets restarted.

This is the information about the library we use:

GNU C Library stable release version 2.9, by Roland McGrath et al.
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.3.3.
Compiled on a Linux >>2.6.18-274.el5xen<< system on 2012-02-15.
Available extensions:
        crypt add-on version 2.1 by Michael Glad and others
        Native POSIX Threads Library by Ulrich Drepper et al
        Support for some architectures added on, not maintained in glibc core.
        BIND-8.2.3-T5B
For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.

Ronny

