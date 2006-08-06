Message-ID: <44D635AD.3050605@domain.hid>
Date: Sun, 06 Aug 2006 20:32:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for
	CAN	devices
References: <44CF6EB1.1010808@domain.hid>
	<44D36389.3030706@domain.hid>	<44D4A0E4.5070703@domain.hid>
	<44D4CAE9.9000800@domain.hid>	<44D4E38D.9060007@domain.hid>
	<44D4FF53.8000904@domain.hid>
In-Reply-To: <44D4FF53.8000904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3BFFBF2DBD09B2CAA6EEE5D"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3BFFBF2DBD09B2CAA6EEE5D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> PS: Another point for the long-term to-do list :-> : The nested locking=

> and the global scope of certain locks. It's safe, it's harmless for
> current primary target platforms (UP), but it's not really beautiful
> when considering SMP setups. A bit tricky, for sure.
>=20

I put Sebastian in the CC. Maybe he sees issues I may ignore in the
following.

Here is some first idea on a new locking scheme. It reduces the number
of locks by one and turns them either into per-device or per-socket in
the end:


rtcan_socket.lock
----------------------
Protects:
 - concurrent read access to socket FIFO
 - /maybe/ also timeouts (but I think the user should better take care
   to not set a timeout and make use of it at the same time - not that
   hard to achieve in practice...)

This means that we need lock-less FIFOs wrt/ reader/writer
synchronisation. Some pattern like RTnet's rtskb_fifo e.g.


rtcan_device.lock
------------------------
Protects:
 - hardware access of related CAN port
 - device reception list

So we only take a single lock in the IRQ handler (+eventually the nklock
when waking someone up). But it requires that a socket, or more
precisely its FIFO is exclusively assigned to a single device.

And this raises the question how to deal with ifindex=3D0, i.e. attaching=

a socket to all devices. Given that in this case the socket may run into
troubles anyway due to the fixed FIFO size, I would say that we better
create multiple FIFOs here (or additional rtcan_socket structures), one
per device of interest. The wakeup would then need some indirection in
order to use a common rtdm_event for all FIFOs of a socket.

Ok, this may complicate things, so we could do this in several steps:

1. Decouple FIFO reader from writer protection. A *global* device lock
   protects the writers + the reception lists, a socket recv_lock the
   read access. Make FIFOs lock-less wrt/ reader/writer concurrency.
2. Make the ifindex=3D0 support optional, fall back to global locking if
   it's on. If it's off (should be default), use per-device locking
   (again) as we then have exclusive assignments of sockets to a single
   device.
3. Create multiple FIFOs if ifindex is 0, always use per-device locks.
   As we already have the all-devices-support configurable at that time,
   we could let the user decide if the additional code for this mode
   should get compiled in or not.

Once this is implemented, the whole pattern could nicely be reused for
RTnet. I have in mind to shorten the reception path in the future and
make it more SMP friendly. So I'm with you here to gain experience! :)

Jan


--------------enigE3BFFBF2DBD09B2CAA6EEE5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE1jWtniDOoMHTA+kRAqLQAJsERjHN54OeuwZ3TlcnAlVpnSHjPACfXWjJ
5wmh7incRrJIab3GSstS/eM=
=uUE9
-----END PGP SIGNATURE-----

--------------enigE3BFFBF2DBD09B2CAA6EEE5D--

