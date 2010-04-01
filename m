Message-ID: <4BB51931.3080307@domain.hid>
Date: Fri, 02 Apr 2010 00:07:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>
	<1270159246.2418.432.camel@domain.hid>
In-Reply-To: <1270159246.2418.432.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE05313DD81EC551CC973E9A7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE05313DD81EC551CC973E9A7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-04-01 at 23:54 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> The bottom line for me, is that T_PRIMARY, as a user-space visible
>>> "feature" should be dropped at some point, and never ever considered =
as
>>> a way to fix the RTDM syscall issue anymore. I don't mind saving an
>>> extra-context switch even in what I think should be _rare_ cases, but=

>>> this has to be done in a way that does not introduce the same kind of=

>>> misunderstanding the eager mode switching allowed by rt_task_set_mode=
()
>>> did in the past.
>>>
>>> Really, I'm convinced that an awful lot of people are currently runni=
ng
>>> under-performing at best, or even broken applications today, because =
of
>>> that, thing.
>> We are not discussing T_PRIMARY here. We are discussing something like=

>> an "rtdm_is_rt_capable()" addition for those _few_ RTDM drivers that
>> actually want to provide Ianus-like services.
>>
>=20
> Yes, we do discuss of T_PRIMARY in between the lines.
>=20

You can take it away, and the rtdm_is_rt_capable-approach would still
work, but that without affecting existing designs.

Jan


--------------enigE05313DD81EC551CC973E9A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1GTQACgkQitSsb3rl5xQV6QCfS+281tK6oomwDkLHArHXbBzo
Md0An0uSygzwjUZzyqzhppLvTnfmq6H0
=GDKP
-----END PGP SIGNATURE-----

--------------enigE05313DD81EC551CC973E9A7--

