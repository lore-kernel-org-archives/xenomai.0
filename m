Message-ID: <44FFE509.3090009@domain.hid>
Date: Thu, 07 Sep 2006 11:23:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid>
In-Reply-To: <44FF3A22.5060901@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B7AB84D55D9A4AB106604B8"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B7AB84D55D9A4AB106604B8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Here are a couple of questions that I hope someone can answer:
>=20
> It appears that the maximum pipe size that can be created using
> rt_pipe_create() is 16 MB.  Is this correct?  If so, what is the cause
> of this limitation, and are there any work-arounds?  I am using a 128 M=
B
> FIFO in my rtlinux simulation.  Any ideas on how I can port this?

Maybe it's a 2.4-related issue (my 2.4 setup is broken, can't test). On
a 2.6.17 kernel I face no problems allocating far larger rt_pipes.

>=20
> It appears that the maximum size for RT-FIFOs created with the rtai
> skin's rtf_create() is much less than 16 MB.  It's hard to quantify,
> since the errors are given at FIFO write time, and not creation time,
> but it appears to be around 100 kB or so.  Why is this not the same as
> for rt_pipe_create()?  Also, why is the memory allocation not done at
> creation time?  It looks like the memory allocation is done on the firs=
t
> rtf_put() -- which is called from my real-time thread!  I assumed the
> memory allocation would be a non-realtime operation.  (It also appears
> that I am getting some kind of memory leak when the memory allocation
> fails, because I can not allocate as much memory the next time around. =

> I am cleaning up the FIFO with rtf_destroy, so I don't know what I coul=
d
> be doing wrong...)

RTAI FIFO allocate their buffers from the real-time system heap, and
that on is 128 KB by default (see kernel config).

Allocation in Xenomai pipes works differently, i.e. always on some
real-time heap. We stumbled over this as well when applying it the first
time. To get larger pools and decouple them from the system heap, we
introduced separated heaps for rt_pipes afterwards. So, as long as your
usage pattern of a particular rt_pipe is deterministic, you can predict
the success of data transfers.

The potential leak you found needs to be examined. Could you post a
simple test that demonstrate it?

Jan


--------------enig8B7AB84D55D9A4AB106604B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/+UJniDOoMHTA+kRAmX5AJ4nDRUFEsTs0+M8dqwC31Hs8TBoUACfcOQR
xIInnMz3c+LZ87882oBNQMM=
=svjE
-----END PGP SIGNATURE-----

--------------enig8B7AB84D55D9A4AB106604B8--

