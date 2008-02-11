Message-ID: <47B093D8.2050605@domain.hid>
Date: Mon, 11 Feb 2008 19:28:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47B0371E0200000100192400@domain.hid>
In-Reply-To: <47B0371E0200000100192400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] T_RRB
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

Hubert Talbot wrote:
> Hi,
> 
> I'm new to Xenomai.
> 
> I am studying xenomai and I would like to kwow how to apply round-robin.
> 
> Specifically, what to do with (do I have to?):
> 
> 	- the kernel configuration
> 
> 		Real-time sub-system/Timing/Enable periodic timing ?
>

Yes. Round-robin scheduling is only available with tick-based timing.

> 	- the timer configuration 
> 
> 		rt_timer_set_mode(rt_timer_ns2ticks(???))  ?
> 

rt_timer_set_mode(ns), to switch the default oneshot mode for the native
API to tick-based.

> 	- the task configuration
> 
> 		rt_task_set_periodic(???)  ?

Not this one; it controls whether your task follows a periodic timeline
using the rt_task_wait_period() service. It's not related to RRB.

> 		rt_task_set_mode(0, T_RRB, 0)    ?

Yes, this one is needed to switch on RRB for the calling task.

> 		rt_task_slice(???)  ?
> 

And this one allows to set the time quantum alloted to the task (in ticks).

> Thanks in advanced.
> 
> Hubert
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

