Message-ID: <451CFF99.8050002@domain.hid>
Date: Fri, 29 Sep 2006 13:12:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] possible future conflict w LOCAL_APIC
References: <451C586A.7020309@domain.hid>
In-Reply-To: <451C586A.7020309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig614FD156DB849046C6CCD84A"
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig614FD156DB849046C6CCD84A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> hi guys,
>=20
> I encountered this error building 18-mm2 with a .config Ive been
> using with xenomai since I started.=20
>=20
>> arch/i386/kernel/built-in.o(.text+0x34f1): In function `do_nmi':
>> arch/i386/kernel/traps.c:752: undefined reference to
>> `panic_on_unrecovered_nmi'
>> arch/i386/kernel/built-in.o(.text+0x3564):arch/i386/kernel/traps.c:712=
:
>> undefined reference to `panic_on_unrecovered_nmi'
>>
>>
>> $ grep nmi arch/i386/kernel/Makefile
>> obj-$(CONFIG_X86_LOCAL_APIC)    +=3D apic.o nmi.o
>>
>> which I dont have enabled.
>=20
>=20
> Will fix.
>=20
> BTW I was planning to make LOCAL_APIC unconditional on i386 too like on=

> x86-64.
> There is basically no reason ever to disable it, and the bug work aroun=
d
> for buggy BIOS one can be done at runtime. Overall the #ifdef / compile=

> breakage
> ratio vs saved code on disabled APIC code is definitely unbalanced.
>=20
> -Andi
>=20
>=20
>=20
> This looks like it may become a problem:
>=20
> Q: The kernel message log says:
>   "Xenomai: Local APIC absent or disabled!
>    Disable APIC support or pass "lapic" as bootparam."
>=20
> A: Xenomai sends this message if the kernel configuration Xenomai was
>   compiled against enables the local APIC support
>   (CONFIG_X86_LOCAL_APIC), but the processor status gathered at boot
>   time by the kernel says that no local APIC support is available.
>   There are two options for fixing this issue:
>=20
>   o either your CPU really has _no_ local APIC hw, then you need to
>     rebuild a kernel with LAPIC support disabled, before rebuilding
>     Xenomai against the latter;
>=20
>=20
>=20
> Is this something fundamental or merely inconvenient ?
>=20

At the bare minimum this would require to decouple the APIC vs. PIC
decision of I-pipe/Xenomai from Linux - or make it a runtime thing as wel=
l.

But given that upcoming clocksource/clockevent/genirq requires some
internal changes anyway (*), that aspect will only be a footnote in this
context. Maybe the result will mean one pitfall less for the poor
end-user... ;)

However, thanks for the hint.

Jan

(*) Also the main reason why there is no patch for 2.6.18 yet. Actually,
2.6.18 is terrible in this respect since it is only half way down the
path, even on x86. I'm convinced that in the end also I-pipe and Xenomai
will benefit from these arch-independent abstractions, e.g. by being
able to provide virtualised clocks or IRQ chips to Linux in a structured
way. But in the meantime it looks like we suffer.


--------------enig614FD156DB849046C6CCD84A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHP+ZniDOoMHTA+kRAtMEAJ9krzMf2byNf+D6TLGSM2KFC8t8mwCcD0XI
Vkw/hBm8WffCnOsCbMMt33M=
=erpp
-----END PGP SIGNATURE-----

--------------enig614FD156DB849046C6CCD84A--

