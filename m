Message-ID: <5130663F.7070209@xenomai.org>
Date: Fri, 01 Mar 2013 09:26:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org>
In-Reply-To: <51306545.1010200@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 03/01/2013 09:22 AM, Philippe Gerum wrote:

> On 02/28/2013 09:22 PM, Thomas De Schampheleire wrote:
>> On Thu, Feb 28, 2013 at 9:10 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 02/28/2013 08:19 PM, Ronny Meeus wrote:
>>>
>>>> Hello
>>>>
>>>> we are using the PSOS interface of Xenomai forge, running completely
>>>> in user-space using the mercury code.
>>>> We deploy our application on different processors, one product is
>>>> running on PPC multicore (P4040, P4080, P4034) and another one on
>>>> Cavium (8 core device).
>>>> The Linux version we use is 2.6.32 but I would assume that this is not
>>>> so relevant.
>>>>
>>>> Our Xenomai application is running on one of the cores (affinity is
>>>> set), while the other cores are running other code.
>>>>
>>>> On both architectures we recently start to see issues that one thread
>>>> is consuming 100% of the core on which the application is pinned.
>>>> The thread that monopolizes the core is the thread internally used to
>>>> manage the timers, running at the highest priority.
>>>> The trigger for running into this behavior is currently unclear.
>>>> If we only start a part of the application (platform management only),
>>>> the issue is not observed.
>>>> We see this on both an old version of Xenomai and a very recent one
>>>> (pulled from the git repo yesterday).
>>>>
>>>> I will continue to debug this issue in the coming days and try isolate
>>>> the code that is triggering it, but I can use hints from the
>>>> community.
>>>> Debugging is complex since once the load starts, the debugger is not
>>>> reacting anymore.
>>>> If I put breakpoints in the functions that are called when the timer
>>>> expires (both oneshot and periodic), the process starts to clone
>>>> itself and I endup with tens of them.
>>>>
>>>> Has anybody seen an issue like this before or does somebody has some
>>>> hints on how to debug this problem?
>>>
>>>
>>> First enable the watchdog. It will send a signal to the application when
>>> detecting a problem, then you can use the watchdog to trigger an I-pipe
>>> tracer trace when the bug happens. You will probably have to increase
>>> the watchdog polling frequency, in order to have a meaningful trace.
>>>
>>
>> I don't think an I-pipe tracer will be possible when using the Mercury
>> core, right (xenomai-forge) ?
>>
> 
> Correct.


I do not think so. The way I see it, you can enable the I-pipe tracer
without CONFIG_XENOMAI.

-- 
                                                                Gilles.

