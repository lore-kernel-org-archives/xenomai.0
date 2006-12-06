From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Wed, 6 Dec 2006 09:19:28 +0100
References: <E1GrHXk-00023w-Oq@domain.hid>
	<200612051934.14391.Sebastian.Smolorz@domain.hid>
	<4575BFBF.1080306@domain.hid>
In-Reply-To: <4575BFBF.1080306@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1Grrzu-0008JP-G8@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >>
> >> Try if smaller CONFIG_IPIPE_TRACE_SHIFT makes it boot without
> >> CONFIG_IPIPE_TRACE_VMALLOC.
> >
> > I already tried that but it didn't help. First with IPIPE_TRACE_SHIFT set
> > to 10 and after modifying Kconfig.debug with a value of 5. Booting
> > impossible.
>
> What about starting disabled and arming the tracer later via
> /proc/ipipe/trace/enable? This sounds like it's not a size issue
> (TRACE_SHIFT=5 is ridiculous small), rather some memory section is
> accessed too early.

It seems to be a combined problem. When the tracer is disabled at boot time, 
the system starts if IPIPE_TRACE_SHIFT < 14, but not if >= 14. With the 
tracer enabled at boot time the IPIPE_TRACE_SHIFT value is not relevant, no 
boot at all.

But the freeze lasts again a long time (between 90-100). I wonder if this is 
related to the ARM cache nature.

--
Sebastian

