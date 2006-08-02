Message-ID: <44D09177.8080001@domain.hid>
Date: Wed, 02 Aug 2006 13:50:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Reading Memory Mapped IO
References: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
In-Reply-To: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B7DE66FFA98ED93229EA550"
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
To: "Doyle, Alan" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B7DE66FFA98ED93229EA550
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Doyle, Alan wrote:
> Hi,
>=20
> I have an application where I need to read four contiguous memory mappe=
d
> data registers in response to an interrupt. As its real time critical I=

> intend to implement the read in Xenomai. Having read and processed the
> data it later needs to be passed to a Linux domain application, I am
> hoping to use a Posix message queue for this purpose.
>=20
> I seem to have two options as to how to implement this, I could registe=
r
> the interrupt in a Xenomai user space thread and mmap the data register=
s
> so that on receiving the interrupt the registers could be read.
> Alternatively I could write a Xenomai RTDM driver to read the registers=

> on interrupt and use the driver read call from the Xenomai user space
> thread to access register data. In each case the data would then be
> passed to the Linux domain via a message to a Posix queue - after some
> further processing that is not real time critical.
>=20
> Could you enlighten me as to the pros and cons of each approach, I am
> particularly unclear as to the implications of using mmap in the Xenoma=
i
> domain and what if any affect it might have on the real time
> responsiveness (I understand mmap() to be a call back into the Linux
> kernel rather than to the Xenomai nucleus).

To call mmap from real-time code is actually a generic issue. If you
look at the design of other time-critical, though not hard-RT drivers
like video4linux, they also try to avoid mmap'ing on demand. Instead one
should set up mappings ahead-of-time during device initialisation. Use
rings of premapped buffers that cycle between the driver and the
application.

Unless you have really specific requirements, going the RTDM path has
the advantage of introducing a clear abstraction between the hardware
accessing driver and some application. If you happen to reuse your
hardware for a different project later, you will then be able to reuse
the driver as well.

Your application could become a multi-threaded Xenomai program: one
thread accessing the RTDM device under strict time constraints and
pushing information into the message queue, some other thread(s)
(SCHED_OTHER, but mapped to Xenomai) reading the queue under primary
mode and handling the data under secondary mode like a normal Linux
thread. If you can isolate all time critical work in the driver, you may
even access the device directly from the second thread, making the first
one obsolete.

Jan


--------------enig5B7DE66FFA98ED93229EA550
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0JF3niDOoMHTA+kRApQ+AJ46bI6WZRYxQUIr14We40edryI5/wCfRmAV
WWyp/dtyed1E8ExSweZjYTQ=
=to6v
-----END PGP SIGNATURE-----

--------------enig5B7DE66FFA98ED93229EA550--

