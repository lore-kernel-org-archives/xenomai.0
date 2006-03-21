Message-ID: <442018FE.3020906@domain.hid>
Date: Tue, 21 Mar 2006 16:17:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up - SOLVED
References: 00603201434.15258@domain.hid> <200603201434.15258@domain.hid>
	<441ED657.1080405@domain.hid> <200603201901.3123@domain.hid>
	<441F3476.1080003@domain.hid> <200603211503.22918@domain.hid>
In-Reply-To: <200603211503.22918@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F844B36A00D352123012A11"
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F844B36A00D352123012A11
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> The problem was in my calling "RT" task. I forgot to switch the new
> created task to PRIMARY MODE, because I didn't know it's neccessary.

As Philippe said, it isn't usually required - with exceptions. Let me
first sketch the standard situation: You registered a read_rt handler
with your device, but no read_nrt. If your application now calls
rt_dev_read (or just read() for the POSIX skin) from the "wrong"
context, RTDM will detect the missing _nrt handler and trigger an
automatic switch to primary mode (and vice versa). So, no need for
manual switching in the standard case.

But if you had registered handlers for both contexts, RTDM will always
invoke the one for your current mode. This means your _nrt handler must
handle this mode correctly! This "sticky" behaviour was invented to
allow providing services both with and without strict determinism. RT
handler may allocate required resources from pre-allocated but limited
pools, NRT handlers are free to use Linux services for this. This is
used in practice e.g. by the 16550A driver or RTnet.

It may appear a bit tricky for IOCTL handlers to implement this scheme,
as the actual service demultiplexing happens inside the handler, and
there might be some IOCTLs exclusively for RT and some only for NRT. In
this case, just reject wrong context invocations by returning -ENOSYS.
RTDM will then re-invoke the service after toggling the context. See the
IOCTL handling of the timerbench driver as example.

> I still have same problems with porting the driver, but I think I can
> handle them myself.
> Thanks for your help.
> Petr Cervenka
>=20

Jan


--------------enig0F844B36A00D352123012A11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIBj/niDOoMHTA+kRAksHAJwN2pgYhX3CwTJm612n46Tds0AvkACdEMUS
lA47di0ik9jFexAy8QrA+YY=
=xPZK
-----END PGP SIGNATURE-----

--------------enig0F844B36A00D352123012A11--

