Message-ID: <450D3A06.3070902@domain.hid>
Date: Sun, 17 Sep 2006 14:05:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] inscrutable pipes
References: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>	<1158250677.5040.199.camel@domain.hid>	<38A01364-EC56-46D9-9768-A14979EA98E5@domain.hid>	<1158326750.5072.2.camel@domain.hid>
	<DE56BFC0-D567-44CE-99A1-869B458AE896@domain.hid>
In-Reply-To: <DE56BFC0-D567-44CE-99A1-869B458AE896@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig216E9FDFEFA8892062954828"
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
To: ckreider <ckreider@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig216E9FDFEFA8892062954828
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ckreider wrote:
> I think I will expand on this because Xenomai coders are on this list.
>=20
> We have two product lines that have been made for several years with
> custom hardware and proprietary RTOS.  We decided to migrate these to
> COTS hardware and Linux.  Conventional wisdom, right?  The other line
> migrated first.  There was pain, but not unbearable.  We used RTLinux
> because we needed something that could sample the A/D card at
> predictable intervals and it was what was available at the time.  I
> recently embarked on the conversion of my line and ran into a big
> problem.  My A/D card controls the timing, so I shouldn't need and
> RTOS.  I have a serial stream of 20 byte packets at 60 hz, but Linux
> should handle that, right?  Well, if I had Mot serial chips that did
> hardware handshake, it would be OK, but COTS hardware has 16550s which
> require and interrupt to drop the handshake line(s).  If Linux it too
> busy to service an interrupt for a full receive fifo, how is it going t=
o
> handle the handshake?  It can't.  So I was dropping bytes every so
> often.  Linux didn't have to mask the interrupt for long, just a fifo
> full at 38400. So it wsa RTOS time.  I picked Xenomai this time
> primarily because of the patent issues, but it has a serial driver
> also.  I am not sorry. Yeah, there was some pain with the pipes, but it=

> is working slick now.  The serial task is only using 0.1% of a
> relatively slow CPU.  I like the status in/proc.=20

Though real numbers will likely not be several orders of magnitude
larger, be careful with that stats: they do not (yet) account for the
IRQ handler load correctly. In fact, some heavy part of the serial job
(reading bytes out of the 16550) runs in IRQ context, and that is
accounted to the task which was preempted - often ROOT, i.e. Linux.

I'm thinking about a more satisfying solution for quite a while, and I
think I found one now. Just needs a bit more refinement and testing, but
the first number are already telling ("latency -p100" on an unloaded
Pentium-M 1.3 GHz):

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          749680     0     01400080   98.0  ROOT
  0  7987   22         46         0     00c00082    0.0  display-7986
  0  7988   0          224356     0     00c00084    1.4  sampling-7986
  0  0      0          26143452   0     00000000    0.6  [IRQ216][timer]

> I like the level of
> support here.  Most of all, I like the quality of Xenomai.  Fantastic
> job all who are involved in Xenomai, and a heartfelt thanks.

In the name of all: We thank you for all the compliments! Though we
certainly don't have the impression users are unhappy with what they
find in Xenomai, hearing it explicitly is always nice.

Jan


--------------enig216E9FDFEFA8892062954828
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFDToGniDOoMHTA+kRAveGAJ9IW217Z9x44w5BRwWo18nFHUm6DQCeP5Ip
RZXTlA2ZDEGicdSw30tO8gA=
=SvOL
-----END PGP SIGNATURE-----

--------------enig216E9FDFEFA8892062954828--

