Message-ID: <4D2379E7.6050307@domain.hid>
Date: Tue, 04 Jan 2011 20:49:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D23435B.70603@domain.hid>
In-Reply-To: <4D23435B.70603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RFC: 16550A pci serial board support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Stefan Kisdaroczi wrote:
> Hi,
> 
> the attached patch adds pci support to the 16550A serial driver. I have
> a Moxa CP-132 board and the first tests are looking good. If there is a
> chance to get the patch applied I kindly request you to review it. I'll
> add support for more Moxa boards if there is a interest to apply the patch.
> 
> thanks
> Stefan

Looks fine to me, however, nit-picking a bit, could we do this differently:

+static const struct rt_16550_pci_board rt_16550_pci_boards[] = {
+/*  0 */ { 0 },
+/*  1 */ { "Moxa C104H/PCI",	2, 4, 8, 921600, 16 },
+/*  2 */ { "Moxa C168H/PCI",	2, 8, 8, 921600, 16 },
+/*  3 */ { "Moxa CP-114",	2, 4, 8, 921600, 16 },
+/*  4 */ { "Moxa CP-132",	2, 2, 8, 921600, 16 },
+};
+
+/* driver_data correspond to the line in the structure above */
+DEFINE_PCI_DEVICE_TABLE( rt_16550_pci_tbl ) = {
+#if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),  .driver_data = 1 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),  .driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114), .driver_data = 3 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132), .driver_data = 4 },
+#endif
+	{ 0 }
+};

For instance:

static const struct rt_16550_pci_board rt_16550_moxa_c104 = {
	.name = "Moxa C104H/PCI",
	.resource_base_addr = 2,
	.nports = 4,
	.port_ofs = 8,
	.baud_base = 921600,
	.tx_fifo = 16,
};

/* ... */

DEFINE_PCI_DEVICE_TABLE( rt_16550_pci_tbl ) = {
#if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),  .driver_data = &rt_16550_moxa_c104 },

/* ... */
};

static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
					 const struct pci_device_id *ent )
{
	struct rt_16550_pci_board *board;
	int err;
	int i;
	int port = 0;
	int base_addr;
	int max_devices = 0;

	if (!ent->driver_data)
		return -ENODEV;

	board = (struct rt_16550_pci_board *)ent->driver_data;


> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
                                                                Gilles.

