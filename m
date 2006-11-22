Message-ID: <45645972.5040103@domain.hid>
Date: Wed, 22 Nov 2006 15:06:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What returns rt_task_self in
	relation	tort_task_create
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4F9C@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D4F9C@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig331BBF70754A8D30F5CF34DC"
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig331BBF70754A8D30F5CF34DC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Philippe Gerum wrote:
>> Use pthread_getspecific() for obtaining back a TLS data previously
>> defined by pthread_setspecific(), indexed on a TLS key obtained from
>> pthread_key_create(). Warning: AFAICT, only pthread_getspecific()
>> refrain from performing any kind of Linux syscall (in the current
>> NPTL and older LinuxThreads implementation, that is), thus won't
>> migrate your RT task to secondary mode when called. The two others
>> could call vanilla kernel services, so you must use them during
>> non-critical preliminary init steps of your task.      =20
>=20
> Does this mean that if you use pthread_getspecific() inside a user-spac=
e
> application you will not switch to secondary mode ? I was just
> abandoning using TLS because I could not imagine how the NPTL's
> functionality can be done without a system call. Is this behaviour
> something one can rely on in the future ?

AFAIK, the TLS ABIs for all relevant architectures are build upon
mechanisms (typically registers, sometimes with further pointer walks)
that avoid syscalls - already for performance reasons.

The only thing I'm not sure of is if all implementations create TLS
space during thread setup or on first access. But as you will likely
fill in data during setup anyway, that should be no practical problem.

>=20
> Is there something similar like TLS inside the native API ?

No need for it, at least in user-space. Use what glibc and the kernel
provide to you. Specifically __thread variables are very handy and
efficient.

Jan


--------------enig331BBF70754A8D30F5CF34DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZFlyniDOoMHTA+kRAufyAJ9WHwQy4pQyoXbBeqSQlhIUrkeO9ACePoXc
7+0Kr5Aq6JJeWsKBvAICCjw=
=CYRJ
-----END PGP SIGNATURE-----

--------------enig331BBF70754A8D30F5CF34DC--

