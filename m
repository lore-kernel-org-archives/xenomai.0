Message-ID: <45E5357B.4090107@domain.hid>
Date: Wed, 28 Feb 2007 08:55:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] warnings and tangled threads.
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
In-Reply-To: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7680933281006ED056B4FB73"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7680933281006ED056B4FB73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> Ok I have CAN functionality of some form running in my tasks.
> Initializing seems to be successful and I have written some kind of
> wrapper to create a can_write() function of my own which also seems to
> be -kind of-  working. I have one question and one problem.
>=20
> I keep on getting this compile warning
>=20
> In file included from /mnt/appusb/xenomai/include/rtdm/rtcan.h:250,
>                 from cancom.cpp:15:
> /mnt/appusb/xenomai/include/rtdm/rtdm.h: In function `ssize_t
> rt_dev_sendto(int, const void*, size_t, int, const sockaddr*,
> socklen_t)':
> /mnt/appusb/xenomai/include/rtdm/rtdm.h:323: warning: missing
> initializer for member `msghdr::msg_flags'
>=20
> Its in rtdm.h so I have not looked closely at it yet but I presume I
> must be doing something wrong to be getting it?

That seems to be due to non-default -Wmissing-field-initializers, right?
Will have a look if we can quiet gcc.

>=20
> The problem I have is that I test my code by running rtcanrecv on
> rtcan0 while my application also sends on rtcan0.
>=20
> What happens is that one of the two real-time tasks does not start up.
> If I am lucky the one (task1) calling can_write() starts up and then
> the messages come through to rtcanrecv. Great. But if I am less lucky
> then task 2 runs happily and task1  does nothing. Nothing is received
> on rtcanrecv.
>=20
> If rtcanrecv is not running then my application has no problems. I can
> see that it is writing by reading out /proc/rtcan/rtcan0/info looking
> at TxCount.
>=20
> I call can_write() directly after rt_task_wait_period so i did not
> think it necessary to use rt_task_shadow or such like in it.

rt_task_shadow() is required if you call blocking services like
rt_task_wait_period from a task AND you didn't create it via some other
native service (rt_task_spawn or rt_task_create/start).

> Can_write is implemented in a separate .cpp file to the one in which
> it is called. Can this cause memory faults? Must I use mlockall in
> can_write() or something?

mlockall is needed once for a _process_, not per thread (or rt_task).

If the problem persists even with clean rt_task setup (rt_task_shadow
etc.), I guess it's best you post your code.

Jan


--------------enig7680933281006ED056B4FB73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5TV7niDOoMHTA+kRArKeAJ0VOqxwWY1JrHnUxUk3dv28ddF/LQCeKSix
JRXHHWphx7UDavlVsPqhFn0=
=RxZS
-----END PGP SIGNATURE-----

--------------enig7680933281006ED056B4FB73--

