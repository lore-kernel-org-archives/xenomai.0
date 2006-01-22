Message-ID: <43D41364.6000300@domain.hid>
Date: Mon, 23 Jan 2006 00:21:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0601180617v38c990f0w@domain.hid>
In-Reply-To: <b647ffbd0601180617v38c990f0w@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24A761DFEEA0BE6D63F7B769"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] Shared irqs v.5
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24A761DFEEA0BE6D63F7B769
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hello Jan,
>=20
> as I promised earlier today, here is the patch.

I finally had a look at your patch (not yet a try), and it looks really
nice and light-weight. Now I only have two topics on my wish list:

o Handling of edge-triggered IRQs (ISA-cards...). As I tried to explain,
  in this case we have to run the IRQ handler list as long as the full
  list completed without any handler reporting XN_ISR_ENABLE back. Then
  and only then we are safe to not stall the IRQ line. See e.g.
  serial8250_interrupt() in linux/drivers/serial/8250.c for a per-driver
  solution and [1] for some discussion on sharing IRQs (be warned, it's
  from the evil side ;) ).

  On our systems we already have two of those use-cases: the xeno_16550A
  handling up to 4 devices on the same IRQ on an ISA card (I don't want
  to know what worst-case latency can be caused here...) and our
  SJA-1000 CAN driver for PC/104 ISA card with 2 controllers on the same
  interrupt line. So a common solution would reduce the code size and
  potential bug sources.

o Store and display (/proc) the driver name(s) registered on an IRQ line
  somewhere (ipipe?). This is just a nice-to-have. I introduced the RTDM
  API with the required argument in place, would be great if we can use
  this some day.

BTW, making the RTDM API shirq-aware should be as easy as adding some
flags: one for sharing in general and maybe another one for marking
edge-triggered IRQs.

Jan


PS: Still at home? How many degrees Centigrade? I guess our current -9=B0=
C
here in Hannover must appear ridiculous, almost subtropical warm to you. =
;)

[1] http://www.microsoft.com/whdc/system/sysperf/apic.mspx


--------------enig24A761DFEEA0BE6D63F7B769
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1BNkniDOoMHTA+kRAqEWAJ4kkRoQAkmBGDnEePYoICtWmoU6NgCfWXil
oKS+K8bu0CeUOQxi1LNo1OM=
=7nvx
-----END PGP SIGNATURE-----

--------------enig24A761DFEEA0BE6D63F7B769--

