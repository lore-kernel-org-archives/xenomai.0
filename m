Message-ID: <45CD9FD1.9040509@domain.hid>
Date: Sat, 10 Feb 2007 11:34:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange deadlock.
References: <45CCCD10.9000008@domain.hid> <45CD44EF.6080807@domain.hid>
In-Reply-To: <45CD44EF.6080807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B513BCBF2A28515E5365B5D"
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
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B513BCBF2A28515E5365B5D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Disclaimer: I'm just jumping on this thread without having read all
details.]

Maksym Veremeyenko wrote:
> ...
> I tried to summarize this info and build time sorted table of actions
> (task B - "bus_monitor_proc[0]", task V - "vdcp[0030]m"):
>=20
> V    5397829215210    rt_mutex_unlock:ENTER
> V    5397828986260    serial_transact:EXIT
> V    5397810469917    serial_transact:ENTER

You are holding the mutex across the serial transaction, i.e. a
secondary mode switch, right? If you haven't set
CONFIG_XENO_OPT_RPIDISABLE, you might be are affected by the bug in the
priority coupling between Xenomai and the Linux kernel. Already tried
latest v2.3.x SVN?

> V    5397792191552    rt_mutex_lock:EXIT
> V    5397792126988    rt_mutex_lock:ENTER
> V    5397770396236    serial_transact:EXIT
> B    5397750468006    rt_mutex_unlock:ENTER
> B    5397732320388    rt_mutex_lock:EXIT
> B    5397732302828    rt_mutex_lock:ENTER
> V    5397718529990    serial_transact:ENTER
> V    5397718501300    serial_transact:EXIT
> V    5397701107940    serial_transact:ENTER
> V    5397682575612    rt_mutex_unlock:ENTER
> V    5397664304073    rt_mutex_lock:EXIT
> V    5397664238700    rt_mutex_lock:ENTER
> V    5397618710764    rt_mutex_unlock:ENTER
> V    5397600363677    rt_mutex_lock:EXIT
> V    5397600295612    rt_mutex_lock:ENTER
>=20
> As i mentioned early task B was executed during serial operation in tas=
k
> V, and may be it could cause switching status of task V from 3146112
> (0x00300180) to 3146624 (0x00300380) - rised bit 0x00000200 (XNRELAX
> 0x00000200 Relaxed shadow thread (blocking bit) )
>=20
> I am not specialist in Xenomai architecture, but it's not looks like
> stack corruption in my program.
>=20
> I rather going to rewrite some code part to use rtserX instead of
> /dev/ttyXX

Given that you hold a lock across the serial transaction, switching to a
deterministic driver is certainly wiser. Still, understanding your
original problem would be good too so that we get aware of any potential
new bug in Xenomai and are able to fix it. So please try the SVN version
with your current code as well.

Jan


--------------enig4B513BCBF2A28515E5365B5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzZ/RniDOoMHTA+kRAtwUAJ9WzIjT7DrtU++zJZxEUbdu8XmUDACfcpTm
2yrfAL/PhDoHI0sEdEWHVWE=
=Y/VD
-----END PGP SIGNATURE-----

--------------enig4B513BCBF2A28515E5365B5D--

