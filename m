Subject: Re: [PATCH 0/4] Dovetail fixes (v5.13)
References: <20210731094934.1799307-1-rpm@xenomai.org>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <ccfa6190-ac98-7e6d-b7fa-6936c211e75e@siemens.com>
Date: Mon, 2 Aug 2021 21:12:16 +0200
In-Reply-To: <20210731094934.1799307-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Philippe,

On 31.07.21 11:49, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The usual pain with synchronizing the virtual and real interrupt
> states. These issues have been detected while porting to v5.14, some
> are reported by CONFIG_DEBUG_LOCKDEP=y.
> 

One of our test boards (Intel XEON D) has an issue with the TSC being
marked unstable because the clocksource watchdog is coming too late.
Could one of these fixes explain that? Something like missed / dropped
interrupts / interrupts not being delivered to Linux?

> Philippe Gerum (4):
>   x86/ioapic: irq_pipeline: unbreak irqflags tracing
>   init: early sync the inband stall with the hardware state
>   x86/fault: dovetail: unbreak irqflags tracing
>   genirq: irq_pipeline: fix inverted check in debug assertion
> 
>  arch/x86/kernel/apic/io_apic.c |  4 ++--
>  arch/x86/mm/fault.c            | 12 ++++++------
>  init/main.c                    |  1 +
>  kernel/irq/pipeline.c          | 10 +++++-----
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

