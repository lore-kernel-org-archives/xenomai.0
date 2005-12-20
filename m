Message-ID: <43A7B687.2030807@domain.hid>
Date: Tue, 20 Dec 2005 08:45:11 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt Shied (II)
References: <38197.128.93.15.41.1135063005.squirrel@domain.hid>
In-Reply-To: <38197.128.93.15.41.1135063005.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB26C1F00D2088F602463E268"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori <smannori@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, wjasper@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB26C1F00D2088F602463E268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

smannori wrote:
> ...
> Now the problems:
> 
> 1) If I push the sample rate above 50 S/s the progam starts, but, after a
> while, the real time square wave disappear. Also the "SquareWave" task
> disappear from /proc/xenomai/sched.

Any segfaults? Take a look at /proc/xenomai/faults (if I remember this
entry name correctly now).

> 
> 2) it is not a problem of interaction with the NON realtime square wave
> because the same behavior remain if I remove the code
> 
> 3) I tried the same program on the PPC achitecture using a PowerBook with
> similar results.
> 
> Where is the catch ? I missed something around the interrupt shield ?
> 
> I need to develop real-time application using USB devices because we need
> something usable with a laptop. Unfortunately USB is NOT supported for real
> time applications and I'm not competent enough to write my real time USB
> driver.
> My hope is that the interrupt shield of Xenomai will save my day :)
> 

It may improve the number of deadline misses, but it will not make them
disappear. The standard Linux stack may do things in your back while you
do some data acquisition, and you cannot control this. Moreover, you can
suffer from low buffers when trying to issue some request to the stack,
and this is also something you cannot influence as the buffers are taken
from global pools.

I'm hopefull that we (well, it's going to be outsourced: a student) will
be able to revise the existing USB4RT stack (=>RTDM port), derive or
define an interface for high-layer drivers like your USB DAQ requires,
and then someone could port things over... :) Actually, USB becomes more
and more important for hard-RT. One just have to think of all those
<X>2USB devices (replace <X> with RS232, CAN, etc.) for boxes with
otherwise limited extensibility.

Jan

--------------enigB26C1F00D2088F602463E268
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDp7aHncNeS9Q0k+IRAuGtAKCxrc3cnP+JmhOZFdbCPD/qng4vkgCgsuZY
wzdQw0JvDk+vjf6oh5/70yU=
=OJcA
-----END PGP SIGNATURE-----

--------------enigB26C1F00D2088F602463E268--

