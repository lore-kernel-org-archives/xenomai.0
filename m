Message-ID: <4B8C2B3E.8020505@domain.hid>
Date: Mon, 01 Mar 2010 22:01:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid> <4B8C25B9.8090705@domain.hid>
	<4B8C26F7.3020306@domain.hid> <4B8C2797.2000501@domain.hid>
	<4B8C29E1.7070404@domain.hid>
In-Reply-To: <4B8C29E1.7070404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0ABDFEA4BC99F69053FE60F"
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
--------------enigF0ABDFEA4BC99F69053FE60F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Charlton, John wrote:
>>>>>> I added some printk output to the cond.c file in xenomai-2.5.1 and=
 it shows that  xnsync_sleep_on returned -ETIMEDOUT as it should:
>>>>>> Xenomai: registered exported object M1-1908 (mutexes)
>>>>>> Xenomai: registered exported object C1-1908 (condvars)
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -110
>>>>>> xnsynch_sleep_on returned: -4
>>>>>> Xenomai: native: cleaning up cond "C1-1908" (ret=3D0).
>>>>>> Xenomai: unregistered exported object C1-1908 (condvars)
>>>>>> Xenomai: native: cleaning up mutex "M1-1908" (ret=3D0).
>>>>>> Xenomai: unregistered exported object M1-1908 (mutexes)
>>>>>> Xenomai: POSIX: destroyed thread df5a0800
>>>>>>
>>>>>> I put the printk on line cond.c:433 after err is set in rt_cond_wa=
it_prologue():
>>>>>>
>>>>>> 	info =3D xnsynch_sleep_on(&cond->synch_base,
>>>>>> 				timeout, timeout_mode);
>>>>>> 	if (info & XNRMID)
>>>>>> 		err =3D -EIDRM;	/* Condvar deleted while pending. */
>>>>>> 	else if (info & XNTIMEO) {
>>>>>> 		err =3D -ETIMEDOUT;	/* Timeout. */
>>>>>>         }
>>>>>> 	else if (info & XNBREAK) {
>>>>>> 		err =3D -EINTR;	/* Unblocked. */
>>>>>> 	}
>>>>>>         printk(KERN_DEBUG "xnsynch_sleep_on returned: %d\n", err);=

>>>>>>
>>>>>> I put a printk in rt_cond_wait_inner() which is called directly by=
 rt_cond_wait() from user mode but did not see the output in the dmesg ou=
tput for that one.
>>>>> One of our problems is the prologue/epilogue split up (both in kern=
el
>>>>> and user space): the epilogue can eat the error code or the prologu=
e,
>>>>> including the -ETIMEDOUT.
>>>> Ah. My fault. Looks user-space is Ok though. Only kernel-space has a=

>>>> problem.
>>>>
>>> Both are affected.
>>>
>>> Could you help me with what issues
>>> 97323b3287b5ee8cad99a7fa67cd050bc51f76c4 should fix?
>> Ah, restart after RT-signals! So far we blocked on the concluding
>> rt_mutex_lock without breaking out to user space, now we have to loop
>> over -EINTR to allow signals, right?
>=20
> Yes, it is needed even for handling linux signals (getting gdb working =

> for instance). However, since we do not want rt_cond_wait to result int=
o
> two syscalls all the time, we handle everything in the first syscall if=
=20
> possible.
>=20
> Try this:
>=20
> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
> index 40e5cfd..d4e885c 100644
> --- a/ksrc/skins/native/syscall.c
> +++ b/ksrc/skins/native/syscall.c
> @@ -1869,9 +1869,12 @@ static int __rt_cond_wait_prologue(struct pt_reg=
s *regs)
>=20
>         err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_mo=
de, timeout);
>=20
> -       if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT)
> -               err =3D rt_cond_wait_epilogue(mutex, lockcnt);
> -
> +       if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT) {
> +               int loc_err =3D rt_cond_wait_epilogue(mutex, lockcnt);
> +               if (loc_err < 0)
> +                       err =3D loc_err;
> +       }
> +
>         if (err =3D=3D -EINTR && __xn_reg_arg3(regs)
>             && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs=
),
>                                       &lockcnt, sizeof(lockcnt)))
>=20

Same issue exists in user space. And rt_cond_wait_inner needs fixing.
And then there is a spurious sign inversion:

diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c
index 478321d..f874678 100644
--- a/src/skins/native/cond.c
+++ b/src/skins/native/cond.c
@@ -96,9 +96,9 @@ int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, =
RTIME timeout)
 				&saved_lockcnt, XN_REALTIME, &timeout);
=20
 	while (err =3D=3D -EINTR)
-		err =3D -XENOMAI_SKINCALL2(__native_muxid,
-					 __native_cond_wait_epilogue, mutex,
-					 saved_lockcnt);
+		err =3D XENOMAI_SKINCALL2(__native_muxid,
+					__native_cond_wait_epilogue, mutex,
+					saved_lockcnt);
 #endif /* !CONFIG_XENO_FASTSYNCH */
=20
 	return err;

Jan


--------------enigF0ABDFEA4BC99F69053FE60F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMK0EACgkQitSsb3rl5xQMWACfQ8ehKpsLgKq3LpnL+6LSoDV5
bycAn2NzPE09xiB/w3nAsb5py1uIN7Q5
=8v+w
-----END PGP SIGNATURE-----

--------------enigF0ABDFEA4BC99F69053FE60F--

