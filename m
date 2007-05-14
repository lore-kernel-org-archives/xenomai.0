Message-ID: <4648A597.70600@domain.hid>
Date: Mon, 14 May 2007 20:08:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46478F98.1040101@domain.hid>
In-Reply-To: <46478F98.1040101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF473707B0652D39627D8CC4A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] pit clocksource broken under Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF473707B0652D39627D8CC4A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> just checked on real hardware (found in qemu originally):
>=20
> When Linux uses the pit clocksource AND Xenomai is attached, the system=

> time no longer makes progress. Observed under 2.6.20 with 1.7-03 and
> newer patches, Xenomai trunk.
>=20
> I guess not many people will be affected by this and I'm lacking time t=
o
> debug, so I'm just dumping the report and running away...

Somehow I hate open issues...

I recalled some private thread with you, Philippe, about this particular
line in pid_read(). A look at it again revealed the reason for this bug.

Jan

PS: pending_patches++ ;)


---
 arch/i386/kernel/i8253.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.20/arch/i386/kernel/i8253.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.20/arch/i386/kernel/i8253.c
@@ -47,7 +47,8 @@ static cycle_t pit_read(void)
=20
 #ifdef CONFIG_IPIPE
 	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
-		return 0;	/* We don't really own the PIT. */
+		/* We don't own the PIT, fall back to jiffies. */
+		return (cycle_t)(jiffies * LATCH);
 #endif /* CONFIG_IPIPE */
=20
 	spin_lock_irqsave(&i8253_lock, flags);



--------------enigF473707B0652D39627D8CC4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSKWXniDOoMHTA+kRArdGAJ9qYDToVQ6lfyIuqeGHP/nRRYhfwgCdFosO
4KTyWwe0emxXJk0EVAe9cBI=
=KtWU
-----END PGP SIGNATURE-----

--------------enigF473707B0652D39627D8CC4A--

