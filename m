Message-ID: <47ED140B.2040406@domain.hid>
Date: Fri, 28 Mar 2008 16:51:39 +0100
From: Neil Armstrong <narmstrong@domain.hid>
MIME-Version: 1.0
References: <47ECBCAA.50701@domain.hid>
	<2ff1a98a0803280811n702cf80ble01c121959bbcf21@domain.hid>
In-Reply-To: <2ff1a98a0803280811n702cf80ble01c121959bbcf21@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDCB9B5CE06306BB53E8F0BA8"
Subject: Re: [Xenomai-core] Porting Ipipe/Adeos patch to new arm9 board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCB9B5CE06306BB53E8F0BA8
Content-Type: multipart/mixed;
 boundary="------------010005060009040804070904"

This is a multi-part message in MIME format.
--------------010005060009040804070904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

First of all, thanks for your aswer,
Gilles Chanteperdrix a =E9crit :
>>  I patched the kernel with the arm1 patch (from the ARM website), the
>>  board non-rt patch enabling serial and the macb ethernet controller a=
nd
>>  finnally tried to apply the ipipe arm patch and resolving failures.
>=20
> At first sight, you call spin_lock_irqsave in __ipipe_mach_set_dec.
> This is illegal, __ipipe_mach_set_dec may (and will) be called from
> real-time context, you should be using the _hw variants. I do not know
> if it is what causes the oops, but it would cause an oops later.
I based my board patch on integrator's and s3c24xx code and they use
spin_lock_irqsave in __ipipe_mach_set_dec, but I found local_irq_save_hw
used on an AT91 patch.
Finally the change did nothing, are the integrator and s3c24xx patchs
up-to-date ?

Should I drop the arm1 patch from ARM ? and start from a fresh vanilla
kernel ?

> I am not sure it makes sense to set the timer auto-reload mode when
> the timer is used in one-shot mode: imagine that the timer is
> programmed in one-shot mode, it will tick several time before the
> interrupt handler is called.
>
Integrator seems using the timer in one-shot mode and changes the
prescaler with the delay value. But won't I loose to much timer ticks
between two reloads ?

Neil
--=20
Neil Armstrong
Neotion Sophia Antipolis
Stagiaire Mars-Septembre 2008 Polytech'Nice-Sophia
narmstrong@domain.hid (PGP:0x1166F485)

--------------010005060009040804070904
Content-Type: text/x-vcard; charset=utf-8;
 name="narmstrong.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="narmstrong.vcf"

begin:vcard
fn:Neil Armstrong
n:Armstrong;Neil
org:Neotion;Neotion Sophia Antipolis
email;internet:narmstrong@domain.hid
title;quoted-printable:Ing=3DC3=3DA9nieur Software Embarqu=3DC3=3DA9
tel;cell:0667474169
note:PGP 0x1166F485
version:2.1
end:vcard


--------------010005060009040804070904--

--------------enigDCB9B5CE06306BB53E8F0BA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH7RQPb5rmahFm9IURAnfBAKC4PJAMD+HAVEjaUSC5JZgTjitDHgCfVa2W
Lia08qWcACjc6Jst3nM817Q=
=8euO
-----END PGP SIGNATURE-----

--------------enigDCB9B5CE06306BB53E8F0BA8--

