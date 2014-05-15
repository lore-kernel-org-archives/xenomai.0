From: "Poole Jr, Donald R." <donald.poole@swri.org>
Date: Thu, 15 May 2014 13:23:08 +0000
Message-ID: <CF9A29EB.3436%donald.poole@swri.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  v2.6.3 ARM I-Pipe Patch Kernel Version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

All,

I=92m using the latest version of Xenomai (v2.6.3) to path the HardKernel O=
DROID-U3 kernel, but I was wondering which 3.8.13 version of the kernel the=
 I-Pipe patch was created from. Specifically, which sub-minor version of th=
e 3.8.13 kernel (e.g. 3.8.13.1, 3.8.13.2, etc.)   Currently, the ODROID-U3 =
kernel is at version 3.8.13.21, but the current patch, ipipe-core-3.8.13-ar=
m-3.patch, does not patch against the 3.8.13.21 kernel.

I realize from earlier discussions regarding this SoC (Samsung Exynos 4412)=
 that Xenomai does not currently support this, so my goal is to create a po=
rt that does. My plan was to try and get the I-pipe patch able to patch my =
kernel, and then go back through the porting guide to make sure all of the =
timers, clocks, interrupts as taken care of for the Cortex-A9 case.  Is thi=
s a good approach?

Donald R. Poole, Jr.
Research Engineer
Voice: 210.522.3131 | Fax: 210.522.4931
Tactical Networks & Communications (tacticalnetworks.swri.org)
Southwest Research Institute (SwRI)

