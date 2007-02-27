From: Paul <paul_c@domain.hid>
Date: Tue, 27 Feb 2007 21:06:30 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W1J5FHgsmxRyFS1"
Message-Id: <200702272106.30750.paul_c@domain.hid>
Subject: [Xenomai-core] x86_64 - missing header
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_W1J5FHgsmxRyFS1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi Philippe

Trying very hard to keep up with the rate of commits - The latest 1.0-05 pa=
tch=20
in conjuntion with r2264 fails with the error:

arch/x86_64/xenomai/hal.c:51:22: error: mach_ipi.h: No such file or directo=
ry
arch/x86_64/xenomai/hal.c: In function =E2=80=98rthal_broadcast_to_local_ti=
mers=E2=80=99:
arch/x86_64/xenomai/hal.c:104: warning: implicit declaration of=20
function =E2=80=98send_IPI_all=E2=80=99

Looks like mach_ipi.h is missing from my 2.6.19 tree, but the function is=20
declared in asm/mach_apic.h - The attached patch resolves this minor proble=
m.


Regards, Paul.




--Boundary-00=_W1J5FHgsmxRyFS1
Content-Type: text/x-diff;
  charset="utf-8";
  name="mach_ipi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mach_ipi.patch"

Index: ksrc/arch/x86_64/hal.c
===================================================================
--- ksrc/arch/x86_64/hal.c	(revision 2264)
+++ ksrc/arch/x86_64/hal.c	(working copy)
@@ -48,7 +48,7 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/xenomai/hal.h>
-#include <mach_ipi.h>
+#include <asm/mach_apic.h>
 #include <stdarg.h>
 
 static struct {

--Boundary-00=_W1J5FHgsmxRyFS1--

