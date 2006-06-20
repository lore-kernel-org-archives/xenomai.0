Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jun 2006 11:21:52 +0200
Message-ID: <923F5E294B7B194EA41B7B11DAE5330B1A9F3990@domain.hid>
From: "Merilainen, Jussi \(GE Healthcare\)" <jussi.merilainen@domain.hid>
Subject: [Xenomai-core] User-space DMA transfer and I/O access from Xenomai
	API
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

=20

I'm porting a PCI driver for a custom board from VxWorks to =
Xenomai/Linux. My goal is to keep the driver as much as possible in =
user-space. Implementing the HW interrupt handler should be quite =
straight forward as presented in 'Writing user-space device drivers' in =
Native-API-Tour manual.
My concern is the PCI DMA transfer. Does the Xenomai API provide any =
support for this in user-space? Does anyone have experience on this =
subject?
Another thing is the Device I/O handling from user-space. Simple =
question: how do I perform read/write operations? In VxWorks, I have for =
example following function for reading an I/O register of the board:
=20
#include <vxworks.h>
#include <sysLib.h>
#include <intLib.h>
#include <taskLib.h>

Uint8 CIo::readIoMaskUint8(Uint32 addr, Uint8 mask)
{
    Uint8 data =3D 0;
    int intKey;
   =20
    // Lock interrupts
    intKey =3D intLock();
   =20
    // Read data
    data =3D sysInByte((int)addr);
    data =3D (data & mask);
   =20
    // Unlock interrupt
    intUnlock(intKey);
   =20
    return data;
}
=20
Thanks in advance for any support,

Jussi Meril=E4inen


