MIME-Version: 1.0
References: <HE1PR03MB31154FC1C35ABA6CC541A8C9E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
 <702edf30-b134-ac8a-3e41-787a5428ac86@siemens.com>
In-Reply-To: <702edf30-b134-ac8a-3e41-787a5428ac86@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 12 Jun 2020 11:57:36 -0400
Message-ID: <CALLqZ8SVZn3=8OPVQzQ9_t--8eaE+CMU929VX2aBqVHd4Hfddg@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm: ipipe: Add basic I-pipe support for the SAMA5D3
 SoC
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Jun 12, 2020 at 11:22 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 12.06.20 13:41, Jouko Haapaluoma via Xenomai wrote:
> > This patch set adds basic I-pipe support for the SAMA5D3 SoC
> >
> > A few mainline patches need to be applied to the tcb_clksrc driver so
> > that it can be used as the only clocksource. A patch from RT_PREEMPT
> > was also merged to support higher than 32k clkevent frequency.
> >
> > Additional patch was created to increase the clkevent max_delta to 32-bit
> > when TCB has 32-bit channels. This makes it possible to always use high
> > resolution clkevent when 32-bit channels are available.
> >
> > After that the ipipe_timer and clksrc support can be added into tcb_clksrc.
> >
> > Pinctrl-at91 also requires usage of the ipipe_handle_demuxed_irq()
> >
> > Tested with latest ipipe-arm branch ipipe/master (Linux 4.19.82)
> >
> > Alexandre Belloni (4):
> >   ARM: at91: move SoC specific definitions to SoC folder
> >   clocksource/drivers/tcb_clksrc: Stop depending on atmel_tclib
> >   clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
> >   clocksource/drivers/timer-atmel-pit: Rework Kconfig option
> >
> > Benedikt Spranger (1):
> >   clocksource: TCLIB: Allow higher clock rates for clock events
> >
> > Jouko Haapaluoma (3):
> >   tcb_clksrc: Always use high resolution with 32-bit channels
> >   tcb_clksrc: Add ipipe_timer and ipipe_tsc support
> >   pinctrl-at91: Add ipipe pipeline support
> >
> > Tuomo Jauhiainen (1):
> >   mach-at91: Add IPIPE_ARM_KUSER_TSC for SAMA5D3
> >
> >  arch/arm/mach-at91/Kconfig                         |   1 +
> >  drivers/clocksource/Kconfig                        |   5 +-
> >  drivers/clocksource/tcb_clksrc.c                   | 237 +++++++++++++++------
> >  drivers/misc/Kconfig                               |  20 +-
> >  drivers/misc/atmel_tclib.c                         |   2 +-
> >  drivers/pinctrl/pinctrl-at91.c                     |   5 +-
> >  drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
> >  include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} |   4 +-
> >  8 files changed, 189 insertions(+), 87 deletions(-)
> >  rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)
> >
>
> Great, thanks for the patches! I assume Greg will look into them in details.
>
> Regarding the mainline patches: Are they simply missing in 4.19 because
> they were not backported as fixes (feature patches)? Are they safe to be
> applied on a stable branch, i.e. side-effect free for other targets?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Found them, I'll apply them and run a few tests.

