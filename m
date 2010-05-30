Message-ID: <4C029F67.6010602@domain.hid>
Date: Sun, 30 May 2010 19:24:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1274245032-10610-1-git-send-email-P.B.Cheblakov@domain.hid>	<4BF3953D.8070108@domain.hid>
	<4BFA2111.5020503@domain.hid> <4BFA2696.5070302@domain.hid>
	<4C026436.6010903@domain.hid>
In-Reply-To: <4C026436.6010903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On 05/30/2010 03:12 PM, Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> From my point of view, yes. Gilles could you please commit this patch?
> 
> No, it seems the patch causes a build issue:
> 
> http://sisyphus.hd.free.fr/~gilles/bx/

Oops, obviously the Kconfig entry is invalid:

+config XENO_DRIVERS_CAN_SJA1000_ESD_PCI (DEPRECATED)

The "(DEPRECATED)" is causing the trouble, I assume.

 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "ESD PCI Cards"

Maybe you want to add the "(DEPRECATED)" here.

 	help
@@ -61,6 +76,9 @@ config XENO_DRIVERS_CAN_SJA1000_ESD_PCI
 	CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
 	CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
 	from the esd electronic system design gmbh (http://www.esd.eu).
+	

Trailing white space!

+	This driver is deprecated. It's functionality is now provided by
+	"PLX90xx PCI-bridge based Cards" driver.

Pavel, could you please fix that.

Thanks,

Wolfgang.



