Message-ID: <48FCD554.5030306@domain.hid>
Date: Mon, 20 Oct 2008 21:00:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>	<48FB15A8.30703@domain.hid>	<48FB17BD.7010904@domain.hid>	<48FB1891.3060609@domain.hid>
	<48FB19F7.1030107@domain.hid>	<48FB5BD5.1060205@domain.hid>
	<48FB5F1C.401@domain.hid> <48FC405E.8010603@domain.hid>
	<48FC440E.90000@domain.hid> <48FCD485.2060606@domain.hid>
In-Reply-To: <48FCD485.2060606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A5712EBF9F0D3425BD45093"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger
 priority	change in user-space.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A5712EBF9F0D3425BD45093
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Philippe Gerum wrote:
>>>>> Well, what about merging the solutions: trap the signal from the li=
brary
>>>>> constructor by default for people relying on #1, AND document the s=
hadow signal
>>>>> handler for people who can do #2?
>>>> For me, merging the two, would mean keep sigshadow_install called up=
on
>>>> thread creation, but export xeno_sigwinch_handler to be callable fro=
m
>>>> user signals.
>>>>
>>>> This way, if people install their signal handler before the first th=
read
>>>> creation, they have nothing to worry about. If they install their si=
gnal
>>>> handler at a later time, they have to take care of calling
>>>> xeno_sigwinch_handler and look at its return value.
>>> Jan, do you agree? The main argument is that people may use third-par=
ty
>>> libraries such as, say, libreadline or libqt which intercept the
>>> SIGWINCH signal, and that we do not want to recompile these libraries=
 to
>>> run with Xenomai.
>> Yes, I'm fine with the current approach + doc + xeno_sigwinch_handler.=

>=20
> Ok. Since I am going to paste the doc in four different places, I'd=20
> better get it right from the beginning. Here is my prose:
>=20
>  * @note: When creating or shadowing a Xenomai thread in user-space, fo=
r the
>  * first time, Xenomai installs a handler for the SIGWINCH signal. If y=
ou had
>  * installed a handler before that, it will be automatically called by =
Xenomai
>  * for SIGWINCH signals that it has not sent.
>  *
>  * If, however, you install a signal handler for SIGWINCH after creatin=
g
>  * or shadowing the first Xenomai thread, you have to explicitely call =
the

explicitly
(I regularly mistype this as well...)

>  * function xeno_sigwinch_handler at the beginning of your signal handl=
er,
>  * using its return to know if the signal was in fact an internal signa=
l of
>  * Xenomai (in which case it returns 1), or if you should handle the si=
gnal (in
>  * which case it returns 0). xeno_sigwinch_handler prototype is:
>  *
>  * <b>int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt);</b=
>
>  *
>  * Which means that you should register your handler with sigaction, us=
ing the
>  * SA_SIGINFO flag, and pass all the arguments you received to
>  * xeno_sigwinch_handler.
>=20
>=20

Sounds good to me.

Jan


--------------enig8A5712EBF9F0D3425BD45093
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj81VQACgkQniDOoMHTA+kWEACbBQ/RlyqQWlF9q6wA6myQf/iJ
LpcAn25F6LsauG6DLyyXSV6mhHJ0mQR6
=KWXg
-----END PGP SIGNATURE-----

--------------enig8A5712EBF9F0D3425BD45093--

