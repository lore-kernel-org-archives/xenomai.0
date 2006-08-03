Message-ID: <44D26C1C.5040506@domain.hid>
Date: Thu, 03 Aug 2006 23:35:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
References: 200608021808.18076@domain.hid> <200608021808.18076@domain.hid>
	<44D0F72E.3020406@domain.hid> <200608031628.31584@domain.hid>
In-Reply-To: <200608031628.31584@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96E919FD22B0BE5D565C2B07"
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96E919FD22B0BE5D565C2B07
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
>>> So I tried to use rt_queue. But when I tried to read from queue with
>>> timeout (or TM_INFINITE), I got an EPERM error. That means: "service
>>> should block, but was called from a context, which cannot sleep.".
>>> But I want to sleep (and wait for new data). Where is the problem? Do=

>>> you have any advice?
>> Is the read of the queue a Xenomai thread? It has to be, even if it wi=
ll
>> mostly run in secondary (Linux) mode. Check also /proc/xenomai/sched
>> when you think it should be.
> Both tasks are created by rt_task_create and started by rt_task_start. =
They are also in /proc/xenomai/sched:
> CPU  PID    PRI      TIMEOUT  STAT       NAME
>   0  0       -1      0        R          ROOT/0
>   1  0       -1      0        R          ROOT/1
>   1  313     20      0        X          main_task
>   1  314     30      30195788906 w          hw_task
> Note: I'm still using your patch allowing to call rtdm_event_timedwait =
even in nrt.

The only thing I can recommend here: try reducing your code to the bare
minimum that still demonstrate the issue, then post it.

Jan


--------------enig96E919FD22B0BE5D565C2B07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0mwcniDOoMHTA+kRAlcGAJ9xZv0nAawmQHG0WTVdnpHs/LWm0QCfQ09f
wOfTUgXHBTDZUkTvtX59mQo=
=V4hu
-----END PGP SIGNATURE-----

--------------enig96E919FD22B0BE5D565C2B07--

