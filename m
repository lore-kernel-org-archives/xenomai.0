Message-ID: <44E32B64.90108@domain.hid>
Date: Wed, 16 Aug 2006 16:27:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ksrc/driver refactoring
References: <Pine.LNX.4.64.0608161603176.7349@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0608161603176.7349@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54B234CAE76037DAAE6C37B3"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54B234CAE76037DAAE6C37B3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Klaas Gadeyne wrote:
>> I just wanted to drop a note that I did some refactoring on the
>> drivers directory (16550A->serial) and the config menus. If anything i=
s
>> broken, shoot me.
>=20
> I don't think this is related, but 2 students of mine got stuck on a li=
nker
> error this morning trying to compile xenomai-trunk on a i386 target
> (2.4.33 kernel with the adeos-ipipe-2.4.32-i386-1.2-06.patch (applied
> with a few minor hunks), gcc 3.3.6 from Debian).
>=20
> ld -m elf_i386 -T /usr/src/linux-2.4.33/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/
> main.o init/version.o init/do_mounts.o \
>                --start-group \
>                arch/i386/kernel/kernel.o arch/i386/mm/mm.o
> kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>                 drivers/acpi/acpi.o drivers/char/char.o
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
> drivers/char             /agp/agp.o drivers/ide/idedriver.o
> drivers/cdrom/driver.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o
> drivers/net/pcmcia/pcmcia_             net.o drivers/video/video.o
> drivers/media/media.o kernel/xenomai/nucleus/xeno_nucleus.o
> kernel/xenomai/skins/native/xeno_native.o
> kernel/xenomai/skins/posix/xeno_posix.o
> kernel/xenomai/skins/rtdm/xeno_rtdm.o
> drivers/xenomai/16550A/xeno_16550A.o drivers/xenom
> ai/testing/xeno_timerbench.o arch/i386/xenomai/built-in.o \
>                net/network.o \
>                /usr/src/linux-2.4.33/arch/i386/lib/lib.a
> /usr/src/linux-2.4.33/lib/lib.a
> /usr/src/linux-2.4.33/arch/i386/lib/lib             .a \
>                --end-group \
>                -o vmlinux
> drivers/char/char.o: In function `handle_scancode':
> (.text+0x1b25a): undefined reference to `pckbd_sysrq_xlate'
> make: *** [vmlinux] Error 1
>=20
> The "quick-fix" solution was to disable the magic_sysrq_key option
> from the kernel.  I first thought the problem was due to a missing
> dependency in the the kernel and not at all xenomai-related (and since
> the quick hack worked, they didn't search any further), but now that
> I've read your mail I started to doubt if it might be related.
>=20
> Let me know if it might be related and if you want further info.

Could you post your .config (bzipped or privately)? Maybe it's also
related to the pending issues around the kd_mksound stuff. I assume you
checked that the problem disappears over vanilla 2.4.33, thus is
actually Xenomai or Adeos related...

>=20
> But I'll wait before shooting :-)

Appreciated.

Jan


--------------enig54B234CAE76037DAAE6C37B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4ytkniDOoMHTA+kRAgsZAJwP8fp2iTl6JTDJmrK5bY6EOUxmdwCfUYbm
AAp+D21TOildGlsAhpV/zlA=
=9faU
-----END PGP SIGNATURE-----

--------------enig54B234CAE76037DAAE6C37B3--

