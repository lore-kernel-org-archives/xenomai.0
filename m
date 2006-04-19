Message-ID: <444670C9.6050207@domain.hid>
Date: Wed, 19 Apr 2006 19:18:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>	
	<4443992C.5000808@domain.hid>	
	<6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>	
	<44455471.8090001@domain.hid>
	<6ee4c8380604190827q76a1442du59c90b2515f71cdd@domain.hid>
In-Reply-To: <6ee4c8380604190827q76a1442du59c90b2515f71cdd@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig80CDE60CF6145A17E4626652"
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
--------------enig80CDE60CF6145A17E4626652
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
>> Why do you create the non-rt threads also via rt_task_create? This jus=
t
>> introduces unneeded load on the RT subsystem.
>=20
> I was under the impression that to interact with xenomai objects
> (RT_QUEUE, RT_MUTEX, etc), I needed to be in a xenomai thread. I
> assumed that because every mutex implementation I've seen has relied
> heavily on the underlying thread library (i.e. to sleep or yield) and
> mixing thread libraries seemed like a bad idea.
>=20
> So, is this what you're suggesting:
>=20
> - Link against pthreads AND native

By linking against native, you implicitly also link against pthread
(native threads are based on pthreads).

> - Start non-realtime threads using pthread_create and real-time
> threads using rt_task_create/rt_task_start

Yep.

> - use RT_MUTEX's/RT_QUEUE's for situations in which there is
> contention/communication among realtime and nonrealtime threads

Yes, but when blocking native services are invoked, the caller has to be
a native thread again. Only pure non-RT threads with no shared critical
paths can be plain pthreads. When in doubt, study the native
documentation regarding allowed contexts. The statement "switches to
primary mode" indicates that a native thread is required.

> - use pthreads mutexes/queues for situations of
> contention/communication among non-realtime threads

That's totally fine and also improve the efficiency (something that has
to be sacrificed for determinism sometimes).

>=20
> It sounds workable to me, assuming the queues/mutexes/etc. don't stop
> working when both threading libraries are involved.

Hope I could clarify the situation.

Jan


--------------enig80CDE60CF6145A17E4626652
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFERnDKniDOoMHTA+kRAhVzAJ4jwPOr7Obyk33iT2lIYqnZtAqAeQCWKkKO
V9DcK700EH3yiIix14QdgA==
=h3hW
-----END PGP SIGNATURE-----

--------------enig80CDE60CF6145A17E4626652--

