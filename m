Subject: Re: [Xenomai-help] More woes with linux 2.6.18 and xenomai 2.2.3
	or 2.2.4 - irq_desc structure changed
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45477DB2.8090304@domain.hid>
References: <1F695B041C4BC345AFB7BD5D647B85000119975A@mail.senetas.com>
	<1162282862.4996.18.camel@domain.hid>  <45477DB2.8090304@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 18:09:07 +0100
Message-Id: <1162314547.4996.130.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 17:45 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-10-31 at 10:18 +1100, John Weston wrote:
> >> Continuing from my previous email regarding xenomai 2.2.4 and linux
> >> 2.6.18 for ppc (8260), I have also noticed that the underlying
> >> irq_desc structure has changed (in include/linux/irq.h), which in turn
> >> breaks hal.c.
> >>
> >> Are there any more recents patches available to fix this? Thanks in
> >> advance
> > 
> > The upcoming 2.3-rc1 fixes the issues raised by upgrading to 2.6.18 and
> > beyond (includes mutex and irq_desc conflicts). You can get this code
> > from the SVN trunk/, until -rc1 is rolled out (soon).
> 
> Shouldn't the 2.6.18-ppc patch be removed from the 2.2.x series then?

It has been ripped off my local tree. It got there mostly by accident.

> Just to avoid further frustrations.

Hey, I'm currently porting Adeos/x86 over 2.6.19-rcX, so why on earth
should I be the only frustrated guy on this list?!... :o} Anyway, the
good news is that, when this thing works, I'm likely going to get +500
Karma points for distinguished real-time services. IOW, does anyone know
anything beyond "PIA" that could more precisely describe the task of
following the vanilla kernel changes these days, when you happen to
contribute some out-of-tree code? Mm, ok, I knew I shouldn't ask...

>  User who know for what setups it
> works (I guess switching off the native skin will work around this
> conflict) could still cherry pick from new versions.
> 

There are still the HAL issues Wolfgang fixed, which won't disappear
when switching off the native interface, unfortunately.

> Jan
> 
-- 
Philippe.



