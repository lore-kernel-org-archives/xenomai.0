Message-ID: <4A938D09.9090502@domain.hid>
Date: Tue, 25 Aug 2009 09:04:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460BE76E09@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460BE76E09@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45FAFEBC21E8065B3AE8E888"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Shared interrupt usage questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45FAFEBC21E8065B3AE8E888
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steve Deiters wrote:
> Is there any acceptable method to share interrupts in userspace using
> the native or other skin?  I am writing a userspace driver for a
> Freescale mpc5121e PSC serial controller, which has 12 programmable
> serial controllers which share a single FIFO controller.  The single
> FIFO controller has only a single IRQ line for all 12 PSCs.  This is
> further complicated by the fact that I also have to share this IRQ line=

> with the Linux domain, as it uses it for the console and other devices.=

>=20
> I cannot create multiple descriptors for the same IRQ line using
> rt_intr_create and the I_SHARED flag doesn't seem to be exported to
> userspace.  Is it valid to create one interrupt object and have multipl=
e
> tasks call rt_intr_wait for the same interrupt object?
> =20
> As far as sharing with the Linux domain, from the documentation it seem=
s
> I would just pass I_PROPAGATE and this should then be transparent to th=
e
> Linux domain.  Are there additional concerns I should be aware of with
> sharing the IRQ between domains?
>=20
> I have set this up with a single shared interrupt object and it seems t=
o
> function properly.  I just want to make sure I'm not putting myself in =
a
> condition where I could get some obscure race condition or have a
> deadlocked interrupt server task.
>=20
> Thanks.

I_PROPAGATE does not help resolving the IRQ sharing problem reliably.
See
http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_=
devices_share_the_same_IRQ.3F
for more information and browse the mailing list archives.

Jan


--------------enig45FAFEBC21E8065B3AE8E888
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkqTjQkACgkQniDOoMHTA+k1xQCfVcqJpre1jwa9dJjnu+jptNeS
BOwAn0k6T2vAMwrQG98DYnEGgbLMKsrI
=P4sB
-----END PGP SIGNATURE-----

--------------enig45FAFEBC21E8065B3AE8E888--

