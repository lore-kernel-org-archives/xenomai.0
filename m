Date: Sun, 10 Apr 2011 07:22:08 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110410052208.GA2924@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA0B878.9010106@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, Apr 09, 2011 at 09:50:16PM +0200, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > Richard Cochran wrote:

> >> Update: It is not enough for me to enable IPIPE_DEBUG. The kernels
> >> that boot have all of the XENO_OPT_DEBUG options enabled.
> >>
> >> Disabling XENO_OPT_DEBUG results in a kernel that freezes. I will try
> >> to find out which of these options makes a difference.

Okay, I confused myself on this one:

I don't need XENO_OPT_DEBUG to boot, just IPIPE_DEBUG.

> > Just to have an idea where the issue come from, could you try reverting
> > all the changes which were made on the tsc and timer? i.e. revert to the
> > original ipipe_mach_get_tsc and ipipe_mach_set_dec?
> > 
> The exact commit to revert is this one:
> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cbd591ed5797f105ff45e04cca3bc939388624ea;hp=a2761e92ecd573bc3a3b068d4ebb7cc06313213c

Will do.

> Also please try disabling the FCSE code. This one changed too...

With IPIPE_DEBUG=n and FCSE=n it also boots.

But I really need FCSE guaranteed!

Thanks,
Richard

