Message-ID: <4ACE34FD.9090408@domain.hid>
Date: Thu, 08 Oct 2009 20:52:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>	
	<4ACCD2A0.8050804@domain.hid>
	<abbab2d60910071418g24c9f604nd1945bbda1f773e3@domain.hid>
In-Reply-To: <abbab2d60910071418g24c9f604nd1945bbda1f773e3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE785CA8CC490DBB8B687642"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] XUM 2009 follow-up : Powerlink,
	CANopen and sockets.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Edouard TISSERANT <edouard.tisserant@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE785CA8CC490DBB8B687642
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[restoring CC]

Edouard TISSERANT wrote:
>> [...] And I hope
>> we will find the required resources/contributor to welcome a cleaned u=
p
>> RTnet stack inside the Xenomai 3 source tree one day.
>=20
> Could you detail that point ?  What is to be changed in RTnet to fit
> with Xenomai 3 ?

No ground shaking changes. I would just like to take the chance and drop
legacy kernel 2.4 support and set a sufficiently high baseline in 2.6
(just like Xenomai 3 will do), clean up the code from some dead
fragments, lindent everything properly, switch to a config interface
that uses socket ioctls instead of /dev/rtnet and go through the locking
once again, specifically checking if it might be done simpler or more
efficiently in some cases. Also drivers should undergo this process (and
not all need to be ported over).

>=20
>>> Would it be theoretically
>>> possible for RTnet to support Linux ethernet drivers through a hook
>>> mechanism as mentioned in previous paragraph ?
>> Everything is possible :), but it's hard to assess the feasibility bas=
ed
>> on this vague description. Just note that RTnet drivers also require
>> some "hook" for deterministic buffer management, ie. they must not
>> blindly allocate buffers for incoming frames from shared Linux pools.
>=20
> Of course there is no magic bullet to change an ethernet driver into a
> real-time one, a porting effort will always be required. Nevertheless,
> you could reduce this effort considerably and let most maintenance
> effort to linux' maintainer of each driver. Let me explain...
> While porting CAN driver to Xenomai I asked myself why there was no
> "linux skin". Don't laugh. That skin would have been similar to RTDM
> in purpose and would be have implemented a subset of linux interface
> for fops, tasks, queues,locks, etc. That skin would require some
> compiler, linker or loader magic to replace calls or re-bind symbols
> initially used by module to some RT replacement. A fine grained
> per-driver or per-subsystem symbol overloading approach could be also
> envisioned.
> Applying this to Ethernet drivers so that they become RTnet driver
> looks like possible, but bringing up such a pipe dream may require
> more effort that porting each driver individually. Your opinion ?

What makes things complicated are the unavoidable semantical differences
in the _use_ of whatever API. Specifically as long as there is no
PREEMPT-RT or, even better, mainline user with such requirements, it
will remain hard to maintain the required diffs.

>> It would be great to start this endeavor with implementing the Powerli=
nk
>> MAC protocol inside RTnet. Just one question arises to me: How would t=
he
>> programming model look like? PF_PACKET via sockets? Or some special
>> protocol, PF_POWERLINK?
>=20
> If we keep CANopen as a userspace library, PF_PACKET should be enough.
> Application may have to open multiple sockets in order to distinguish
> packets sent in Isochronous phase (poll requests and responses) and
> those sent in Asynchronous phase. MAC discipline would guess what to

"guess" - that sounds scary in the context of RT... :)

> do with packets according to specified MAC addresses. In my sense a
> packet interface is what best fit as a CANopen library back-end.

So Powerlink simply uses a few Ethernet frame types, and we would simply
pass them to/from user space via PF_SOCKET? If that fits, it would be nic=
e.

>=20
>> When thinking further: If you move the node's object dictionary into
>> user space, you will also have to design a local interprocess
>> communication interface so that multiple processes can access it, righ=
t?
> This is perfectly true, and the only workaround is to have a special
> PF_POWERLINK or protocol, or even better,  PF_CANOPEN (for re-use in
> SocketCan). Problem is that I still don't see clearly how to implement
> CANopen through socket paradigm in a simple and efficient way.
> If the whole CANopen stack with object dictionary reside in kernel
> space it is not conceivable anymore to have a static dictionary
> implemented through generated C code. Would process(es) have to
> declare their own CANopen nodes and OD entries through socket API
> (with bind() and listen() ?). Or maybe could nodes and dictionary be
> constructed with network interfaces administration tools ?
> In the end I'm not sure at all that socket would be the right
> interface for object dictionary entries.... A virtual file system with
> mmap() and select() would certainly fit better.

Well, let's start small, maybe even only with single-process support
(ie. stuffing all the CANopen and high-level Powerlink stack into some
library). We can still evolve the approach once more demanding use cases
pop up, specifically as long as no special ABIs are set in stone.

Jan


--------------enigDE785CA8CC490DBB8B687642
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrONP0ACgkQitSsb3rl5xSF9ACcDWFX3crTLzZRAjtsgf4wlMfc
zRcAoNRVWEnH1lo84Yaw1E3RyYWdsjFl
=aM0l
-----END PGP SIGNATURE-----

--------------enigDE785CA8CC490DBB8B687642--

