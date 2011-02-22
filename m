Message-ID: <4D63A352.6020200@domain.hid>
Date: Tue, 22 Feb 2011 12:51:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] RTDM: Add missing stddef.h to API header
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Required for NULL.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/rtdm/rtdm.h b/include/rtdm/rtdm.h
index 1e6e41e..d907f08 100644
--- a/include/rtdm/rtdm.h
+++ b/include/rtdm/rtdm.h
@@ -61,6 +61,7 @@ typedef struct task_struct rtdm_user_info_t;
 #else /* !__KERNEL__ */

 #include <fcntl.h>
+#include <stddef.h>
 #include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-- 
1.7.1

