Message-ID: <44A160A8.1080909@domain.hid>
Date: Tue, 27 Jun 2006 18:45:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
In-Reply-To: <20060626172120.322015000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig608E5D80102A947929A4ECC8"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig608E5D80102A947929A4ECC8
Content-Type: multipart/mixed; boundary="------------070401020003080506080908"

This is a multi-part message in MIME format.
--------------070401020003080506080908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

jan.kiszka@domain.hid wrote:
> This patch introduces another rttesting driver, xeno_irqbench, for
> measuring external IRQ latencies. The irqbench device is controlled
> by a user-mode tool irqloop. A second tool for plain Linux, irqbench,
> is provided to trigger the event over serial or parallel cross-link
> (the latter is incomplete yet) and measure the reaction latency.
>=20

As a follow-up, here is a patch to add some documentation for irqbench.
I do not repeat the command line args of irqbench/irqloop, but feel free
to point out missing explanations.

Jan

--------------070401020003080506080908
Content-Type: text/x-patch;
 name="irqbench-doc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="irqbench-doc.patch"

Index: xenomai/doc/txt/irqbench.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/doc/txt/irqbench.txt
@@ -0,0 +1,48 @@
+IRQ Latency Benchmark
+---------------------
+
+This latency benchmark for external interrupts consists of three parts:
+
+1. xeno_irqbench (ksrc/drivers/testing)
+   RTDM driver for the test target to handle and reply to the IRQ events=
, or
+   forward them to user-space.
+
+2. irqloop (src/testsuite/irqbench)
+   xeno_irqbench control front-end and user-space loop-closer. Runs agai=
nst
+   the POSIX skin on the test target.
+
+3. irqbench (src/testsuite/irqbench)
+   IRQ triggering and reaction measuring tool for the log system. Runs o=
ver
+   plain Linux on x86 hosts (contains inline assembly, ports to other ar=
chs
+   will be welcome).
+
+To link both test and log system, a null-modem cable between 8250-compat=
ible
+two RS232 ports is required. The infrastructure for parallel port cross-=
over
+is prepared as well, but yet untested and incomplete. The null-modem cab=
le
+must provide at least the following links:
+
+        test target             log system
+        -----------             ----------
+          CTS(8)      <------     RTS(7)        IRQ trigger
+          RTS(7)      ------>     CTS(8)        reply
+
+          DCD(1)
+          and/or      <------     DTR(4)        trace trigger (optional)=

+          DSR(6)
+
+        (Pin number on 9-pin sub-D socket)
+
+Test and log system can be started in arbitrary order, they will wait on=

+each other.
+
+The log system runs each single IRQ measurement with local IRQs disabled=
=2E It
+will wait up to 100 times the current period on the test system's reply =
(after
+initial successful synchronisation, which happens with IRQs enabled). No=
te that
+these timeouts may disturb other processes or drivers on the log system.=

+
+Keep in mind for test evaluations that, by design, irqbench will not tri=
gger a
+new IRQ event before the reply on the previous one has arrived or timed =
out.
+Thus the specified test period may be dynamically expended in case of
+overload. But maximum a latency close or above the period will clearly
+indicate this.
+
Index: xenomai/doc/txt/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/doc/txt/Makefile.am
+++ xenomai/doc/txt/Makefile.am
@@ -2,6 +2,7 @@ txtdocdir =3D $(datadir)/doc/$(PACKAGE)-$(
=20
 dist_txtdoc_DATA =3D \
 	16550A-driver.txt \
+	irqbench.txt \
 	pse51-skin.txt \
 	psos-skin.txt \
 	rtai-skin.txt \

--------------070401020003080506080908--

--------------enig608E5D80102A947929A4ECC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEoWConiDOoMHTA+kRArQ3AJ0TvQ6Jr9aEmJzwSTvSTtGiVy9TsQCeJ8nv
18nmTFbIPc+VfsKm8tNt3+c=
=xUjm
-----END PGP SIGNATURE-----

--------------enig608E5D80102A947929A4ECC8--

