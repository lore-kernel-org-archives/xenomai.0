Message-ID: <465ECE5A.8080809@domain.hid>
Date: Thu, 31 May 2007 15:32:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BD4FEAD09E8E3DB2BC0E576"
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
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BD4FEAD09E8E3DB2BC0E576
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
> Hi,
>=20
> I'm still blocked on a CPU affinity problem.
> In order to adapt a set affinity function which is based on
> posix linux lib :
> - CPU_AssignPID(uint32 PID, uint32 CPU_id)
> - the cpu affinity of the caller and all its child threads must be set =
to CPU_id.
>=20
> Problems are:
> Child PIDs must be listed, the only means I found is listing pids using=
 `ls /proc/"Parent pid"/ > temp_file`
> And each listed pid is sched_setaffinity'ed.
> I don't know if setting affinity of RT threads from an other thread (pa=
rent) using pid works with xenomai.

It works in so far as the Xenomai thread will not change its CPU until
it enters secondary mode. Moreover, there is no explicit "hey, RT thread
x, go to CPU #n!" under the POSIX skin. Migration always go through
secondary mode.

>=20
> So, my question is :
> With xenomai, is recursively cpu affinity setting from a parent thread,=
 a good way of doing ?
> I read switchtest program, and I conclude that in a xenomai and RT pers=
pective, it seems "nicer"
> to set affinity each threads separately during their init phase before =
the RT infinite loop.
> Otherwise, setting affinity after child threads creation from its paren=
t, may switch them into=20
> secondary mode during their RT loop, and at an unknown moment.

Actually, this issue has nothing to do with Xenomai's internals. It's
rather a generic question for RT apps: Shall some thread be forced to
migrate on a different CPU while it is running? Note that this can cause
unexpected latency hickups.

I wouldn't allow such a scheme via your middleware. Either you have
clear pre-operational states of your threads in which you can change
affinity safely (also across process boundaries - if this is required),
or try to establish a different CPU assignment scheme.

> Argumentation is important for my internship because I have to port on =
xenomai a very big RT=20
> posix based application. And I should justify any modifications and pre=
vent potential problems.
>=20
> Sorry, I don't know if it is clear.
>=20
> Thanks in advance, Niry.
>=20

HTH,
Jan


--------------enig9BD4FEAD09E8E3DB2BC0E576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXs5aniDOoMHTA+kRAqZxAJ9DLl9qwM8WOLbG9PrNdP1srpSX1wCdHHPw
hMtYqXwvmuDQm1V5veJ2S7g=
=apZ/
-----END PGP SIGNATURE-----

--------------enig9BD4FEAD09E8E3DB2BC0E576--

