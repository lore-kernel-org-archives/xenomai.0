Message-ID: <2ff1a98a0801150229j3c3cfeb2t59320e3525acd263@domain.hid>
Date: Tue, 15 Jan 2008 11:29:42 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <478C8AD4.8030808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
	<478B8249.90303@domain.hid>
	<2ff1a98a0801140752y5e6e47e2tb9980bfb344522a4@domain.hid>
	<478C8AD4.8030808@domain.hid>
Subject: Re: [Xenomai-help] Xenomai problems on pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernhard Michael <michael.bernhard@domain.hid>
Cc: xenomai@xenomai.org

On Jan 15, 2008 11:28 AM, Bernhard Michael <michael.bernhard@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > Could you try the following:
> > in the version compiled without EABI, in Linux file
> > arch/arm/mach-pxa/time.c, function pxa_timer_interrupt, try removing
> > the do { } while loop in :
> >
> >         do {
> >                 timer_tick();
> > #ifndef CONFIG_IPIPE
> >                 OSSR = OSSR_M0;  /* Clear match on timer 0 */
> > #else /* CONFIG_IPIPE */
> >                 last_jiffy_time += LATCH;
> >                 if (__ipipe_mach_timerstolen)
> >                         next_match = last_jiffy_time + LATCH;
> >                 else
> > #endif /* CONFIG_IPIPE */
> >                 next_match = (OSMR0 += LATCH);
> >         } while( (signed long)(next_match - OSCR) <= 8 );
> >
>
> Gilles, do you mean removing the whole while loop or just removing
> 'do' and 'while'? I will do the test this afternoon.

I meant just removing the do and while. Sorry for the misunderstanding.

-- 
                                               Gilles Chanteperdrix

