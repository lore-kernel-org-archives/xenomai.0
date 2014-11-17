Date: Tue, 18 Nov 2014 00:37:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117233725.GR31920@sisyphus.hd.free.fr>
References: <20141116062956.GO4656@sisyphus.hd.free.fr>
 <20141116094734.GQ4656@sisyphus.hd.free.fr>
 <20141116190830.GH4656@sisyphus.hd.free.fr>
 <20141116192231.GI4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141116192231.GI4656@sisyphus.hd.free.fr>
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

On Sun, Nov 16, 2014 at 08:22:31PM +0100, Gilles Chanteperdrix wrote:
> On Sun, Nov 16, 2014 at 08:08:30PM +0100, Gilles Chanteperdrix wrote:
> > On Sun, Nov 16, 2014 at 10:47:34AM +0100, Gilles Chanteperdrix wrote:
> > > for-raw-ipipe-3.16:
> > >       arm/ipipe: disable stack unwinding in perf interrupt
> > >       modules: allow calling try_module_get/module_put from real-time context
> > >       cortexa9: use arm_global_timer
> > >       arm/ipipe: at91 fixup
> > >       ipipe: use chip irq_startup when needed
> > > 
> > >  arch/arm/boot/dts/imx6qdl.dtsi         |    6 +
> > >  arch/arm/boot/dts/omap4.dtsi           |    6 +
> > >  arch/arm/kernel/perf_event.c           |  765 +++++++++++------------
> > >  arch/arm/kernel/smp_twd.c              |   54 +-
> > >  arch/arm/mach-at91/at91_ipipe.c        |    1 +
> > >  arch/arm/mach-imx/Kconfig              | 1163 ++++++++++++++++++-----------------
> > >  arch/arm/mach-omap2/Kconfig            |    1 +
> > >  drivers/clocksource/arm_global_timer.c |   76 ++-
> > >  include/linux/ipipe.h                  |   20 +-
> > >  kernel/irq/chip.c                      |   50 +-
> > >  kernel/irq/internals.h                 |    3 +
> > >  kernel/irq/irqdesc.c                   |    3 +
> > >  kernel/module.c                        |   20 +-
> > >  13 files changed, 1095 insertions(+), 1073 deletions(-)
> > 
> > Ok, don't pull that one just yet: it is probably just a bunch of
> > whitespace changes which will be problematic with later merges.
> 
> In fact, I ma not ready for 3.16, I just found out that the 3.16
> kernel does not boot on omap3, and have not even started
> build-testing for all the ARM SOCs we support.

Ok, the I-pipe now also runs on omap3, I have found a few more
fixups when build-testing for all the suported SOCs, and have remove
the whitespace damage. The resulting, more reasonable, diffstat:

Gilles Chanteperdrix (6):
      arm/ipipe: more fixups
      arm/ipipe: disable stack unwinding in perf interrupt
      modules: allow calling try_module_get/module_put from real-time context
      cortexa9: use arm_global_timer
      arm/ipipe: at91 fixup
      ipipe: use chip irq_startup when needed

 arch/arm/boot/dts/Makefile                |    6 +++
 arch/arm/boot/dts/omap3-igep0020-3430.dts |   66 ++++++++++++++++++++++++++++----
 arch/arm/boot/dts/omap3430-igep.dtsi      |    5 ++-
 arch/arm/common/timer-sp.c                |    3 +-
 arch/arm/kernel/perf_event.c              |    3 ++
 arch/arm/mach-at91/at91_ipipe.c           |    1 +
 arch/arm/mach-imx/Kconfig                 |    1 +
 arch/arm/mach-imx/common.h                |    2 +-
 arch/arm/mach-imx/time.c                  |    6 ++-
 arch/arm/mach-sa1100/time.c               |    2 +-
 drivers/clocksource/arm_global_timer.c    |    2 +-
 drivers/gpio/gpio-omap.c                  |    2 +-
 include/linux/ipipe.h                     |   20 +---------
 kernel/irq/chip.c                         |   46 +++++++++++++++++++++-
 kernel/irq/internals.h                    |    3 ++
 kernel/irq/irqdesc.c                      |    3 ++
 kernel/module.c                           |    8 ++--
 17 files changed, 139 insertions(+), 40 deletions(-)

I am now going to run regression test on my platforms.

-- 
					    Gilles.

