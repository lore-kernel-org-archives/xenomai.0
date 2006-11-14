Message-ID: <455A20D1.1020507@domain.hid>
Date: Tue, 14 Nov 2006 21:02:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>	
	<45203E31.6050707@domain.hid>	
	<4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>	
	<4554A498.8030202@domain.hid>
	<4546494d0611121951n600c6a53pe3a08097e923435d@domain.hid>
In-Reply-To: <4546494d0611121951n600c6a53pe3a08097e923435d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDA70BBB74FBFD82387060BA9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA70BBB74FBFD82387060BA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Please see my comments bellow:
>=20
> On 11/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> Li Yi (Adam) wrote:
>> > Hi Jan and Philippe,
>>
>>
>> This must be
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L=
2337
>>
>>
>> saying "root thread is about the be scheduled away". But then I'm
>> missing code here that one would normally see on x86:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L=
2442
>>
>>
>> Likely inlined on bfin, but this *must* make some noise:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L=
2453
>>
>>
>> Instead we enter the pending timer interrupt. This currently makes no
>> sense to me, rather make me think that something is skewed. Maybe only=

>> the tracer, maybe more...
>=20
>=20
> Do you have a tracer-log for i386 for reference? So I can do some compa=
re.

Oops, I found the same pattern on i386 - and that made me think about it
again: All fine, red herring, no bug.

What I failed to see is the special case of switching from the
gatekeeper back to the Xenomai thread that is about to be hardened. In
that case, we actually do not see the second pid trace after the switch.

Ok, the world was just proven to be still round. :)

Jan


--------------enigDA70BBB74FBFD82387060BA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFWiDRniDOoMHTA+kRAglEAJ9N8oI/b286GhUCcsTzTF26CtFWDgCbBTll
mYI+swH72NofoJY5yHm4ohQ=
=cazs
-----END PGP SIGNATURE-----

--------------enigDA70BBB74FBFD82387060BA9--

