Message-ID: <43EB87B5.4060209@domain.hid>
Date: Thu, 09 Feb 2006 19:19:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Isolated CPU, SMI problems an thoughts
References: <43EB80BC.1060403@domain.hid>
In-Reply-To: <43EB80BC.1060403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig644A5ACFAECBFACA71A92631"
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
To: John Schipper <jschipper@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig644A5ACFAECBFACA71A92631
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

John Schipper wrote:
> Hello,
> I'm new to this list but have in the past used RTAI in a single
> processor off the shelf solution. I'm looking to switch to native
> Xenomai api but have a general problem...
>  The problem is SMI on new systems, and other latency killers that

What do you mean with "other" precisely?

> sometimes are not controllable by software always popping up when tryin=
g
> to migrate to a newer platform.  Can a dual core processor using
> isolcpus, preemp-rt and xenomai effectively future proof agains smi/chi=
p
> set issues (specificly AMD or Intel dual core solutions) by isolating a=

> cpu for exclusively xenomai/realtime use?

SMI can only be addressed with CPU isolation if you are able to redirect
the related event only to one CPU. Don't know if this is possible / defau=
lt.

There are tricks to disable SMI on modern Intel chipsets. Xenomai
implements this, you can select the workaround during system
configuration. Don't this work for your particular systems? Then please
report details.

"Other", more subtle latency issues can only be addressed when the
mechanisms behind them are understood. Depends on the chipset
manufacturer's documentation. So, no general answer is possible.

>=20
> Some background information:  The realtime software I've developed in
> the past (with RTAI/adeos in user space) is a simple high speed
> serializer driver (mmap) to communicate with outside hardware and is
> responsible for syncronizing (with a semaphore/mutex) a linux process
> (soft realtime) at ~60Hz.  The realtime process is periodic at 1.2Khz o=
r
> 2.4Khz and calculates/filters the data before sending commands back dow=
n
> the serializer interface and to the linux process for soft realtime
> network access.
>=20
>  Generally we like to use "off the shelf" business PC's (Dell 170's and=

> Dell 270's, HP 5000 with 1Gig memory) and find that 20-30us latency is
> achievable.  We use "off the shelf" hardware because availability
> (recieve within a week) and low cost are desired.   Whenever looking fo=
r
> an alernative solution either availablity or cost becomes a show
> stopper.  I'm open to suggestions and invite anyones thoughts on the
> subject.

Using off the shelf standard systems is always risky. I've heard of a
larger German automation company ordering standard PC hardware for
industrial control purposes only when initial latency tests on a
specific charge were successful. Ok, they are ordering large enough
quantities, so they can dictate certain conditions...

Jan


--------------enig644A5ACFAECBFACA71A92631
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD64e2niDOoMHTA+kRAilxAJ0fCmI0Tpk+PCQXysennq+GaNShXwCfREWU
VmKk4zv+ZHgad64ABmBvJaw=
=9V4r
-----END PGP SIGNATURE-----

--------------enig644A5ACFAECBFACA71A92631--

