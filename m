Message-ID: <462DF8CD.6090304@domain.hid>
Date: Tue, 24 Apr 2007 14:32:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<460B7FDF.8030100@domain.hid>	 <460BECFD.2030003@domain.hid>
	<460C0C7D.7000001@domain.hid>	
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	
	<17964.64208.463335.611234@domain.hid>	
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>	
	<462DC874.20303@domain.hid>	
	<bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>	
	<462DE13C.7030305@domain.hid>
	<bc4264770704240514i4478b0a4p890540bee5da8d8b@domain.hid>
In-Reply-To: <bc4264770704240514i4478b0a4p890540bee5da8d8b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEF7FB555DF70DE25CCD5706C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF7FB555DF70DE25CCD5706C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
>> > I am aware of this. For the current machine I will stick to this.
>> >
>>
>> Then don't complain. :)
> Yes sir!
> :)
> Not complaining really, I think and I hope that the latency of 30us
> average will do nicely for me. Just curious actually.
>=20
>> > to be give worse latencies than much slower machines. Are the 2
>> > interrupts causing the latency?
>>
>> Those two increase the latency of code in timed tasks, for sure. The
>> question is if your measurement on the slower machine also included th=
is
>> scenario (timer event + 2 IRQs in a row). This definitely doesn't happ=
en
>> often, and maybe timing on the slower box makes it less likely. Or the=
re
>> is one potential IRQ source more on your fast box (e.g. due to IRQ
>> sharing on the slower one).
>>
>> You see, RT system design on the edge (ie. when hunting a few 10 us) i=
s
>> tricky and not easily portable from box X to box Y.
>=20
> Its not possible to determine which IRQ's are responsible for this
> from the trace I presume?
>=20

echo 1 > /proc/ipipe/trace/verbose

Then look at the "User Val." reported at "common_interrupt" (see also [1]=
).

Jan

[1] http://www.xenomai.org/index.php/I-pipe:Tracer


--------------enigEF7FB555DF70DE25CCD5706C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLfjQniDOoMHTA+kRAlvHAJ470vDaZ7z3a1FDJL6jxevPXQIz1QCcDHqW
/Pbn8D6QvL88wZpYzQg6unc=
=hT19
-----END PGP SIGNATURE-----

--------------enigEF7FB555DF70DE25CCD5706C--

