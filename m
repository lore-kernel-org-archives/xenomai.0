Subject: Re: [Xenomai-core] [rfc, patch] allow timer interrupt to be shared.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1155904566.4326.65.camel@domain.hid>
References: <17636.56428.140050.265677@domain.hid>
	<1155898533.4326.50.camel@domain.hid>
	<17637.41333.124122.921988@domain.hid>
	<1155904566.4326.65.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:39:53 +0200
Message-Id: <1155904794.4326.69.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2006-08-18 at 14:36 +0200, Philippe Gerum wrote:
> On Fri, 2006-08-18 at 13:16 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >  > I'd rather keep the number of obscure conditional macros as low as
> >  > possible; we should actually try to reduce them since we have a growing
> >  > number of real and pseudo-archs to support, and those macros tend to
> >  > obfuscate the generic code.
> >  > 
> >  > In the same vein, is there anything we could use in the compatible Adeos
> >  > patch that would unambiguously identify the presence of such support
> >  > without resorting to yet-another-macro like IPIPE_HAVE_SHARED_TIMER_IRQ?
> > 
> > We could decide that ipipe_timer_irq_p() must be implemented as a macro,
> > and use #ifdef ipipe_timer_irq_p but I thought that #ifdef
> > IPIPE_HAVE_SHARED_TIMER_IRQ was easier to understand.
> > 
> 
> It is, but the point is that we should not define a normalized
> interface; older ARM patches are obsoleted by the very existence of the
> new one adding a required feature for PXA.

AT91.

>  Therefore, at some point in
> time, we are going to deprecate them, removing the conditional from the
> Xenomai codebase. In other words, this code is aimed at transitioning
> internally between two Adeos patch series, not at providing a stable
> interface.
> 
-- 
Philippe.



