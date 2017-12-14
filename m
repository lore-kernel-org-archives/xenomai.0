From: MINIER Bertrand <Bertrand.MINIER@sercel.com>
Date: Thu, 14 Dec 2017 11:23:19 +0000
Message-ID: <df27493b419a4ff4a603ddc503201523@NANS01204.it.intra.sercel.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Writing to UDD driver through mapped memory cause
 secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I implemented an UDD driver for a SOC IP on my Xilinx Ultrascale ZCU102 boa=
rd.
The arch is arm64 so I'm using Xenomai from the next branch.

When I try to write to the memory mapped from the user space side, Xenomai =
switches to secondary mode.

I activated the SIGDEBUG and attached an handler to point the origin and th=
e reason of this secondary mode switch.
The result of sigdebug_reason(siginfo) is SIGDEBUG_MIGRATE_FAULT.

I'm using mmap with the following attributes:
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fpgaMemfd, 0);

The file descriptor is opened with O_RDWR flag.

What is strange is that memory write effectively works but the SIGDEBUG_MIG=
RATE_FAULT is triggered. Reading the physical driver memory with devmem ret=
urns the written value.

Does anyone would have any idea about the origin of the issue ?

Thanks,

Bertrand Minier


This e-mail and any accompanying attachments are confidential. If you are n=
ot the intended recipient, you must not review, disclose, copy, distribute =
or use this e-mail; please delete it from your system and notify the sender=
 immediately.
