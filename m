Message-ID: <4A4902F8.4080102@domain.hid>
Date: Mon, 29 Jun 2009 20:07:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48D9A1.40509@domain.hid> <1246289947.4040.20.camel@domain.hid>	
	<4A48E37C.6090106@domain.hid> <1246296525.4040.52.camel@domain.hid>
In-Reply-To: <1246296525.4040.52.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] DYNAMIC_FTRACE vs. I-pipe tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> On Mon, 2009-06-29 at 17:53 +0200, Jan Kiszka wrote: 
>> Philippe Gerum wrote:
>>> But now that
>>> it is right (at least non-x86s are happy with this now), we need
>>> DYNAMIC_FTRACE to enable the tracepoints; otherwise we would only get a
>>> few xenomai symbols in the trace log (seen on x86*/ppc*). As it is, we
>>> do get meaningful traces via /proc/ipipe/trace, but I would not assume
>>> that we could not break the kernel when fiddling with ftrace's debugfs
>>> interface.
>> Look at x86's entry_64.S: Enabling DYNAMIC_FTRACE cannot be correct as
>> it disables direct invocation of a callback handler in favor of runtime
>> patching (around ftrace_stub). And runtime patching goes through int3
>> IIRC. That will break sooner or later.
> 
>>From what I see in this code, dyn traces are injected on the fly under
> stop_machine() callback protection, by emitting a jmp (e8) to the proper
> target (either to skip MCOUNT_SIZE insns, or to branch to ftrace_caller,
> depending on the disabled/enabled status).

Yes, my information was outdated, based on their first approach. They
now no longer patch on demand, but atomically on enable/disable. That
should be safe.

> 
> The main issue I can see at first glance concerns how "atomic"
> stop_machine() can be without any I-pipe awareness. Maybe we could reuse
> the NMI protection hack available.

I would rather go for replacing stop_machine with
ipipe_critical_enter/exit here. Clean cut, no side effects due to other
users of stop_machine (module loading e.g.). NMIs is another issue, but
ftrace's protection mechanism looks OK for us.

> 
> Admittedly, enabling DYNAMIC_FTRACE was a cheap way to get the
> tracepoints back; however, I would rather try to iron the kstop path in
> order to enable dynamic patching (and maybe fix a few other issues),
> rather than dismissing dyn ftrace totally, which would be really helpful
> in pre-production setups.

If we get it ironed so that you can switch on the tracer without risking
to blow up your box, I'm all for it (and would actually start to ship
our kernels with CONFIG_IPIPE_TRACE_MCOUNT).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

