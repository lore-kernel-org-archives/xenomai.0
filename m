Message-ID: <456D9082.5040409@domain.hid>
Date: Wed, 29 Nov 2006 14:52:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-15?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-15?Q?_Switch_mode_with_x86?=
References: <s56d88c0.000@domain.hid>
In-Reply-To: <s56d88c0.000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig569AD86E7103A6261EBA88AD"
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
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig569AD86E7103A6261EBA88AD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>>
>> Hello,
>>
>> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
>> and change the config :=20
>>                                        - CONFIG_M586
>>                                        - disable CONFIG_INPUT_PCSPKR
> (it was on module)
>>                                        - disable prio boosting (check
> CONFIG_XENO_OPT_RPDISALBLE)
>> and it seems to work better, one hour without blocking, it's a record
>> for me.
>>
>> So, i will investigate to find which modification improve my problem.
>=20
> After somes tests (kernel compil), it seems that prio boost is
> responsable of my
> problem. When it's disable (kernel option checked) my program run
> correctly.

Yeah, that's what I assumed now as well. Full output of
/proc/xenomai/sched would be interesting now.

>=20
> I'm not sure to understand how the prio boost work.
> Can someone explain ?

Any Linux service, including those requested by Xenomai threads in
secondary mode, runs over the root thread. The root thread normally runs
at priority -1, i.e. below all Xenomai tasks. When
CONFIG_XENO_OPT_RPDISALBLE is *not* set and a Xenomai thread switches to
secondary mode, Xenomai raises the root thread's prio to the level of
that thread. This boosts Linux temporarily above any lower priority RT
thread, aiming at accelerating the completion of the requested Linux
service. If you do not depend on such boosting for your system design,
switching the service off improves the mode switch performance (and
obviously avoids a bug here we have to fix nevertheless).

Jan


--------------enig569AD86E7103A6261EBA88AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbZCCniDOoMHTA+kRAlE8AJ9o3qX7mjDnqtkjDfnUd9tSc/RhLwCeJVZh
Tu7Zt7bXZO5IDl3NZw0DUcw=
=TqfF
-----END PGP SIGNATURE-----

--------------enig569AD86E7103A6261EBA88AD--

