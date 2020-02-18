Subject: Re: Towards Xenomai on Dovetail
References: <97687b86-9c39-e808-d49c-04b0178d8c31@siemens.com>
From: Philippe Gerum <philippe.gerum@gmail.com>
Message-ID: <3a0bab49-a40f-75d3-9abb-26a7a2e2341c@gmail.com>
Date: Tue, 18 Feb 2020 18:36:45 +0100
MIME-Version: 1.0
In-Reply-To: <97687b86-9c39-e808-d49c-04b0178d8c31@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2/10/20 7:57 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> could you give a rough overview what areas would be just mapping API
> calls, what would be more different and what is simply missing in
> Dovetail in order to place Xenomai on top of it?

By order of trickiness:

- Dovetail assumes the companion core shares the same timekeeping bases
and unit with the common kernel, providing some help in doing so. The
core should switch to nanosecs, ktime_t internally. Typically, MMIO
clock sources which are not architected can be exported directly by the
vDSO (e.g. ARM with its truckload of different clock sources). IOW, no
more tsc-based timekeeping, CLOCK_HOST_REALTIME becomes useless as
clock_gettime() is usable from any context. This deeply affects the
Xenomai timer framework, and the way libcobalt reads time (no need for
tsc->ns conversion, the vDSO delivers nanosecs via clock_gettime()). In
the wake of such change, there would be no reason to keep the arith
support in Xenomai.

- kernel/cobalt/irq.c and related can go. Dovetail integrates the
so-called "out-of-band" IRQ management directly into the mainline genirq
logic. This means Xenomai can switch to the request/free_irq() interface
or related.

- kernel/cobalt/arch/*/ and related can go, almost entirely. There is
direct support for context switching including fpu management for
threads controlled by the companion (e.g. real-time) core. This means
that Xenomai's scheduler core should be adapted to use the available
dovetail interface for this. The workings are explained in the
description of the so-called "alternate scheduling" Dovetail implements [3].

- support for synchronous breakpoints would need to be reworked a bit,
around the ptrace()-related events Dovetail triggers (TASK_PTSTOP,
PTSTEP, PTCONT). As a consequence, the most ugly KEVT_SCHEDULE event is
gone.

- although this would not be a requirement for a port, you could reuse
the native VFS support for out-of-band I/O handling in character drivers
Dovetail brings, in order to drop the RTDM-specific file descriptor
management [2], simplifying things even further.

- the I-pipe tracer has gone in dovetail. ftrace's regular "function
tracer" is safe in all contexts, directly adds information related to
the IRQ pipelining logic. This means the trace* API in Xenomai would
have to be enabled in a different way.

- the APC interface can go entirely, along with the
ipipe_post_root_work() call, all this can be obtained using the regular
irq_work() API now.

- straightforward renames such as ipipe_spin_lock to hard_spin_lock etc.

Although there may be never enough of it, there is still a fair amount
of documentation already available for all of this at [1]. I'm gathering
the bits for writing a document which could be titled "How to write your
own Linux co-kernel on top of Dovetail". This needs time, I'm a slow writer.

The detailed note I sent you in July '18 about how Dovetail was
diverging from the I-pipe is still relevant for the most part. The
update logic for an irqchip to support interrupt pipelining has been
simplified compared to the description in this note though (no more
pipeline-specific handlers basically).

[1] https://evlproject.org/dovetail/
[2] https://evlproject.org/core/kernel-api/
[3] https://evlproject.org/dovetail/altsched/

> 
> BTW, something like a folded Dovetail patch queue does not exist yet,
> does it? Would it make sense to create something like that, or is it
> still too early?
> 

I could add this. Please note that Dovetail API stability across kernel
releases is not guaranteed, although I tend to minimize such changes
when this does not impede improving the code.

-- 
Philippe.

