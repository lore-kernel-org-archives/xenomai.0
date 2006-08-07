Message-ID: <44D74EC4.3010806@domain.hid>
Date: Mon, 07 Aug 2006 16:31:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid> <44D4CAE9.9000800@domain.hid>
	<44D4E38D.9060007@domain.hid> <44D4FF53.8000904@domain.hid>
	<44D74B93.9070905@domain.hid>
In-Reply-To: <44D74B93.9070905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9615B6EBB410047BD09043C4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9615B6EBB410047BD09043C4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>>>>> - Well known issue: the RTCAN name. This should definitely get
>>>>>> resolved
>>>>>> before we merge. Any feedback already?
>>>>> I contacted the author. If I will not get an answer soon, I tend
>>>>> changing the global name to RT-Socket-CAN (rtsocketcan).
>>>> I would really hate to have a drivers/rtsocketcan or a
>>>> rtdm/rtsocketcan.h. The short name is so much nicer.
>>> He did not say, that we cannot use the name RTCAN but he prefers that=
 we
>>> use a different name to avoid confusion. Therefore I suggest to use t=
he
>>> offical name "RT-Socket-CAN" for the project, but leave almost all
>>> internal rtcan prefixes as they are apart from:
>>>
>>>   drivers/rtsocketcan
>>>   rtdm/rtsocketcan.h
>>>
>>> Note that the API does use the Linux naming in most cases (with the
>>> prefix can).
>>>
>>> Another possibility would be to use rtscan as short form for rtsocket=
can
>>> as prefix.
>>>
>>> What do you think? Well, it's just a name.
>>
>> Never underestimate naming. Ok, I have this proposal now:
>>
>>  o drivers/can/ - That's consistent with the existing subdir naming
>>    anyway.
>>
>>  o rtdm/rtcan.h - The "rtdm/" prefix clearly defines the context: It's=

>>    THE standard real-time CAN profile for RTDM.
>>
>>  o All references to "RTCAN" in comments, READMEs, headers, etc. must =
be
>>    changed to RT-Socket-CAN. So it should be clear that this has nothi=
ng
>>    to do with the existing "rtcan" project.
>>
>>  o Variable, type, and function names remain as they are.
>>
>> Jan
>>
>>
>> PS: Another point for the long-term to-do list :-> : The nested lockin=
g
>> and the global scope of certain locks. It's safe, it's harmless for
>> current primary target platforms (UP), but it's not really beautiful
>> when considering SMP setups. A bit tricky, for sure.
>=20
> I just realized another issue. Where to put README and CREDITS file? Th=
e
> README should go into doc/txt/can-driver.txt. Should I add the credits
> to this file as well?

I would maintain that file under drivers/can. Who knows if it doesn't
grow noticeably over the time... Some reference from the main CREDITS
would be good then. Something like "See drivers/<subsystem>/CREDITS for
further contributors".

Jan


--------------enig9615B6EBB410047BD09043C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE107EniDOoMHTA+kRAmGTAJ9kpOxjN5W5R50YfZV8i+N1AvNqngCfWLdx
Xmp+LDWYJbDSIsJMjC3JCA4=
=fAIY
-----END PGP SIGNATURE-----

--------------enig9615B6EBB410047BD09043C4--

