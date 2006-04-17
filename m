Message-ID: <4443F498.6020404@domain.hid>
Date: Mon, 17 Apr 2006 22:03:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>	<4443992C.5000808@domain.hid>
	<4443AB1F.2060405@domain.hid> <4443D1E0.5020708@domain.hid>
In-Reply-To: <4443D1E0.5020708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAFB3ABB4EBB78EE50DAA4049"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "Brian L." <bluczkie@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFB3ABB4EBB78EE50DAA4049
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>
>>> Brian L. wrote:
>>>
>>>> If I create a native-skin RT_TASK from userspace with no flags, i.e.=

>>>>
>>>> void task(void*)
>>>> {
>>>>    for (;;) ;
>>>> }
>>>> int main()
>>>> {
>>>>   RT_TASK t;
>>>>   rt_task_create(&t, 0, 3, 0);
>>>>   rt_task_start(&t,task,0);
>>>>   (do something which blocks)
>>>> }
>>>
>>>
>>>
>>> mlockall left out for simplicity? Or is it also missing on your real
>>> test? In the latter case, occasional application crashes are "normal"=

>>> (as described below).
>>>
>>> Philippe, you suggested some code for detecting this. We should reall=
y,
>>> really add this soon (maybe to the exception path)!
>>>
>>
>> The submitted patch works pretty well detecting unlocked memory, I'm
>> using it right now, but I'd like something a bit more self-explanatory=

>> than just receiving SIGXCPU. I don't think the execption path is the
>> right place to put this, since the mlockall issue causes random bugs,
>> and you likely want to detect them early and unconditionally.
>>
>=20
> Commit #941 should provide a reliable guard against lack of process
> memory locking.
>=20

Hmm, a simple test using the latency tool with disabled mlockall did not
yet show any effect on my system. Shouldn't there pop up some message
when starting such a "broken" program?

Jan


--------------enigAFB3ABB4EBB78EE50DAA4049
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ/SYniDOoMHTA+kRAjD7AJ0cvkQ+O8btPumeFGu09L9O6pO1RACbBpEJ
L32M2jd2jscYV4q9/KbFxaA=
=7tSZ
-----END PGP SIGNATURE-----

--------------enigAFB3ABB4EBB78EE50DAA4049--

