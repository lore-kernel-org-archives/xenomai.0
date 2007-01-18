Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits
	kernel	on	FC6	x86_64?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45AF5FA5.3080201@domain.hid>
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
	<45AE3ED4.7040506@domain.hid> <45AE68CF.5080200@domain.hid>
	<200701181118.27226.paul_c@domain.hid> <45AF5E27.9040600@domain.hid>
	<45AF5FA5.3080201@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 13:12:06 +0100
Message-Id: <1169122326.25556.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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

On Thu, 2007-01-18 at 12:53 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Paul wrote:
> >> Hi Jan
> >>
> >> On Wednesday 17 January 2007 18:19, Jan Kiszka wrote:
> >>>>> But the best is a Xenomai which supports 64-bit AMD processors :)
> >> I've made a tentative stab at a couple of the kernel sources, but must admit 
> >> the assembly code scares the heck out of me....
> > 
> > I think the assembly part should be a smaller issue, certainly a
> > solvable one. You are invited to post your questions regarding this here
> > (or better on xenomai-core) so that we all can try to look at it. /me
> 
> BTW, posting your current status as patch would be the best start for a
> discussion and for inviting others to join the hack. Even if it's just
> uncompilable incomplete stuff.

Okay, don't tell anyone outside of the Internet, but I'm working lazily
on the I-pipe port for x86_64. No availability date, no guarantee, just
the good old free software uncertainty that usually ends up coming to
reality, at some point in time. It's not that my plate is not full
enough, but we have to support this freaking architecture. Damnit.

I will post a prototype for getting help on testing and finalizing the
beast, before the Xenomai port starts over it. Other contributions are
welcome.

> 
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



