From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <878sc687h6.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 22 Oct 2020 14:22:17 +0200
MIME-Version: 1.0
Message-ID: <1176-5f917980-13f-12dbaa60@116769483>
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

Le Vendredi, Octobre 16, 2020 18:24 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Le Vendredi, Octobre 16, 2020 14:03 CEST, Philippe Gerum <rpm@xenom=
ai.org> a =C3=A9crit: 
> >  
> >> 
> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> 
> >> > Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <rpm@xe=
nomai.org> a =C3=A9crit: 
> >> >  
> >> >> 
> >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> >> 
> >> >> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <gre=
g@embeddedgreg.com> a =C3=A9crit: 
> >> >> >  
> >> >> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@sieme=
ns.com> wrote:
> >> >> >> >
> >> >> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
> >> >> >> > > Anybody can help on this ?
> >> >> >> > >
> > >> >> >
> >> >> >> > I'm unfortunately not familiar with the armv7 details of c=
opy-from-user,
> >> >> >> > not too speak of how spectre contributed to it. Greg, Phil=
ippe, did you
> >> >> >> > come across this already?
> >> >> >> >
> >> >> >> > Jan
> >> >> >> >
> >> >> >> I'll take a look tonight but I haven't hit this in my testin=
g.  This
> >> >> >> was found on 4.4? Have you tried the 4.19 kernels?
> >> >> >> 
> >> >> >> -Greg
> >> >> >  
> >> >> > So I tried the same case on 4.19.121, with the same result, a=
nd I guess for the same reason.
> >> >> > Could anybody explain why, on ARMv7, we need to copy the mess=
age header at the syscall entry, and not let the xxxmsg routine do it o=
n its own ?
> >> >> > Also, I could not find how those COBALT=5FSYSCALL32emu logic =
work.
> >> >> 
> >> >> There is no way an armv7 system would run the sys32emu code in
> >> >> Cobalt. This code path is specific to architectures which suppo=
rt mixed
> >> >> ABI models. Only Cobalt/x86 supports this so far, issuing x86=5F=
32
> >> >> syscalls to an x86=5F64 kernel. You may want to check
> >> >> CONFIG=5FXENO=5FARCH=5FSYS3264, it is set to "def=5Fbool n" in =
the Kconfig
> >> >> stuff.
> >> >> 
> >> >
> >> > Maybe I don't use the right terms here, but what I can see from =
the code is (in linux tree kernel/xenomai/posix/syscall32.c)
> >> > COBALT=5FSYSCALL32emu(sendmsg, handover,
> >> > 		    (int fd, struct compat=5Fmsghdr =5F=5Fuser *umsg, int flag=
s))
> >> > {
> >> > 	struct user=5Fmsghdr m;
> >> > 	int ret;
> >> >
> >> > 	ret =3D sys32=5Fget=5Fmsghdr(&m, umsg);
> >> >
> >> > 	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
> >> > }
> >> >
> >> > And the problem regarding SPECTRE mitigation is with the "ret =3D=

> >> > sys32=5Fget=5Fmsghdr(&m, umsg);" line, as af=5Fpacket (in my cas=
e, but I
> >> > believe the other handlers should do the same) will also call
> >> > copy=5Ffrom=5Fuser on the "msghdr" argument, and the SPECTRE mit=
igation
> >> > will check that this pointer is in the userland MM area.
> >> 
> >> There is indeed a problem with this code passing the kernel memory=

> >> address of a bounce buffer to RTDM handlers which would expect =5F=
=5Fuser
> >> tagged memory instead. This ends up confusing any low-level
> >> copy=5Fto/from=5Fuser routine which includes attack
> >> mitigation. rtnet=5Fget=5Farg() does call such routine under the h=
ood. This
> >> is something some Xenomai contributor may want to address.
> >> 
> >> But, again, this sys32emu code cannot run for armv7 under the curr=
ent
> >> stock implementation. So what we are discussing is purely hypothet=
ical
> >> at this stage for this architecture, and should definitely never h=
appen
> >> by construction if you are running armv7 (which does not make the
> >> original issue go away, that is granted).
> >> 
> >
> > I'm not sure I quite understand that point. The code reproduced abo=
ve is well built in the kernel. Are you saying this code is not called =
whenever userland calls sendmsg on an rt socket ? Am I looking in the w=
rong direction ? In that case, where should I be looking ? I mean, I tr=
acked the whole thing with a JTAG debugger, and it seemed to me that th=
is was what was really happening, with the SPECTRE code setting the poi=
nter to 0 which was later being caught by arm=5Fcopy=5Ffrom=5Fuser.
> >
> 
> How could syscall32.c and compat.c be built into the kernel with
> CONFIG=5FXENO=5FARCH=5FSYS3264 forcibly unset in the Kconfig, which i=
s always
> the case when building for anything else than x86?
> 
> Checking kernel/cobalt/posix/Makefile may help in understanding why i=
t
> is simply not possible. arm=5Fcopy=5Ffrom=5Fuser is built in, no ques=
tion,
> and your analysis regarding SVC context memory being spuriously fed i=
nto
> arm=5Fcopy=5Ffrom=5Fuser is likely right.
> 
> But the sys32 wrappers are neither for armv7, armv8 nor ppc32. So yes=
,
> you are certainly following the wrong path when looking at
> kernel/cobalt/posix/syscall32.c. This 32-to-64bit syscall support is =
NOT
> built into a kernel targeting armv7, at least when it comes to the
> vanilla Xenomai code.
> 
> You may want to double-check which call site actually invokes
> arm=5Fcopy=5Ffrom=5Fuser.
> 
> -- 
> Philippe.
 
Just to follow up on that. I tried to modify cobalt system calls (sendm=
sg/recvmsg) to remove the copy=5Ffrom=5Fuser as follows and run with SP=
ECTRE mitigation built in :

 COBALT=5FSYSCALL(recvmsg, handover,
	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flags))
{
//	struct user=5Fmsghdr m;
	ssize=5Ft ret;
//
//	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
//	if (ret)
//		return ret;
//
//    ret =3D rtdm=5Ffd=5Frecvmsg(fd, &m, flags);
    ret =3D rtdm=5Ffd=5Frecvmsg(fd, umsg, flags);
//	if (ret < 0)
		return ret;

//	return cobalt=5Fcopy=5Fto=5Fuser(umsg, &m, sizeof(*umsg)) ?: ret;
}

COBALT=5FSYSCALL(sendmsg, handover,
	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flags))
{
//	struct user=5Fmsghdr m;
//	int ret;
//
//	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
//
//  return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
  return rtdm=5Ffd=5Fsendmsg(fd, umsg, flags);
}

I don't get no more exceptions, and still the RTNET network seems funct=
ionnal.
So now, I wonder why these copy=5Ffrom/to=5Fuser calls need to be there=
 at the syscall entry ?

Fran=C3=A7ois


