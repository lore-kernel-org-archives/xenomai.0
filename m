Message-ID: <45268FBE.9050607@domain.hid>
Date: Fri, 06 Oct 2006 19:17:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] kernel panic
References: <47746.127.0.0.1.1160160976.squirrel@domain.hid>
In-Reply-To: <47746.127.0.0.1.1160160976.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3FBF8739990E2FB78DA9763"
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
To: Wael BACHTA <wael@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3FBF8739990E2FB78DA9763
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wael BACHTA wrote:
> Hi,
>=20
> I use an Intel Pentium 4 processor which can be used as 2 virtual
> processors when setting the SMP option during the kernel compiling (I c=
an
> see 2 processors with "cat /proc/cpuinfo").

Hyperthreading? No good idea for RT if you are after low latencies. This
virtualisation of a second CPU is incomplete and can cause congestions
so that you stall on low-prio work at arbitrary points in your code. I
would suggest to measure the effect to be sure if it is acceptable
(latency test under high non-RT load like kernel builds, with SMP vs. !SM=
P).

>=20
> I patched the kernel with adeos in order to install xenomai. I discover=
ed
> that :
> - when completely disabling the ACPI and setting the SMP, my system boo=
ts
> but I have only one processor when I look into /proc/cpuinfo
> - Everything goes well when I don't disable completely the ACPI.
>=20
> I also use a PCI framegrabber. its driver is a real time one developed

[If it is for common hardware, publishing it would be nice. I guess that
there are others interested in such support.]

> under xenomai. I noticed that this driver works fine only if the PCI_MS=
I
> is set. Otherwise, I don't have any interrupts.
>=20
> I must use my real time driver and the 2 virtual processors.
> But, when I enable the ACPI, the SMP and the PCI_MSI, I have a kernel
> panic. My PC boots when I disable the ACPI but I loose 1 processor.

What about ACPI on (/wo ACPI_PROCESSOR) and SMP off?

>=20
> I don't see what's wrong.

Likely Adeos/I-pipe, as the amount of MSI-related bug reports also
indicates. Maybe this workaround already helps you:

https://mail.gna.org/public/adeos-main/2006-09/msg00032.html

If not, try to catch the oops (e.g. via serial or netconsole) for
further debugging. In any case, please post your findings.

Jan


--------------enigF3FBF8739990E2FB78DA9763
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFJo++niDOoMHTA+kRAqMlAJ9bkahD+7rbZP7X5HqNhDaJjtf30QCeKc4g
vnRvn0MI0K9K5qh7/bh8M/4=
=tmNi
-----END PGP SIGNATURE-----

--------------enigF3FBF8739990E2FB78DA9763--

