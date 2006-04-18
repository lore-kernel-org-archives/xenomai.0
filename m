Message-ID: <44451CF9.8020201@domain.hid>
Date: Tue, 18 Apr 2006 19:08:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Where did my interrupts go?
References: <444502A6.7020402@domain.hid>
In-Reply-To: <444502A6.7020402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD05CA84E8F06AB74EFEC172"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD05CA84E8F06AB74EFEC172
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> Hello all,
>=20
> I have been writing an RTDM driver for an ISA (PC/104) based DAQ board.=
 I had=20
> the initial driver working under a very old trunk snapshot (Rev 464). T=
his=20
> morning I upgraded to the latest trunk. I put a few small fixes into my=
 driver=20
> and test application to take care of some deprecated functions and cons=
tants.=20
> (rt_queue_recv() and RT_IRQ_ENABLED). It appears that my driver is no l=
onger=20
> receiving interrupts. I can see the irq line go active on the oscillosc=
ope but=20
> it is never cleared and it appears my interrupt handler is never called=
=2E
>=20
> I ran the test suite including xeno-test with no problems. Attached are=
 output=20
> files from dmesg, xeno-config and xeno-test outputs. My kernel config f=
ile is=20
> also attached.
>=20
> At this point I think I need to turn on some debugging in the kernel. W=
hich=20
> debug options would be appropriate here?.
>=20

First of all, what does /proc/xenomai/irq tell you about your DAQ IRQ?
Is it registered correctly? Are there any arrivals noted?

Then double-check if you pass the correct code on return from the IRQ
handler: either RTDM_IRQ_HANDLED (if that IRQ was for you - standard),
or RTDM_IRQ_NONE. Nothing else (RT_IRQ_ENABLE is "native stuff", i.e.
violates the rule to keep your driver clean from non-RTDM APIs).

Regarding debugging options: CONFIG_XENO_OPT_DEBUG_RTDM is highly
recommended for drivers under development.

Jan


--------------enigAD05CA84E8F06AB74EFEC172
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERRz5niDOoMHTA+kRAi5cAJ9g2Uk91WgKoe/64YWNyPXzMsQJMQCfci9W
+SEiw6YfheGBCj9R2ROmsSc=
=T/Qr
-----END PGP SIGNATURE-----

--------------enigAD05CA84E8F06AB74EFEC172--

