Message-ID: <45FDA81F.2080004@domain.hid>
Date: Sun, 18 Mar 2007 21:59:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<E1HOW5u-0006Ap-EW@mailer.emlix.com>	<45F7DEA8.2050309@domain.hid>	<E1HRSws-0007cE-R3@domain.hid>
	<45FBD768.9050407@domain.hid> <45FD12D4.3070901@domain.hid>
	<45FD238F.2050009@domain.hid>
In-Reply-To: <45FD238F.2050009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig86E89196392DEA57D1126E71"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig86E89196392DEA57D1126E71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Back to our preferred solution 1. Attached is a patch for review
>>> including some other fixes and suggestions accumulated over time:
>>>
>>>      * ksrc/drivers/can/*: To avoid unnecessary bus error interrupt
>>>      flooding, the option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now allows =
to
>>>      enable bus error interrupts "on demand" only if an application i=
s
>>>      interested in such errors. It is automatically selected for CAN
>>>      controllers supporting bus error interrupts like the SJA1000.
>>
>> Jumping into this more or less blindly: Could you explain to me (as we=
ll
>> as the poor CAN users...) what the downsides of enabling
>> CONFIG_XENO_DRIVERS_CAN_BUS_ERR are? If there isn't anything
>> significant, I would strongly vote for keeping the switch forest as
>> small as possible.
>=20
> The user has not to care and cannot even enable this option. It is auto=

> selected for SJA1000. The purpose of this config option is to suppress
> correlated code for builds without SJA1000. About the functionality: as=


Hmm, probably the attached help text confused me (who should see it BTW?)=
=2E

> you know, on the SJA1000 the bus error interrupt can result in high
> error interrupt rates and even hang the system on slow processors. Just=

> unplugging the CAN cable can cause such interrupt flooding. This proble=
m
> popped up again recently and Sebastian proposed:
>=20
>> Last summer we had a discussion about the BEI issue on the
>> socketcan-ML. Two additional handling policies popped up:
>> 1. The interface could restart itself after an amount of BEIs, thus
>>    taking responsibility from the user application.
>> 2. The BEI could be completely disabled if no one is interested in
>>    this ype of error frame.
>=20
> As 2. is also my preferred solution, I have implemented it. The only
> downside is that you do not see the error counter increasing when
> /proc/rtcan/devices is inspected. We also discussed 1., but
> RT-Socket-CAN does not restart the CAN controller by purpose and just
> stoppping it requires user intervention.

And if there is someone listening, how is the flooding issue on cable
unplug etc. solved by option 2?

What about something like option 3: After the first error occurred that
may mark the beginning of a flood, disable that error interrupt until
the next stop/start cycle or the user has read the event?

Jan


--------------enig86E89196392DEA57D1126E71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/agfniDOoMHTA+kRAgzjAJ9by2T0o7Ts5ZV6J4pU9+UEvGHrqQCfT+42
Xpc4uYDep2mfmOhoTOaOFGo=
=ZrVJ
-----END PGP SIGNATURE-----

--------------enig86E89196392DEA57D1126E71--

