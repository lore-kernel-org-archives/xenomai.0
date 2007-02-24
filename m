Subject: Re: [Xenomai-core] x86_64 - Initial results.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702241655.17697.paul_c@domain.hid>
References: <200702241526.22786.paul_c@domain.hid>
	<1172332571.2161.26.camel@domain.hid>
	<200702241655.17697.paul_c@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 18:17:43 +0100
Message-Id: <1172337463.2161.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2007-02-24 at 16:55 +0000, Paul wrote:
> On Saturday 24 February 2007 15:56, Philippe Gerum wrote:
> > >  Initial results look promising with the latency test reporting figures
> > > in the 0.5 to 4 uSec range under light load. A kernel compile bumps the
> > > wost up to 9-14uSec.
> >
> > Not bad. Is this a UP or SMP config, and which kind of box did run the
> > tests precisely?
> 
> AMD X2 4600+ with SMP config - MoBo is an Asus A8V with a Via K8T800Pro 
> chipset and a measly 512M of RAM.
> 

Ok.

> > >  Firing up X,KDE, and a gamut of desktop apps really kills the
> > > numbers though - ~267uSec being the worst recorded so far,
> >
> > Ok, the latter looks clearly pathological. The trace should tell us
> > more.
> 
> The latency log ?

Rather the CONFIG_IPIPE_TRACE feature, with the IRQs off tracking option
set, but the latency log already has some value, thanks.

> Attached is some three hours worth of log - Should point out there are no 
> proprietory video drivers being used, just the regular Xorg stuff and what 
> ever the kernel provides.
> 

Looking at this log, the good news is that latency peaks are not spread
all over the place, but only a few of them are bugging us. This tend to
confirm a bad interference exists with something specific to the X
startup procedure (maybe/likely? related to the graphic card). Does the
peak still occur if you disable hw acceleration for the graphic card in
your XF86Config file?

> 
> Regards, Paul.
> 
-- 
Philippe.



