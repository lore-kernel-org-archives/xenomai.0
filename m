From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87mu0m8s1g.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 16 Oct 2020 11:45:19 +0200
MIME-Version: 1.0
Message-ID: <1176-5f896b80-125-12dbaa60@116735130>
Subject: =?utf-8?q?Re=3A?= Strange switching =?utf-8?q?=5Bthreadname=5D?= to 
 secondary mode after exception #0 in kernel-space at 0x80272444
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@embe=
ddedgreg.com> a =C3=A9crit: 
> >  
> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> >> >
> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
> >> > > Anybody can help on this ?
> >> > >
> >> >
> >> > I'm unfortunately not familiar with the armv7 details of copy-fr=
om-user,
> >> > not too speak of how spectre contributed to it. Greg, Philippe, =
did you
> >> > come across this already?
> >> >
> >> > Jan
> >> >
> >> I'll take a look tonight but I haven't hit this in my testing.  Th=
is
> >> was found on 4.4? Have you tried the 4.19 kernels?
> >> 
> >> -Greg
> >  
> > So I tried the same case on 4.19.121, with the same result, and I g=
uess for the same reason.
> > Could anybody explain why, on ARMv7, we need to copy the message he=
ader at the syscall entry, and not let the xxxmsg routine do it on its =
own ?
> > Also, I could not find how those COBALT=5FSYSCALL32emu logic work.
> 
> There is no way an armv7 system would run the sys32emu code in
> Cobalt. This code path is specific to architectures which support mix=
ed
> ABI models. Only Cobalt/x86 supports this so far, issuing x86=5F32
> syscalls to an x86=5F64 kernel. You may want to check
> CONFIG=5FXENO=5FARCH=5FSYS3264, it is set to "def=5Fbool n" in the Kc=
onfig
> stuff.
> 

Maybe I don't use the right terms here, but what I can see from the cod=
e is (in linux tree kernel/xenomai/posix/syscall32.c)
COBALT=5FSYSCALL32emu(sendmsg, handover,
		    (int fd, struct compat=5Fmsghdr =5F=5Fuser *umsg, int flags))
{
	struct user=5Fmsghdr m;
	int ret;

	ret =3D sys32=5Fget=5Fmsghdr(&m, umsg);

	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
}

And the problem regarding SPECTRE mitigation is with the "ret =3D sys32=
=5Fget=5Fmsghdr(&m, umsg);" line, as af=5Fpacket (in my case, but I bel=
ieve the other handlers should do the same) will also call copy=5Ffrom=5F=
user on the "msghdr" argument, and the SPECTRE mitigation will check th=
at this pointer is in the userland MM area.

> Converting long/pointer data conforming to a 32bit ABI to their 64bit=

> representation is the reason why the sys32/compat wrappers exist and =
are
> compiled in when CONFIG=5FXENO=5FARCH=5FSYS3264 is set. Aggregates ar=
guments
> such as msg headers do contain such data.
> 
> > Can anybody point me to some documentation ?
> >
> 
> There is none, I'm afraid.
> 
> -- 
> Philippe.


