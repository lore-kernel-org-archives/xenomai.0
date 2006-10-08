Subject: Re: [Xenomai-core] Compiler and linker flags
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <452956C3.8010109@domain.hid>
References: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
	<4528FBE5.7020803@domain.hid> <17705.6276.735921.764908@domain.hid>
	<45293C9B.1030608@domain.hid> <1160335881.4963.19.camel@domain.hid>
	<452956C3.8010109@domain.hid>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 22:44:39 +0200
Message-Id: <1160340280.4963.28.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

On Sun, 2006-10-08 at 21:51 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> >>
> >>  o -D__XENO__
> > 
> > POSIX code may be compiled either against the regular Linux support, or
> > against the Xenomai one; this define provides a standard signature to
> > test for in order to detect the second case, if need be.
> 
> Ok. Should we restrict it to --posix-cflags then?
> 

No objection, but in such a case, we'd be better off moving the define
somewhere in include/posix/*.h. Gilles?

> > 
> >>  o -fstrict-aliasing -Wno-strict-aliasing
> > 
> > We want strict aliasing to be enabled for optimization purpose at
> > application level too, asking the compiler to silence type punned
> > references in case it find somes, due to legacy code support.
> 
> So I guess the idea is just like with -Wall: prod the user to write
> clean code? I'm not strictly against it, but I also understand Thomas'
> argument: "what if every lib exported its private policy?"
> 

Actually, those flags went in just because I once wanted everything that
I'd build out of tree to be safe from obvious sanity issues. No
objection to allow people to relax this constraint though and get rid of
those switches from the standard flags. They are not part of the basic
pattern anyway; it's "only" about some performance/sanity trade-off.

> > 
> >>  o -rdynamic
> >>
> > 
> > Applications may want to use dlopen() against there own image, in which
> > case, passing -rdynamic (same as --export-dynamic) makes dlsym()
> > properly find global symbols exported this way by the executable.
> 
> If the only /may want/ to do this, shouldn't they apply that switch on
> their own to CFLAGS? Aren't there any downsides of doing this
> unconditionally via Xenomai?

There's no downside, aside of a few bytes more in the executable's GOT.
But I agree that people using lazy binding in their apps should know
about -rdynamic and dlopen() anyway, so that part is their business
after all; we don't need to enforce it as a basic option.

> 
> Jan
-- 
Philippe.



