Message-ID: <45AB8CC0.8020008@domain.hid>
Date: Mon, 15 Jan 2007 15:16:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid>
	<45A6CB80.9060306@domain.hid>	<45A802CD.8010606@domain.hid>
	<45AA3D26.2040409@domain.hid>
In-Reply-To: <45AA3D26.2040409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17E57E5BB6FC9A205F647E63"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17E57E5BB6FC9A205F647E63
Content-Type: multipart/mixed; boundary="------------090607050808050801040503"

This is a multi-part message in MIME format.
--------------090607050808050801040503
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jeff Webb wrote:
>> Jan Kiszka wrote:
>>> Jeff Webb wrote:
>>>> ...
>>>> My serial test program works fine in the above scenario.  However, i=
f I
>>>> try to disable the linux serial support at boot time by adding
>>>> "8250.nr_uarts=3D0" to the kernel boot options, my serial test progr=
am
>>>> does not work.  There are no errors opening, configuring, or reading=

>>>> from the rtdm device, but no data is received from the driver.  I as=
sume
>>>> that my test program is not initializing something properly, so it w=
orks
>>>> when linux initializes the serial port.  I can't seem to find what I=
'm
>>>> doing wrong.  Any help would be appreciated.
>>> Hmm, maybe a PnP issue. If there is no driver registered for the on-c=
hip
>>> PnP UARTS, power might be switched off (or kept off) for them. As
>>> xeno_16550A doesn't perform any validation of the underlying hardware=

>>> (dunno right now if there is a pattern to test at all), it may just
>>> operate on dead addresses.
>>>
>>> I faced the same issue with irqbench and parallel ports. They get
>>> switched off once the related Linux driver is removed. One solution
>>> there was to register irqbench with the PnP subsystem. I need to chec=
k
>>> if this is required here as well.
>> Thanks for the suggestion.  I looked at the PnP-related code in
>> irqbench.c, and compared this to what is in
>> linux/drivers/parport/parport_pc.c.  I then modified 16550A.c in a
>> similar fashion, merging in the required code from
>> linux/drivers/serial/8250_pnp.c.  I can now boot the kernel with
>> 8250.nr_uarts=3D0", insert the modified xeno_16550A module, and then r=
un
>> my serial test program successfully.  I have not tried compiling the
>> modified xeno_16550A code into the kernel, but I will try this next.
>=20
> Nice to hear.
>=20
>> Please review the attached patch and merge into subversion as you see =
fit.
>=20
> Basically, it looks good. I'm just wondering if we shouldn't make use o=
f
> the resource information passed on probe, validate it against what the
> user provided, and only claim those ports the user actually selected.
>=20
> Another thing the check is MODULE_DEVICE_TABLE. Does your device still
> work when you remove this line? While it is useful for standard ports
> that shall be automatically configured, I noticed that it causes
> irqbench being loaded automatically during boot (because the pnp
> signature matches). That is likely not what you want when you configure=

> xeno_16550A as module and have to switch off the standard port first
> before insmod'ing the rt-driver with full arguments.
>=20

Here is an untested variant of your patch, implementing my ideas. I
currently don't have my hands on any hardware that is able to stress the
code appropriately, and you have the ultimate test case anyway. So
please let me know if it works for you. Note: You /should/ be able to
leave the irq parameter open with this approach.

Jan

--------------090607050808050801040503
Content-Type: text/plain;
 name="16550A_pnp-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="16550A_pnp-v2.patch"

---
 ksrc/drivers/serial/16550A.c |  364 ++++++++++++++++++++++++++++++++++++=
++++++-
 1 file changed, 363 insertions(+), 1 deletion(-)

Index: xenomai/ksrc/drivers/serial/16550A.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/serial/16550A.c
+++ xenomai/ksrc/drivers/serial/16550A.c
@@ -16,10 +16,15 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
=20
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <asm/io.h>
=20
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
+#include <linux/pnp.h>
+#endif /* Linux >=3D 2.6.0 */
+
 #include <rtdm/rtserial.h>
 #include <rtdm/rtdm_driver.h>
=20
@@ -1072,11 +1077,358 @@ static const struct rtdm_device __initda
     device_sub_class:   RTDM_SUBCLASS_16550A,
     profile_version:    RTSER_PROFILE_VER,
     driver_name:        "xeno_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 4, 0),
