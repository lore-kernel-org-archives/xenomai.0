Message-ID: <43BCF138.3060703@domain.hid>
Date: Thu, 05 Jan 2006 11:13:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43BC4FFB.8040709@domain.hid>
In-Reply-To: <43BC4FFB.8040709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] latency tracer update
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi again,
> 
> here comes the first update of the new latency tracer.
> 
>  arch/i386/kernel/entry.S      |   27 +++
>  arch/i386/kernel/ipipe-root.c |    4
>  include/asm-i386/system.h     |   70 +++++++++
>  include/linux/ipipe_trace.h   |    3
>  kernel/ipipe/Kconfig          |   18 ++
>  kernel/ipipe/tracer.c         |  247 +++++++++++++++++++++++-----------
>  6 files changed, 288 insertions(+), 81 deletions(-)
> 
> The list of changes:
> 
>  o save ipipe_trace_freeze() (and only this function!) from NMI context
>  o CONFIG_IPIPE_TRACE_IRQSOFF instrumentation traces the longest
>    hard-IRQs-off phase of the system (regarding limitations see my
>    earlier posting today)
>  o fixed subtle trace mess-up
>  o added some "unlikely" to the tracer's hotpath
>  o added ipipe_trace_{max|frozen}_reset() to the API
> 
> To-do
>  o fix leaking IRQs-off trace
>  o documentation...
> 
> Philippe, I think this should already be merged into Adeos although
> TRACE_IRQSOFF is not perfect yet.
> 

Ok, it's queued for review. I'm busy right now integrating Dmitry's 
shared IRQ infrastructure into all supported archs and revalidating Xeno 
with the shortened interrupt path; once that's done and a first round of 
patches is rolled out, a second one will follow for x86 with the tracer 
fixes.

-- 

Philippe.

