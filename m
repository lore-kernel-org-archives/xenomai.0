From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <1175-5f9fbe80-df-25a5a500@198976341>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 20 Nov 2020 17:06:05 +0100
MIME-Version: 1.0
Message-ID: <1174-5fb7e980-5d-37e14c00@74918021>
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
To: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Philippe Gerum <rpm@xenomai.org>, =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Lundi, Novembre 02, 2020 09:08 CET, Fran=C3=A7ois Legal via Xenomai =
<xenomai@xenomai.org> a =C3=A9crit: 
 
> Le Samedi, Octobre 31, 2020 17:48 CET, Philippe Gerum <rpm@xenomai.or=
g> a =C3=A9crit: 
>  
> > 
> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > 
> > > Le Vendredi, Octobre 16, 2020 18:24 CEST, Philippe Gerum <rpm@xen=
omai.org> a =C3=A9crit: 
> > >  
> > >> 
> > >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > >> 
> > >> > Le Vendredi, Octobre 16, 2020 14:03 CEST, Philippe Gerum <rpm@=
xenomai.org> a =C3=A9crit: 
> > >> >  
> > >> >> 
> > >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > >> >> 
> > >> >> > Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <r=
pm@xenomai.org> a =C3=A9crit: 
> > >> >> >  
> > >> >> >> 
> > >> >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > >> >> >> 
> > >> >> >> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher=
 <greg@embeddedgreg.com> a =C3=A9crit: 
> > >> >> >> >  
> > >> >> >> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@=
siemens.com> wrote:
> > >> >> >> >> >
> > >> >> >> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wr=
ote:
> > >> >> >> >> > > Anybody can help on this ?
> > >> >> >> >> > >
> > >> > >> >> >
> > >> >> >> >> > I'm unfortunately not familiar with the armv7 details=
 of copy-from-user,
> > >> >> >> >> > not too speak of how spectre contributed to it. Greg,=
 Philippe, did you
> > >> >> >> >> > come across this already?
> > >> >> >> >> >
> > >> >> >> >> > Jan
> > >> >> >> >> >
> > >> >> >> >> I'll take a look tonight but I haven't hit this in my t=
esting.  This
> > >> >> >> >> was found on 4.4? Have you tried the 4.19 kernels?
> > >> >> >> >> 
> > >> >> >> >> -Greg
> > >> >> >> >  
> > >> >> >> > So I tried the same case on 4.19.121, with the same resu=
lt, and I guess for the same reason.
> > >> >> >> > Could anybody explain why, on ARMv7, we need to copy the=
 message header at the syscall entry, and not let the xxxmsg routine do=
 it on its own ?
> > >> >> >> > Also, I could not find how those COBALT=5FSYSCALL32emu l=
ogic work.
> > >> >> >> 
> > >> >> >> There is no way an armv7 system would run the sys32emu cod=
e in
> > >> >> >> Cobalt. This code path is specific to architectures which =
support mixed
> > >> >> >> ABI models. Only Cobalt/x86 supports this so far, issuing =
x86=5F32
> > >> >> >> syscalls to an x86=5F64 kernel. You may want to check
> > >> >> >> CONFIG=5FXENO=5FARCH=5FSYS3264, it is set to "def=5Fbool n=
" in the Kconfig
> > >> >> >> stuff.
> > >> >> >> 
> > >> >> >
> > >> >> > Maybe I don't use the right terms here, but what I can see =
from the code is (in linux tree kernel/xenomai/posix/syscall32.c)
> > >> >> > COBALT=5FSYSCALL32emu(sendmsg, handover,
> > >> >> > 		    (int fd, struct compat=5Fmsghdr =5F=5Fuser *umsg, int=
 flags))
> > >> >> > {
> > >> >> > 	struct user=5Fmsghdr m;
> > >> >> > 	int ret;
> > >> >> >
> > >> >> > 	ret =3D sys32=5Fget=5Fmsghdr(&m, umsg);
> > >> >> >
> > >> >> > 	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
> > >> >> > }
> > >> >> >
> > >> >> > And the problem regarding SPECTRE mitigation is with the "r=
et =3D
> > >> >> > sys32=5Fget=5Fmsghdr(&m, umsg);" line, as af=5Fpacket (in m=
y case, but I
> > >> >> > believe the other handlers should do the same) will also ca=
ll> >> >> > copy=5Ffrom=5Fuser on the "msghdr" argument, and the SPECTR=
E mitigation
> > >> >> > will check that this pointer is in the userland MM area.
> > >> >> 
> > >> >> There is indeed a problem with this code passing the kernel m=
emory
> > >> >> address of a bounce buffer to RTDM handlers which would expec=
t =5F=5Fuser
> > >> >> tagged memory instead. This ends up confusing any low-level
> > >> >> copy=5Fto/from=5Fuser routine which includes attack
> > >> >> mitigation. rtnet=5Fget=5Farg() does call such routine under =
the hood. This
> > >> >> is something some Xenomai contributor may want to address.
> > >> >> 
> > >> >> But, again, this sys32emu code cannot run for armv7 under the=
 current
