Message-ID: <45D46E55.7020907@domain.hid>
Date: Thu, 15 Feb 2007 15:29:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D35545.20100@domain.hid> <45D45F63.5050009@domain.hid>
	<45D461DC.20303@domain.hid> <45D4661D.7010506@domain.hid>
In-Reply-To: <45D4661D.7010506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3CEC5329365555B233D7A770"
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
--------------enig3CEC5329365555B233D7A770
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hi Jan,
>>>
>>> Jan Kiszka wrote:
>>>> Hi Wolfgang,
>>>>
>>>> fiddling with the CAN utils, I noticed the behaviour that rtcansend =
on
>>>> freshly registered but stopped devices simply blocks. And when you
>>>> meanwhile call rtcanconfig up on that device, rtcansend will
>>>> continue to
>>>> block.
>>> I see the expected behavior on stopped devices:
>>>
>>>   bash-2.05b# rtcansend rtcan0
>>>   rt_dev_send: Network is down
>>>
>>> This is, because the tx_sem is marked "destroyed" already when the
>>> device gets initialized. I wonder why your app blocks.
>>
>> Unlikely, because the sem is _not_ marked destroyed on startup:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtc=
an_dev.c#181
>>
>=20
> You missed
>=20
>     /* Set dummy state for following call */
>     dev->state =3D CAN_STATE_ACTIVE;
>     /* Enter reset mode */
>     rtcan_sja_mode_stop(dev, NULL);
>=20
> in the init part of rtcan_sja1000.c and rtcan_mscan.c, ...
>=20
>>
>> In case it makes a subtle difference: I tested with xeno_can_virt, but=
 I
>> think I saw the same effect on real SJA1000 hw as well.
>=20
> ... which is missing in rtcan_virt.c. I already thought moving it to th=
e
> common part. The attached patch fixes that.

I'm still not happy with this pattern, at least it's hidden from the
drivers now. But do not rtcan_sja1000.c and rtcan_mscan.c require some
changes as well to avoid double destruction when this happens in generic
code from now on?

>=20
>>>> The reason is that during startup of CAN devices the tx-semaphore is=

>>>> re-initialised while it is already set up during device registration=
=2E
>>>> Re-init on an already initialised rtdm_sem is, say, undefined.
>>> That makes definitely trouble. A CAN_MODE_START should only start the=

>>> device if it's not active. The attached patch fixes this. Another
>>> possibility would be to force a CAN_MODE_STOP in case the device is
>>> already active (=3Drestart).
>>>
>>>> So rtdm_sem should better only be initialised/destroyed by the drive=
rs.
>>>> Trying to send on a shut down CAN device could be catched differentl=
y,
>>>> e.g. via the device state. This likely needs more thoughts, take it
>>>> as a
>>>> note that $something should be done.
>>> With the fix above I do not see further problems with the existing
>>> implementation using the "destroyed" state to mark the device
>>> unavailable.
>>
>> The problem of double init remains. I don't think that the sem state
>> should be used for encoding the CAN device state towards potential
>> senders.
>=20
> As I see it, Sebastian's trick saves code and synchronization.

Well, we are discussing a single test here. Or doesn't dev->state hold
the require information as well. Moreover, the existing pattern was easy
to get wrong between core and driver.

On the other hand, if we manage to clean the code up, I may change my min=
d.

Jan


--------------enig3CEC5329365555B233D7A770
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1G5VniDOoMHTA+kRAnEOAJ91rXU9fR29Tx1qg9osnyRaU1peyACfSETe
yYUALHqWhrXPudsjxPKDm+k=
=cYPS
-----END PGP SIGNATURE-----

--------------enig3CEC5329365555B233D7A770--

