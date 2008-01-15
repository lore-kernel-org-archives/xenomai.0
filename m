Message-ID: <2ff1a98a0801150509w2dae4826r4696cd95c21aecb3@domain.hid>
Date: Tue, 15 Jan 2008 14:09:57 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <478CAB5F.70208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
	<478B8249.90303@domain.hid>
	<2ff1a98a0801140752y5e6e47e2tb9980bfb344522a4@domain.hid>
	<478CAB5F.70208@domain.hid>
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

On Jan 15, 2008 1:47 PM, Bernhard Michael <michael.bernhard@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > It looks like we have two issues:
> > - one issue is that compiling with the EABI toolchain generates a lot
> > of unaligned access, which causes a crash, when the fault handler gets
> > invoked at the wrong time. To solve this issue, I will check if we can
> > allow the unaligned access to be handled in primary mode under some
> > condition (it will need at least, a valid linux stack)
> > - another issue is that there is something wrong with Linux timer
> > interrupt handling, which causes the soft lockups and weird timer
> > behaviour.
> >
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
> Gilles, I removed 'do' and 'while' as you suggested but the kernel does
> not boot. The last boot messages before the kernel stalls are the following:
>
> ...
> PID hash table entries: 256 (order: 8, 1024 bytes)
> I-pipe 1.8-03: pipeline enabled.
> start_kernel(): bug: interrupts were enabled early
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 64MB = 64MB total
> Memory: 61568KB available (2928K code, 279K data, 104K init)

Ok, it means that vanilla linux needs the do { } while loop. Let us
try something else: put back the do and while. And modify the function
pxa_timer_init. Replace:

OSMR0 = OSCR + LATCH;

with:

last_jiffy_time = OSCR;
OSMR0 = last_jiffy_time + LATCH;

-- 
                                               Gilles Chanteperdrix

