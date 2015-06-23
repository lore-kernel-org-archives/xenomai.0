Message-ID: <5588ECBD.8050005@web.de>
Date: Tue, 23 Jun 2015 07:21:01 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1098268209.1791408.1435010153652.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <1098268209.1791408.1435010153652.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Supported PCI Express CANOpen hardware?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Ross <mr_trekkie@yahoo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-06-22 23:55, Wayne Ross wrote:
> 18 Months ago we ported our propietary software/hardware to Linux, levera=
ging Xenomai's CAN and RS232 driver support with a PCI CAN card using the x=
eno_can_mem device driver delivering the RT behaviors we need.
> =

> We are now looking at using a different hardware vendor that utilizes a "=
Mini PCI Express" form factor ("the successor of the Mini PCI").
> =

> I am trying to validate if the vendor's (Hilscher) interface is supported=
 (a "netX Dual-Port Memory Interface").  I did see a couple 2-year-old emai=
ls in the Xenomai archive with PCI_VENDOR_ID_Hilscher, but I see none of th=
at source code made it to 2.6.4.  ./ksrc/drivers/can/README basically indic=
ates support for only the SJA1000 CAN controller.
> =

> =

> So I have two questions:
> - Is is possible Hilscher's netX interface might be supported for CANOpen?
> - Does anyone know if there are *any* supported CANOpen cards in the PCIe=
 Mini family?
> =


Note that CANopen is "just" a software layer on top of regular CAN
hardware - just in case you restricted your hardware search needlessly.
There are mini PCIe cards on the market with SJA1000 controller, e.g. by
PHYTEC - adopting the existing driver is then not very tricky. I assume
you already have the required CANopen bits in your software stack.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150623/67e7ae58/at=
tachment.sig>
