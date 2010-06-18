Message-ID: <4C1B88B1.7050709@domain.hid>
Date: Fri, 18 Jun 2010 16:54:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C1B57D4.6090700@domain.hid>	
	<1276868598.12743.26.camel@domain.hid>	
	<4C1B78BD.7020900@domain.hid>
	<1276871828.12743.58.camel@domain.hid>
In-Reply-To: <1276871828.12743.58.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] irq masking in ipipe_restore_pipeline_head
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
> On Fri, 2010-06-18 at 15:46 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2010-06-18 at 13:26 +0200, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> don't we need this in ipipe_restore_pipeline_head to play safe
>>> I can't see what this is supposed to fix. Any hint?
>> You enter ipipe_restore_pipeline_head with hard IRQs enabled and you
>> don't take the slow path as the domain is not stalled and the passed
>> flags do not change this. Then you leave with hard IRQs disabled. Corner
>> case, but I think it's not per se impossible.
> 
> In fact, the semantics of raw_local_irq_restore() are not that specific,
> looking at various irqflags.h implementations.
> Architectures are allowed to apply a local optimization for that
> routine. They may only re-enable if the flags arg passed says irqs were
> on previously to setting them off (e.g. blackfin), or even test a
> private system variable to know the current hw state and act upon this,
> ignoring the flags argument totally for this purpose (e.g. ppc64). There
> are likely others, since flipping the irq mask is costly for some archs,
> so optimizing makes sense for them.
> 
> In short, __ipipe_restore_pipeline_head() does not guarantee more than
> the kernel does with raw_local_irq_restore(), meaning that it is only
> required to switch irqs on if they were set off by the matching
> __ipipe_test_and_stall_pipeline_head(), but nothing more.
> 
> However, it would make sense to detect such misuse of the interface and
> whine loudly whenever we enter __ipipe_restore_pipeline_head() with irqs
> on.

You mean something like

if (WARN_ON_ONCE(!irqs_disabled_hw()))
	local_irq_disable_hw();

?

(Which leaves the if path even under !CONFIG_BUG. Maybe we want a bit
more optimization.)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

