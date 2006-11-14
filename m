Message-ID: <455A1EF4.4080205@domain.hid>
Date: Tue, 14 Nov 2006 20:54:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid>
	<4559DA0E.7060406@domain.hid> <455A02AD.9000403@domain.hid>
	<455A14C3.60701@domain.hid>
In-Reply-To: <455A14C3.60701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4C72EE8222A19B441A636BC"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4C72EE8222A19B441A636BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
>>> @@ -894,6 +937,12 @@
>>>      /* We got access */
>>> =20
>>> =20
>>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>>> +    /* Push message onto stack for loopback when TX done */
>>> +    if (sock->tx_loopback)
>>> +    rtcan_tx_push(dev, sock, frame);
>>> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
>>
>> Hmm, I would prefer to define something like
>>
>> if (rtcan_tx_loopback_enabled(sock))
>>     rtcan_tx_push(dev, sock, frame);
>>
>> with rtcan_tx_loopback_enabled resolving to 0 in the configured-out
>> case. Thus some #ifdefs could be moved from the code to central places=

>> in header files.
>=20
> OK, here I can avoid the #ifdef's ...
>=20
>>> Index: ksrc/drivers/can/mscan/rtcan_mscan.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ksrc/drivers/can/mscan/rtcan_mscan.c    (revision 1834)
>>> +++ ksrc/drivers/can/mscan/rtcan_mscan.c    (working copy)
>>> @@ -251,6 +251,21 @@
>>>      regs->cantier =3D 0;
>>>      /* Wake up a sender */
>>>      rtdm_sem_up(&dev->tx_sem);
>>> +
>>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>>> +    if (dev->tx_socket) {
>>
>> Same here. A macro like rtcan_tx_loopback_pending(dev) would avoid the=

>> #ifdef.
>=20
> ...but not here. Or does the optimizer remove the if block?

AFAIK, all relevant gcc versions kill blocks like

if (0) {
	...
}

from the binary. But one problem might appear: the block content must be
compilable in any case...

>> I think the timestamp should rather be passed to rtcan_tc_loopback and=

>> set there. Or, if passing that value increases the code size needlessl=
y,
>> rtcan_tx_loopback should be defined like
>>
>> static inline void
>> rtcan_tx_loopback(struct rtcan_device *dev, nanosecs_abs_t timestamp)
>> {
>>     <set timestamp>
>>     __rtcan_tx_loopback(dev);
>> }
>>
>> where __rtcan_tx_loopback is the uninlined code. That makes the driver=

>> code leaner. Locking will hopefully change anyway, so nothing to do on=

>> this part for now.
>=20
> Or do it directly in rtcan_tx_loopback() and rtcan_recv(). Would it be
> OK to read the time in these functions as well or should it be done, as=

> is, at the beginning of the ISR? I have already planned some similar
> rewrite when Xenomai 2.3. is out, hopefully together with the new locki=
ng.

A few cycles offset of the timestamp doesn't matter here. We should just
avoid reading it more than once as this can be a costly operation on
some systems.

Jan


--------------enigD4C72EE8222A19B441A636BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFWh71niDOoMHTA+kRApPSAJ971lDyeoGpQS5Jf8DLDde6+vNV9ACeJ7eW
iXaMPvfR8PiFYaBWsmMzDQQ=
=HbtS
-----END PGP SIGNATURE-----

--------------enigD4C72EE8222A19B441A636BC--

