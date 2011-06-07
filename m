From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Jun 2011 16:23:03 +0200
Message-ID: <1307456583.2148.118.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 0/5] [PULL] ipipe-2.6.38-x86
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2011-06-07 at 16:17 +0200, Jan Kiszka wrote:
> The following changes since commit c6ef3e86ff13163e416f3f91df8a4df2ca36bcb3:
> 
>   ipipe: x86: Fix 64-bit IRQ exit path (2011-06-04 16:16:52 +0200)
> 
> are available in the git repository at:
>   git://git.kiszka.org/ipipe queues/2.6.38-x86
> 
> Shortened summary below. Excluded:
> 
> Jan Kiszka (1):
>       Merge branch 'queues/2.6.38-noarch' into queues/2.6.38-x86
> 
> One last wish: Please create the arch branches by forking off from
> noarch, not from mainline. That avoids needless merge conflicts when
> pulling in noarch updates later on. Thanks!

That should be always the case since 2005 or so... If 2.6.38 escapes
that rule, then this was unintended, because that makes no sense.

> 
> Jan Kiszka (5):
>   ipipe: x86: Fix irq->vector lookup for IRQ_MOVE_CLEANUP_VECTOR
>   ipipe: x86: Optimize ipipe_percpu_domain_data::status accesses
>   ipipe: x86: Fix flags corruption in arch_mangle_irq_bits on 64-bit
>     systems
>   ipipe: x86: Unbreak !CONFIG_SPARSE_IRQ build
>   ipipe: x86: Avoid trashing vector_irq[IRQ_MOVE_CLEANUP_VECTOR] on
>     migration
> 
>  arch/x86/include/asm/ipipe_base.h |    2 --
>  arch/x86/include/asm/irqflags.h   |    2 +-
>  arch/x86/kernel/apic/io_apic.c    |   11 ++++++++---
>  arch/x86/kernel/ipipe.c           |    4 +++-
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 

-- 
Philippe.



