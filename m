Date: Thu, 5 Aug 2010 17:19:32 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100805151932.GA25701@domain.hid>
References: <1276880276.12743.73.camel@domain.hid>
	<4C1BA6F7.9080004@domain.hid>
	<20100805125828.GA22855@domain.hid>
	<1281016845.1706.0.camel@domain.hid>
	<4C5AC77F.1040508@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C5AC77F.1040508@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Aug 05, 2010 at 04:15:27PM +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2010-08-05 at 14:58 +0200, Tschaeche IT-Services wrote:
> >> On Fri, Jun 18, 2010 at 07:03:51PM +0200, Gilles Chanteperdrix wrote:
> >>> Philippe Gerum wrote:
> >>>> Recovery from runaway loops in primary mode is introduced by the mayday
> >>>> patch series; the faulty thread gets relaxed, instead of being killed,
> >>>> when the nucleus watchdog triggers.
> >> just adapted to Xenomai 2.5.4 with a simple patch,
> >> exporting the xnshadow_call_mayday() symbol from nucleus,
> >> so that we can call it from our watchdog driver.
> >>
> >> Should we call xnshadow_call_mayday() in another (official) way?
> > 
> > xnshadow_call_mayday() is already exported to modules in 2.5.4.
> 
> It is exported to GPL modules, maybe that is the issue?

yes. EXPORT_SYMBOL_GPL requires the callee to be GPL too, right?
may we GPL patch kernel/xenomai/skin/native/task.c with something like:

	int rt_task_shadow_mayday(RTASK *t)
	{
		return xnshadow_call_mayday(t->thread_base, WATCHDOG_SIGXCPU);
	}
	EXPORT_SYMBOL(rt_task_shadow_mayday)

Native API does not require GPL callees. BTW: why are there different licenses?

did not clarify yet, if our driver code may be open source.
i think, it would be appreciated if not.

thx,

	Olli

