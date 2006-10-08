Message-ID: <45297772.5080500@domain.hid>
Date: Mon, 09 Oct 2006 00:10:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F75680F860D267E7AAB1B70"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] rtf_put broken due to kernel 2.4 bug
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F75680F860D267E7AAB1B70
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this issue

http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0211.html

was revealed by the rtai fifo code. We currently have the double
__test_and_set_bit combination at least here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtai/fifo.c#=
L309
(resolves to __test_and_set_bit via ipipe_test_and_stall_pipeline_from)
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtai/fifo.c#=
L311

The effect on this code is that multiple rtf_put on an unconnected fifo
corrupts its queue.

I'm now awaiting the comment of the 2.4 maintainer, but we will still
have to cope with this issue on current 2.4 kernels. There is also the
risk that more spots are affected or will be affected in the future
given the embedded use of __test_and_set_bit in pipeline stalling command=
s.

Anyone any smart idea how to handle this? Should we simply include the
bitops patch in 2.4-x86-ipipe?

Jan


--------------enig4F75680F860D267E7AAB1B70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKXdyniDOoMHTA+kRAnTaAJ47T81F5AKlvVqzNyV4+15RPS6L1QCfZPXJ
LX6JDnyhtwyJLC1Y1F/kSKw=
=79J+
-----END PGP SIGNATURE-----

--------------enig4F75680F860D267E7AAB1B70--

