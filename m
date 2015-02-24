From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Tue, 24 Feb 2015 13:08:00 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342902FDB@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Wrong email address and I understand your reply not correctly you are right=
 -> sorry.

Ok, so now I changed the flags to H_SINGLE | H_SHARED | H_DMA | H_NONCACHED=
. (it is possible? DMA + NONCACHED)

By the way, we have 3 shm areas:
2 of them was created from the user space application with the flags: H_SIN=
GLE | H_SHARED | H_NONCACHED
1 of them created from the kernel driver with : H_SINGLE | H_SHARED | H_DMA=
 (contiguous memory for dma)

I spend my time to check the situation, here my notice:

------
FLAGS: H_SINGLE | H_SHARED | H_DMA
shmMu_initialize: Open or create SHM "SLINK4" with 256 bytes header and 368=
64 bytes data.
createNewHeap: FLAGS_: 0x0700
createNewHeap: Heap SLINK4 (Id =3D 0x9f0f05c6, size=3D37120, flags=3D0x0000=
0700, address: f57f0c00) successfully created.
allocateHeap: +RTAPI+ rt_heap_alloc( shm =3D "SLINK4" ) success. Shm-area i=
s at c0051000
rtapi_shmInitialize: shm-area SLINK4 (id =3D 0x9f0f05c6) allocated at c0051=
000 size =3D 37120
SM. Shared Memory Area SLINK4 at c0051000

Ok, the kernel driver creates shm with the name SLINK4 but the user space s=
ide doesn't see it:

rt_heap_bind(shmName=3DSLINK4) failed. Error=3D-11 -> EWOULDBLOCK
SHM area (Name SLINK4, Id 0x9f0f05c6)  at (nil) is INVALID!!!

But the Shm areas that was created from the user space application for hers=
elf works fine.
Only the Flags are different:

shmMu_initialize: Open or create SHM "GLOBAL" with 256 bytes header and 104=
8576 bytes data.
createNewHeap: FLAGS: 0x0e00
createNewHeap: Heap GLOBAL (Id =3D 0x5e8b9ffb, size=3D1048832, flags=3D0x00=
000e00, address: f5540800) successfully created.
allocateHeap: +RTAPI+ rt_heap_alloc( shm =3D "GLOBAL" ) success. Shm-area i=
s at f873d000

rt_heap_bind(shmName=3DGLOBAL) success. RT_HEAP =3D 0x9ade0f0, HEAP->area=
=3D 0xf873c000.
( shm =3D "GLOBAL" ) success. Shm-area is at 0xb4e29000

----------
No lets start the kernel with "nopat"

FLAGS: H_SINGLE | H_SHARED | H_DMA and nopat in cmd line
shmMu_initialize: Open or create SHM "SLINK4" with 256 bytes header and 368=
64 bytes data.
createNewHeap: FLAGS: 0x0700
createNewHeap: Heap SLINK4 (Id =3D 0x9f0f05c6, size=3D37120, flags=3D0x0000=
0700, address: f650ac00) successfully created.
allocateHeap: +RTAPI+ rt_heap_alloc( shm =3D "SLINK4" ) success. Shm-area i=
s at c0051000 from f650ac00
rtapi_shmInitialize: shm-area SLINK4 (id =3D 0x9f0f05c6) allocated at c0051=
000 size =3D 37120
SM. Shared Memory Area SLINK4 at c0051000

Kerneldriver creates shm, and the userspace side can catch it.

rt_heap_bind(shmName=3DSLINK4) success. RT_HEAP =3D 0x8ac7ca8, HEAP->area=
=3D 0xf83b1000.
Shm-area is at 0xb4f90000 from 0x8ac7ca8

And the self created shm area is also good.

rt_heap_bind(shmName=3DGLOBAL) success. RT_HEAP =3D 0x8ba0070, HEAP->area=
=3D 0xf873c000.
( shm =3D "GLOBAL" ) success. Shm-area is at 0xb4e8e000

And the system works fine. I hope my notice are helpful.

With best regards,
Alexander H=E4nel-Baas
