References: <878sc687h6.fsf@xenomai.org> <1175-5f8d2f80-c5-25a5a500@198942087>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Strange switching [threadname] to     secondary mode after
 exception #0 in kernel-space at 0x80272444
In-reply-to: <1175-5f8d2f80-c5-25a5a500@198942087>
Date: Sat, 31 Oct 2020 17:48:49 +0100
Message-ID: <87lffm1gum.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Vendredi, Octobre 16, 2020 18:24 CEST, Philippe Gerum <rpm@xenomai.org=
> a =C3=A9crit:=20
>=20=20
>>=20
>> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>>=20
>> > Le Vendredi, Octobre 16, 2020 14:03 CEST, Philippe Gerum <rpm@xenomai.=
org> a =C3=A9crit:=20
>> >=20=20
>> >>=20
>> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >>=20
>> >> > Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <rpm@xenom=
ai.org> a =C3=A9crit:=20
>> >> >=20=20
>> >> >>=20
>> >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >> >>=20
>> >> >> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@e=
mbeddedgreg.com> a =C3=A9crit:=20
>> >> >> >=20=20
>> >> >> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
>> >> >> >> >
>> >> >> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
>> >> >> >> > > Anybody can help on this ?
>> >> >> >> > >
>> > >> >> >
>> >> >> >> > I'm unfortunately not familiar with the armv7 details of copy=
-from-user,
>> >> >> >> > not too speak of how spectre contributed to it. Greg, Philipp=
e, did you
>> >> >> >> > come across this already?
>> >> >> >> >
>> >> >> >> > Jan
>> >> >> >> >
>> >> >> >> I'll take a look tonight but I haven't hit this in my testing. =
 This
>> >> >> >> was found on 4.4? Have you tried the 4.19 kernels?
>> >> >> >>=20
>> >> >> >> -Greg
>> >> >> >=20=20
>> >> >> > So I tried the same case on 4.19.121, with the same result, and =
I guess for the same reason.
>> >> >> > Could anybody explain why, on ARMv7, we need to copy the message=
 header at the syscall entry, and not let the xxxmsg routine do it on its o=
wn ?
>> >> >> > Also, I could not find how those COBALT_SYSCALL32emu logic work.
>> >> >>=20
>> >> >> There is no way an armv7 system would run the sys32emu code in
>> >> >> Cobalt. This code path is specific to architectures which support =
mixed
>> >> >> ABI models. Only Cobalt/x86 supports this so far, issuing x86_32
>> >> >> syscalls to an x86_64 kernel. You may want to check
>> >> >> CONFIG_XENO_ARCH_SYS3264, it is set to "def_bool n" in the Kconfig
>> >> >> stuff.
>> >> >>=20
>> >> >
>> >> > Maybe I don't use the right terms here, but what I can see from the=
 code is (in linux tree kernel/xenomai/posix/syscall32.c)
>> >> > COBALT_SYSCALL32emu(sendmsg, handover,
>> >> > 		    (int fd, struct compat_msghdr __user *umsg, int flags))
>> >> > {
>> >> > 	struct user_msghdr m;
>> >> > 	int ret;
>> >> >
>> >> > 	ret =3D sys32_get_msghdr(&m, umsg);
>> >> >
>> >> > 	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
>> >> > }
>> >> >
>> >> > And the problem regarding SPECTRE mitigation is with the "ret =3D
>> >> > sys32_get_msghdr(&m, umsg);" line, as af_packet (in my case, but I
>> >> > believe the other handlers should do the same) will also call
>> >> > copy_from_user on the "msghdr" argument, and the SPECTRE mitigation
>> >> > will check that this pointer is in the userland MM area.
>> >>=20
>> >> There is indeed a problem with this code passing the kernel memory
>> >> address of a bounce buffer to RTDM handlers which would expect __user
>> >> tagged memory instead. This ends up confusing any low-level
>> >> copy_to/from_user routine which includes attack
>> >> mitigation. rtnet_get_arg() does call such routine under the hood. Th=
is
>> >> is something some Xenomai contributor may want to address.
>> >>=20
>> >> But, again, this sys32emu code cannot run for armv7 under the current
>> >> stock implementation. So what we are discussing is purely hypothetical
>> >> at this stage for this architecture, and should definitely never happ=
en
>> >> by construction if you are running armv7 (which does not make the
>> >> original issue go away, that is granted).
>> >>=20
>> >
>> > I'm not sure I quite understand that point. The code reproduced above =
is well built in the kernel. Are you saying this code is not called wheneve=
r userland calls sendmsg on an rt socket ? Am I looking in the wrong direct=
ion ? In that case, where should I be looking ? I mean, I tracked the whole=
 thing with a JTAG debugger, and it seemed to me that this was what was rea=
lly happening, with the SPECTRE code setting the pointer to 0 which was lat=
er being caught by arm_copy_from_user.
>> >
>>=20
>> How could syscall32.c and compat.c be built into the kernel with
>> CONFIG_XENO_ARCH_SYS3264 forcibly unset in the Kconfig, which is always
>> the case when building for anything else than x86?
>>=20
>> Checking kernel/cobalt/posix/Makefile may help in understanding why it
>> is simply not possible. arm_copy_from_user is built in, no question,
>> and your analysis regarding SVC context memory being spuriously fed into
>> arm_copy_from_user is likely right.
>>=20
>> But the sys32 wrappers are neither for armv7, armv8 nor ppc32. So yes,
>> you are certainly following the wrong path when looking at
>> kernel/cobalt/posix/syscall32.c. This 32-to-64bit syscall support is NOT
>> built into a kernel targeting armv7, at least when it comes to the
>> vanilla Xenomai code.
>>=20
>> You may want to double-check which call site actually invokes
>> arm_copy_from_user.
>>=20
>> --=20
>> Philippe.
>=20=20
> Thanks Philippe for pointing me in the right direction.
> So, if I'm correct this time, the problem is about the same, but in posix=
/io.c.
> In=20
>=20=20
> COBALT_SYSCALL(sendmsg, handover,
> 	       (int fd, struct user_msghdr __user *umsg, int flags))
> {
> 	struct user_msghdr m;
> 	int ret;
>
> 	ret =3D cobalt_copy_from_user(&m, umsg, sizeof(m));
>
> 	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
> }
>
> Same thing, the user_msghdr is allocated on the SVC stack, then copied fr=
om user, then handed over to the sendmsg handling function pertaining to th=
at fd, and whenever that handling function call copy_from_user for the same=
 user_msghdr pointer, it triggers the SPECTRE mitigation protection.
>
> What is still unclear to me is why this user_msghdr struct is copied here=
, and not left to the handling function, as in the sendmmsg syscalls, the s=
truct mmsghdr is not copied from user in syscall entry.
>

Unlike sendmsg(), sendmmsg() has to deal with 32bit compat mode, so
__rtdm_fd_sendmmsg() receives a couple of helpers along with the user
pointer in order to do the right thing, depending on the 32/64 syscall
entry. sendmsg() was implemented much earlier too, when SPECTRE
mitigation was not there: passing SVC memory to copy_from/to_user
services was still wrong, but went unnoticed.

--=20
Philippe.

