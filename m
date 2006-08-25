Message-ID: <44EF37BE.70207@domain.hid>
Date: Fri, 25 Aug 2006 19:47:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problems?
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
In-Reply-To: <44EF17E8.5040606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21CF95C1F695AD7A06F912DD"
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
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21CF95C1F695AD7A06F912DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steve Kreyer wrote:
> Hi,
>=20
> Ive got a problem using periodic tasks, or timers in generally.
> First of all the relevant piece of source:
>=20
> -----------------------------------------------------------------------=
------------------------------
>=20
> #define SLEEP_TIME 100000000
>=20
> ...
>=20
> static void xmit(void* user_data){
>    int err =3D 0;
>    unsigned long timeout;
>    err =3D rt_task_set_periodic(NULL, TM_NOW, SLEEP_TIME);
>    if(err < 0){
>        fprintf(stderr, "Error: Cannot set rt task 'xmit' periodic!
> errcode=3D%d\n", err);
>        return;
>    }
>    err =3D rt_task_wait_period(&timeout);
>    if(err < 0)
>        fprintf(stderr, "Warning: Cannot wait for task period! errcode=3D=
%d
> timeout=3D%ld\n", err, timeout);
> }
> ...
> int main(){
>    int err =3D 0;
>    mlockall(MCL_CURRENT | MCL_FUTURE);
>    signal(SIGINT, cleanup);
>    err =3D rt_timer_set_mode(TM_ONESHOT);
>    if(err < 0){
>        fprintf(stderr, "Error: Cannot set rt timer mode to TM_ONESHOT!
> errcode=3D%d\n", err);
>        return 1;
>    }
>    err =3D rt_task_spawn(&xmit_task, xmit_task_name, 0, XMIT_TASK_PRIO,=

> T_FPU, xmit, NULL);
> ...
> }
> -----------------------------------------------------------------------=
--------------------------------------
>=20
>=20
> The task did not wait for the period to which it is set.
> I get always an ETIMEDOUT error, and a timer overrun of 16 times when I=

> try to call rt_task_wait_period...
> Also another problem is, everytime I try to call rt_task_sleep or the
> standard linux library functions pause,sleep or usleep,
> my system does not react on inputs anymore and I have to restart the
> machine...
> Can anyone tell me whats going on there?
> If you need additional informations, please let me know :)
>=20

Your example (with slight modifications) works fine, and the other
effect you listed here clearly indicates some fundamental problem of
your box. Does the kernel log contain any suspicious messages,
specifically after that input lock-up? If not, please provide a precise
setup description: Xenomai version, kernel version + ipipe revision,
hardware description (e.g. the architecture), and the .config of your
system (zipped please).

Jan


--------------enig21CF95C1F695AD7A06F912DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE7ze+niDOoMHTA+kRAjYrAJ91vab+1DhR/ovDA8BeA1KVxO4HGwCeN58S
TU1wZTW55HdYd5tnkwoz5uw=
=gAiT
-----END PGP SIGNATURE-----

--------------enig21CF95C1F695AD7A06F912DD--

