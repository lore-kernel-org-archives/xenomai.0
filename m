Message-ID: <50E471AC.2000701@siemens.com>
Date: Wed, 02 Jan 2013 18:43:08 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] XNARCH_TIMER_IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

this may involve some refactoring of the HAL and a bit of I-pipe, so I
better ask first:

Not sure when it changed, but XNARCH_TIMER_IRQ may no longer return the
same values when called on different CPUs. Therefore, It should rather
be called XNARCH_THIS_CPU_TIMER_IRQ now.

Looking at its users (an I-pipe debug warning pointed it out), there are
two that don't expect this: xnintr_query_next() and format_irq_proc().
The former actually wants XNARCH_TIMER_IRQ(cpu), the latter needs
something like is_timer_irq_on_any_cpus(irq).

So I would propose to refactor XNARCH_TIMER_IRQ and RTHAL_TIMER_IRQ
accordingly. But this unfortunately requires extensions of I-pipe to
provide something like __ipipe_hrtimer_irq(cpu) and
__ipipe_this_cpu_hrtimer_irq. And some ugly workaround in Xenomai for
older I-pipe versions.

Does this make sense?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

