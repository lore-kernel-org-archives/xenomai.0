Message-ID: <462DC874.20303@domain.hid>
Date: Tue, 24 Apr 2007 11:05:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<45F6AA11.40707@domain.hid>	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>	<460AB8FF.5060904@domain.hid>
	<460B21C0.7090200@domain.hid>	<460B7FDF.8030100@domain.hid>
	<460BECFD.2030003@domain.hid>	<460C0C7D.7000001@domain.hid>	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	<17964.64208.463335.611234@domain.hid>
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
In-Reply-To: <bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig769C0725DCEEC219CDF949CD"
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
--------------enig769C0725DCEEC219CDF949CD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi
>=20
>> The latency killers:
>> - SMI: check dmesg to see if you get a warning saying that an
>>   SMI-enabled chipset was detected. If yes,
> Yes get this message.
>=20
>> read the TROUBLESHOOTING. If
> Done what it says here. No change. My latency is also less than 100 us
> so this is probably not the problem. Tried anyway but as mentioned, no
> difference.
>=20
>> - USB: disable legacy USB in BIOS configuration, sometimes it is not
> My BIOS settings do not allow me to switch off the USB legacy. At
> least I cannot find the place where this is to be done.
>=20
>=20
>>   enough, and you have to _enable_ USB in kernel configuration, and lo=
ad
>>   the USB modules (that is at least uhci-hcd, ohci-hcd, ehci-hcd and
>>   usbcore) so that they disable BIOS legacy USB emulation.
> These ARE enabled.
>=20
>> - X-window: if you see high latencies only when the X server is runnin=
g,
>>   the X-server is probably causing them. A workaround is proposed in t=
he
>>   TROUBLESHOOTING file.
> Ran latency without X running. No difference.
>=20
>>
>> In case all that fails, enable the I-pipe tracer, run latency with the=

>> -f option, and check /proc/ipipe/trace/frozen once you observed the hi=
gh
>> latency in latency.
> Have done this and attached the result. I have looked at it myself but
> cannot interpret the meaning.
>=20
> A bit of help would be appreciated.

Two conclusions:

 - You are running your kernel as i586 without TSC support - suboptimal,
   costs you a few micros.
 - The reported latency perfectly matches the trace, nothing
   pathological there. The trace looks like this: Timer fired,
   measurement task woken up, two interrupts squeeze themselves between
   wakeup and time stamp acquisition. All sane.

Jan


--------------enig769C0725DCEEC219CDF949CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLch0niDOoMHTA+kRAiu3AJsGFmKy6M8zKyT1I0VuV/9I8CFM1wCdHRxP
NDtV+7qJheXNgDmOHz1DNsM=
=Ac+7
-----END PGP SIGNATURE-----

--------------enig769C0725DCEEC219CDF949CD--

