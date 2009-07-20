Message-ID: <4A6410C2.6060804@domain.hid>
Date: Mon, 20 Jul 2009 08:37:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A62D1C1.9050807@domain.hid>
	<4A62D2B8.8030907@domain.hid>	<4A6337D8.7030300@domain.hid>
	<4A633A57.1090005@domain.hid> <1248017714.4228.157.camel@domain.hid>
In-Reply-To: <1248017714.4228.157.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B79CDD11157CC2A527ABB5A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 2/3] x86-64: Work around gcc issues with
 populating syscall registers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B79CDD11157CC2A527ABB5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2009-07-19 at 17:23 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> gcc-4.1.3 of kubuntu has problem with proper syscall register
>>>> initialization in rt_task_shadow if TLS is enabled. But it is likely=

>>>> that more compiler versions below 4.3 and more configuration variant=
s
>>>> are affected.
>>>>
>>>> This patch installs a workaround for these gcc versions which places=
 an
>>>> optimization barrier before the register variable setup. This forces=
 gcc
>>>> to actually load the registers.
>>> I have tried the barrier with arm gcc, it does not work. However,
>>> marking the registered clobbered instead of the memory fixes arm gcc =
4.3
>>> bug. So, I wonder, would not it make more sense to mark the registers=
 as
>>> clobbered by the barrier instead of memory on x86 too?
>>>
>> Sounds reasonable. Will give it a try later.

Sounded reasonable - but didn't work. So we have to stick with the
original version.

>>
>> I just noticed that my unification patch includes some unwanted merge
>> artifact, so it requires another round in any case.
>=20
> So I'm discarding the pending pull request entirely. Please re-submit
> when ready.

I just pushed an updated for patch 3 (removing the original "+r"
workaround from the unified version). Please pull now from
git://git.xenomai.org/xenomai-jki.git for-upstream

Jan


--------------enig5B79CDD11157CC2A527ABB5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpkEMUACgkQniDOoMHTA+kGsQCfejuvC5oQ5nBeWy0tCXbb8jA4
AnYAmgLL6MdJ83TaCSY2MoYB14qEd3ie
=p0HG
-----END PGP SIGNATURE-----

--------------enig5B79CDD11157CC2A527ABB5A--

