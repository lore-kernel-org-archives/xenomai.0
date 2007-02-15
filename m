Message-ID: <45D461DC.20303@domain.hid>
Date: Thu, 15 Feb 2007 14:36:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D35545.20100@domain.hid> <45D45F63.5050009@domain.hid>
In-Reply-To: <45D45F63.5050009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig68D64C18DB0B40C28F1FB68C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: RT-CAN tx_sem
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
--------------enig68D64C18DB0B40C28F1FB68C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> Hi Wolfgang,
>>
>> fiddling with the CAN utils, I noticed the behaviour that rtcansend on=

>> freshly registered but stopped devices simply blocks. And when you
>> meanwhile call rtcanconfig up on that device, rtcansend will continue =
to
>> block.
>=20
> I see the expected behavior on stopped devices:
>=20
>   bash-2.05b# rtcansend rtcan0
>   rt_dev_send: Network is down
>=20
> This is, because the tx_sem is marked "destroyed" already when the
> device gets initialized. I wonder why your app blocks.

Unlikely, because the sem is _not_ marked destroyed on startup:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_=
dev.c#181

In case it makes a subtle difference: I tested with xeno_can_virt, but I
think I saw the same effect on real SJA1000 hw as well.

>=20
>> The reason is that during startup of CAN devices the tx-semaphore is
>> re-initialised while it is already set up during device registration.
>> Re-init on an already initialised rtdm_sem is, say, undefined.
>=20
> That makes definitely trouble. A CAN_MODE_START should only start the
> device if it's not active. The attached patch fixes this. Another
> possibility would be to force a CAN_MODE_STOP in case the device is
> already active (=3Drestart).
>=20
>> So rtdm_sem should better only be initialised/destroyed by the drivers=
=2E
>> Trying to send on a shut down CAN device could be catched differently,=

>> e.g. via the device state. This likely needs more thoughts, take it as=
 a
>> note that $something should be done.
>=20
> With the fix above I do not see further problems with the existing
> implementation using the "destroyed" state to mark the device unavailab=
le.

The problem of double init remains. I don't think that the sem state
should be used for encoding the CAN device state towards potential sender=
s.

Jan

>=20
> Wolfgang.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> + diff -u xenomai/ksrc/drivers/can/rtcan_raw_dev.c.TXSEM xenomai/ksrc/d=
rivers/can/rtcan_raw_dev.c
> --- xenomai/ksrc/drivers/can/rtcan_raw_dev.c.TXSEM	2007-02-15 11:21:43.=
000000000 +0100
> +++ xenomai/ksrc/drivers/can/rtcan_raw_dev.c	2007-02-15 14:16:16.000000=
000 +0100
> @@ -193,7 +193,8 @@
>      switch (request) {
>      case SIOCSCANMODE:
>  	mode =3D (can_mode_t *)&ifr->ifr_ifru;
> -	if (dev->do_set_mode)
> +	if (dev->do_set_mode &&
> +	    !(*mode =3D=3D CAN_MODE_START && CAN_STATE_OPERATING(dev->state))=
)
>  	    ret =3D dev->do_set_mode(dev, *mode, &lock_ctx);
>  	break;
> =20



--------------enig68D64C18DB0B40C28F1FB68C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1GHcniDOoMHTA+kRAvV9AKCAVmq3vYtlfBM2EMJjETTo7gDkuwCfRXlJ
uQTkr5MduuVEF++2B9xjTwA=
=C/5J
-----END PGP SIGNATURE-----

--------------enig68D64C18DB0B40C28F1FB68C--

