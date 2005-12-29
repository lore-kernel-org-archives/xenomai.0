Message-ID: <43B3FABA.4050903@domain.hid>
Date: Thu, 29 Dec 2005 16:03:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] autostart timer, rt_timer_start/stop
References: <43B3EAFA.2050906@domain.hid>
In-Reply-To: <43B3EAFA.2050906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7839872C66485920C4D55547"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7839872C66485920C4D55547
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Stefan Kisdaroczi wrote:
> Hi,
> 
> cant the timer be started by default ?
> 
> The current state (2.0.1) seems to lead to the following scenario:
> 1) Every app calls rt_timer_start()
> 2) If you call rt_timer_stop you can hurt other rt-apps, so dont
>    call it
> 3) As some apps dont stop the timer, check in 1) if its already running
> 
> I think most apps do not care in which mode the timer is running if it is already,
> and just go on, of course you can stop and restart the timer if its a wrong state,
> but you do not know if you hurt others.
> 
> Now, as i read in the other thread that the periodic timer support isnt configured by default,
> why not start the oneshot timer automatic ?
> 
> Like this, a 'normal' app doesnt need to fiddle with the timer and
> an app that really cares can still call rt_timer_inquire,_stop,_start.
> 

Yea, that's good that someone else brings this topic up again! :) I've
been pointing on this several times, but as we did not come to a
conclusion how to handle the system timer in a consistent way across all
skins, no one (me included...) came up with a fix of this issue so far.

The thing is that most skins start the timer during module init via some
parameter (nowadays also as a kernel boot option for compiled-in skins).
As far as I remember, only the native and the RTAI compat skin do their
own dance - the latter one has to remain compatible, ok, but the former
one should be allowed to perform smarter.

Ok, to be more concrete: autostarting the one-shot time in the absence
of periodic mode is certainly worth considering. For the other cases and
as sysfs is no option on 2.4 kernels, what about adding a /proc-exported
control mechanism for the timer mode (and period) to either the HAL or
the nucleus? Additionally, we could provide some CONFIG_xyz to set the
default mode during compile time.

Ceterum censeo rt_timer_start/stop esse delendam. ;)

Jan

--------------enig7839872C66485920C4D55547
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDs/q6niDOoMHTA+kRAvN1AJ4vLpJUEQZZmSqnyu6xAq7FoMyeXwCfeIAc
2H6PPwD807FK2g/uz/rY55U=
=iTUU
-----END PGP SIGNATURE-----

--------------enig7839872C66485920C4D55547--

