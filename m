Message-ID: <4BB5B7C1.4020301@domain.hid>
Date: Fri, 02 Apr 2010 11:24:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid>
In-Reply-To: <4BB5B64B.6040803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F74A5054582C927278BF2FA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F74A5054582C927278BF2FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Henri Roosen wrote:
>> We have the same requirement for which we also have no solution. One
>> of our threads has a configurable priority of which at the lowest
>> priority the thread should behave like an idle task that is only
>> scheduled when all xenomai threads are idle and also the Linux domain
>> is idle. The thread might use rtdm-drivers and xenomai mutexes and
>> therefore has to be moved to the Xenomai domain. But then it always
>> has higher priority than any threads scheduled in linux.
>=20
> That's not true, Xenomai threads can run in non-RT scheduling classes a=
s
> well. They may just gain RT priority while holding some lock that is
> requested by a RT thread as well.
>=20
>> Actually, when seen from the first domain, this requirement would be
>> solved when we could set a first domain priority for the second
>> domain... Gilles, is that what is meant by the SCHED_IDLE policy for
>> Linux?
>=20
> "nice +20", thus a very small CPU share if other task are runnable.
>=20
> Note that "true" SCHED_IDLE, ie. no CPU share if some other task is
> runnable, could only work if we forbid access to Linux syscalls for suc=
h
> tasks - not feasible.

Actually, "nothing is impossible": That task could gain normal Linux
priority while running the syscall. But it would have to loose
immediately again when leaving Linux. So no lazy mode switching like we
do for other Xenomai tasks, otherwise these tasks would loose there idle
property after the first syscall.

The point is that things get fairly special and maybe invasive to
Xenomai, and I'm still not seeing the practical benefit compared to nice
19 or 20.

Jan


--------------enig5F74A5054582C927278BF2FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1t8EACgkQitSsb3rl5xQ9awCdGzmf+tr1xOBuq5EF8YMmupD5
AMwAoNOqp+eRAwEp3RPPXTiCEumeIblT
=Q8Ae
-----END PGP SIGNATURE-----

--------------enig5F74A5054582C927278BF2FA--

