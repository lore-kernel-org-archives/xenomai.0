References: <87mu0m8s1g.fsf@xenomai.org> <1176-5f896b80-125-12dbaa60@116735130>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Strange switching [threadname] to   secondary mode after
 exception #0 in kernel-space at 0x80272444
In-reply-to: <1176-5f896b80-125-12dbaa60@116735130>
Date: Fri, 16 Oct 2020 14:03:00 +0200
Message-ID: <87k0vq8jkb.fsf@xenomai.org>
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

> Le Vendredi, Octobre 16, 2020 10:59 CEST, Philippe Gerum <rpm@xenomai.org=
> a =C3=A9crit:=20
>=20=20
>>=20
>> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>>=20
>> > Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@embedde=
dgreg.com> a =C3=A9crit:=20
>> >=20=20
>> >> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
>> >> >
>> >> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
>> >> > > Anybody can help on this ?
>> >> > >
>> >> >
>> >> > I'm unfortunately not familiar with the armv7 details of copy-from-=
user,
>> >> > not too speak of how spectre contributed to it. Greg, Philippe, did=
 you
>> >> > come across this already?
>> >> >
>> >> > Jan
>> >> >
>> >> I'll take a look tonight but I haven't hit this in my testing.  This
>> >> was found on 4.4? Have you tried the 4.19 kernels?
>> >>=20
>> >> -Greg
>> >=20=20
>> > So I tried the same case on 4.19.121, with the same result, and I gues=
s for the same reason.
>> > Could anybody explain why, on ARMv7, we need to copy the message heade=
r at the syscall entry, and not let the xxxmsg routine do it on its own ?
>> > Also, I could not find how those COBALT_SYSCALL32emu logic work.
>>=20
>> There is no way an armv7 system would run the sys32emu code in
>> Cobalt. This code path is specific to architectures which support mixed
>> ABI models. Only Cobalt/x86 supports this so far, issuing x86_32
>> syscalls to an x86_64 kernel. You may want to check
>> CONFIG_XENO_ARCH_SYS3264, it is set to "def_bool n" in the Kconfig
>> stuff.
>>=20
>
> Maybe I don't use the right terms here, but what I can see from the code =
is (in linux tree kernel/xenomai/posix/syscall32.c)
> COBALT_SYSCALL32emu(sendmsg, handover,
> 		    (int fd, struct compat_msghdr __user *umsg, int flags))
> {
> 	struct user_msghdr m;
> 	int ret;
>
> 	ret =3D sys32_get_msghdr(&m, umsg);
>
> 	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
> }
>
> And the problem regarding SPECTRE mitigation is with the "ret =3D
> sys32_get_msghdr(&m, umsg);" line, as af_packet (in my case, but I
> believe the other handlers should do the same) will also call
> copy_from_user on the "msghdr" argument, and the SPECTRE mitigation
> will check that this pointer is in the userland MM area.

There is indeed a problem with this code passing the kernel memory
address of a bounce buffer to RTDM handlers which would expect __user
tagged memory instead. This ends up confusing any low-level
copy_to/from_user routine which includes attack
mitigation. rtnet_get_arg() does call such routine under the hood. This
is something some Xenomai contributor may want to address.

But, again, this sys32emu code cannot run for armv7 under the current
stock implementation. So what we are discussing is purely hypothetical
at this stage for this architecture, and should definitely never happen
by construction if you are running armv7 (which does not make the
original issue go away, that is granted).

--=20
Philippe.

