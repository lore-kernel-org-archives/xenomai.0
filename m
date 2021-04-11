From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 1/4] drivers/can/peak_canfd: Fix building out-of-tree
Date: Sun, 11 Apr 2021 09:54:18 +0200
Message-Id: <3e641de2fffe5690b8888f329c7941620acc2ce1.1618127660.git.jan.kiszka@web.de>
In-Reply-To: <cover.1618127660.git.jan.kiszka@web.de>
References: <cover.1618127660.git.jan.kiszka@web.de>
MIME-Version: 1.0
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/can/peak_canfd/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/can/peak_canfd/Makefile b/kernel/drivers/can/p=
eak_canfd/Makefile
index 22670a9c46..f56f451562 100644
=2D-- a/kernel/drivers/can/peak_canfd/Makefile
+++ b/kernel/drivers/can/peak_canfd/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PEAK-System CAN-FD IP module drivers
 #
-ccflags-y +=3D -Idrivers/xenomai/can
+ccflags-y +=3D -I$(srctree)/drivers/xenomai/can
+
 obj-$(CONFIG_XENO_DRIVERS_CAN_PEAK_CANFD) +=3D xeno_can_peak_pciefd.o
+
 xeno_can_peak_pciefd-y :=3D rtcan_peak_pciefd.o rtcan_peak_canfd.o
=2D-
2.26.2


