Message-ID: <4820B784.3080306@domain.hid>
Date: Tue, 06 May 2008 21:54:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5719c6f30805050943p31f3f5eew74d0f7ef3dd2b5a5@domain.hid>
In-Reply-To: <5719c6f30805050943p31f3f5eew74d0f7ef3dd2b5a5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig81AF9F2079767D9D3592FF65"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Advice regarding MIPS port
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Florent Audebert <f.audebert@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81AF9F2079767D9D3592FF65
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Florent Audebert wrote:
> Hi,
>=20
> I am starting to work on a Xenomai port for MIPS architecture as part

Cool!

> of an internship at Open Wide (France). It is my first real diving
> into the kernel sources so I'm far from being an expert. The goal of
> this project is to be able to run it on a Broadcom BCM6448 board.
>=20
> My first objective is to be able to run an Adeos patched kernel. I
> have decided to work with QEMU (mips-malta board emulation) instead of
> my real target since it provides me an easy way to use GDB and thus to
> understand a little bit more what is going on. Furthermore, it
> provides an easy way of testing it for other people since it only
> requires QEMU and no specific real hardware.

Yes, a reasonable approach for arch bring-up. Specifically when using
low-end targets, QEMU is able to provide faster debug round-trip times
than real hw.

>=20
> I read as much as documents I can (Life with Adeos, Porting Adeos,
> ...) and finally started messing with the code. I managed to compile a
> MIPS kernel merging common Adeos code from latest x86 patch and
> adapting (see below) / commenting out. I guess my kernel is far from
> functional. My current issue seems to be related to the timer (see
> attached file).
>=20
> Here is a list of explicit changes I have done so far :
>=20
>     - include/asm-mips/irqflags.h : added raw_local_*() and local_irq_*=
().
>     - include/asm-mips/irq.h : do_IRQ() calls __ipipe_handle_irq()
> instead of generic_handle_irq().
>     - arch/mips/kernel/ipipe.c : created __ipipe_do_IRQ() (used with
> __ipipe_enable_pipeline()) which calls generic_handle_irq().
>=20
> Do you think my approach is correct ? Are my few changes relevant ? I
> avoided to modify entry.S and genex.S, is this mandatory ?

I would be fairly surprised if you get away without touching them on
MIPS. Maybe you should study changes to those files (or comparable ones)
on other archs first - offline, but you may use QEMU here as well. Try
to understand some typical code paths from the hardware to the delivery
to some domain.

Jan


--------------enig81AF9F2079767D9D3592FF65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIILeLniDOoMHTA+kRAiyKAJ4i1ni3FvHTF1VZmEJtl4wtBh0w5QCeP/02
LetYwoIzpVcHtzKdSdf8/JA=
=Kw/o
-----END PGP SIGNATURE-----

--------------enig81AF9F2079767D9D3592FF65--

