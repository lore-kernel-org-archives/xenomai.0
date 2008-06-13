Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jun 2008 17:35:40 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28DA@esealmw118.eemea.ericsson.se>
In-Reply-To: <4852908D.2020704@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28D9@domain.hid>
	<2ff1a98a0806130809ga992aa9y7372fa061466ad7f@domain.hid>
	<4852908D.2020704@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: Re: [Xenomai-core] pSOS skin: bug in tm_ticks_to_date() and
	tm_date_to_ticks()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Sorry, I have not tried 2.4.4 (the same old story, we are a little late
with the versions ... ;-)
But anyway, as Philippe mentioned, both fixes are not okay in 2.4.4.
I hope my fix is correct in both situations.

Markus


-----Original Message-----
From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of
Philippe Gerum
Sent: Freitag, 13. Juni 2008 17:22
To: Gilles Chanteperdrix
Cc: Markus Osterried; Xenomai-core@domain.hid
Subject: Re: [Xenomai-core] pSOS skin: bug in tm_ticks_to_date() and
tm_date_to_ticks()

Gilles Chanteperdrix wrote:
> On Fri, Jun 13, 2008 at 4:18 PM, Markus Osterried=20
> <markus.osterried@domain.hid> wrote:
>> Hello,
>>
>> there is a bug in the pSOS kernel-space skin, calculating calendar=20
>> time to ticks and vice versa.
>> The file xenomai/ksrc/skins/psos+/tm.c should be fixed like this:
>=20
> Have you tried Xenomai 2.4.4 ? It contains a fix in the same file.
>=20

Actually, my fix was wrong, it should have read:

	for (n =3D month - 1; n > 0; n--)
-		*count +=3D tm_month_sizes[n];
+		*count +=3D tm_month_sizes[n - 1];

The other hunk, which is an overflow issue has been fixed in SOLO
recently, but not merged back yet, so this still applies.

--
Philippe.

