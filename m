Message-ID: <482D33B3.9070700@domain.hid>
Date: Fri, 16 May 2008 09:11:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
	<482B3BCF.8090700@domain.hid> <482B3EE5.9030702@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276E025@domain.hid>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF100276E025@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E78AAD0154E296720682493"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E78AAD0154E296720682493
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

DOURNES Guillaume wrote:
> Thanks a lot for your attention. And sorry for my poor english.
> I change my context into a real RT context and my problem disappears.
>=20
> Nevertheless, I have other questions about the IRQ management.
>=20
> In fact, after executing my software application (so after the rtdm_clo=
se call, and so the free irq), I obtain a syslog message : kernel Disabli=
ng IRQ #11. This message doesn't affect my software if I run it again, bu=
t may be there are some side effect. In dmesg, the following error messag=
e appears : irq 11: nobody cared (try booting with the "irqpoll" option).=

> In my open function I call :=20
> - request_region
> - rtdm_irq_request
> In my close function I call :
> - rtdm_irq_free
> - release_region
> May be there is a function to call to avoid this disabling irq ?

Are you sure that you properly configured your device to no longer
generate IRQs before unregistering the handler?

>=20
>=20
> Moreover, when I'm using my discrets I/O driver (on the IRQ 11) and I a=
dd an USB Key (on this IRQ 11) the software freeze. Note that my USB Key =
works normaly before I call my open function, and doesn't work after my s=
oftware execution, may be because of the Disabling IRQ.
> Note that the freeze appears with the 16550A rtdm driver use. For examp=
le, when my keyboard irq is the same as the seria board irq, the computer=
 freeze when the driver is running and the keyboard is using at the same =
moment.
> I think that the linux irq and xenomai irq are not usable at the same t=
ime !
>=20
> Note that my kernel is configured with shared interrupt.

Please read the FAQ in the wiki about shared RT/non-RT IRQS.

Jan


--------------enig8E78AAD0154E296720682493
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFILTOzniDOoMHTA+kRAlaIAJ4mpjTf9z0cxG26tzvN5KwelshrwACcCcYp
iuHbTDixwUMdiY8AbSgmPHc=
=nk7/
-----END PGP SIGNATURE-----

--------------enig8E78AAD0154E296720682493--

