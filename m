Message-ID: <48BD13F1.2010300@domain.hid>
Date: Tue, 02 Sep 2008 12:22:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ff1d78710809020250g57e6d871kf9284a46ae4685ec@domain.hid>
In-Reply-To: <ff1d78710809020250g57e6d871kf9284a46ae4685ec@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig907CA5DFBA988A57CD0BDEB9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel Oops calling rt_dev_close
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig907CA5DFBA988A57CD0BDEB9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Kauffmann wrote:
> Hi all,
>=20
> I'm getting Kernel oops when calling rt_dev_close in my application
> [*]. The application creates a new real-time task and in this task
> rt_dev_recvfrom is waiting for incoming CAN messages.
>=20
> In the close function of the application I first call rt_dev_close and
> after that I kill the thread with rt_task_delete. I also wait for the
> termination of this thread with rt_task_join. But when rt_dev_close is
> called, the kernel oops occurs.

Do you have a (small) test case for this issue? Does it work with a
virtual CAN device as well? That would be the fastest way to track down
the issue.

Otherwise, some disassembly of drivers/xenomai/can/rtcan_socket.o would
be nice (objdump -drS). Also, enabling CONFIG_IPIPE_TRACE_PANIC would
enrich the backtrace with some longer function call history. But, again,
local reproducibility would be best.

Jan


--------------enig907CA5DFBA988A57CD0BDEB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki9E/UACgkQniDOoMHTA+mDpACfZbCT59u5SMl/Tpk9hKoRf9n+
ehcAn1953ObyOgEgxDX/opt0kl0qBYJ7
=yjmz
-----END PGP SIGNATURE-----

--------------enig907CA5DFBA988A57CD0BDEB9--

