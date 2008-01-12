Message-ID: <4788C279.1020607@domain.hid>
Date: Sat, 12 Jan 2008 14:36:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig866253A21CF84B43E0041155"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [BUG] evsync is not SMP-safe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig866253A21CF84B43E0041155
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe,

this

int fastcall __ipipe_dispatch_event (unsigned event, void *data)
=2E..
	ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
	local_irq_restore_hw(flags);
	propagate =3D !evhand(event, start_domain, data);
	local_irq_save_hw(flags);
	ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);

doesn't fly on SMP. While the invoked event handler is running, it may
happen that the caller gets migrated to another CPU. The result is an
inconsistent evsync state that causes ipipe_catch_event to stall (test
case: invoke Jerome's system() test a few times, them try to unload
Xenomai skins and nucleus).

First idea (I've nothing implemented to far, would happily leave it to
someone else's hand): Track event handler entry/exit with an, say, 8 bit
per-cpu counter. On event deregistration, just summarize over the
per-cpu counters and wait for the sum to become 0. This has just the
drawback that it may cause livelocks on large SMP boxes when trying to
wait for a busy event. I've no perfect idea so far.

Jan


--------------enig866253A21CF84B43E0041155
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHiMJ8niDOoMHTA+kRAm4sAJ98gocc4CWQl+NSaezFUPFQAo4ULwCggkxO
zQjVIa9iMMclOGLI92KwNic=
=dZfA
-----END PGP SIGNATURE-----

--------------enig866253A21CF84B43E0041155--

