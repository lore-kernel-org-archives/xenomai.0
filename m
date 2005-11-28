Message-ID: <438B3BDC.6090700@domain.hid>
Date: Mon, 28 Nov 2005 18:18:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Latest snapshot (182) not compiling (kernel)
References: <438743FC.6070007@domain.hid>	<ae7121c60511280857l26c080b7g299c6cae93a8afed@domain.hid>
	<ae7121c60511280858g7d25f4d9y28de0688053ad51d@domain.hid>
In-Reply-To: <ae7121c60511280858g7d25f4d9y28de0688053ad51d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Panagiotis Issaris <panagiotis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Panagiotis Issaris wrote:
> Hi,
>=20
> I'm also having issues compiling the latest Xenomai tree.
>=20

Mm, dot-config would be great. TIA,

>=20
> On 11/25/05, *Ignacio Garc=EDa P=E9rez* <iggarpe@domain.hid
> <mailto:iggarpe@domain.hid>> wrote:
>=20
>     Hi,
>=20
>     I dunno what's changed, but I updated my xenomai snapshot to the la=
test
>     revision (182) and the kernel no longer compiles (fails due to some
>     xnpod_* undefined symbols).
>=20
>     Revision 179 compiled fine.
>=20
>=20
>=20
> I'm using revision 199 on a x86 Ubuntu 5.10 system with GCC 4.0.1 (is=20
> anyone else using that one?).
>=20
>=20
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `disengage_irq_shield':
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:176:=20
> undefined reference to `__raw_write_lock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:207:=20
> undefined reference to `__raw_write_unlock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:186:=20
> undefined reference to `__raw_write_unlock'
> kernel/built-in.o: In function `xnshadow_reset_shield':
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:=20
> undefined reference to `__raw_read_lock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:=20
> undefined reference to `__raw_read_unlock'
> kernel/built-in.o: In function `lostage_handler':
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:=20
> undefined reference to `__raw_read_lock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:=20
> undefined reference to `__raw_read_unlock'
> kernel/built-in.o: In function `xnshadow_relax':
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:=20
> undefined reference to `__raw_read_lock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:=20
> undefined reference to `__raw_read_unlock'
> kernel/built-in.o: In function `schedule_event':
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:=20
> undefined reference to `__raw_read_lock'
> /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:=20
> undefined reference to `__raw_read_unlock'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [_all] Error 2
>=20
>=20
> With friendly regards,
> Takis
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

