Subject: Re: [PATCH 0/8] ipipe-noarch: Pending fixes and cleanups
References: <cover.1553692686.git.jan.kiszka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1878c54a-8055-9647-6275-407928c63c43@xenomai.org>
Date: Wed, 27 Mar 2019 16:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 3/27/19 2:17 PM, Jan Kiszka wrote:
> The ARM-only reverts I sent before. New are some fixes the the ipipe
> tracer, the fix for the ipipe timer ack handler, and a small cleanup of
> grab_timer.
> 
> Jan
> 
> Jan Kiszka (8):
>   ipipe: Revert changes to ARM arch_timer_set_cntkctl
>   Revert "clocksource: imx/imx53: ipipe: add support for user-visible
>     TSC"
>   Revert "clocksource: imx/imx51: ipipe: add support for user-visible
>     TSC"
>   Revert "clocksource: omap/dmtimer: ipipe: add support for user-visible
>     TSC"
>   ipipe: Fix panic output of tracer
>   ipipe: Fix output layout of tracer
>   ipipe: Call present ack and end handlers for timer irq unconditionally
>   ipipe: Drop unneeded NULL check from grab_timer
> 
>  arch/arm/include/asm/arch_timer.h         |  4 ---
>  arch/arm/mach-imx/mach-imx51.c            |  5 ----
>  arch/arm/mach-imx/mach-imx53.c            |  5 ----
>  arch/arm/plat-omap/dmtimer.c              | 17 ++----------
>  arch/arm/plat-omap/include/plat/dmtimer.h |  6 -----
>  kernel/ipipe/timer.c                      | 17 +++++++-----
>  kernel/ipipe/tracer.c                     | 44 +++++++++++++++----------------
>  7 files changed, 34 insertions(+), 64 deletions(-)
> 

Merged. In addition, 4.19/arm is running fine on imx6, imx7 ATM. Preview
at wip/4.19-noarch and wip/4.19-arm from the ipipe-noarch and ipipe-arm
trees respectively. I'll update the master branches in the coming days.

-- 
Philippe.

