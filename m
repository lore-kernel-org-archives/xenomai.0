Message-ID: <44D90C41.5070307@domain.hid>
Date: Wed, 09 Aug 2006 00:12:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
References: <44D7EDCF.9010409@domain.hid>
In-Reply-To: <44D7EDCF.9010409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2137D05F93F83D41C6F601FB"
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
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org, andrewg@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2137D05F93F83D41C6F601FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Vincent Levesque wrote:
> Hello,
>=20
> I'm having some problems with rt_task_send/receive/reply in the native
> skin. The code attached at the end of this email works fine on Xenomai
> 2.1 but rt_task_send() fails with error message -110 on Xenomai 2.2.0
> and today's subversion trunk. I checked the error values of all other
> calls (removed for clarity) and everything seems to be ok. The -110
> error code is returned either when rt_task_send() times out or when
> rt_task_reply() is called, whichever comes first. If I set it to
> TM_INFINITE, rt_task_send() never returns and the system hangs when I
> press control-c. I've reproduced this behavior on two computers.
>=20
> Am I doing something wrong that was tolerated by 2.1? Is this a bug in
> Xenomai 2.2?

Nothing. This looks like a good catch of a regression in 2.2.

I'm not that deep into rt_task_send/receive design, but this problem
seems to be related to some heavy disagree between xnsynch_sleep_on and
rt_task_send about the correct ownership of the receiver's send queue.

Reading this comment [1] and then looking at that piece of code [2],
something must go utterly wrong wrt/ message passing in Xenomai 2.2. [1]
says the owner of task->msendq will always be "task" and never "sender"
(the current thread), so the test in [2] will always fail. The
lock-steeling code was introduced with 2.2, so this effect did not occur
with 2.1.

I have no idea yet how to solve it cleanly. Maybe Philippe finds some
time to comment on this before he'll be away for the next week. In the
meantime message passing users of the native skin may better stay on 2.1.=
x.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/ta=
sk.c#L1750
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c=
#L212


--------------enig2137D05F93F83D41C6F601FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE2QxBniDOoMHTA+kRAsJsAJ0QmryoiFnpU7SAvNAeqJYLOYXpjgCeJ1CU
oFrZxz8RihygioMs2RaItPo=
=zVhk
-----END PGP SIGNATURE-----

--------------enig2137D05F93F83D41C6F601FB--

