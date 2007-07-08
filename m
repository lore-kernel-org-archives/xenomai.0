Message-ID: <4690D1DC.1020204@domain.hid>
Date: Sun, 08 Jul 2007 14:00:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <15cf230500002197@domain.hid> <4681332D.2030105@domain.hid>
In-Reply-To: <4681332D.2030105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEBEE0E97215E209DEB1B1F7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] accessing context switch counter from rttask
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gsellmann Peter <Peter.Gsellmann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEBEE0E97215E209DEB1B1F7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gsellmann Peter wrote:
>> Hi!
>>
>> I searched for a while and found this snippet
>>
>> RT_TASK *rt =3D rt_task_self();
>> int x =3D rt->thread_base.stat.csw;
>>
>> should give the number of context switches, but:
>> RT_TASK in non-kernel mode is only RT_TASK_PLACEHOLDER so i have no
>> access to thread_base!
>>
>> Is there an official way to get this info (w/o opening
>> "/proc/xenomai/...")?
>>
>=20
> Not yet. You could extend RT_TASK_INFO with this statistic (obtained vi=
a
> rt_task_inquire). There is currently work in progress to add accumulate=
d
> execution times to the same interface, so this extension would fit quit=
e
> well. Patches always welcome.

Meanwhile, I added this feature to my experimental patch stack while
integrating some other new stats. See

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/

against Xenomai SVN trunk, namely

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/enhance-thread-sta=
ts.patch

Just call rt_task_inquire() and check RT_TASK_INFO::ctxswitches (there
are modeswitches and pagefaults too as we are already at it).

Feedback welcome!

Jan


--------------enigDEBEE0E97215E209DEB1B1F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkNHdniDOoMHTA+kRAj45AJ4ysZjZsY0UOcPmjJPLHzzgNPJI+gCfacD2
pnHz1hUONMVevXUGILJUpLc=
=p9zA
-----END PGP SIGNATURE-----

--------------enigDEBEE0E97215E209DEB1B1F7--

