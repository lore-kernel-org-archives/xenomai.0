Message-ID: <4BB5250F.1040409@domain.hid>
Date: Fri, 02 Apr 2010 00:58:23 +0200
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
	<4BB51931.3080307@domain.hid> <4BB523E8.705@domain.hid>
In-Reply-To: <4BB523E8.705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig134FCE953C24B105979BAD51"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig134FCE953C24B105979BAD51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2010-04-01 at 23:54 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> The bottom line for me, is that T_PRIMARY, as a user-space visible
>>>>> "feature" should be dropped at some point, and never ever considere=
d as
>>>>> a way to fix the RTDM syscall issue anymore. I don't mind saving an=

>>>>> extra-context switch even in what I think should be _rare_ cases, b=
ut
>>>>> this has to be done in a way that does not introduce the same kind =
of
>>>>> misunderstanding the eager mode switching allowed by rt_task_set_mo=
de()
>>>>> did in the past.
>>>>>
>>>>> Really, I'm convinced that an awful lot of people are currently run=
ning
>>>>> under-performing at best, or even broken applications today, becaus=
e of
>>>>> that, thing.
>>>> We are not discussing T_PRIMARY here. We are discussing something li=
ke
>>>> an "rtdm_is_rt_capable()" addition for those _few_ RTDM drivers that=

>>>> actually want to provide Ianus-like services.
>>>>
>>> Yes, we do discuss of T_PRIMARY in between the lines.
>>>
>> You can take it away, and the rtdm_is_rt_capable-approach would still
>> work, but that without affecting existing designs.
>=20
> Ok. I almost regret I launched this troll. We have discussed some time
> with Philippe, and I agree with him that drivers which this change
> really broke were already broken. The only side-effect is the double
> switch issue, which, per-se is not that much a trouble in real-world
> applications. So what I propose is a special RTDM driver flag that woul=
d
> somehow fix the issue for the switchtest driver, and would only be used=

> by that driver and not exported in the rtdm headers, and of course not
> documented.
>=20

No, I'm queuing rtdm_rt_capable() + a revert of the __xn_exec_conforming
commit now. That's way less surprising for existing drivers and still
does not require user land to fiddle with the mode. All can be handled
at driver level (ie. in Analogy, obviously the only driver that needs it
so far).

Jan


--------------enig134FCE953C24B105979BAD51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1JRMACgkQitSsb3rl5xSwnACeLqzjY4HPWU1ydUAleJ5JgdLn
ajsAnRuVEUfBTjmQdswg37FQUGMvO9JH
=LWQl
-----END PGP SIGNATURE-----

--------------enig134FCE953C24B105979BAD51--

