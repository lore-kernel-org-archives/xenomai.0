Date: Sun, 16 Nov 2014 20:08:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141116190830.GH4656@sisyphus.hd.free.fr>
References: <20141116062956.GO4656@sisyphus.hd.free.fr>
 <20141116094734.GQ4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141116094734.GQ4656@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] Pull requests.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sun, Nov 16, 2014 at 10:47:34AM +0100, Gilles Chanteperdrix wrote:
> for-raw-ipipe-3.16:
>       arm/ipipe: disable stack unwinding in perf interrupt
>       modules: allow calling try_module_get/module_put from real-time context
>       cortexa9: use arm_global_timer
>       arm/ipipe: at91 fixup
>       ipipe: use chip irq_startup when needed
> 
>  arch/arm/boot/dts/imx6qdl.dtsi         |    6 +
>  arch/arm/boot/dts/omap4.dtsi           |    6 +
>  arch/arm/kernel/perf_event.c           |  765 +++++++++++------------
>  arch/arm/kernel/smp_twd.c              |   54 +-
>  arch/arm/mach-at91/at91_ipipe.c        |    1 +
>  arch/arm/mach-imx/Kconfig              | 1163 ++++++++++++++++++-----------------
>  arch/arm/mach-omap2/Kconfig            |    1 +
>  drivers/clocksource/arm_global_timer.c |   76 ++-
>  include/linux/ipipe.h                  |   20 +-
>  kernel/irq/chip.c                      |   50 +-
>  kernel/irq/internals.h                 |    3 +
>  kernel/irq/irqdesc.c                   |    3 +
>  kernel/module.c                        |   20 +-
>  13 files changed, 1095 insertions(+), 1073 deletions(-)

Ok, don't pull that one just yet: it is probably just a bunch of
whitespace changes which will be problematic with later merges.

-- 
					    Gilles.

