Message-ID: <4691F2A2.9090605@domain.hid>
Date: Mon, 09 Jul 2007 10:32:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0707090105m2ee4cc2fvbf70b60a71cb4d88@domain.hid>
In-Reply-To: <7289437c0707090105m2ee4cc2fvbf70b60a71cb4d88@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F59EEF250E83580BD95908A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM : invocation of _rt or _nrt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F59EEF250E83580BD95908A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> Currently, I'm writing some drivers with RTDM and I ask me a few questi=
ons.
> If I have two different functions associated to open_rt and open_nrt fo=
r
> instance, how can I call one or the other ?
> I tried and when I call rt_dev_open, it takes the open_nrt by default (=
it
> seems).

The _rt-variants of RTDM handlers are taken if the caller runs in
primary mode, i.e. over a Xenomai thread and without previously
switching to Linux for some syscall.

Generally, you don't need to worry about _rt handlers for
open/socket/close. Most initialisation and cleanup work requires Linux
context anyway. Thus, providing only a _nrt handler is the right thing
to do. Moreover, I'm considering to remove open_rt/socket_rt/close_rt
for one of the next RTDM revisions to simplify things and to avoid
confusion like this. So if you see a real need for device
opening/closing in hard RT context, speak up loudly soon. :)

Things are different, e.g., when looking at ioctl_rt/nrt. There is a
fair amount of reasonable use cases where you need handlers for both
context to address different caller contexts with different code (e.g.
to fail via -ENOSYS if the other context is required and let Xenomai
then switch the caller over to the right context automatically).

Hope that clarified things. If not, don't hesitate to ask again.

Jan


--------------enig3F59EEF250E83580BD95908A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkfKlniDOoMHTA+kRAmjmAJ0QcrYTpMtaXJ7ikTSsIoiYCYC/4QCeOsbg
AKmHimCTp3G6ewaeHVCYLp8=
=HJ1c
-----END PGP SIGNATURE-----

--------------enig3F59EEF250E83580BD95908A--

