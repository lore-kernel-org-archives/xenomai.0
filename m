Message-ID: <43DFB3EC.7020009@domain.hid>
Date: Tue, 31 Jan 2006 20:01:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	<b647ffbd0601220010x3cc023an@domain.hid>	<fd6a47a90601220819n3f4cd382t@domain.hid>	<E1F16LA-0001ku-C4@domain.hid>	<43D52BA3.6020005@domain.hid>
	<43DE27E5.3010206@domain.hid> <43DE31B8.3070002@domain.hid>
	<43DE386A.60106@domain.hid> <43DE9CE1.2000602@domain.hid>
In-Reply-To: <43DE9CE1.2000602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54AADCD899E834D8C42C5ACA"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54AADCD899E834D8C42C5ACA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> At this chance: any comments on the panic-freeze extension for the
>> tracer? I need to rework the Xenomai patch, but the ipipe side should =
be
>> ready for merge.
>>
>=20
> No issue with the ipipe side since it only touches the tracer support
> code. No issue either at first sight with the Xeno side, aside of the
> trace being frozen twice in do_schedule_event? (once in this routine,
> twice in xnpod_fatal); but maybe it's wanted to freeze the situation
> before the stack is dumped; is it?

Yes, this is the reason for it. Actually, only the first freeze has any
effect, later calls will be ignored.

Hmm, I though to remember some issue of the Xenomai-side patch when
tracing was disabled but I cannot reproduce this issue again (was likely
related to other hacks while tracking down the PREEMPT issue). So from
my POV that patch is ready for merge as well.

Jan


--------------enig54AADCD899E834D8C42C5ACA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD37PsniDOoMHTA+kRAsLxAJ9eld3gYBrwv78JeSOvTsVgv7pzdACfWeJ4
SrgST2xplnzW56lhLFcqkdo=
=v4Ng
-----END PGP SIGNATURE-----

--------------enig54AADCD899E834D8C42C5ACA--

