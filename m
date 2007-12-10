Message-ID: <b054e88e0712100325o75285b0ej9f2c649cd8cd7079@domain.hid>
Date: Mon, 10 Dec 2007 12:25:08 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <b054e88e0712100258l4a52db06m1efd4b0cc2c4e4be@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
	<475C13C6.8080508@domain.hid>
	<18268.5917.619555.657394@domain.hid>
	<b054e88e0712100258l4a52db06m1efd4b0cc2c4e4be@domain.hid>
Subject: [Xenomai-core] BUG while modprobing nucleus - no SMI workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The smictrl utility gives this output:

# ./smictrl -s 0

SMI-enabled chipset found:
PCI_VENDOR_ID_INTEL:PCI_DEVICE_ID_INTEL_ICH7_0 (8086:27b8)
SMI_EN register:       0002202b
new value:             00000003

Seems like someone's locking those bits.

Anyway, lspci -nn gives this:

00:00.0 Host bridge [0600]: Intel Corporation 82975X Memory Controller
Hub [8086:277c]
00:01.0 PCI bridge [0604]: Intel Corporation 82975X PCI Express Root
Port [8086:277d]
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family)
High Definition Audio Controller [8086:27d8] (rev 01)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 [8086:27d0] (rev 01)
00:1c.4 PCI bridge [0604]: Intel Corporation 82801GR/GH/GHM (ICH7
Family) PCI Express Port 5 [8086:27e0] (rev 01)
00:1c.5 PCI bridge [0604]: Intel Corporation 82801GR/GH/GHM (ICH7
Family) PCI Express Port 6 [8086:27e2] (rev 01)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #1 [8086:27c8] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #2 [8086:27c9] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #3 [8086:27ca] (rev 01)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #4 [8086:27cb] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB2 EHCI Controller [8086:27cc] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev e1)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family)
LPC Interface Bridge [8086:27b8] (rev 01)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family)
IDE Controller [8086:27df] (rev 01)
00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
Family) SATA RAID Controller [8086:27c3] (rev 01)
01:00.0 VGA compatible controller [0300]: ATI Technologies Inc RV515GL
[FireGL V3350] [1002:7153]
01:00.1 Display controller [0380]: ATI Technologies Inc RV515GL
[FireGL V3350] (Secondary) [1002:7173]
3f:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme
BCM5755 Gigabit Ethernet PCI Express [14e4:167b] (rev 02)


> "SMI workaround failed" does not mean that the chipset is not supported,
> it means that the chipset is supported but that masking/settting the SMI
> bits failed, probably because the BIOS locked the SMI bits.
>
> --
>                                             Gilles Chanteperdrix.
>

