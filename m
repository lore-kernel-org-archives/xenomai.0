Subject: Re: [PATCH v2 0/6] ipipe-noarch: IRQ tracing, enabling, and lockdep
 fixes/cleanups
References: <cover.1562874977.git.jan.kiszka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <851500ac-519e-328e-a8b6-0f74ad71b142@xenomai.org>
Date: Tue, 23 Jul 2019 18:39:52 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 7/11/19 9:56 PM, Jan Kiszka wrote:
> This included the patches from v1, the addition (patch 3), and the new
> patches needed to add return codes and irq enabling to some services.
> 
> Jan
> 
> Jan Kiszka (6):
>   ipipe: Restore trace_hardirqs_on_virt_caller
>   ipipe: lockdep: Remove duplicate context checks
>   ipipe: Add missing include for ipipe_root_only
>   ipipe: Let ipipe_enable_irq return an error code
>   ipipe: Activate IRQ in ipipe_enable_irq
>   ipipe: Let ipipe_set_irq_affinity return an error
> 
>  include/linux/ipipe.h           |  6 +++---
>  include/linux/kernel.h          |  1 +
>  kernel/irq/chip.c               | 17 ++++++++++++-----
>  kernel/locking/lockdep.c        |  6 ------
>  kernel/trace/trace_preemptirq.c | 11 +++++++++++
>  5 files changed, 27 insertions(+), 14 deletions(-)
> 

Applied, thanks.

-- 
Philippe.

