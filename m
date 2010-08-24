From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C73F767.9090909@domain.hid>
References: <4C73EC62.80703@domain.hid>
	<1282667450.1961.132.camel@domain.hid>
	<1282668277.1961.139.camel@domain.hid>
	<4C73F767.9090909@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 19:11:45 +0200
Message-ID: <1282669905.1961.161.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] [RFT] ipipe patch for 2.6.35.3-x86
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
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

On Tue, 2010-08-24 at 18:46 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2010-08-24 at 18:30 +0200, Philippe Gerum wrote:
> >> On Tue, 2010-08-24 at 17:59 +0200, Jan Kiszka wrote:
> >>> Hi,
> >>>
> >>> just uploaded a forward port of the 2.6.34 ipipe patch for x86 to latest
> >>> stable 2.6.35.3. It boots and runs fine here in 64-bit mode with Xenomai
> >>> head, but I only ran light tests so far. Anyone interested in upgrading
> >>> the host kernel (I think I read some request recently) is welcome to
> >>> give it a try and report results back (specifically on 32 bit as that is
> >>> a bit out of focus for me ATM). You can download the full git tree from
> >>>
> >>> 	git://git.kiszka.org/ipipe-2.6.git queues/2.6.35-x86
> >>> 	(alternatively also via http://)
> >>>
> >>> Looking forward to feedback,
> >> The comment and the relevant code for 82a7dd3df needs fixing: all
> >> pipeline ports should expose 4 IPIs, named IPIPE_SERVICE_IPI[0-3].
> >> powerpc/SMP has one more up to 2.6.34, but IPI4 will disappear in
> >> 2.6.35. The upcoming arm/SMP port conforms to this requirement as well.
> >> Those are merely pipelined IPI channels, the way the arch-dep section
> >> manages to multiplex them (or not) over the available hw channel(s) is
> >> of course unspecified. The virtual IPI numbers are also unspecified.
> > 
> > Actually, the more I think of it, the less I see the value of checking
> > the parameter passed to such an internal call like __ipipe_send_ipi().
> > There is no user interaction with this code. So removing the test is
> > indeed better.
> > 
> 
> Isn't ipipe_send_ipi() a public API? That's what I was thinking of: if
> at all, then here.

Yes, ipipe_send_ipi() is the public API, calliong into
__ipipe_send_ipi() for a per-arch implementation; I messed up in my
explanation. My point is that your idea to remove the check from
__ipipe_send_ipi seems correct to me, since nobody should send a silly
value to this internal call. The test should be done in ipipe_send_ipi()
once for all, relying on the generic names of the IPIs.

Regarding those names, and unlike I initially thought, ppc64 is still
preventing me from removing IPI4 in 2.6.35, so I guess that for
implementing a generic test, we would have to resort to #ifdef
pollution.

> 
> Jan
> 

-- 
Philippe.



