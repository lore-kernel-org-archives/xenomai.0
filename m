Message-ID: <463AE7D3.6030401@domain.hid>
Date: Fri, 04 May 2007 09:59:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <24394502.1178264721982.JavaMail.ngmail@domain.hid>
In-Reply-To: <24394502.1178264721982.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE33017117DC826EA101BEB8F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE33017117DC826EA101BEB8F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I have been gone one step back to analyze the issue from the situation =
is originally occurred.
> This was the situation that I had a 2.6.20.4 kernel and Xenomai 2.3.1 (=
included Adeos patch).
> When I  enable MSI in the kernel configuration I get the kernel message=
:
> "spurious APIC interrupt on CPU#0, should never happen."
> when trying to enable (ifconfig) the e1000 driver for an onboard PCIe n=
etwork adapter.
>=20
> I have now used the very same kernel without Xenomai patch, but using t=
he same kernel config
> (MSI enabled). This returns the IRQ 223 for the Ethernet adapter.
> With 2.6.21 it returns IRQ 219, there seems to be a difference between =
2.6.20 and 2.6.21.
> Well, as I am working with 2.6.20.4, I looked deeper in that.
>=20
> One interesting thing I found was in arch/i386/kernel/ipipe.c at functi=
on __ipipe_enable_pipeline
> I do not understand the meaning of that code.
> At the beginning of that function, there are a couple of calls to ipipe=
_virtualize_irq().
> These MAP the APIC system vectors.
> However, the second call that maps=20
> SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR (with is infact 223) is ma=
pped to
> smp_spurious_interrupt (which leads to the result I see).
> However, I am not sure if it is correct to use the VECTOR values here a=
s ipipe_virtualize_irq
> uses "irq" as second parameter and not  a vector. This looks like a vec=
tor vs. irq mismatch.

Isn't this the issue Philippe's last patch against ipipe and xenomai fixe=
s?

>=20
> Within the create_irq() function, the e1000 creates irq 223 on vector 2=
01.
>=20
> When I monitor the calls to set_intr_gate() I see that the vector 32 wi=
ll end up at the address
> of irq_entries_start, vector 32 will end up at irq_entries_start + 8 et=
c.
> In entry.S this will end up in writing ~(vector) unto the stack and cal=
ling common_interrupt.
> This finally calls __ipipe_handle_irq.
> The means that __ipipe_handle_irq will not be called with the IRQ numbe=
r but with the vector!!
> It could be that this is the same for the "old" IRQ vectors (<32).=20
> However for the MSI IRQs this seems to be not correct.
> I think that this could be the root cause for the problems I see.

Again, please verify that you are not debugging the issue that Philippe
may have already fixed, ie. re-evaluate your (very systematic!) findings
after applying the ipipe fix.

Jan


--------------enigE33017117DC826EA101BEB8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFGOufTniDOoMHTA+kRAhwBAJdB2vRWvZH0QQm5wnsSTExIK9+vAJ9/UKPn
9wM0nZGbLRC7zv4hVQeQEA==
=2y1l
-----END PGP SIGNATURE-----

--------------enigE33017117DC826EA101BEB8F--

