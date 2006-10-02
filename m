Message-ID: <452133D2.7070006@domain.hid>
Date: Mon, 02 Oct 2006 17:44:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SH4 port
References: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid> <45211492.6080109@domain.hid>
	<003101c6e6f6$1fa52de0$1501a8c0@domain.hid> <452125A4.4010705@domain.hid>
	<002901c6e6ff$3f519d00$1501a8c0@domain.hid>
In-Reply-To: <002901c6e6ff$3f519d00$1501a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA98B1805EFD239060874C837"
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
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA98B1805EFD239060874C837
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kiichi Kameda wrote:
>> Kiichi Kameda wrote:
>>>> [ksrc/arch/sh/switch.c]
>>>>
>>>> void rthal_switch_to(xnarchtcb_t *prev, xnarchtcb_t *next)
>>>> {
>>>> ...
>>>>         /*
>>>>          * Restore the kernel mode register
>>>>          *      k7 (r7_bank1)
>>>>          */
>>>>  if(next->user_task) {
>>>>
>>>>             asm volatile("ldc       %0, r5_bank"
>>>>                      : /* no output */
>>>>                      : "r" (next->user_task->thread_info));
>>>>  }
>>>>
>>>> Is there a particular reason why comment and reality diverge regardi=
ng
>>>> the thread_info register? Could this cause your troubles?
>>>>
>>> I'm sorry, the comment is wrong.
>>> The code that uses r7_bank  results in overwriting "current".
>> What code is it?
>=20
> Above code(rthal_switch_to) is derived from Linux, which uses r7_bank.
> At first I used r7_bank  in rthal_switch_to , but this code caused pani=
c.

Why? Rhetorical questions. The point is you need to understand the
mechanisms preventing this to work because it looks to me like this is
the way to go.

Was there anything else that denies invoking the original Linux
__switch_to directly? That should be preferred if feasible.

>=20
>>> To avoid this,  I changed  from r7_bank to r5_bank for Xenomai contex=
t
>>> switch .
>> Wouldn't it be better to avoid that overwriting in the first place
>> instead of escaping from it? You may not be safe from code running on
>> behalf of a Xenomai user-space thread that assumes current is still in=

>> r7_bank.
>>
>>> Also, I added to the Linux context switch code  so that thread_info i=
s
> set
>>> in r5_bank register  as well as in r7_bank regsiter.
>>> r5_bank register is referenced in the page fault handling code.
>> The handling code of Xenomai or Linux?
>=20
> There exists only one page fault handling code for both Xenomai and Lin=
ux.
> Is this a problem?

Xenomai normally only has a hook here to suspend RT threads on faults
and/or migrate them to Linux. I just didn't know if you had to develop
something special for SH4.

>=20
>> The goal must be that the environment for a shadowed Xenomai thread
>> looks (almost) like that of a normal Linux thread. If there is Xenomai=

>> code that messes this up on SH4, this has to be fixed. Patching Linux
>> Linux outside the I-pipe context indicates that something is wrong wit=
h
>> the design. This is what I can say from my distant POV without knowing=

>> the specific issues of SH4.
>>
>=20
> Yes I think so too.
>=20
>=20
>=20

Jan


--------------enigA98B1805EFD239060874C837
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFITPTniDOoMHTA+kRAkbHAJoCFPwRfn+t+uk7tPREdSbsG0sjUwCfXwV8
8xwKl37t10fEHLIAJM0YG0E=
=04UP
-----END PGP SIGNATURE-----

--------------enigA98B1805EFD239060874C837--

