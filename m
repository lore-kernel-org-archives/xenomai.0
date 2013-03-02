MIME-Version: 1.0
In-Reply-To: <513069D5.1090508@xenomai.org>
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Sat, 2 Mar 2013 12:13:10 +0100
Message-ID: <CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
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

On Fri, Mar 1, 2013 at 9:41 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/01/2013 09:30 AM, Gilles Chanteperdrix wrote:
>>
>> On 03/01/2013 09:30 AM, Philippe Gerum wrote:
>>
>>> On 03/01/2013 09:26 AM, Gilles Chanteperdrix wrote:
>>>>
>>>> On 03/01/2013 09:22 AM, Philippe Gerum wrote:
>>>>
>>>>> On 02/28/2013 09:22 PM, Thomas De Schampheleire wrote:
>>>>>>
>>>>>> On Thu, Feb 28, 2013 at 9:10 PM, Gilles Chanteperdrix
>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>
>>>>>>> On 02/28/2013 08:19 PM, Ronny Meeus wrote:
>>>>>>>
>>>>>>>> Hello
>>>>>>>>
>>>>>>>> we are using the PSOS interface of Xenomai forge, running completely
>>>>>>>> in user-space using the mercury code.
>>>>>>>> We deploy our application on different processors, one product is
>>>>>>>> running on PPC multicore (P4040, P4080, P4034) and another one on
>>>>>>>> Cavium (8 core device).
>>>>>>>> The Linux version we use is 2.6.32 but I would assume that this is
>>>>>>>> not
>>>>>>>> so relevant.
>>>>>>>>
>>>>>>>> Our Xenomai application is running on one of the cores (affinity is
>>>>>>>> set), while the other cores are running other code.
>>>>>>>>
>>>>>>>> On both architectures we recently start to see issues that one
>>>>>>>> thread
>>>>>>>> is consuming 100% of the core on which the application is pinned.
>>>>>>>> The thread that monopolizes the core is the thread internally used
>>>>>>>> to
>>>>>>>> manage the timers, running at the highest priority.
>>>>>>>> The trigger for running into this behavior is currently unclear.
>>>>>>>> If we only start a part of the application (platform management
>>>>>>>> only),
>>>>>>>> the issue is not observed.
>>>>>>>> We see this on both an old version of Xenomai and a very recent one
>>>>>>>> (pulled from the git repo yesterday).
>>>>>>>>
>>>>>>>> I will continue to debug this issue in the coming days and try
>>>>>>>> isolate
>>>>>>>> the code that is triggering it, but I can use hints from the
>>>>>>>> community.
>>>>>>>> Debugging is complex since once the load starts, the debugger is not
>>>>>>>> reacting anymore.
>>>>>>>> If I put breakpoints in the functions that are called when the timer
>>>>>>>> expires (both oneshot and periodic), the process starts to clone
>>>>>>>> itself and I endup with tens of them.
>>>>>>>>
>>>>>>>> Has anybody seen an issue like this before or does somebody has some
>>>>>>>> hints on how to debug this problem?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> First enable the watchdog. It will send a signal to the application
>>>>>>> when
>>>>>>> detecting a problem, then you can use the watchdog to trigger an
>>>>>>> I-pipe
>>>>>>> tracer trace when the bug happens. You will probably have to increase
>>>>>>> the watchdog polling frequency, in order to have a meaningful trace.
>>>>>>>
>>>>>>
>>>>>> I don't think an I-pipe tracer will be possible when using the Mercury
>>>>>> core, right (xenomai-forge) ?
>>>>>>
>>>>>
>>>>> Correct.
>>>>
>>>>
>>>>
>>>> I do not think so. The way I see it, you can enable the I-pipe tracer
>>>> without CONFIG_XENOMAI.
>>>>
>>>
>>> Mercury has NO pipeline in the kernel.
>>>
>>
>> You mean mercury can not run with an I-pipe kernel?
>>
>
> I mean it does not care about the pipeline, it does not need it. So if this
> is about observing kernel activity, then ftrace should be fine, or possibly
> perf to find out where userland spends time.
>
> --
> Philippe.
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

Hello

An update on the investigation:
I was able to make this issue disappear by changing the timeout value
of the smallest timers we use.
We use a couple of timers with a timeout of 25ms. By enlarging these
to 25sec and the problem is gone.

Yesterday I was also able to see (using the"strace" tool) the process
executing constantly "clone" system calls.
Note that the process we use is large (2Gb) and uses an mlockall call.

In http://stackoverflow.com/questions/4263958/some-information-on-timer-helper-thread-of-librt-so-1/4935895#4935895
I see that a new thread is created when the timer_create is called for
the first time. This thread stays alive until the program exits and is
used to process the timer expiries.
I have the feeling that there is an issue during the creation of this
thread. For example what would happen if the clone operation takes
longer than the time needed to perform the clone operation?
In the past we already observed issues with the clone call that we
could not explain (creation of the clone simply failed on our
application while it was working fine on a smaller application).

Do you guys know whether there is an impact on the clone operation by
this mlockall call?

I will try to make a small test application on which the issue can be
reproduced.

---
Ronny

