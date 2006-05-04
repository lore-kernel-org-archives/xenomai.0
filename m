Message-ID: <4459A511.8050302@domain.hid>
Date: Thu, 04 May 2006 08:54:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
References: <200604281736.28169.lbocseg@domain.hid>
	<200605020936.00576.lbocseg@domain.hid> <4458625C.5020808@domain.hid>
	<200605031315.01583.lbocseg@domain.hid>
In-Reply-To: <200605031315.01583.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E21B9C3F4B65485098421E3"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E21B9C3F4B65485098421E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quarta 03 Maio 2006 04:57, Jan Kiszka escreveu:
>=20
>>> ...Or should I use other IPC mechanism for sharing resource with
>>> PIP?
>> Mutexes were invented for such resource access control :). They have a=

>> strict ownership concept, thus allowing to apply PIP as well.
>=20
> Yes, however I can't figure out how could I use mutexes as counting=20
> semaphores, for instance. They have different meanings. However I could=
 think=20
> in semaphores protected by PIP in singular cases, although I couldn't f=
igure=20
> out how to do it in a systematic approach so that it could be used in a=
=20
> realtime framework such as Xenomai...
>=20

So you have to protect a multi-instance resource which can be used by a
certain number of tasks in parallel? Is this a real scenario or just a
hypothetical?

Let's consider it's real: this means that every task successfully
requesting the resource becomes one of the owners. So you would have to
maintain a list of owners, not just a single reference as with mutexes.
Once someone requests the resource when there are no instances left, at
least one of the owners should be boosted to the requesters priority.

All feasible, but probably so special with traps and pitfalls (think of
initialising or handling multiple requests by the same tasks) that no
one yet developed a generic mechanism for any OS I know of. But you are
always free to do so based on existing elementary mechanisms. :)

Jan


--------------enig7E21B9C3F4B65485098421E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWaURniDOoMHTA+kRAsUAAJ9/31T6LcR5tb1dhB7L/EH85egfTwCfRL8J
IWqDlYsGhsyUIWOuKDuL904=
=ubk2
-----END PGP SIGNATURE-----

--------------enig7E21B9C3F4B65485098421E3--

