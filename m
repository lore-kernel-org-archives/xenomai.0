Message-ID: <44B1472F.5070903@domain.hid>
Date: Sun, 09 Jul 2006 20:13:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] nervous nmi-watchdog
References: <44736EE4.2060807@domain.hid> <44845D59.5040608@domain.hid>	
	<17540.32930.566897.960413@domain.hid>	
	<448482B4.2040105@domain.hid>	
	<17584.64392.157061.788526@domain.hid>	
	<1152463301.5027.3.camel@domain.hid> <44B1354A.50403@domain.hid>
	<1152464821.5027.6.camel@domain.hid>
In-Reply-To: <1152464821.5027.6.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34030D17CB3FFEF5FA602824"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34030D17CB3FFEF5FA602824
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-07-09 at 18:56 +0200, Jan Kiszka wrote:
>> I can confirm the failing NMI test here on my notebook with both nucle=
us
>> and native skin built into the kernel. I haven't seen false positive
>> NMIs yet, but the tracer is still on. Will switch off and re-check.
>=20
> FWIW, here, the false positive is raised immediately when starting the
> latency test.
>=20

Still no "luck" here, i.e. the watchdog only triggers when I reduce the
threshold. But I'm not on the box where I originally observed this
effect, and that one is out of reach for me now. Remains mysterious,
maybe chipset-dependent. Fortunately, it's only a debug feature.

Jan


PS: Hey, looks good for France. I do have to switch the "program" now. :)=



--------------enig34030D17CB3FFEF5FA602824
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEsUc0niDOoMHTA+kRAgRlAJ96YNUw8TqueY+gUCRf64UpGq92KACfSpT0
9fFKRPjiVRFIr+nvtE7dPH0=
=0LPu
-----END PGP SIGNATURE-----

--------------enig34030D17CB3FFEF5FA602824--

