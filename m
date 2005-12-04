Message-ID: <4392CAD5.3000208@domain.hid>
Date: Sun, 04 Dec 2005 11:54:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie question about priorities of xenomai Threads
References: <4392171A.9070703@domain.hid>
In-Reply-To: <4392171A.9070703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paolo Gai <pj@domain.hid>
Cc: xenomai@xenomai.org

Paolo Gai wrote:
> Dear all,
> 
> My name is Paolo and i am brand new to Xenomai :-)
>

Welcome then.

> I downloaded and installed the stable version of Xenomai, 2.0.1. I tried 
> a few demos, and some POSIX skin examples: they work just fine :-). Then 
> and I started reading the documentation and some code (I have to say it 
> is very well done). Sorry if my first questions will be a little bit 
> simple and obvious.
> 
> I have a first question related to Xenomai Threads priorities and 
> scheduling. In particular I refer to the "Common priority scheme" in the 
> "Life with Adeos" document. What I understood is the following:
> 
> - Xenomai threads have a priority value that is compatible (let's say 
> transparent) between the primary and secondary domain.
> - Xenomai threads in secondary mode and Linux real time threads (let's 
> say those with SCHED_FIFO or SCHED_RR policy) have compatible priority 
> values.
> - Among the pool of ready Xenomai threads, the Xenomai thread with 
> highest priority is scheduled first.
> - If the selected xenomai thread is in secondary mode and there is a 
> Linux thread with higher priority, the Linux thread is scheduled first.
> 
> 
> First example:
> ---------------------
> Suppose that at a rescheduling we have the following thread in the ready 
> queues
> - High Priority -> Linux thread H
> - Medium Priority -> Xenomai thread M in PRIMARY domain
> - Low Priority -> Xenomai thread L in primary domain
> 
> Then, the Xenomai scheduler will select M, and M will be dispatched.
> 
> Second example:
> --------------------------
> - High Priority -> Linux thread H
> - Medium Priority -> Xenomai thread M in SECONDARY domain
> - Low Priority -> Xenomai thread L in primary domain
> 
> Then, the Xenomai scheduler will select M. but M is in secondary mode, 
> which means the Linux kernel will be scheduled. The Linux scheduler 
> knows H (it's a linux thread), M (it's in secondary mode), and maybe 
> about L (if it has been created by UVMs). The Linux scheduler will 
> choose H, and H will be scheduled.
> 
> Is that right?
> 

Yes, it is. In the latter case, Linux gains thread M's priority as a
result of the latter entering the secondary domain, so Linux's priority
scheme applies. As an aside, a point to consider is the role of the
mutable priority of the Linux placeholder thread in the Xenomai
scheduler (aka the "ROOT" thread). With other co-scheduling systems,
this priority never changes, i.e. the placeholder keeps "running" at the
lowest possible priority value, and only gets elected when no more
real-time duties are pending.
With Xenomai, this priority which actually defines the one of the Linux
kernel as a whole within the RT system changes dynamically, so that it
tracks the (Xenomai-based) priority level of any Xenomai thread entering
the secondary mode. Would some primary mode thread with higher
priority than the Linux placeholder in the Xenomai scheduler be awaken - 
regardless of the priority of the task Linux currently runs -, and
execution would resume in primary mode immediately.

The reasoning behind all of this, is that RT systems tend to have
multiple components with different levels of timely response
requirements as they get more complex. Until the advent of native RT
support in the vanilla Linux kernel (ala PREEMPT_RT), only primary
domain execution would bring us truely timely and deterministic
behaviour. With stable and efficient native preemption and priority
enforcement (e.g. PI) inside the Linux kernel, it will become possible
to delegate larger portions of the real-time duties to the secondary
mode, and reuse Linux's rich infrastructure for carrying them on. Btw,
this is exactely the reason why Xenomai talks about "primary" and
"secondary" execution modes since day #1, by constrast with "real-time"
and "non real-time".

This said, primary mode will probably keep the advantage of being
extremely resilient to any change, driver update - or yet undiscovered
latency point - introduced into the vanilla kernel, which given the
increasing complexity of it (and notably to get real-time performances),
should remain a valuable asset for quite a long time for critical
real-time duties requring very short latencies. Secondary mode has the 
notable advantage of giving access to the rich set of native Linux 
services, and especially to be able to use common tools when working 
with Xeno (GDB anyone?). IOW, both modes are orthogonal for a 
significant part of the application spectrum, this is basically why a 
lot of effort is put to have them tightly and seamlessly integrated into 
Xeno.

To sum up, we are basically searching for the best of both worlds, 
without triggering the worst of both hells...

-- 

Philippe.


