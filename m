Date: Mon, 22 Jun 2015 21:55:53 +0000 (UTC)
From: Wayne Ross <mr_trekkie@yahoo.com>
Message-ID: <1098268209.1791408.1435010153652.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Supported PCI Express CANOpen hardware?
Reply-To: Wayne Ross <mr_trekkie@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

18 Months ago we ported our propietary software/hardware to Linux, leveraging Xenomai's CAN and RS232 driver support with a PCI CAN card using the xeno_can_mem device driver delivering the RT behaviors we need.

We are now looking at using a different hardware vendor that utilizes a "Mini PCI Express" form factor ("the successor of the Mini PCI").

I am trying to validate if the vendor's (Hilscher) interface is supported (a "netX Dual-Port Memory Interface").  I did see a couple 2-year-old emails in the Xenomai archive with PCI_VENDOR_ID_Hilscher, but I see none of that source code made it to 2.6.4.  ./ksrc/drivers/can/README basically indicates support for only the SJA1000 CAN controller.


So I have two questions:
- Is is possible Hilscher's netX interface might be supported for CANOpen?
- Does anyone know if there are *any* supported CANOpen cards in the PCIe Mini family?


Thanks,
    Wayne

