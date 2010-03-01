Message-ID: <4B8C2797.2000501@domain.hid>
Date: Mon, 01 Mar 2010 21:46:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid> <4B8C25B9.8090705@domain.hid>
	<4B8C26F7.3020306@domain.hid>
In-Reply-To: <4B8C26F7.3020306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA07C0A67C7C9DB64A04AB15B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA07C0A67C7C9DB64A04AB15B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Charlton, John wrote:
>>>> I added some printk output to the cond.c file in xenomai-2.5.1 and i=
t shows that  xnsync_sleep_on returned -ETIMEDOUT as it should:
>>>> Xenomai: registered exported object M1-1908 (mutexes)
>>>> Xenomai: registered exported object C1-1908 (condvars)
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -110
>>>> xnsynch_sleep_on returned: -4
>>>> Xenomai: native: cleaning up cond "C1-1908" (ret=3D0).
>>>> Xenomai: unregistered exported object C1-1908 (condvars)
>>>> Xenomai: native: cleaning up mutex "M1-1908" (ret=3D0).
>>>> Xenomai: unregistered exported object M1-1908 (mutexes)
>>>> Xenomai: POSIX: destroyed thread df5a0800
>>>>
>>>> I put the printk on line cond.c:433 after err is set in rt_cond_wait=
_prologue():
>>>>
>>>> 	info =3D xnsynch_sleep_on(&cond->synch_base,
>>>> 				timeout, timeout_mode);
>>>> 	if (info & XNRMID)
>>>> 		err =3D -EIDRM;	/* Condvar deleted while pending. */
>>>> 	else if (info & XNTIMEO) {
>>>> 		err =3D -ETIMEDOUT;	/* Timeout. */
>>>>         }
>>>> 	else if (info & XNBREAK) {
>>>> 		err =3D -EINTR;	/* Unblocked. */
>>>> 	}
>>>>         printk(KERN_DEBUG "xnsynch_sleep_on returned: %d\n", err);
>>>>
>>>> I put a printk in rt_cond_wait_inner() which is called directly by r=
t_cond_wait() from user mode but did not see the output in the dmesg outp=
ut for that one.
>>> One of our problems is the prologue/epilogue split up (both in kernel=

>>> and user space): the epilogue can eat the error code or the prologue,=

>>> including the -ETIMEDOUT.
>> Ah. My fault. Looks user-space is Ok though. Only kernel-space has a
>> problem.
>>
>=20
> Both are affected.
>=20
> Could you help me with what issues
> 97323b3287b5ee8cad99a7fa67cd050bc51f76c4 should fix?

Ah, restart after RT-signals! So far we blocked on the concluding
rt_mutex_lock without breaking out to user space, now we have to loop
over -EINTR to allow signals, right?

Jan


--------------enigA07C0A67C7C9DB64A04AB15B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMJ5cACgkQitSsb3rl5xTbQgCgkZ9HfnWRiPx+2yRISZp/Viya
XqYAn0zch0bGW3zlQMfMF3PkT7fsW4YF
=8bs1
-----END PGP SIGNATURE-----

--------------enigA07C0A67C7C9DB64A04AB15B--

