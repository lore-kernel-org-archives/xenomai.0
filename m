Message-ID: <448EB72F.4080007@domain.hid>
Date: Tue, 13 Jun 2006 15:01:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai integration to LTTng and LTTV
References: <448E7C42.3030504@domain.hid>
In-Reply-To: <448E7C42.3030504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jean-Olivier Villemure <jean-olivier.villemure@domain.hid>
Cc: ltt-dev@domain.hid, xenomai@xenomai.org

Jean-Olivier Villemure wrote:
> Hello,
> 
> I'm currently working on my diploma thesis which will finish in December 
> 2006. The first goal of my project is to integrate Xenomai events to 
> LTTng, a task quite simple since creating new events in LTTng is not 
> very difficult. The second goal is to create a new module in the viewer, 
> LTTV, to analyse these specifics events.
> 
> Our idea about the LTTV module is to create a new controlflow module 
> representing realtime task behavior by identifying the start, end, 
> suspend, resume, period, etc...The difference with the current 
> controlflow is that we will not be showing the states of the process, 
> but there will be a line for each task (multiple realtime tasks by 
> process) and identifiers for each important events. Eventualy it will be 
> good to detected problems relating to periodic tasks. If I have enough 
> time, it could also be a good idea to add some statistics.
> 
> If you have any idea relating to Xenomai or LTTng/LTTV, I will 
> considerate them.

The overall idea of getting RT thread-awareness - in terms of behaviour 
- is a fundamentally good one. The key in easily pinpointing problems 
with the help of any tracer is to have a linear view of events (i.e. 
regardless of the context), but also a context-sensitive view (by 
thread, by cpu, by action on a particular synchronzation object, with or 
without asynchronous events listed), and above all, being able to switch 
from one to another in a snap.

Additionally, representing graphically the interrupt states as they 
preempt thread contexts would be very useful to get a clearer view of 
potential race windows. This also means that getting the name of the 
preempted code/routines instead of the simple task identifier would be 
very interesting. This would somehow look like what the I-pipe tracer 
does using an in-kernel mcount() instrumentation, but with 
thread-awareness and context sensitivity added, to filter out unwanted 
events.

In any case, problems with tracers is almost never the lack of available 
data, but rather having way too many data available to be interpreted 
easily. We need a tool that gathers related events (synchronous / 
asynchronous) and allow us to look at them in different ways.

Regarding Xenomai in particular, I'd suggest to focus on the nucleus 
interface (xnpod_*) for building the list of traceable core events, and 
allow for extending those events following the skin abstraction. I.e.
xnpod_suspend_thread() would catch any attempt to block a thread (and 
subsequent wake up on exit), whilst e.g. pthread_mutex_lock(), 
sc_tsuspend() or taskSuspend() would catch the upper logic based on the 
former, for the POSIX, VRTX or VxWorks interfaces/skins.
Going this way is likely to ease the adaptation of that work on top of 
preempt-rt too, since the underlying semantics and levels of abstraction 
would be strictly compatible.

The good news doing so would be that the day Xenomai skins are rebased 
on a preempt-rt kernel, such tool would still work with very few changes 
in this configuration, because the nucleus layer will still be present, 
even if implemented differently to leverage native preemption.

-- 

Philippe.

