MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.1788.84033.579023@domain.hid>
Date: Wed, 10 May 2006 17:30:04 +0200
Subject: Re: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
In-Reply-To: <4461FED6.9010603@domain.hid>
References: <4460FC50.6030904@domain.hid>
	<17504.65186.650064.785243@domain.hid>
	<44610180.30206@domain.hid>
	<17505.60475.312706.601248@domain.hid>
	<4461FED6.9010603@domain.hid>
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
 > >  > > - it does not work on SMP because the kgdb patch uses
 > >  > >   smp_processor_id(), which does not work on SMP over Xenomai domain.
 > >  > > 
 > >  > 
 > >  > Ok, but probably fixable. If simple search&replace in the kgdb patch is
 > >  > not enough, a similar workaround could be applied for now: disallow kgdb
 > >  > usage over SMP.
 > > 
 > > Since we are going to have this problem over and over again for each
 > > patch that we want to adapt to xenomai (ltt comes to my mind), maybe we
 > > could make smp_processor_id() in adeos patch safe to be called over non
 > > root domain by using ipipe_processor_id() when called over non-root
 > > domains.
 > > 
 > > I think there is currently no code that take advantage of the fact that
 > > the fast smp_processor_id() may safely be called over shadow threads, so
 > > the performance penalty of using ipipe_processor_id() will be minimal.
 > > 
 > 
 > What about the potential penalty for normal Linux callers of
 > smp_processor_id()? Would this degrade the overall performance
 > noticeably even if there is now kgdb or ltt? Or should we make this
 > "ipipe-safe" smp_processor_id() optional for such users?

ipipe_current_domain uses ipipe_processor_id, so that replacing
smp_processor_id with :
if (ipipe_current_domain() == ipipe_root_domain)
    return raw_smp_processor_id()

is really stupid...

-- 


					    Gilles Chanteperdrix.

