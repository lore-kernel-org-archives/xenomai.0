Message-ID: <4ACCD2A0.8050804@domain.hid>
Date: Wed, 07 Oct 2009 19:40:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>
In-Reply-To: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91FB6A0B8291C1453AE2802A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] XUM 2009 follow-up : Powerlink,
	CANopen and sockets.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edouard TISSERANT <edouard.tisserant@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91FB6A0B8291C1453AE2802A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Edouard,

Edouard TISSERANT wrote:
> Dear hackers,
>=20
> I've been passing last month seeking for the best way to implement
> Powerlink with Xenomai. I still didn't find the absolute truth, and
> would like to confront my point of view.
>=20
> In short, Powerlink is a kind of CANopen over polled ethernet.
> Powerlink re-use a subset of CANopen concepts for high level
> communications, whereas on the low level, a single master cyclically
> poll each node for data. As you can imagine, communication cycle is
> seriously influenced by each controlled node latency answering poll
> requests from master.
>=20
> My intention is to write an efficient Powerlink implementation for
> Xenomai, but suitable for later reuse in future Real Time Linux
> implementation such as RT-PREEMPT. Discussing with RT-PREEMT gurus, I
> understood that re-using native Linux queues could never be a
> solution, as those queues induce way too long and unpredictable
> latencies for such real-time ethernet (those latencies also apply for
> SocketCan). Some software hook at ethernet driver level will be
> necessary to reroute RT-related packets directly to the concerned RT
> stack. With this approach, the whole stack would have to stay kernel
> side to reduce latency in answering poll requests. Implementing the
> whole CANopen stack kernel side is generally a bad idea, as it
> complicate access to object dictionary from application, usually in
> user space.
>=20
> RTnet proves that Real-Time ethernet can be implemented through the
> socket paradigm. I believe that Time Division Medium Access (TDMA) of
> RTnet could be interchanged with polled ethernet medium access
> discipline from Powerlink. Thus, CANopen implementation part could
> stay user side, and could pre-fill answers to poll requests, avoiding
> long latencies. But what is the future of RTnet ? Will it be ported to
> RT-PREEMPT or will it enter official Xenomai tree ?

RTnet is expected to gain PREEMPT-RT support via Xenomai 3 (porting it
to "native" PREEMPT-RT, thus creating a branch from its current
RTDM-based version would let the maintenance effort explode). And I hope
we will find the required resources/contributor to welcome a cleaned up
RTnet stack inside the Xenomai 3 source tree one day.

> Will available
> RTnet's drivers set continue to grow ?

Yes, as users keep contributing. It makes no sense to port blindly, we
always have to focus on chips that are in use, provide test
environments, simply have a non-zero user base.

> Would it be theoretically
> possible for RTnet to support Linux ethernet drivers through a hook
> mechanism as mentioned in previous paragraph ?

Everything is possible :), but it's hard to assess the feasibility based
on this vague description. Just note that RTnet drivers also require
some "hook" for deterministic buffer management, ie. they must not
blindly allocate buffers for incoming frames from shared Linux pools.

>=20
> My feeling is that, yes, we should try to fit implementation of
> Powerlink data link layer inside RTnet as another MAC discipline, and
> use a modified version of CanFestival for CANopen aspects, keeping it
> a user space library. Please comment.

It would be great to start this endeavor with implementing the Powerlink
MAC protocol inside RTnet. Just one question arises to me: How would the
programming model look like? PF_PACKET via sockets? Or some special
protocol, PF_POWERLINK?

When thinking further: If you move the node's object dictionary into
user space, you will also have to design a local interprocess
communication interface so that multiple processes can access it, right?

Jan


--------------enig91FB6A0B8291C1453AE2802A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrM0qQACgkQitSsb3rl5xSjmQCgk3IAgyp+4x7eBT+w2Y/Gdc6z
qtcAoLAC0lSZqJqFxKjbdrv44GaY+EY9
=AMfL
-----END PGP SIGNATURE-----

--------------enig91FB6A0B8291C1453AE2802A--

