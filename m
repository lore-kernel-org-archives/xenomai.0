Message-ID: <44FEE10F.5030208@domain.hid>
Date: Wed, 06 Sep 2006 16:54:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>	
	<44FD9F92.4050802@domain.hid>	
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>	
	<44FE6C55.1030900@domain.hid>	
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>	
	<44FE943F.9000803@domain.hid>
	<b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>
In-Reply-To: <b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig14954CE684532083A83AB525"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14954CE684532083A83AB525
Content-Type: multipart/mixed; boundary="------------060706070106030201090102"

This is a multi-part message in MIME format.
--------------060706070106030201090102
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> > If such a driver (that requires EDGE_SHARED) is a part of the mainli=
ne,
>> > then
>> > we may use Kconfig features either (1) to make it "selectable" only
>> when
>> > XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE
>> automatically
>> > when the driver has been choosen.
>> >
>>
>> Let's do both, the runtime check + some Kconfig magic for mainline
>> drivers.
>>
>> For the latter we should reorganise the config options slightly.
>> XENO_OPT_SHIRQ_* may better depend on a new switch XENO_OPT_SHIRQ. Thu=
s,
>> when the user enables IRQ sharing and some in-tree driver requires
>> edge-triggering support, XENO_OPT_SHIRQ_EDGE will be selected by the
>> driver's Kconfig: select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ. With t=
he
>> current layout it would look like this: select XENO_OPT_SHIRQ_EDGE if
>> XENO_OPT_SHIRQ_LEVEL.
>=20
>=20
> XENO_OPT_SHIRQ_LEVEL doesn't need to be on in order to use
> XENO_OPT_SHIRQ_EDGE.
>=20
> Or you probably mean the following behavior :
>=20
> (1)
> some driver with XN_ISR_EDGE is selected :
>=20
> if XENO_OPT_IRQ
>     select XENO_OPT_SHIRQ_EDGE
>=20
> else
>     "run-time" check in xnintr_attach() will report -EBUSY in case the =
line
> is already busy
>=20
> What I meant is
>=20
> (2)
> some driver with XN_ISR_EDGE is selected :
>=20
> o   select XENO_OPT_SHIRQ_EDGE
>=20
> So that shared irq support (only for edge-triggered interrupts) gets
> unconditionally enabled.
>=20
> in case of (1), XENO_OPT_SHIRQ can't be enabled on its own, i.e. withou=
t
> any
> of XENO_OPT_SHIRQ_*.

See attached patch: XENO_OPT_SHIRQ would just be a menu-enabler without
any affect outside kconfig. You could enabled it and leave the rest off
(makes no sense of course) - as long as there are no edge-triggered
users around.

Doesn't apply on 2.4, though, but we would still have the runtime test
in place. As long as catching luser mistakes is that simple, I'm
personally in favour of appropriate tests.

>=20
> Well, your proposal is probably better. With XN_ISR_EDGE a driver only
> declares that it's ready to work in shared mode but it doesn't mean it
> can't
> work in non-shared one.
>=20
> If a user has a separate line for it, then the shared-IRQ infrastractur=
e
> adds just non-used overhead. Yep, you are right (heh... you are asking =
who
> had doubts? :)
>=20

Jan

--------------060706070106030201090102
Content-Type: text/plain;
 name="shirq-kconfig.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shirq-kconfig.patch"

Index: ksrc/drivers/serial/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/serial/Kconfig	(revision 1561)
+++ ksrc/drivers/serial/Kconfig	(working copy)
@@ -3,6 +3,7 @@ menu "Serial drivers"
 config XENO_DRIVERS_16550A
 	depends on XENO_SKIN_RTDM
 	tristate "16550A UART driver"
+	select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ
 	help
 	Real-time UART driver for 16550A compatible controllers. See
 	doc/txt/16550A-driver.txt for more details.
Index: ksrc/drivers/can/sja1000/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/Kconfig	(revision 1561)
+++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
@@ -1,24 +1,21 @@
 config XENO_DRIVERS_RTCAN_SJA1000
        depends on XENO_DRIVERS_RTCAN
        tristate "Philips SJA1000 CAN controller"
-       default n
=20
 config XENO_DRIVERS_RTCAN_SJA1000_ISA
        depends on XENO_DRIVERS_RTCAN_SJA1000
        tristate "Standard ISA devices"
-       default n
+       select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ
=20
 config XENO_DRIVERS_RTCAN_SJA1000_ISA_MAX_DEV
        depends on XENO_DRIVERS_RTCAN_SJA1000_ISA
        int "Maximum number of ISA devices"
-       default 4      =20
+       default 4
=20
 config XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI
        depends on XENO_DRIVERS_RTCAN_SJA1000
        tristate "PEAK PCI Card"
-       default n
=20
 config XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG
        depends on XENO_DRIVERS_RTCAN_SJA1000
        tristate "PEAK Parallel Port Dongle"
-       default n
Index: ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Kconfig	(revision 1561)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -355,13 +355,15 @@ config XENO_OPT_TIMER_WHEEL_STEP
 endmenu
=20
=20
-menu "Shared interrupts"
+menuconfig XENO_OPT_SHIRQ
+	bool "Shared interrupts"
=20
 config XENO_OPT_SHIRQ_LEVEL
 	bool "Level-triggered interrupts"
-	default n
+	depends on XENO_OPT_SHIRQ
+	default y
 	help
-=09
+
 	Enables support for shared level-triggered interrupts, so that
 	multiple real-time interrupt handlers are allowed to control
 	dedicated hardware devices which are configured to share
@@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL
=20
 config XENO_OPT_SHIRQ_EDGE
 	bool "Edge-triggered interrupts"
-	default n
+	depends on XENO_OPT_SHIRQ
+	default y
 	help
=20
 	Enables support for shared edge-triggered interrupts, so that
@@ -377,8 +380,6 @@ config XENO_OPT_SHIRQ_EDGE
 	dedicated hardware devices which are configured to share
 	the same interrupt channel.
=20
-endmenu
-
 menu "LTT tracepoints filtering"
=20
 	depends on LTT

--------------060706070106030201090102--

--------------enig14954CE684532083A83AB525
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/uEPniDOoMHTA+kRAsy2AJ0cGOv1Jcj9utIhfizm1pLNsXX5DACbBUxp
IC8skPnQoexto7ebqKmZ/A4=
=8aHF
-----END PGP SIGNATURE-----

--------------enig14954CE684532083A83AB525--

