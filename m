From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <56BDB259.2050606@sigmatek.at>
Date: Fri, 12 Feb 2016 11:22:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] IRQ of pci express claimed by linux domain
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I am using an imx6 controller where a FPGA-device is connected via PCI 
express.
To use the FPGA in realtime I try to claim the IRQ 155 using 
rtdm_irq_request() but the IRQ is hold by the linux domain.
It looks like the default driver claims the IRQ, but I have my own 
driver that is linked to the device if we can trust the output of lspci
Has anyone of you an idea what could be the reason for this issue or an 
idea how to fix it ?


 > cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
...
150:      39833          0          0          0       GIC 2188000.ethernet
151:          0          0          0          0       GIC 2188000.ethernet
155:          0          0          0          0       GIC  PCIe PME
...

 > lspci -v
00:00.0 PCI bridge: Device 16c3:abcd (rev 01) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     Memory behind bridge: 01100000-012fffff
     [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
     Capabilities: [70] Express Root Port (Slot-), MSI 00
     Capabilities: [100] Advanced Error Reporting
     Capabilities: [140] Virtual Channel
     Kernel driver in use: pcieport

01:00.0 ACCESS Bus: Device 5112:0c00
     Subsystem: Device 5112:0c00
     Flags: bus master, fast devsel, latency 0, IRQ 155
     Memory at 01100000 (32-bit, non-prefetchable) [size=1M]
     Memory at 01200000 (32-bit, non-prefetchable) [size=1M]
     Capabilities: [40] Power Management version 3
     Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [58] Express Endpoint, MSI 00
     Capabilities: [100] Device Serial Number 00-00-00-01-01-00-0a-35
     Kernel driver in use: Sigmatek PCIE


Kind regards

-- 
Wolfgang Netbal
Softwareentwicklung
________________________________

SIGMATEK GmbH & Co KG
Sigmatekstraße 1
5112 Lamprechtshausen
Österreich / Austria

Tel.: +43/6274/4321-0
Fax: +43/6274/4321-300
E-Mail: wolfgang.netbal@sigmatek.at
http://www.sigmatek-automation.at

****************************Please note: ****************************
This email and all attachments are confidential and intended solely
for the person or entity to whom it is addressed. If you are not the
named addressee you must not make this email and all attachments
accessible to any other person. If you have received this email in
error please delete it together with all attachments.
*********************************************************************

