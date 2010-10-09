Message-ID: <4CB02734.3060900@domain.hid>
Date: Sat, 09 Oct 2010 10:26:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6tAnApCNw9hzQUEYR7BcsgDSU3YA5N+xn-uN2@domain.hid>
In-Reply-To: <AANLkTi=6tAnApCNw9hzQUEYR7BcsgDSU3YA5N+xn-uN2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBA440A49FDE32587F6A58ADE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] latency spike when starting opengl windows
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA440A49FDE32587F6A58ADE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 08.10.2010 03:44, Peter Pastor wrote:
> Hey there,
>=20
> I noticed a spike in the latency over around 600-800microseconds when
> starting an opengl window.
>=20
> I have the SMI workaround enabled and also included my device id in the=

>=20
> /usr/src/xenomai/ksrc/arch/x86/smi.c
>=20
> file
>=20
> lspci -vvv -nn shows a
>=20
> Intel Corporation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16=
]
>=20
> so I added
>=20
> {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},
>=20
> After recompiling the kernel I finally saw
>=20
> [    2.443949] Xenomai: SMI-enabled chipset found
>=20
> ( I did not see that line before )
> but unfortunately I also saw
>=20
> [    2.443957] Xenomai: SMI workaround failed!
>=20
> Well, the latency test still showed spikes of about 600-800microsends w=
hen
> for example starting or closing glxgears. I am using a nvidia FxQuadro =
FX
> 4800 and I am using the latest nvidia driver which I downloaded from th=
e
> nvidia homepage (256.53).

The nice nvdidia driver is known to cause latency peaks during DMA
memory allocation/mapping (wbinvd...). You will have to leave it in a
stable state (no X restarts, no 3D or CUDA setup/tear-down, not sure
about mode switches ATM) as long as the RT load is running.

Jan


--------------enigBA440A49FDE32587F6A58ADE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkywJzgACgkQitSsb3rl5xT/SwCgnaPJQYcEMdDioPMbCjMm9rEQ
2OgAniaU9WzusLR/8yQ9jtsTH0cEArYj
=mTfj
-----END PGP SIGNATURE-----

--------------enigBA440A49FDE32587F6A58ADE--

