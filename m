Message-ID: <44699D5A.9070806@domain.hid>
Date: Tue, 16 May 2006 11:37:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RTDM] best strategy for periodic reading
References: <e4c3bv$829$1@domain.hid>
In-Reply-To: <e4c3bv$829$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5E898FDC0AB5C3598A89849F"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E898FDC0AB5C3598A89849F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Jackel wrote:
> Hello,
> I'm writing a driver for a A/D converter with a multiplexer. I want to
> access it with software controlled conversion. The controller has 15
> Inputs. I've to set a few Bits to select the Channel that I want to rea=
d
> from and to start the conversion. I want to access different channel
> with a different frequency. At the moment I try to do this with
> different realtime-tasks started from the "read_rt" function
> (rtdm_task_init).
> Is this the best way or is there something more elegant?
>=20

What is the usage model of your driver? Is there an application thread
associated to each frequency or even each channel? Or is there a single
reader which gets woken up once some channel finishes the conversion? Or
does the application requests a bulk of samples from multiple channels?

Depending on that usage model, an alternative way to implement your
driver is to let the application generate the conversion clock, i.e. let
it poll the data (maybe just blocking on the conversion completion).

On the other hand, if the acquisition job currently performed in
rtdm_tasks is rather light-weight, maybe timers would help you to reduce
the overhead involved in multiple threads reading from the same device
(including locking etc.). Unfortunately, an RTDM interface for direct
timer usage has not yet been fully specified. Some preliminary patch
hangs around on my box for quite a few months now. Do you see advantages
for your scenario when using timers, i.e. executing the periodic jobs
directly in the context of the timer IRQ handler? If yes, I could try to
accelerate the finalisation of this patch.

Jan


--------------enig5E898FDC0AB5C3598A89849F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaZ1eniDOoMHTA+kRAsLBAJsEh07tx5WdExOB9SVY30/oat2abQCeOv+3
f2NsCnMk3qh3FSbC3RAOXo0=
=z51L
-----END PGP SIGNATURE-----

--------------enig5E898FDC0AB5C3598A89849F--

