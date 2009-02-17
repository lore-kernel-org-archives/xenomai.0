Date: Tue, 17 Feb 2009 09:47:50 +0100
From: "gwenhael.goavec" <gwen@domain.hid>
Message-ID: <20090217094750.46fb937d@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] I.MXL won't boot after patching with
 adeos-ipipe-2.6.27-arm-1.12-00.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I wish to test adeos and Xenomai on Arm9 I.MXL(MC9328) based
platform. I have already tested with linux-2.6.26.5 and
linux-2.6.24.3. Ipipe worked fine and the system has booted
correctly.
But with linux-2.6.27.13 and others 2.6.27.XX System
won't boot. The last message I have is :=20

BIOS> boot                                                                 =
   =20
## Booting kernel from Legacy Image at 100a0000 ...
   Image Name:   Linux-2.6.27.13                  =20
   Created:      2009-02-16  21:03:08 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1329204 Bytes =3D  1.3 MB             =20
   Load Address: 08008000              =20
   Entry Point:  08008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK                           =20
 =20
Starting kernel ...
                  =20
Uncompressing
Linux......................................................................=
.................
done, booting the kernel.

kernel_start() is never called.
=09
However, when CONFIG_IPIPE is not active, the system works
well!

Do someone have the same problem ?
What is the solution for having  linux-2.6.27 working
with this processor ?
Thank you very much.

Gwenha=EBl

