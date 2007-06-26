From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <468116FE.4090402@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid> <18046.42783.829807.333066@domain.hid>
	<468116FE.4090402@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 21:37:06 +0200
Message-Id: <1182886626.7458.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-06-26 at 15:39 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > IMO, the only advantage of having absolute timers is to be able to apply
> > the posix scheme. So, if I followed correctly your discussion, what we
> > need is:
> > - an XNTBISOL flag with a service xntbase_isol which set this flag and
> >   unshare the target timebase if it is shared (IOW, if aperiodic)
> > - the service xntbase_adjust_time to walk all the absolute timers of the
> >   non isolated timebases and adjust their expiry date or play their
> >   handler the posix way.
> 
> Two questions came up here regarding item #2:
> 
>  - Shouldn't we also adjust the non-monotonic timers of an isolated base
>    if it asks for wallclock tuning? I think so.

When xntbase_adjust_time() is called for an isolated timebase, we want
the real-time timers to be checked for immediate expiry against the new
epoch, and fire those who happen to have "suddently" elapsed.

> 
>  - We don't have a service to walk the list of all pending timers, do
>    we? As that touches all of our timer queue variants and I'm not
>    familiar with their details (except for plain lists...), I would
>    welcome any support on this.
> 
> Jan
> 
-- 
Philippe.



