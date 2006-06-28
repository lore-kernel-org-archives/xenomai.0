Message-ID: <44A295C2.1000405@domain.hid>
Date: Wed, 28 Jun 2006 16:44:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
References: <20060626172116.019532000@domain.hid>	<20060626172120.322015000@domain.hid>	<17570.29185.754625.871443@domain.hid>	<44A275DE.5080500@domain.hid>
	<17570.34620.38518.404171@domain.hid>
In-Reply-To: <17570.34620.38518.404171@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCA3F4A992933237C08AC9C0B"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA3F4A992933237C08AC9C0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > Is there no way to make this code easier to port for example by us=
ing
>  > > native or posix services for timings measurement and by abstractin=
g the
>  > > non portable part and moving them to include/asm-i386 ?
>  >=20
>  > This tool is intentionally left Xenomai-free. You can put it on any =
x86
>  > box around (and I assume that there is almost always some...) and ru=
n
>  > the test. Thus, no need for a second RT-patched system.
>  >=20
>  > Anyway, suggestions or patches to add a porting layer are welcome. T=
he
>  > following points need to be addressed: time measuring, irq protectio=
n,
>  > hardware access. I just wonder if this is worth the effort.
>=20
> I do not understand: it appears to me that Xenomai trunk does not
> compile on other architectures than x86 when applying the IRQ latency
> benchmark patch. So, something needs to be done. It may be the enabling=

> of an automake conditional in configure.in when compiling for x86.
>=20

See the patch:

Index: xenomai/src/testsuite/irqbench/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/testsuite/irqbench/Makefile.am
@@ -0,0 +1,47 @@
+testdir =3D $(prefix)/testsuite/irqbench
+
+test_PROGRAMS =3D irqloop
+
+ifeq ($(XENO_TARGET_ARCH),i386)
+test_PROGRAMS +=3D irqbench
+endif


I just realised that some hint in the documentation that irqbench can
easily be compiled outside Xenomai is required.

>  >=20
>  > >=20
>  > > Also note that calling printf from a signal handler risk deadlocki=
ng if
>  > > the signal handler get called on the return path of the write call=
 that
>  > > take place in the middle of a printf call on the main thread.
>  > >=20
>  >=20
>  > Ok, then we also need a fix for the latency test (this is where I
>  > grabbed that pattern from). Is there a high risk that this locks up?=
 I
>  > wonder why I never observed or heard of problems with latency.
>=20
> The latency test used to deadlock, that is why the summary printed on
> signal is printed on stderr. Unfortunately, there seem to be one displa=
y
> left on stdout, so it should still deadlock. The reason why we never se=
e
> the deadlock is (perhaps) that the continuous intermediate results are
> printed on the context of the "display" thread, whereas the termination=

> signals are preferably delivered by the kernel to the "main" thread,
> that only calls pause. Which makes the use of stderr in signals handler=
s
> pointless.
>=20
> Anyway, since your program is frequently using printf on the context of=

> the main thread, the risk of deadlock is real.
>=20

Ok, I'm going to address this.

Thanks for the hint!

Jan


--------------enigCA3F4A992933237C08AC9C0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEopXCniDOoMHTA+kRArXuAJ9RWWebhwkq7XjwLMbwyx9JfmFsAACePCki
NC+7CorzePfjJyzv9DtYX64=
=AaDY
-----END PGP SIGNATURE-----

--------------enigCA3F4A992933237C08AC9C0B--

