Message-ID: <45D421EA.5070507@domain.hid>
Date: Thu, 15 Feb 2007 10:03:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	
	<45D029B8.1030805@domain.hid>	
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>	
	<45D0666C.8070409@domain.hid>	
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>	
	<45D171F9.7000705@domain.hid>	
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>	
	<45D192EB.9030608@domain.hid>	
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>	
	<45D2CE22.5010105@domain.hid>
	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
In-Reply-To: <e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A490BB41A32BE90E6F34DAB"
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A490BB41A32BE90E6F34DAB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> Hi,
>=20
> Do u mean to say that if i have created my tasks using native xenomai A=
PI's
> like rt_task_create , then inside those tasks i will have to use posix =
skin
> calls like pthread_setschedpolicy, etc...?
>=20
> Is that so.

Nope. If you picked the native skin API, all scheduler setup for a RT
task should be done through that interface.

>=20
> Cant i just have context switch between the tasks themselves say low
> priority and a high priority task created by rt_task_create.
>=20
> Reason being i have created two tasks using the rt_task_create API and =
my
> high priority task is runnning and my low priority task has slept, so a=
s
> soon as my low priority task has expired its sleep time and gets ready =
to
> run,
>=20
> The low priority task preempts my high priority task and even its prior=
ity
> gets raised to that of the high priority task and starts executing. The=

> higgh priority task gets suspended altogether amidst its running. Simpl=
y
> baffled by the behavior?

If you have found a weird behaviour of Xenomai, please post some
as-small-as-possible demo code that exposes the issue. We will have a
look at it.

Jan


--------------enig8A490BB41A32BE90E6F34DAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1CHqniDOoMHTA+kRArntAJ4ytpsb98PwzyIwWEmXGBxqpheWtgCcDUR1
sIadUzcsu/8Eq9nlBBSJ5HM=
=kEJ6
-----END PGP SIGNATURE-----

--------------enig8A490BB41A32BE90E6F34DAB--

