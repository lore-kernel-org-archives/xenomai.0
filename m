MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.60475.312706.601248@domain.hid>
Date: Wed, 10 May 2006 15:35:55 +0200
Subject: Re: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
In-Reply-To: <44610180.30206@domain.hid>
References: <4460FC50.6030904@domain.hid>
	<17504.65186.650064.785243@domain.hid>
	<44610180.30206@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > BTW, this reminds me the ask for a merging plan of the kgdb support for
 > >  > ipipe - this bug was tracked down via kgdb...
 > > 
 > > There are some issues with the kgdb patch:
 > > - it does not work if the nucleus is compiled as a module, because it
 > >   uses xnpod_current_thread()
 > 
 > I know, but I do not have a clean solution for this yet. A workaround
 > would be to force the nucleus into the kernel via kconfig if the kgdb is
 > enabled. Any other ideas how to detect kernel-only threads (i.e. invalid
 > "current")?

If we suppose that the kgdb patch is made adeos aware, could we ask a
domain-specific callback to be called when not running the root domain ?
This callback would be set by Xenomai in an #ifdef CONFIG_KGDB section.

 > 
 > > - it does not work on SMP because the kgdb patch uses
 > >   smp_processor_id(), which does not work on SMP over Xenomai domain.
 > > 
 > 
 > Ok, but probably fixable. If simple search&replace in the kgdb patch is
 > not enough, a similar workaround could be applied for now: disallow kgdb
 > usage over SMP.

Since we are going to have this problem over and over again for each
patch that we want to adapt to xenomai (ltt comes to my mind), maybe we
could make smp_processor_id() in adeos patch safe to be called over non
root domain by using ipipe_processor_id() when called over non-root
domains.

I think there is currently no code that take advantage of the fact that
the fast smp_processor_id() may safely be called over shadow threads, so
the performance penalty of using ipipe_processor_id() will be minimal.

-- 


					    Gilles Chanteperdrix.