> > >> >> stock implementation. So what we are discussing is purely hyp=
othetical
> > >> >> at this stage for this architecture, and should definitely ne=
ver happen
> > >> >> by construction if you are running armv7 (which does not make=
 the
> > >> >> original issue go away, that is granted).
> > >> >> 
> > >> >
> > >> > I'm not sure I quite understand that point. The code reproduce=
d above is well built in the kernel. Are you saying this code is not ca=
lled whenever userland calls sendmsg on an rt socket ? Am I looking in =
the wrong direction ? In that case, where should I be looking ? I mean,=
 I tracked the whole thing with a JTAG debugger, and it seemed to me th=
at this was what was really happening, with the SPECTRE code setting th=
e pointer to 0 which was later being caught by arm=5Fcopy=5Ffrom=5Fuser=
.
> > >> >
> > >> 
> > >> How could syscall32.c and compat.c be built into the kernel with=

> > >> CONFIG=5FXENO=5FARCH=5FSYS3264 forcibly unset in the Kconfig, wh=
ich is always
> > >> the case when building for anything else than x86?
> > >> 
> > >> Checking kernel/cobalt/posix/Makefile may help in understanding =
why it
> > >> is simply not possible. arm=5Fcopy=5Ffrom=5Fuser is built in, no=
 question,
> > >> and your analysis regarding SVC context memory being spuriously =
fed into
> > >> arm=5Fcopy=5Ffrom=5Fuser is likely right.
> > >> 
> > >> But the sys32 wrappers are neither for armv7, armv8 nor ppc32. S=
o yes,
> > >> you are certainly following the wrong path when looking at
> > >> kernel/cobalt/posix/syscall32.c. This 32-to-64bit syscall suppor=
t is NOT
> > >> built into a kernel targeting armv7, at least when it comes to t=
he> >> vanilla Xenomai code.
> > >> 
> > >> You may want to double-check which call site actually invokes
> > >> arm=5Fcopy=5Ffrom=5Fuser.
> > >> 
> > >> -- 
> > >> Philippe.
> > >  
> > > Thanks Philippe for pointing me in the right direction.
> > > So, if I'm correct this time, the problem is about the same, but =
in posix/io.c.
> > > In 
> > >  
> > > COBALT=5FSYSCALL(sendmsg, handover,
> > > 	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flags=
))> > {
> > > 	struct user=5Fmsghdr m;
> > > 	int ret;
> > >
> > > 	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
> > >
> > > 	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
> > > }
> > >
> > > Same thing, the user=5Fmsghdr is allocated on the SVC stack, then=
 copied from user, then handed over to the sendmsg handling function pe=
rtaining to that fd, and whenever that handling function call copy=5Ffr=
om=5Fuser for the same user=5Fmsghdr pointer, it triggers the SPECTRE m=
itigation protection.
> > >
> > > What is still unclear to me is why this user=5Fmsghdr struct is c=
opied here, and not left to the handling function, as in the sendmmsg s=
yscalls, the struct mmsghdr is not copied from user in syscall entry.
> > >
> > 
> > Unlike sendmsg(), sendmmsg() has to deal with 32bit compat mode, so=

> > =5F=5Frtdm=5Ffd=5Fsendmmsg() receives a couple of helpers along wit=
h the user
> > pointer in order to do the right thing, depending on the 32/64 sysc=
all
> > entry. sendmsg() was implemented much earlier too, when SPECTRE
> > mitigation was not there: passing SVC memory to copy=5Ffrom/to=5Fus=
er> services was still wrong, but went unnoticed.
> > 
> > -- 
> > Philippe.
>  
>  Alright, so shall I submit a patch removing those copy=5Ffrom/to=5Fu=
ser calls at system call entry in sendmsg and recvmsg ?
> Is this the way to go ?
> 
> Thanks
> 
> Fran=C3=A7ois
> 
> 
 
So for the records, I tried to patch posix/io.c to remove the copy=5Fto=
/from=5Fuser from there to try to avoid the SPECTRE problem, and while =
that seem to work perfectly well for the rt=5Fpacket endpoint, I come a=
cross another problem in xddp sockets which do expect the struct user=5F=
msghdr to be present in kernel space.

So I still wonder which is the way to go ? Removing the copy=5Ffrom/to=5F=
user in posix/io.c  and modifying xddp (and possibly other protocols re=
lying on that) to to add the copy=5Fto/from=5Fuser there, or modify onl=
y af=5Fpacket (and possibly/probably all sockets type in RTNET) ?

Thanks

Fran=C3=A7ois


