Message-ID: <441EC28F.20004@domain.hid>
Date: Mon, 20 Mar 2006 15:56:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: <200603201434.15258@domain.hid> <441EB558.9040408@domain.hid>
	<441EBBE7.6060605@domain.hid>
In-Reply-To: <441EBBE7.6060605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB80721A73251BD90D8D51CFA"
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
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB80721A73251BD90D8D51CFA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Petr Cervenka wrote:
>>
>>> Hello,
>>> I'm trying to port a  driver of a AD card to RTDM.
>>> When I use rtdm_event_timedwait in IOCTL handler (called from NRT
>>> user app), the system will hang-up immediately.
>>> Does it have something to do with:
>>> https://mail.gna.org/public/xenomai-help/2006-03/msg00035.html
>>> , ie. it's not possible to call wait /caller blocking functions from
>>> non-real-time, is it?
>>
>>
>> Yep, that's exactly the point, it's an illegal usage.
>>
>> And the fact that this still causes a crash instead of some more
>> graceful failure reminds me of one reason why I asked for the new
>> XENO_ASSERT macro: adding debug checks for such mistakes to RTDM.
>>
>=20
> It would be nice to have all potentially blocking syscalls actively
> checking for invalid call context, so that we always get graceful
> returns. At least, I'm in the process of adding the missing checks to
> the traditional RTOS skins which I'm extending with a native syscall
> interface. The good news is that it's basically a matter of grepping
> xnsynch_sleep_on() in the codebase.
>=20
> --- skins/rtdm/drvlib.c    (revision 765)
> +++ skins/rtdm/drvlib.c    (working copy)
> @@ -648,6 +648,11 @@
>      else if (!__test_and_clear_bit(0, &event->pending)) {
>          xnthread_t  *thread =3D xnpod_current_thread();
>=20
> +    if (xnpod_unblockable_p()) {
> +        err =3D -EPERM;
> +        goto unlock_and_exit;
> +    }
> +
>          xnsynch_sleep_on(&event->synch_base, XN_INFINITE);
>=20
>          if (!xnthread_test_flags(thread, XNRMID|XNBREAK))
> @@ -658,6 +663,7 @@
>              err =3D -EINTR;
>      }
>=20
> + unlock_and_exit:
>      xnlock_put_irqrestore(&nklock, s);
>=20
>      return err;

Agree, but I prefer to be able to switch those checks off when the used
drivers have been verified for correctness.

Actually, this check is up to them: when some service is invoked from
the "wrong" context, the driver can return -ENOSYS to let Xenomai switch
to the right one. It can also return some other error to the user
instead. Or it can block certain contexts by not registering related
service handlers.

As the user never invokes RTDM services directly, I see no need for
permanent checks. The Linux kernel does such checking also on demand,
not by default.

Jan


--------------enigB80721A73251BD90D8D51CFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHsKPniDOoMHTA+kRAr0UAJ4/hlBSGExpJvG0uKSvttQu1o+6KQCdHf9h
DDIK5FoZV3VAiDdbm/lJPXs=
=Y8OH
-----END PGP SIGNATURE-----

--------------enigB80721A73251BD90D8D51CFA--

