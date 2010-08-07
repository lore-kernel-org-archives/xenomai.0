Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Guenter Ebermann <guenter.ebermann@domain.hid>
In-Reply-To: <4C5C83E5.9040508@domain.hid>
Date: Sat, 7 Aug 2010 11:28:17 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7EFC96D-FF5D-4150-A63D-1FFF25412FE7@domain.hid>
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
	<4C5C83E5.9040508@domain.hid>
Subject: Re: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: xenomai@xenomai.org

Hi Thomas,

Thank you very much for your help.

Thomas Lockhart wrote:
> We are thinking about trying to refactor a driver to use RTDM due to =
the
> recent discussions on losing support for userland interrupt handling, =
but for
> our purposes the current support for interrupts in userland has worked =
fine.

If I understand you correctly you are using the rt_intr_*() functions =
from the
Native xenomai API in user space.

> We use pci_scan_bus() and friends for finding the device, and mmap to =
get it
> into userland memory.

Ok. This means your devices are on the pci bus and you have written a =
kernel
driver which maps the pci address space of your card to the user space =
using
mmap. I once did the same thing for a PCI data aquisition host driver =
under
linux. But, please correct me if I am wrong, such a minimal =
pci-memory-mapping
driver cant gain advantage of the xenomai rtdm or other xenomai api. =
Because
the whole mapping stuff will happen only once during module init and the =
user
space application (which hopefully only stays in the xenomai domain) =
will take
over after that.

But the whole PCI stuff leads me to another question:
I know the PCI-host infrastructure of the linux kernel - device =
enumeration and
driver structure. But AFAIK the PCI infrastructure of the linux kernel =
"only"
deals with the use case where linux is the master/host on the PCI bus.  =
Our
aquisition device must be a bus master PCI slave/device - this means it =
is
plugged into a normal PC via PCI-express. Therefor linux on the card is =
not
allowed to make bus enumeration. We will have to port our own =
PCI-device-driver
which uses the DMA controller to make PCI-burst-transfers to host =
memory. Is
there a infrastructure I dont know of, which can help us in this task? =
E.g.: A
existing general purpose DMA Api which I only have to extend to the DMA
controller (I think it is a kind of Freescale Bestcomm) of our new CPU.

-Guenter



