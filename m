From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4667CEF2.2050509@domain.hid>
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>
	<1181143109.17978.101.camel@domain.hid>
	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
	<4667AA4D.6070505@domain.hid>
	<7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
	<4667BBBE.1040405@domain.hid>  <4667CEF2.2050509@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 12:07:02 +0200
Message-Id: <1181210822.4998.54.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Cyclictest
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2007-06-07 at 11:25 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > Perrine Martignoni wrote:
> > 
> >>Ok. I'll do this.
> >>
> >>But I don't understand why the same application compiled without any links
> >>with Xenomai give different results if there is Xenomai in the kernel.
> > 
> > 
> > [Looking at your numbers again] Hmm, maybe some rounding issue of ticks
> > due to whatever side-effect of I-pipe. We would first of all need the
> > usual set of information (.config, involved versions) and also
> > /sys/devices/system/clocksource/clocksource0/current_clocksource.
> 
> Maybe what Perrine is observing is simply the overhead of the I-pipe ?
> I mean, Linux is Xenomai idle task, so it is acceptable for Linux
> numbers to be a bit worse than when Xenomai is not running.
> 

Most of the "known" overhead has disappeared with the PF_EVNOTIFY
extension, so that we relay Linux-originated events (e.g. syscalls) only
to subscribed domains (e.g. Xenomai). In the test case we are discussing
of, no relay should be done since no domain did subscribe to receive
those events.

The best way to check if the I-pipe still adds a noticeable overhead is
to compare:

- a vanilla kernel running cyclic test, 
with
- an I-pipe patched kernel, without Xenomai, using the same .config than
the vanilla kernel used. Without Xenomai either means to not run the
prepare-kernel.sh script, but only patch the kernel with the I-pipe
support, or disable CONFIG_XENOMAI entirely if the preparation script
has been run on the target kernel tree.

_Having both kernel setups share the very same kernel configuration is
mandatory, otherwise you would end up comparing apples and oranges._
The best way to make sure of this is to copy the .config file used for
the vanilla kernel to the I-pipe patched one, and run "make oldconfig".
You should be prompted only once, for the new CONFIG_IPIPE switch. Any
other behaviour would be the sign of some discrepancy in your test
configuration.

Since we can't have any temporal predictability for such configs, the
max value the cyclic test reports has no meaning. The useful figures are
the min and average values, as observed for a few minutes while the
board/box is sitting doing nothing but running the test.

A better way measure such artefacts is to run something like hackbench,
and compare the execution times, on kernels w/ and w/o the I-pipe.
http://developer.osdl.org/craiger/hackbench/src/hackbench.c
Tune the argument representing the number of process groups which you
pass to this program, so that it runs for a few minutes without putting
your box/board on its knees. There should be no significant difference
between the time reported at the end of both tests, at the very least,
not a 30% increase as your first report suggested. If the difference is
noticeable, then, there might be an issue (the final conclusion really
depends on the underlying hw).

-- 
Philippe.



