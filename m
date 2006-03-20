Message-ID: <441ED4C7.5030009@domain.hid>
Date: Mon, 20 Mar 2006 17:13:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: <200603201434.15258@domain.hid> <441EB558.9040408@domain.hid>
	<441EBBE7.6060605@domain.hid> <441EC28F.20004@domain.hid>
	<441EC9DB.7090907@domain.hid>
In-Reply-To: <441EC9DB.7090907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8BD25B9E4A2C2AEF9FEEE1B0"
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
--------------enig8BD25B9E4A2C2AEF9FEEE1B0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Petr Cervenka wrote:
>>>>
>>>>
>>>>> Hello,
>>>>> I'm trying to port a  driver of a AD card to RTDM.
>>>>> When I use rtdm_event_timedwait in IOCTL handler (called from NRT
>>>>> user app), the system will hang-up immediately.
>>>>> Does it have something to do with:
>>>>> https://mail.gna.org/public/xenomai-help/2006-03/msg00035.html
>>>>> , ie. it's not possible to call wait /caller blocking functions fro=
m
>>>>> non-real-time, is it?
>>>>
>>>>
>>>> Yep, that's exactly the point, it's an illegal usage.
>>>>
>>>> And the fact that this still causes a crash instead of some more
>>>> graceful failure reminds me of one reason why I asked for the new
>>>> XENO_ASSERT macro: adding debug checks for such mistakes to RTDM.
>>>>
>>>
>>> It would be nice to have all potentially blocking syscalls actively
>>> checking for invalid call context, so that we always get graceful
>>> returns. At least, I'm in the process of adding the missing checks to=

>>> the traditional RTOS skins which I'm extending with a native syscall
>>> interface. The good news is that it's basically a matter of grepping
>>> xnsynch_sleep_on() in the codebase.
>>>
>>> --- skins/rtdm/drvlib.c    (revision 765)
>>> +++ skins/rtdm/drvlib.c    (working copy)
>>> @@ -648,6 +648,11 @@
>>>     else if (!__test_and_clear_bit(0, &event->pending)) {
>>>         xnthread_t  *thread =3D xnpod_current_thread();
>>>
>>> +    if (xnpod_unblockable_p()) {
>>> +        err =3D -EPERM;
>>> +        goto unlock_and_exit;
>>> +    }
>>> +
>>>         xnsynch_sleep_on(&event->synch_base, XN_INFINITE);
>>>
>>>         if (!xnthread_test_flags(thread, XNRMID|XNBREAK))
>>> @@ -658,6 +663,7 @@
>>>             err =3D -EINTR;
>>>     }
>>>
>>> + unlock_and_exit:
>>>     xnlock_put_irqrestore(&nklock, s);
>>>
>>>     return err;
>>
>>
>> Agree, but I prefer to be able to switch those checks off when the use=
d
>> drivers have been verified for correctness.
>>
>> Actually, this check is up to them: when some service is invoked from
>> the "wrong" context, the driver can return -ENOSYS to let Xenomai swit=
ch
>> to the right one. It can also return some other error to the user
>> instead. Or it can block certain contexts by not registering related
>> service handlers.
>=20
> I agree; there are some RTDM specific issues, especially the adaptive
> calls.
>=20
>>
>> As the user never invokes RTDM services directly, I see no need for
>> permanent checks. The Linux kernel does such checking also on demand,
>> not by default.
>>
>=20
> Yes, but the kernel usually don't go south when a user-level app does a=

> mistake. We currently do.

Regarding RTDM, we only do this when the driver fails on its job, and
that's "normal" for all monolithic kernels.

OK, I will prepare the checks based on XENO_ASSERT. To make sure I pick
the right expressions:

!xnpod_unblockable_p():
- allows blockable RT-context (kernel and user threads)
- rejects user threads in secondary mode
- rejects Linux threads

xnpod_root_p():
- allows Linux threads (kerne and user)
- allows threads in secondary mode
- rejects the rest

Right?

Jan


--------------enig8BD25B9E4A2C2AEF9FEEE1B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHtTHniDOoMHTA+kRAsBrAJ48/4+ycGCX/cEUPAa60ZFssBWiEwCdF13O
1KkX0KnJxyOlgHLSUSVCKhI=
=7SNt
-----END PGP SIGNATURE-----

--------------enig8BD25B9E4A2C2AEF9FEEE1B0--

