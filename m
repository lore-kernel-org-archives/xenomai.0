Message-ID: <4C037798.8070307@domain.hid>
Date: Mon, 31 May 2010 10:47:20 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1274245032-10610-1-git-send-email-P.B.Cheblakov@domain.hid>	<4BF3953D.8070108@domain.hid>
	<4BFA2111.5020503@domain.hid> <4BFA2696.5070302@domain.hid>
	<4C026436.6010903@domain.hid> <4C029F67.6010602@domain.hid>
	<4C03689D.4010304@domain.hid>
In-Reply-To: <4C03689D.4010304@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH V2] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 05/31/2010 09:43 AM, Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> On 05/30/2010 03:12 PM, Gilles Chanteperdrix wrote:
>>> Wolfgang Grandegger wrote:
>>>> From my point of view, yes. Gilles could you please commit this patch?
>>> No, it seems the patch causes a build issue:
>>>
>>> http://sisyphus.hd.free.fr/~gilles/bx/
>>
>> Oops, obviously the Kconfig entry is invalid:
>>
>> +config XENO_DRIVERS_CAN_SJA1000_ESD_PCI (DEPRECATED)
>>
>> The "(DEPRECATED)" is causing the trouble, I assume.
>>
>>  	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
>>  	tristate "ESD PCI Cards"
>>
>> Maybe you want to add the "(DEPRECATED)" here.
>>
>>  	help
>> @@ -61,6 +76,9 @@ config XENO_DRIVERS_CAN_SJA1000_ESD_PCI
>>  	CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
>>  	CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
>>  	from the esd electronic system design gmbh (http://www.esd.eu).
>> +=09
>>
>> Trailing white space!
>>
>> +	This driver is deprecated. It's functionality is now provided by
>> +	"PLX90xx PCI-bridge based Cards" driver.
>>
>> Pavel, could you please fix that.
>=20
> Ok. If these are the only differences between the patch which was
> actually tested and the patch you posted, simply tell us, I can fix it
> in my tree.

The attached patch fixes the remaining issues, including some compiler
warnings :-(.

Thanks,

Wolfgang.

---
 ksrc/drivers/can/sja1000/Kconfig         |   10 ++++------
 ksrc/drivers/can/sja1000/rtcan_plx_pci.c |    8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

Index: xenomai-2.5/ksrc/drivers/can/sja1000/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.5.orig/ksrc/drivers/can/sja1000/Kconfig
+++ xenomai-2.5/ksrc/drivers/can/sja1000/Kconfig
@@ -66,21 +66,19 @@ config XENO_DRIVERS_CAN_SJA1000_EMS_PCI
 	W=FCnsche (http://www.ems-wuensche.de). To get the second channel
 	working, Xenomai's shared interrupt support must be enabled.
=20
-
-config XENO_DRIVERS_CAN_SJA1000_ESD_PCI (DEPRECATED)
+config XENO_DRIVERS_CAN_SJA1000_ESD_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
-	tristate "ESD PCI Cards"
+	tristate "ESD PCI Cards (DEPRECATED)"
 	help
=20
 	This driver supports the esd PCI CAN cards CAN-PCI/200,
 	CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
 	CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
-	from the esd electronic system design gmbh (http://www.esd.eu).
-=09
+	from the esd electronic system design gmbh (http://www.esd.eu)
+
 	This driver is deprecated. It's functionality is now provided by
 	"PLX90xx PCI-bridge based Cards" driver.
=20
-
 config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
 	depends on XENO_DRIVERS_CAN_SJA1000 && !PARPORT
 	tristate "PEAK Parallel Port Dongle"
Index: xenomai-2.5/ksrc/drivers/can/sja1000/rtcan_plx_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.5.orig/ksrc/drivers/can/sja1000/rtcan_plx_pci.c
+++ xenomai-2.5/ksrc/drivers/can/sja1000/rtcan_plx_pci.c
@@ -288,12 +288,12 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_t
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
=20
-static u8 plx_pci_read_reg(const struct rtcan_device *dev, int port)
+static u8 plx_pci_read_reg(struct rtcan_device *dev, int port)
 {
 	return ioread8((void* __iomem)dev->base_addr + port);
 }
=20
-static void plx_pci_write_reg(const struct rtcan_device *dev, int port, u8=
 val)
+static void plx_pci_write_reg(struct rtcan_device *dev, int port, u8 val)
 {
 	iowrite8(val, (void* __iomem)dev->base_addr + port);
 }
@@ -303,7 +303,7 @@ static void plx_pci_write_reg(const stru
  * by trying to switch 'em from the Basic mode into the PeliCAN mode.
  * Also check states of some registers in reset mode.
  */
-static inline int plx_pci_check_sja1000(const struct rtcan_device *dev)
+static inline int plx_pci_check_sja1000(struct rtcan_device *dev)
 {
 	int flag =3D 0;
=20
@@ -507,7 +507,7 @@ static int __devinit plx_pci_add_card(st
 		}
=20
 		strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
-		dev->board_name =3D ci->name;
+		dev->board_name =3D (char *)ci->name;
=20
 		card->rtcan_dev[i] =3D dev;
 		chip =3D card->rtcan_dev[i]->priv;



=20

