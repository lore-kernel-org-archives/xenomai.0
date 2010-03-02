Message-ID: <4B8D079B.1090008@domain.hid>
Date: Tue, 02 Mar 2010 13:42:03 +0100
From: Alex Monti <alexmonti_82@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] PCI cause system freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,
I'm testing realtime linux on Powerpc and I'm finding some serious problem with Adeos patch.
My platform is mpc5121e rev 4 based one and I'm using 2.6.29.4 DENX kernel with Xenomai patch.
My board boots, Xenomai works, but when I try to enable a Network Pci card, system always freeze.

In details:

With only 2.6.29.4 DENX kernel (without Xenomai patch) all works fine: board boots, all peripherals work (included network card).

When I apply the Xenomai patch, board boots,  Xenomai works and loading module of the network adapter (insmod .../module_name) has no problems but when I try to enable the interface (ifconfig eth1 up), system always freeze.

I've tried two network adapters (Intel e100 and Realtek r8169) so problem is not the driver.
I've tried RTAI patch but result is always the same.

I think problem is in the ADEOS patch because it is the only thing common to all tests (same version for both patch).

Modifing driver of e100 I realize that system crash enabling irq (I think, not sure: I added some printk within the driver and the last function call that I see is e100_enable_irq).

Any suggestion? Any help is very usefull!!!
Thanks



 <http://lxr.free-electrons.com/ident?i=e100_enable_irq>


