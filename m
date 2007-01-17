Subject: Re: [Xenomai-help] special glibc support for Xenomai?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45AE0C86.9080101@domain.hid>
References: <45AE059C.9050605@domain.hid>
	<1169033628.17493.35.camel@domain.hid>  <45AE0C86.9080101@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 13:14:16 +0100
Message-Id: <1169036056.17493.43.camel@domain.hid>
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-01-17 at 12:46 +0100, Steven Scholz wrote:
> Philippe,
> 
> >> I wonder if I would need a special glibc support in order to build and run
> >> xenomai applications.
> > 
> > In short, no. You could use the oldish linuxthreads, or the NPTL as you
> > see fit, from any glibc version...
> Thanks.
> 
> > ... Hi-res timing is provided by the
> > Xenomai nucleus directly, and it is implicitely made available by the
> > Xenomai APIs to the bound applications.
> 
> But that would need some low level support for my special platform? Cause
> hrtimers are platform specific. Right?

Since Xenomai implements its own hi-res timers, the "only" thing you
need is to have it ported over your platform of choice. The Xenomai
(user-space) API side is totally independent from the way hi-res timing
is obtained.

> 
> > In the particular POSIX case, calling e.g. nanosleep() over a Xenomai
> > thread context already gives you a microsecond-level precision for
> > timings. 
> Ok.
> 
> > You just need to make sure to compile/link with the hardened
> > Xenomai POSIX library, try running:
> > $ xeno-config --posix-cflags|--posix-ldflags.
> What does it do?

It returns the proper CFLAGS and LDFLAGS to use in order to compile a
POSIX application using the Xenomai hardened POSIX library. In short,
libpthread.so is partially shadowed by our libpthread_rt.so library.
What's not shadowed remains handled by the vanilla glibc/Linux code, the
rest is handled by Xenomai, i.e. with timeliness and predictability in
mind.

> Can I use it for cross-compiling as well?
> 

Same principles.

> Steven
-- 
Philippe.



