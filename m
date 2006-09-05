Message-ID: <44FD9F92.4050802@domain.hid>
Date: Tue, 05 Sep 2006 18:02:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>
In-Reply-To: <44FD99E9.6030500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B4D431B18873B880F1F32A2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
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
--------------enig8B4D431B18873B880F1F32A2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Hi Wolfgang,
>>
>> in the process of preparing to merge rtdm_irq_enable into
>> rtdm_irq_request I would like to check if the attached patch is ok, th=
us
>> we could finally drop rtdm_irq_enable once the API is refactored. Plea=
se
>> check carefully when the first IRQs may happen and what the handler
>> expects to be initialised! SJA1000 /should/ be ok as it works with
>=20
>> shared IRQs, but MSCAN does not (why, BTW?) and /may/ stumble.
>=20
> OK. Why should I use shared interrupts if there is no need? Most
> embedded PowerPC systems have a dedicated interrupt source.

Of course, /me forgot once again that not all the world is designed like
crappy x86. :)

At this chance I looked over the irq_flag mechanism of the CAN stack and
found a minor cleanup: this #ifdef [1] is not required. If there is no
sharing support, the subscriber will simply be redirected to the
non-shared handler.

@Dmitry: What happens under CONFIG_XENO_OPT_SHIRQ_LEVEL &&
!CONFIG_XENO_OPT_SHIRQ_EDGE when someone comes along with
XN_ISR_SHARED|XN_ISR_EDGE? Looks like the level-triggered shared handler
gets installed. Should we catch this? At Kconfig or at nucleus level?

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja=
1000/rtcan_peak_pci.c?v=3DSVN-trunk#L233


--------------enig8B4D431B18873B880F1F32A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/Z+SniDOoMHTA+kRAgaYAJ9OMUlxa8EZJIKD/aI/VoYzlHj5zQCfVN4K
nj6AsmK4gRxREqkEAcWUNTU=
=uvgS
-----END PGP SIGNATURE-----

--------------enig8B4D431B18873B880F1F32A2--

