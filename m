From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:28 +0200
Message-Id: <cd312c55d8718d09cc73811bd1f714fdd79715d5.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 04/24] Revert "rtdm: tag syscalls as
	conforming"
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <berlemont.hauw@domain.hid>

From: Jan Kiszka <jan.kiszka@domain.hid>

This reverts commit 13bfdd477ab880499d2e8f3b82c49ef4d2cccff0. We better
let the driver trigger the confoming switch once it detects such a case
by using the new service rtdm_rt_capable(). Always being comforming
caused regressions for existing designs.

CC: Philippe Gerum <rpm@xenomai.org>
CC: Alexis Berlemont <berlemont.hauw@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/syscall.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ksrc/skins/rtdm/syscall.c b/ksrc/skins/rtdm/syscall.c
index d869887..80785ab 100644
--- a/ksrc/skins/rtdm/syscall.c
+++ b/ksrc/skins/rtdm/syscall.c
@@ -154,14 +154,14 @@ static xnsysent_t __systab[] = {
 	[__rtdm_close] =
 	    {sys_rtdm_close, __xn_exec_current | __xn_exec_adaptive},
 	[__rtdm_ioctl] =
-	    {sys_rtdm_ioctl, __xn_exec_conforming | __xn_exec_adaptive},
-	[__rtdm_read] = {sys_rtdm_read, __xn_exec_conforming | __xn_exec_adaptive},
+	    {sys_rtdm_ioctl, __xn_exec_current | __xn_exec_adaptive},
+	[__rtdm_read] = {sys_rtdm_read, __xn_exec_current | __xn_exec_adaptive},
 	[__rtdm_write] =
-	    {sys_rtdm_write, __xn_exec_conforming | __xn_exec_adaptive},
+	    {sys_rtdm_write, __xn_exec_current | __xn_exec_adaptive},
 	[__rtdm_recvmsg] =
-	    {sys_rtdm_recvmsg, __xn_exec_conforming | __xn_exec_adaptive},
+	    {sys_rtdm_recvmsg, __xn_exec_current | __xn_exec_adaptive},
 	[__rtdm_sendmsg] =
-	    {sys_rtdm_sendmsg, __xn_exec_conforming | __xn_exec_adaptive},
+	    {sys_rtdm_sendmsg, __xn_exec_current | __xn_exec_adaptive},
 };
 
 static struct xnskin_props __props = {
-- 
1.6.0.2


