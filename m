From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:44 +0200
Message-Id: <f11f7b041b6755301d2e710c21c506ded5715f0b.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 20/24] RTDM: Document device close
	procedure
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

Interating over the close handler when it returns -EAGAIN or in case a
pending reference to the device context exists is RTDM practice since
day one. Documenting this is seriously overdue.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 3f79abc..bd8a9d0 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -193,11 +193,18 @@ typedef int (*rtdm_socket_handler_t)(struct rtdm_dev_context *context,
  *
  * @param[in] context Context structure associated with opened device instance
  * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
+ * NULL if kernel mode or deferred user mode call
  *
  * @return 0 on success. On failure return either -ENOSYS, to request that
  * this handler be called again from the opposite realtime/non-realtime
- * context, or another negative error code.
+ * context, -EAGAIN to request a recall after a grace period, or a valid
+ * negative error code according to IEEE Std 1003.1.
+ *
+ * @note Drivers must be prepared for that case that the close handler is
+ * invoked more than once per open context (even if the handler already
+ * completed an earlier run successfully). The driver has to avoid releasing
+ * resources twice as well as returning false errors on successive close
+ * invocations.
  *
  * @see @c close() in IEEE Std 1003.1,
  * http://www.opengroup.org/onlinepubs/009695399 */
-- 
1.6.0.2


