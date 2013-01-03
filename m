Message-ID: <50E5A75B.6090507@siemens.com>
Date: Thu, 03 Jan 2013 16:44:27 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50E471AC.2000701@siemens.com> <50E5A0E4.4000108@xenomai.org>
In-Reply-To: <50E5A0E4.4000108@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XNARCH_TIMER_IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-03 16:16, Gilles Chanteperdrix wrote:
> On 01/02/2013 06:43 PM, Jan Kiszka wrote:
>> Hi,
>>
>> this may involve some refactoring of the HAL and a bit of I-pipe, so I
>> better ask first:
>>
>> Not sure when it changed, but XNARCH_TIMER_IRQ may no longer return the
>> same values when called on different CPUs. Therefore, It should rather
>> be called XNARCH_THIS_CPU_TIMER_IRQ now.
>>
>> Looking at its users (an I-pipe debug warning pointed it out), there are
>> two that don't expect this: xnintr_query_next() and format_irq_proc().
>> The former actually wants XNARCH_TIMER_IRQ(cpu), the latter needs
>> something like is_timer_irq_on_any_cpus(irq).
>>
>> So I would propose to refactor XNARCH_TIMER_IRQ and RTHAL_TIMER_IRQ
>> accordingly. But this unfortunately requires extensions of I-pipe to
>> provide something like __ipipe_hrtimer_irq(cpu) and
>> __ipipe_this_cpu_hrtimer_irq. And some ugly workaround in Xenomai for
>> older I-pipe versions.
>>
>> Does this make sense?
> 
> Made something similar for forge:
> http://git.xenomai.org/?p=xenomai-gch.git;a=commitdiff;h=37ca257af466e7e5fbfb402b39f088487d048fd5;hp=a9971c363fd361b428f12200536bc5a01dff9c05

Oh, great, there is already something usable in the core patches. Fix
for 2.6 will follow.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

