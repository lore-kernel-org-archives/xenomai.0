Message-ID: <4446934D.4060705@domain.hid>
Date: Wed, 19 Apr 2006 21:45:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>	
	<4443992C.5000808@domain.hid>	
	<6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>	
	<44455471.8090001@domain.hid>	
	<6ee4c8380604190827q76a1442du59c90b2515f71cdd@domain.hid>	
	<444670C9.6050207@domain.hid>
	<6ee4c8380604191042v1e914467k3ce36ffd44843548@domain.hid>
In-Reply-To: <6ee4c8380604191042v1e914467k3ce36ffd44843548@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95D18E05876F33E7D76AE932"
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
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95D18E05876F33E7D76AE932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
>> Yes, but when blocking native services are invoked, the caller has to =
be
>> a native thread again. Only pure non-RT threads with no shared critica=
l
>> paths can be plain pthreads. When in doubt, study the native
>> documentation regarding allowed contexts. The statement "switches to
>> primary mode" indicates that a native thread is required.
>=20
> So in this case, can I still call the functions from a thread created
> using pthread_create (assuming that they may momentarily increase in
> priority)?

You can call native (or more general: Xenomai) services from non-RT
threads when they do not let your thread block (or contain the risk of
blocking). To block on some RT resources like a queue or a mutex you
need a RT context, e.g. a native thread.

>=20
> Can you explain "no shared critical paths"? Would this include
> contending for a mutex-protected resource which is also used by a
> real-time thread?

Yes, this is such a critical path. You may want that every thread
holding the mutex does this only for a bounded time. To ensure this,
priority inheritance may be applied on the mutex holder, thus it has to
be a rt-thread.

>=20
> All of my non-time-critical threads are doing some form of
> communication with real-time threads, either through a queue or
> through mutex-protected memory. Can they still be pthread_create
> threads?

Nope, in this case they have to be extended, i.e. created as native threa=
ds.

>=20
>> Hope I could clarify the situation.
>=20
> You've been supremely helpful. I apologize for asking so many questions=
=2E
>=20

No problem, I always hope this helps others implicitly as well. :)

Jan


--------------enig95D18E05876F33E7D76AE932
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERpNNniDOoMHTA+kRAtR7AJ91/ckIV4xkNXip99CcAC20NOSgnACfcgz/
6zeF7oocdm4sZwOzK57L28M=
=A4+c
-----END PGP SIGNATURE-----

--------------enig95D18E05876F33E7D76AE932--