+    driver_version:     RTDM_DRIVER_VER(1, 5, 0),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };
=20
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
+#define UNKNOWN_DEV 0x3000
+
+/* Bluntly cloned from drivers/serial/8250_pnp.c */
+static const struct pnp_device_id xeno_16550A_pnp_tbl[] =3D {
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	{	"AAC000F",		0	},
+	/* Anchor Datacomm BV */
+	/* SXPro 144 External Data Fax Modem Plug & Play */
+	{	"ADC0001",		0	},
+	/* SXPro 288 External Data Fax Modem Plug & Play */
+	{	"ADC0002",		0	},
+	/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
+	{	"AEI0250",		0	},
+	/* Actiontec ISA PNP 56K X2 Fax Modem */
+	{	"AEI1240",		0	},
+	/* Rockwell 56K ACF II Fax+Data+Voice Modem */
+	{	"AKY1021",		0 /*SPCI_FL_NO_SHIRQ*/	},
+	/* AZT3005 PnP SOUND DEVICE */
+	{	"AZT4001",		0	},
+	/* Best Data Products Inc. Smart One 336F PnP Modem */
+	{	"BDP3336",		0	},
+	/*  Boca Research */
+	/* Boca Complete Ofc Communicator 14.4 Data-FAX */
+	{	"BRI0A49",		0	},
+	/* Boca Research 33,600 ACF Modem */
+	{	"BRI1400",		0	},
+	/* Boca 33.6 Kbps Internal FD34FSVD */
+	{	"BRI3400",		0	},
+	/* Boca 33.6 Kbps Internal FD34FSVD */
+	{	"BRI0A49",		0	},
+	/* Best Data Products Inc. Smart One 336F PnP Modem */
+	{	"BDP3336",		0	},
+	/* Computer Peripherals Inc */
+	/* EuroViVa CommCenter-33.6 SP PnP */
+	{	"CPI4050",		0	},
+	/* Creative Labs */
+	/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
+	{	"CTL3001",		0	},
+	/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
+	{	"CTL3011",		0	},
+	/* Creative */
+	/* Creative Modem Blaster Flash56 DI5601-1 */
+	{	"DMB1032",		0	},
+	/* Creative Modem Blaster V.90 DI5660 */
+	{	"DMB2001",		0	},
+	/* E-Tech */
+	/* E-Tech CyberBULLET PC56RVP */
+	{	"ETT0002",		0	},
+	/* FUJITSU */
+	/* Fujitsu 33600 PnP-I2 R Plug & Play */
+	{	"FUJ0202",		0	},
+	/* Fujitsu FMV-FX431 Plug & Play */
+	{	"FUJ0205",		0	},
+	/* Fujitsu 33600 PnP-I4 R Plug & Play */
+	{	"FUJ0206",		0	},
+	/* Fujitsu Fax Voice 33600 PNP-I5 R Plug & Play */
+	{	"FUJ0209",		0	},
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	{	"GVC000F",		0	},
+	/* Hayes */
+	/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
+	{	"HAY0001",		0	},
+	/* Hayes Optima 336 V.34 + FAX + Voice PnP */
+	{	"HAY000C",		0	},
+	/* Hayes Optima 336B V.34 + FAX + Voice PnP */
+	{	"HAY000D",		0	},
+	/* Hayes Accura 56K Ext Fax Modem PnP */
+	{	"HAY5670",		0	},
+	/* Hayes Accura 56K Ext Fax Modem PnP */
+	{	"HAY5674",		0	},
+	/* Hayes Accura 56K Fax Modem PnP */
+	{	"HAY5675",		0	},
+	/* Hayes 288, V.34 + FAX */
+	{	"HAYF000",		0	},
+	/* Hayes Optima 288 V.34 + FAX + Voice, Plug & Play */
+	{	"HAYF001",		0	},
+	/* IBM */
+	/* IBM Thinkpad 701 Internal Modem Voice */
+	{	"IBM0033",		0	},
+	/* Intertex */
+	/* Intertex 28k8 33k6 Voice EXT PnP */
+	{	"IXDC801",		0	},
+	/* Intertex 33k6 56k Voice EXT PnP */
+	{	"IXDC901",		0	},
+	/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	{	"IXDD801",		0	},
+	/* Intertex 33k6 56k Voice SP EXT PnP */
+	{	"IXDD901",		0	},
+	/* Intertex 28k8 33k6 Voice SP INT PnP */
+	{	"IXDF401",		0	},
+	/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	{	"IXDF801",		0	},
+	/* Intertex 33k6 56k Voice SP EXT PnP */
+	{	"IXDF901",		0	},
+	/* Kortex International */
+	/* KORTEX 28800 Externe PnP */
+	{	"KOR4522",		0	},
+	/* KXPro 33.6 Vocal ASVD PnP */
+	{	"KORF661",		0	},
+	/* Lasat */
+	/* LASAT Internet 33600 PnP */
+	{	"LAS4040",		0	},
+	/* Lasat Safire 560 PnP */
+	{	"LAS4540",		0	},
+	/* Lasat Safire 336  PnP */
+	{	"LAS5440",		0	},
+	/* Microcom, Inc. */
+	/* Microcom TravelPorte FAST V.34 Plug & Play */
+	{	"MNP0281",		0	},
+	/* Microcom DeskPorte V.34 FAST or FAST+ Plug & Play */
+	{	"MNP0336",		0	},
+	/* Microcom DeskPorte FAST EP 28.8 Plug & Play */
+	{	"MNP0339",		0	},
+	/* Microcom DeskPorte 28.8P Plug & Play */
+	{	"MNP0342",		0	},
+	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	{	"MNP0500",		0	},
+	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	{	"MNP0501",		0	},
+	/* Microcom DeskPorte 28.8S Internal Plug & Play */
+	{	"MNP0502",		0	},
+	/* Motorola */
+	/* Motorola BitSURFR Plug & Play */
+	{	"MOT1105",		0	},
+	/* Motorola TA210 Plug & Play */
+	{	"MOT1111",		0	},
+	/* Motorola HMTA 200 (ISDN) Plug & Play */
+	{	"MOT1114",		0	},
+	/* Motorola BitSURFR Plug & Play */
+	{	"MOT1115",		0	},
+	/* Motorola Lifestyle 28.8 Internal */
+	{	"MOT1190",		0	},
+	/* Motorola V.3400 Plug & Play */
+	{	"MOT1501",		0	},
+	/* Motorola Lifestyle 28.8 V.34 Plug & Play */
+	{	"MOT1502",		0	},
+	/* Motorola Power 28.8 V.34 Plug & Play */
+	{	"MOT1505",		0	},
+	/* Motorola ModemSURFR External 28.8 Plug & Play */
+	{	"MOT1509",		0	},
+	/* Motorola Premier 33.6 Desktop Plug & Play */
+	{	"MOT150A",		0	},
+	/* Motorola VoiceSURFR 56K External PnP */
+	{	"MOT150F",		0	},
+	/* Motorola ModemSURFR 56K External PnP */
+	{	"MOT1510",		0	},
+	/* Motorola ModemSURFR 56K Internal PnP */
+	{	"MOT1550",		0	},
+	/* Motorola ModemSURFR Internal 28.8 Plug & Play */
+	{	"MOT1560",		0	},
+	/* Motorola Premier 33.6 Internal Plug & Play */
+	{	"MOT1580",		0	},
+	/* Motorola OnlineSURFR 28.8 Internal Plug & Play */
+	{	"MOT15B0",		0	},
+	/* Motorola VoiceSURFR 56K Internal PnP */
+	{	"MOT15F0",		0	},
+	/* Com 1 */
+	/*  Deskline K56 Phone System PnP */
+	{	"MVX00A1",		0	},
+	/* PC Rider K56 Phone System PnP */
+	{	"MVX00F2",		0	},
+	/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
+	{	"nEC8241",		0	},
+	/* Pace 56 Voice Internal Plug & Play Modem */
+	{	"PMC2430",		0	},
+	/* Generic */
+	/* Generic standard PC COM port	 */
+	{	"PNP0500",		0	},
+	/* Generic 16550A-compatible COM port */
+	{	"PNP0501",		0	},
+	/* Compaq 14400 Modem */
+	{	"PNPC000",		0	},
+	/* Compaq 2400/9600 Modem */
+	{	"PNPC001",		0	},
+	/* Dial-Up Networking Serial Cable between 2 PCs */
+	{	"PNPC031",		0	},
+	/* Dial-Up Networking Parallel Cable between 2 PCs */
+	{	"PNPC032",		0	},
+	/* Standard 9600 bps Modem */
+	{	"PNPC100",		0	},
+	/* Standard 14400 bps Modem */
+	{	"PNPC101",		0	},
+	/*  Standard 28800 bps Modem*/
+	{	"PNPC102",		0	},
+	/*  Standard Modem*/
+	{	"PNPC103",		0	},
+	/*  Standard 9600 bps Modem*/
+	{	"PNPC104",		0	},
+	/*  Standard 14400 bps Modem*/
+	{	"PNPC105",		0	},
+	/*  Standard 28800 bps Modem*/
+	{	"PNPC106",		0	},
+	/*  Standard Modem */
+	{	"PNPC107",		0	},
+	/* Standard 9600 bps Modem */
+	{	"PNPC108",		0	},
+	/* Standard 14400 bps Modem */
+	{	"PNPC109",		0	},
+	/* Standard 28800 bps Modem */
+	{	"PNPC10A",		0	},
+	/* Standard Modem */
+	{	"PNPC10B",		0	},
+	/* Standard 9600 bps Modem */
+	{	"PNPC10C",		0	},
+	/* Standard 14400 bps Modem */
+	{	"PNPC10D",		0	},
+	/* Standard 28800 bps Modem */
+	{	"PNPC10E",		0	},
+	/* Standard Modem */
+	{	"PNPC10F",		0	},
+	/* Standard PCMCIA Card Modem */
+	{	"PNP2000",		0	},
+	/* Rockwell */
+	/* Modular Technology */
+	/* Rockwell 33.6 DPF Internal PnP */
+	/* Modular Technology 33.6 Internal PnP */
+	{	"ROK0030",		0	},
+	/* Kortex International */
+	/* KORTEX 14400 Externe PnP */
+	{	"ROK0100",		0	},
+	/* Rockwell 28.8 */
+	{	"ROK4120",		0	},
+	/* Viking Components, Inc */
+	/* Viking 28.8 INTERNAL Fax+Data+Voice PnP */
+	{	"ROK4920",		0	},
+	/* Rockwell */
+	/* British Telecom */
+	/* Modular Technology */
+	/* Rockwell 33.6 DPF External PnP */
+	/* BT Prologue 33.6 External PnP */
+	/* Modular Technology 33.6 External PnP */
+	{	"RSS00A0",		0	},
+	/* Viking 56K FAX INT */
+	{	"RSS0262",		0	},
+	/* K56 par,VV,Voice,Speakphone,AudioSpan,PnP */
+	{       "RSS0250",              0       },
+	/* SupraExpress 28.8 Data/Fax PnP modem */
+	{	"SUP1310",		0	},
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	{	"SUP1421",		0	},
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	{	"SUP1590",		0	},
+	/* SupraExpress 336i Sp ASVD */
+	{	"SUP1620",		0	},
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	{	"SUP1760",		0	},
+	/* SupraExpress 56i Sp Intl */
+	{	"SUP2171",		0	},
+	/* Phoebe Micro */
+	/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
+	{	"TEX0011",		0	},
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	{	"UAC000F",		0	},
+	/* 3Com Corp. */
+	/* Gateway Telepath IIvi 33.6 */
+	{	"USR0000",		0	},
+	/* U.S. Robotics Sporster 33.6K Fax INT PnP */
+	{	"USR0002",		0	},
+	/*  Sportster Vi 14.4 PnP FAX Voicemail */
+	{	"USR0004",		0	},
+	/* U.S. Robotics 33.6K Voice INT PnP */
+	{	"USR0006",		0	},
+	/* U.S. Robotics 33.6K Voice EXT PnP */
+	{	"USR0007",		0	},
+	/* U.S. Robotics Courier V.Everything INT PnP */
+	{	"USR0009",		0	},
+	/* U.S. Robotics 33.6K Voice INT PnP */
+	{	"USR2002",		0	},
+	/* U.S. Robotics 56K Voice INT PnP */
+	{	"USR2070",		0	},
+	/* U.S. Robotics 56K Voice EXT PnP */
+	{	"USR2080",		0	},
+	/* U.S. Robotics 56K FAX INT */
+	{	"USR3031",		0	},
+	/* U.S. Robotics 56K FAX INT */
+	{	"USR3050",		0	},
+	/* U.S. Robotics 56K Voice INT PnP */
+	{	"USR3070",		0	},
+	/* U.S. Robotics 56K Voice EXT PnP */
+	{	"USR3080",		0	},
+	/* U.S. Robotics 56K Voice INT PnP */
+	{	"USR3090",		0	},
+	/* U.S. Robotics 56K Message  */
+	{	"USR9100",		0	},
+	/* U.S. Robotics 56K FAX EXT PnP*/
+	{	"USR9160",		0	},
+	/* U.S. Robotics 56K FAX INT PnP*/
+	{	"USR9170",		0	},
+	/* U.S. Robotics 56K Voice EXT PnP*/
+	{	"USR9180",		0	},
+	/* U.S. Robotics 56K Voice INT PnP*/
+	{	"USR9190",		0	},
+	/* Wacom tablets */
+	{	"WACF004",		0	},
+	{	"WACF005",		0	},
+	{       "WACF006",              0       },
+	/* Compaq touchscreen */
+	{       "FPI2002",              0 },
+	/* Fujitsu Stylistic touchscreens */
+	{       "FUJ02B2",              0 },
+	{       "FUJ02B3",              0 },
+	/* Fujitsu Stylistic LT touchscreens */
+	{       "FUJ02B4",              0 },
+	/* Passive Fujitsu Stylistic touchscreens */
+	{       "FUJ02B6",              0 },
+	{       "FUJ02B7",              0 },
+	{       "FUJ02B8",              0 },
+	{       "FUJ02B9",              0 },
+	{       "FUJ02BC",              0 },
+	/* Rockwell's (PORALiNK) 33600 INT PNP */
+	{	"WCI0003",		0	},
+	/* Unkown PnP modems */
+	{	"PNPCXXX",		UNKNOWN_DEV	},
+	/* More unkown PnP modems */
+	{	"PNPDXXX",		UNKNOWN_DEV	},
+	{	"",			0	}
+};
+
+static int xeno_16550A_pnp_probe(struct pnp_dev *dev,
+                                 const struct pnp_device_id *dev_id)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_DEVICES; i++)
+		if (pnp_port_valid(dev, 0) &&
+		    pnp_port_start(dev, 0) =3D=3D ioaddr[i]) {
+			if (!irq[i])
+				irq[i] =3D pnp_irq(dev, 0);
+			return 0;
+		}
+
+	return -ENODEV;
+}
+
+static struct pnp_driver xeno_16550A_pnp_driver =3D {
+	.name		=3D "xeno_16550A",
+	.id_table	=3D xeno_16550A_pnp_tbl,
+	.probe		=3D xeno_16550A_pnp_probe,
+};
+
+static int pnp_registered;
+#endif /* Linux >=3D 2.6.0 */
+
 void __16550A_exit(void);
=20
 int __init __16550A_init(void)
@@ -1086,6 +1438,11 @@ int __init __16550A_init(void)
     int                 i;
=20
=20
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
+    if (pnp_register_driver(&xeno_16550A_pnp_driver) =3D=3D 0)
+        pnp_registered =3D 1;
+#endif /* Linux >=3D 2.6.0 */
+
     for (i =3D 0; i < MAX_DEVICES; i++) {
         if (!ioaddr[i])
             continue;
@@ -1158,6 +1515,11 @@ void __16550A_exit(void)
             release_region(ioaddr[i], 8);
             kfree(device[i]);
         }
+
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
+    if (pnp_registered)
+        pnp_unregister_driver(&xeno_16550A_pnp_driver);
+#endif /* Linux >=3D 2.6.0 */
 }
=20
 module_init(__16550A_init);

--------------090607050808050801040503--

--------------enig17E57E5BB6FC9A205F647E63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFq4zAniDOoMHTA+kRAnGcAJ4lyz+jbEQ71z78RTAUbNAF5nkjTgCfVE1n
xg9E1wL1/xPGTHHjWHI5AcY=
=cpCi
-----END PGP SIGNATURE-----

--------------enig17E57E5BB6FC9A205F647E63--

