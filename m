Message-ID: <46B72685.30104@domain.hid>
Date: Mon, 06 Aug 2007 15:47:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BCC5E4E7C20D3C4780433ADBFF20273C07C97B@GBPLESL203AMSX.gb001.siemens.net>
In-Reply-To: <BCC5E4E7C20D3C4780433ADBFF20273C07C97B@GBPLESL203AMSX.gb001.siemens.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39DB32693DCAB52E47DF1C47"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Random crash in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Richardson, Andy" <andy.richardson@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39DB32693DCAB52E47DF1C47
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Richardson, Andy wrote:
> Hi,=20
>  I get an AIEE, but no oops! I have disabled the xenomai RTDM device
> open in my software and the problem goes away. The standard aiee
> complains and "disables interrupt handler". The system then reboots. I
> am using a custom PPC board with version 2.6.14 of Linux and 2.2.4 of
> Xenomai. I don't seem to be able to activate Adeos debugging: I can
> compile the kernel with that option enabled, but the board won't boot
> when using it! Is there an option I can use to output more printk's fro=
m
> Linux when booting?

I guess you mean the I-pipe tracer (CONFIG_IPIPE_DEBUG_CONTEXT was
introduced much later): The tracer may make your board stumble in case
of low memory. Try CONFIG_IPIPE_TRACE_VMALLOC. Still, this alone will
not help to point at the bug.

Let us start with clarifying the scenario a bit more: You have Xenomai
loaded (including RTDM) and working flawlessly (e.g. tested with the
included testsuite)? Then you insert your custom RTDM driver and open it
from some user space application, right? And next you get those crashes.

You may try using Xenomai debugging options, specifically
CONFIG_XENO_OPT_DEBUG_RTDM. /Maybe/ there is some issue hidden in your
RTDM driver (not claiming that RTDM must be bugfree).

Jan


--------------enig39DB32693DCAB52E47DF1C47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGtyaFniDOoMHTA+kRAgCUAJ0Sd8ey3Yk2OC4nqOoAH/+CljZUuACfQSxk
BfI6yKXirG1fI1zx/13Y3Wk=
=UXfj
-----END PGP SIGNATURE-----

--------------enig39DB32693DCAB52E47DF1C47--

