Message-ID: <4438E533.7070604@domain.hid>
Date: Sun, 09 Apr 2006 12:42:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Problems using Xenoscope
References: <91clg3-vfp.ln1@domain.hid>	<443826D4.9070507@domain.hid>
	<a3vmg3-6is.ln1@domain.hid>
In-Reply-To: <a3vmg3-6is.ln1@domain.hid>
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
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

Bernhard Walle wrote:
> Hello,
> 
> Philippe Gerum <rpm@xenomai.org> [2006-04-08]:
> 
>>Bernhard Walle wrote:
>>
>>>Hello,
>>>
>>>I have problems using Xenoscope (Xenomai 2.1.0, Xenosim 2.1). The
>>>simulation works, i.e. text messages are printed on the console. I use
>>>the example from
>>>http://www.mail-archive.com/xenomai@xenomai.org.
>>>
>>>The problem is that the traces dialog is empty, there are also no items
>>>in the tree, only
>>>
>>>  - System
>>>     -RT/Interfaces
>>>
>>
>>It's not a bug, it's just that the tracer and some other interface 
>>objects are still missing.
> 
> 
> Just wondering at
> http://www.linux-automation.de/konferenz/papers/Jan_Kiszka_UNI-HANNOVER_RTAI/RTAI-fusion.pdf
> I can see more functionality? Is this because this is RTAI Fusion 0.9
> and I'm trying Xenomai 2.1?
>

Nope, RTAI/fusion is dead, and Xenomai 2.0 is what would have been 
RTAI/fusion 1.0 under other circumstances. This document likely 
reproduces some information found in the simulator's documentation for 
Xenomai, which is itself somehow a copy of the documentation found in 
the original simulator called "CarbonKernel" 
(www.gna.org/projects/carbonkernel/), which does provide these 
functionalities, but for a different simulation system.

The CarbonKernel simulator has been adapted to use the Xenomai real-time 
core instead of its own RTOS simulation models written in C++, so that 
its event-driven engine could be used as a virtual hw architecture for 
running the Xenomai nucleus in a simulation environment. However, due to 
lack of time, a few bits have not been ported from CarbonKernel to the 
Xenomai simulator, including the syscall tracer and some Tcl snippets 
that present a graphical interface for manipulating the active RTOS 
objects while the simulation is running. The core support for these 
features is already available in the Xenomai simulator codebase since 
it's part of the event-driven simulation core, but the outer interfaces 
have not been plugged in.

-- 

Philippe.

