Message-ID: <4C6D23CE.1000606@domain.hid>
Date: Thu, 19 Aug 2010 14:30:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=dpYJNx+UzbjLy6Jpky2sscccUoVS5VZCAKMUv@domain.hid>	<4C6CF5BF.3060405@domain.hid>	<AANLkTi=MKjwGhRXVGQtPQML5dyO6wUB0edWngncZVqjP@mail.gmail.com>	<4C6CFD24.1080004@domain.hid>
	<AANLkTinCCejWZQhGOQd=CZ+yq482x0z4VCB5we+1mX9H@mail.gmail.com>
In-Reply-To: <AANLkTinCCejWZQhGOQd=CZ+yq482x0z4VCB5we+1mX9H@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] using floating point in rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Hi
>=20
> There are some differences with RTLinuxfree which are making things
> difficult ... .
>=20
> One last question (offtopic ?=C2=BF)....
>=20
> In user space I can use outb commands (using ioperm). For example :
>=20
>=20
> #define PORT_PARALLEL 0x378
>  outb(valor,PORT_PARALLEL);
>=20
> This can easily done for fixed addresses like the Parallel PORT. Althou=
gh it
> is not nice
> it is working fine (and it very useful during the porting process )
>=20
>=20
>=20
> This is more difficult for PCI devices which address is not fixed. In t=
he
> kernel space (RTDM) I could use "pci_find_device" commands to obtain th=
e
> base device base address.
>=20
> Once this is done I could do something like:
>=20
> outw(yint,PCI_BASE_ADRESS_1711 + PCI171x_DA0);
>=20
> If I Know the device base address   (PCI_BASE_ADRESS_1711), this comman=
ds
> would also work
> in the user space ?

Well probably. Addresses such as PCI_BASE_ADDRESS_1711 live in a
separate address space, only accessible with outb/inb, etc... Accessing
I/O mapped PCI registers is another story. One way to access them is to
use libpci (package pciutils) to obtain their physical address, then
mmap it using /dev/mem.

>=20
> How can I obtain the base address in the user space ?
>=20
> (As this is temporary, could I obtain the address in kernel space by a
> simple program and
> use it in the user space ?)

PCI_BASE_ADDRESS_1771 looks like a macro to me, so surely, it may be
used in user-space without "passing it".

The design we encourage to use is the same as for regular Linux
applications and drivers: driver code in kernel-space using the RTDM
skin, application code in user-space using the native or posix skin
(posix is most probably what you are looking for).

--=20
					    Gilles.


