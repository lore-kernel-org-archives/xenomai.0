Message-ID: <465EDB8B.8010507@domain.hid>
Date: Thu, 31 May 2007 16:28:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
	<465ECE5A.8080809@domain.hid> <465ED94F.2010300@domain.hid>
In-Reply-To: <465ED94F.2010300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C70A875A388FAEF2187D032"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C70A875A388FAEF2187D032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> RAKOTOSALAMA, Nirilanto wrote:
>>
>>> Hi,
>>>
>>> I'm still blocked on a CPU affinity problem.
>>> In order to adapt a set affinity function which is based on
>>> posix linux lib :
>>> - CPU_AssignPID(uint32 PID, uint32 CPU_id)
>>> - the cpu affinity of the caller and all its child threads must be se=
t to CPU_id.
>>>
>>> Problems are:
>>> Child PIDs must be listed, the only means I found is listing pids usi=
ng `ls /proc/"Parent pid"/ > temp_file`
>>> And each listed pid is sched_setaffinity'ed.
>>> I don't know if setting affinity of RT threads from an other thread (=
parent) using pid works with xenomai.
>>
>> It works in so far as the Xenomai thread will not change its CPU until=

>> it enters secondary mode. Moreover, there is no explicit "hey, RT thre=
ad
>> x, go to CPU #n!" under the POSIX skin. Migration always go through
>> secondary mode.
>=20
> Let's repeat it, rephrased, once again: what works with Linux regarding=

> CPU affinity also works with Xenomai.

To my understanding, there is difference in the behaviour of
sched_setaffinity() when used on a foreign pid/tid depending on if the
target is a Xenomai thread in primary mode or if it is a Linux thread,
no? If this matters in practice, that's a different question (I don't
think it does, for the reasons given earlier).

Jan


--------------enig7C70A875A388FAEF2187D032
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXtuLniDOoMHTA+kRAq+wAJ0VGfOknVeMCnLI++7JVFvHPQwhSACfWr3+
2/Ay9o8QWmB5iiwyEUaFGIY=
=fv/0
-----END PGP SIGNATURE-----

--------------enig7C70A875A388FAEF2187D032--

