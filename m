From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87k0vq8jkb.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 16 Oct 2020 16:05:55 +0200
MIME-Version: 1.0
Message-ID: <1175-5f89a900-c1-25a5a500@198942021>
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

Le Vendredi, Octobre 16, 2020 14:03 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <rpm@xenom=
ai.org> a =C3=A9crit: 
> >  
> >> 
> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> 
> >> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@e=
mbeddedgreg.com> a =C3=A9crit: 
> >> >  
> >> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >> >> >
> >> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
> >> >> > > Anybody can help on this ?
> >> >> > >
> >> >> >
> >> >> > I'm unfortunately not familiar with the armv7 details of copy=
-from-user,
> >> >> > not too speak of how spectre contributed to it. Greg, Philipp=
e, did you
> >> >> > come across this already?
> >> >> >
> >> >> > Jan
> >> >> >
> >> >> I'll take a look tonight but I haven't hit this in my testing. =
 This
> >> >> was found on 4.4? Have you tried the 4.19 kernels?
> >> >> 
> >> >> -Greg
> >> >  
> >> > So I tried the same case on 4.19.121, with the same result, and =
I guess for the same reason.
> >> > Could anybody explain why, on ARMv7, we need to copy the message=
 header at the syscall entry, and not let the xxxmsg routine do it on i=
ts own ?
> >> > Also, I could not find how those COBALT=5FSYSCALL32emu logic wor=
k.
> >> 
> >> There is no way an armv7 system would run the sys32emu code in
> >> Cobalt. This code path is specific to architectures which support =
mixed
> >> ABI models. Only Cobalt/x86 supports this so far, issuing x86=5F32=

> >> syscalls to an x86=5F64 kernel. You may want to check
> >> CONFIG=5FXENO=5FARCH=5FSYS3264, it is set to "def=5Fbool n" in the=
 Kconfig
> >> stuff.
> >> 
> >
> > Maybe I don't use the right terms here, but what I can see from the=
 code is (in linux tree kernel/xenomai/posix/syscall32.c)
> > COBALT=5FSYSCALL32emu(sendmsg, handover,
> > 		    (int fd, struct compat=5Fmsghdr =5F=5Fuser *umsg, int flags))=

> > {
> > 	struct user=5Fmsghdr m;
> > 	int ret;
> >
> > 	ret =3D sys32=5Fget=5Fmsghdr(&m, umsg);
> >
> > 	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
> > }
> >
> > And the problem regarding SPECTRE mitigation is with the "ret =3D
> > sys32=5Fget=5Fmsghdr(&m, umsg);" line, as af=5Fpacket (in my case, =
but I
> > believe the other handlers should do the same) will also call
> > copy=5Ffrom=5Fuser on the "msghdr" argument, and the SPECTRE mitiga=
tion
> > will check that this pointer is in the userland MM area.
> 
> There is indeed a problem with this code passing the kernel memory
> address of a bounce buffer to RTDM handlers which would expect =5F=5F=
user
> tagged memory instead. This ends up confusing any low-level
> copy=5Fto/from=5Fuser routine which includes attack
> mitigation. rtnet=5Fget=5Farg() does call such routine under the hood=
. This
> is something some Xenomai contributor may want to address.
> 
> But, again, this sys32emu code cannot run for armv7 under the current=

> stock implementation. So what we are discussing is purely hypothetica=
l
> at this stage for this architecture, and should definitely never happ=
en
> by construction if you are running armv7 (which does not make the
> original issue go away, that is granted).
> 

I'm not sure I quite understand that point. The code reproduced above i=
s well built in the kernel. Are you saying this code is not called when=
ever userland calls sendmsg on an rt socket ? Am I looking in the wrong=
 direction ? In that case, where should I be looking ? I mean, I tracke=
d the whole thing with a JTAG debugger, and it seemed to me that this w=
as what was really happening, with the SPECTRE code setting the pointer=
 to 0 which was later being caught by arm=5Fcopy=5Ffrom=5Fuser.

Fran=C3=A7ois

> -- 
> Philippe.


