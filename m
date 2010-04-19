From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:42 +0200
Message-Id: <c6fc15b891bca9854ca9e6f8f7d07960bfcec6a2.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 02/25] RTDM: Add rtdm_rt_capable() service
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This adds rtdm_rt_capable(), a function that can be used by drivers to
detect callers that could issue a service request also from the
(typically preferred) real-time context. If that is the case, the driver
can trigger a restart of the request if the current context is not
real-time.

CC: Philippe Gerum <rpm@xenomai.org>
CC: Alexis Berlemont <berlemont.hauw@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h |    6 ++++++
 ksrc/skins/rtdm/drvlib.c   |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 0fc1496..d124157 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
 {
 	return (rthal_current_domain != rthal_root_domain);
 }
+
+static inline int rtdm_rt_capable(void)
+{
+	return (!xnpod_root_p() || xnshadow_thread(current) != NULL);
+}
+
 #endif /* !DOXYGEN_CPP */
 
 int rtdm_exec_in_rt(struct rtdm_dev_context *context,
diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 3b04493..6e26501 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -2341,6 +2341,31 @@ int rtdm_strncpy_from_user(rtdm_user_info_t *user_info, char *dst,
  */
 int rtdm_in_rt_context(void);
 
+/**
+ * Test if the caller is capable of running in real-time context
+ *
+ * @return Non-zero is returned if the caller is able to execute in real-time
+ * context (independent of its current execution mode), 0 otherwise.
+ *
+ * @note This function can be used by drivers that provide different
+ * implementations for the same service depending on the execution mode of
+ * the caller. If a caller requests such a service in non-real-time context
+ * but is capable of running in real-time as well, it might be appropriate
+ * for the driver to reject the request via -ENOSYS so that RTDM can switch
+ * the caller and restart the request in real-time context.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: never.
+ */
+int rtdm_rt_capable(void);
+
 #endif /* DOXYGEN_CPP */
 
 /** @} Utility Services */
-- 
1.6.0.2


