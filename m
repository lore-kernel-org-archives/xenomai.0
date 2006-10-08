Subject: Re: [Xenomai-core] Compiler and linker flags
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45293C9B.1030608@domain.hid>
References: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
	<4528FBE5.7020803@domain.hid> <17705.6276.735921.764908@domain.hid>
	<45293C9B.1030608@domain.hid>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 21:31:21 +0200
Message-Id: <1160335881.4963.19.camel@domain.hid>
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

On Sun, 2006-10-08 at 19:59 +0200, Jan Kiszka wrote:

> >  > @All: What flags are *really* required to build and link some *user*
> >  > application against Xenomai? Beside that -I. at least -O2 can be fairly
> >  > problematic I guess - if not even more. Also the debug mode of the
> >  > Xenomai build leaks to the user if (s)he wants it or not.
> >  > 
> >  > Time for a cleanup?
> > 
> > -D_GNU_SOURCE is necessary, at least when compiling for the POSIX skin,
> > because on some platforms, it makes the defines for the pthread mutex
> > types available.
> > 
> > -D_REENTRANT is required when compiling a multithreaded application with
> > the glibc. Theoretically, the glibc is not supposed to make its services
> > thread safe when a program is not compiled with this define.
> > 
> 
> Ok, they will be saved from the hoover. What about those:
> 
>  o -D__XENO__

POSIX code may be compiled either against the regular Linux support, or
against the Xenomai one; this define provides a standard signature to
test for in order to detect the second case, if need be.

>  o -fstrict-aliasing -Wno-strict-aliasing

We want strict aliasing to be enabled for optimization purpose at
application level too, asking the compiler to silence type punned
references in case it find somes, due to legacy code support.

>  o -rdynamic
> 

Applications may want to use dlopen() against there own image, in which
case, passing -rdynamic (same as --export-dynamic) makes dlsym()
properly find global symbols exported this way by the executable.

> Again, only /wrt to user apps. We can keep them all internally.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



