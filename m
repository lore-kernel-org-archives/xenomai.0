From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470B247B.6060805@domain.hid>
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>
	<470A6B28.7020009@domain.hid>
	<bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
	<470AB8DA.5000408@domain.hid> <470B1CA2.8070509@domain.hid>
	<470B247B.6060805@domain.hid>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 23:42:16 +0200
Message-Id: <1192225336.6499.170.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

On Tue, 2007-10-09 at 08:49 +0200, Jan Kiszka wrote:
> Roland Tollenaar wrote:
> > Hi Jan,
> > 
> >>>> But note that we are still sweeping out remaining bugs around this
> >>>> kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
> >>>> broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover,
> >>>> today's
> > 
> >> Just checked again: The problem is still limited to kernels with
> >> CONFIG_HIGH_RES_TIMERS or CONFIG_NO_HZ. So you can already do your tests
> >> with those features disabled and the two mentioned patches applied.
> > I presume the "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
> >>>> broken fasteoi handling" are the patches you are refering to. I also
> > assume these have been posted on xenomai-core and/or adeos-main mailing
> > list. If that is correct I am having some trouble locating them in the
> > ML archives with the labels above. Any other manner I can get hold of
> > those patches?
> 
> This way e.g.:
> 
> http://search.gmane.org/?query=Fix+__ipipe_pin_range_globally&group=gmane.linux.real-time.xenomai.devel
> 
> Alternatively, I attached both for you, adding a third one which is
> relevant if you use Xenomai with --enable-x86-sep.

Warning: the fasteoi patch as inlined is incomplete, and has been fixed
in the latest I-pipe release (i.e. 2.6.22-1.10-07, 2.6.20-1.10-06) --
spinlocking around the IO-APIC manipulation is missing.

-- 
Philippe.



