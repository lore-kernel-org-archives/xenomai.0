Message-ID: <441FB2F3.8090202@domain.hid>
Date: Tue, 21 Mar 2006 09:01:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
References: <441EFB6D.8000507@domain.hid> <441F1675.1010703@domain.hid>
	<441F3BE9.5010409@domain.hid>
In-Reply-To: <441F3BE9.5010409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Hi,
>>>
>>>as I started to actually use XENO_ASSERT, I noticed that there is no
>>>infrastructure yet to enable it. CONFIG_XENO_OPT_DEBUG_LEVEL is nowhere
>>>defined. Add this as integer to Kconfig? Or better convert
>>>nucleus/assert.h to CONFIG_OPT_DEBUG for now until we really feel like
>>>we need more than on/off for this? I would vote for the latter ATM.
>>
>>Actually, we already need more than a simple switch: I'd really like the
>>queue debugging option to become a level on its own (say, 4294967295?).
>>I'll add this tomorrow.
> 
> 
> Hmm, raises my old concern again: this "vertical" debugging implies to
> switch everything on when you only want queue debugging. I still think
> we rather need "horizontal" control: switch on queues, asserts, ...

It just depends whether we want to make the assertion mechanism a 
formalized exported feature or not. If there is a limited number of 
"clients", the simpler the better. This said, implementing sub-system 
debug switches instead of global debug levels would still be pretty 
trivial, provided we keep the number of sub-systems within reasonable 
limits (e.g. <= 64).

> 
> This level "4294967295" indicates for me where we may end with: dozens
> of debug levels no one can tell apart, and you have to switch them all
> on to gain the relevant pieces or to be sure that you didn't missed
> anything. I always have the mess in mind we once had in ndiswrapper: for
> serious debugging of the USB layer you had to raise the debug level
> which dragged in bulks of (in this case) useless reports from other
> subsystems.
> 
> A student (Marc Kleine-Budde) once ported some nice debug subsystem into
> an internal project that requested a subsystem ID for every debug
> statement (I think it came from kaffe). At compilation time or even
> later during runtime you could easily select which subsystem should
> start babbling and checking and which one is not that interesting for a
> specific test. I think this is far more useful than debug levels. Queues
> could become such a subsystem, RTDM (with its asserts) another, and so
> forth. Of course, this means maintaining those subsystem IDs at a
> central place, but it's clearer than deciding which level to pick for a
> new debug code.
> 
> Jan
> 


-- 

Philippe.

