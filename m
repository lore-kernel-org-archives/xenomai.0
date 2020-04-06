Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Mon, 06 Apr 2020 09:55:20 +0200
Subject: =?utf-8?q?=5BPATCH=5D?= RTNet builtin kernel - Fix IP protocols
Message-ID: <3c02-5e8ae080-3-1bdc25c0@140723114>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

The link order of IP protocols does not allow to do UDP/TCP over IP wit=
h RTNet builtin as protocol list gets zeroed by af=5Finet when initiali=
zing

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/net/stack/ipv4/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/Makefile b/kernel/drivers/ne=
t/stack/ipv4/Makefile
index f0fcd36..7d45d23 100644
--- a/kernel/drivers/net/stack/ipv4/Makefile
+++ b/kernel/drivers/net/stack/ipv4/Makefile
@@ -1,9 +1,5 @@
 ccflags-y +=3D -Idrivers/xenomai/net/stack/include
 
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4=5FUDP) +=3D udp/
-
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4=5FTCP) +=3D tcp/
-
 obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4) +=3D rtipv4.o
 
 rtipv4-y :=3D \
@@ -16,4 +12,8 @@ rtipv4-y :=3D \
 	ip=5Foutput.o \
 	ip=5Ffragment.o
 
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4=5FUDP) +=3D udp/
+
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4=5FTCP) +=3D tcp/
+
 rtipv4-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4=5FICMP) +=3D icmp.o
-- 
2.1.4


