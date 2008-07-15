Message-ID: <487BF171.2090902@domain.hid>
Date: Tue, 15 Jul 2008 02:38:09 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
	<487BA305.6040401@domain.hid> <487BB89B.6010604@domain.hid>
In-Reply-To: <487BB89B.6010604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE28EFD87DAC05DC831A91876"
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE28EFD87DAC05DC831A91876
Content-Type: multipart/mixed;
 boundary="------------010407040307020002020408"

This is a multi-part message in MIME format.
--------------010407040307020002020408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

the attached patch fixed the problem for me.
However, i think that in the "break case" still EACCES is returned.
Can the break be replaced with a "return ETIMEDOUT" ?

kisda

Philippe Gerum schrieb:
> Stefan Kisdaroczi wrote:
>> Hi Philippe,
>>
>> Philippe Gerum schrieb:
>>> Stefan Kisdaroczi wrote:
>>>> Hi all,
>>>>
>>>> If I call rt_task_bind() with a timeout value other than TM_NONBLOCK=
 or
>>>> TM_INFINITE
>>>> it works not as expected (by me).
>>>>
>>>> System: Debian Lenny with Xenomai 2.4.3 and Kernel 2.6.24.
>>>>
>>>> The attached example calls 3 times rt_task_bind() for a nonexistent
>>>> task:
>>>>
>>>> 1. dont wait: rt_task_bind(&task,"SomeTaskName",TM_NONBLOCK)
>>>>   -> returns -11 (EWOULDBLOCK) -> OK
>>>>
>>>> 2. wait 5 secs: rt_task_bind(&task,"SomeTaskName",5000000000LL);
>>>>   -> returns immediately -13 (EACCES) without waiting -> ?
>>>>   -> I expected ETIMEDOUT after 5 seconds
>>>>
>>> "SomeTaskName" was found in the registry, but suddenly disappeared
>>> while in the
>>> process of returning its handle (we do post-validation after binding)=
=2E
>>> That task
>>> has probably exited prematurely.
>> There was and is no task with this name. This happens on a freshly
>> rebooted box
>> with any name i choose. Can someone please try my small example from t=
he
>> first
>> mail on his box. Thank you.
>>
>=20
> Can't test right now, unfortunately, and I'll be travelling tomorrow.
>=20
> I suspect some weird issue with xnregistry_bind(). Please make sure to =
disable
> CONFIG_XENO_OPT_NATIVE_REGISTRY, and apply this trivial trace point. Th=
e only
> reason to get EACCES would be to receive a success code from xnregistry=
_bind(),
> which we should not. I'd be interested to know the result codes for eac=
h call
> your snippet does. TIA,
>=20
> --- ksrc/nucleus/registry.c	(revision 4044)
> +++ ksrc/nucleus/registry.c	(working copy)
> @@ -776,6 +776,8 @@
>=20
>  	xnlock_put_irqrestore(&nklock, s);
>=20
> +	printk(KERN_INFO "%s: ret=3D%d\n", __FUNCTION__, err);
> +
>  	return err;
>  }
>=20
>=20
>>>> 3. wait forever: rt_task_bind(&task,"SomeTaskName",TM_INFINITE);
>>>>   -> blocks a expected -> OK
>>>>
>>>> I have the same problem with rt_queue_bind() calls.
>>>>
>>>> Do i expect something wrong?
>>>>
>>>> Thanks for your help!
>>>>
>>>> kisda
>>>>
>>>>
>>>> --------------------------------------------------------------------=
----
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>
>=20
>=20


--------------010407040307020002020408
Content-Type: text/plain;
 name="xenomai-bind-timeout.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xenomai-bind-timeout.patch"

--- xenomai/nucleus/registry.c.old	2008-07-15 00:36:10.000000000 +0200
+++ xenomai/nucleus/registry.c	2008-07-15 01:51:13.000000000 +0200
@@ -733,7 +733,7 @@ int xnregistry_bind(const char *key, xnt
 		if (timeout !=3D XN_INFINITE) {
 			xnticks_t now =3D xntbase_get_time(tbase);
=20
-			if (stime + timeout >=3D now)
+			if (stime + timeout <=3D now)
 				break;
=20
 			timeout -=3D (now - stime);

--------------010407040307020002020408--

--------------enigE28EFD87DAC05DC831A91876
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIe/GDIPTw9rIdn6oRAsezAJ9/3+9f5PJs93GylC3NS6XNm3vpgACggAGH
AB68Q6Y3EI+d5Cb59ugN1Zs=
=dYZw
-----END PGP SIGNATURE-----

--------------enigE28EFD87DAC05DC831A91876--

