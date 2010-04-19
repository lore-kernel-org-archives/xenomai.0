From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:45 +0200
Message-Id: <9e3e3f371930c5fb44b09ddb4fec3d96af94e670.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 05/25] RTDM: Deprecate open_rt, socket_rt,
	and close_rt
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Support for RTDM device creation and destruction in RT context will be
removed in the future. Start warning the users about this when loading
a driver that makes use of it.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h  |   12 +++++++++---
 ksrc/skins/rtdm/API.CHANGES |    2 ++
 ksrc/skins/rtdm/device.c    |   14 +++++++++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index d124157..d68f542 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -328,7 +328,8 @@ typedef int (*rtdm_rt_handler_t)(struct rtdm_dev_context *context,
 struct rtdm_operations {
 	/*! @name Common Operations
 	 * @{ */
-	/** Close handler for real-time contexts (optional) */
+	/** Close handler for real-time contexts (optional, deprecated)
+	 *  @deprecated Only use non-real-time close handler in new drivers. */
 	rtdm_close_handler_t close_rt;
 	/** Close handler for non-real-time contexts (required) */
 	rtdm_close_handler_t close_nrt;
@@ -468,14 +469,19 @@ struct rtdm_device {
 	int socket_type;
 
 	/** Named device instance creation for real-time contexts,
-	 *  optional if open_nrt is non-NULL, ignored for protocol devices */
+	 *  optional (but deprecated) if open_nrt is non-NULL, ignored for
+	 *  protocol devices
+	 *  @deprecated Only use non-real-time open handler in new drivers. */
 	rtdm_open_handler_t open_rt;
 	/** Named device instance creation for non-real-time contexts,
 	 *  optional if open_rt is non-NULL, ignored for protocol devices */
 	rtdm_open_handler_t open_nrt;
 
 	/** Protocol socket creation for real-time contexts,
-	 *  optional if socket_nrt is non-NULL, ignored for named devices */
+	 *  optional (but deprecated) if socket_nrt is non-NULL, ignored for
+	 *  named devices
+	 *  @deprecated Only use non-real-time socket creation handler in new
+	 *  drivers. */
 	rtdm_socket_handler_t socket_rt;
 	/** Protocol socket creation for non-real-time contexts,
 	 *  optional if socket_rt is non-NULL, ignored for named devices */
diff --git a/ksrc/skins/rtdm/API.CHANGES b/ksrc/skins/rtdm/API.CHANGES
index 84487f7..64a4b38 100644
--- a/ksrc/skins/rtdm/API.CHANGES
+++ b/ksrc/skins/rtdm/API.CHANGES
@@ -4,6 +4,8 @@ Scheduled modifications (unsorted):
  o Threaded IRQ handlers.
  o Support for deferring IRQ line re-enabling from handler to thread context.
  o Support for user-space drivers.
+ o Removal of open_rt, socket_rt, and close_rt, ie. support for device
+   creation and destruction in RT context.
 
 Revision 8:
  o Added rtdm_rt_capable.
diff --git a/ksrc/skins/rtdm/device.c b/ksrc/skins/rtdm/device.c
index e927ce7..e229932 100644
--- a/ksrc/skins/rtdm/device.c
+++ b/ksrc/skins/rtdm/device.c
@@ -219,6 +219,10 @@ int rtdm_dev_register(struct rtdm_device *device)
 		XENO_ASSERT(RTDM, ANY_HANDLER(*device, open),
 			    xnlogerr("RTDM: missing open handler\n");
 			    return -EINVAL;);
+		if (device->open_rt &&
+		    device->socket_rt != (void *)rtdm_no_support)
+			xnlogerr("RTDM: RT open handler is deprecated, "
+				 "driver requires update.\n");
 		SET_DEFAULT_OP_IF_NULL(*device, open);
 		SET_DEFAULT_OP(*device, socket);
 		break;
@@ -228,6 +232,10 @@ int rtdm_dev_register(struct rtdm_device *device)
 		XENO_ASSERT(RTDM, ANY_HANDLER(*device, socket),
 			    xnlogerr("RTDM: missing socket handler\n");
 			    return -EINVAL;);
+		if (device->socket_rt &&
+		    device->socket_rt != (void *)rtdm_no_support)
+			xnlogerr("RTDM: RT socket creation handler is "
+				 "deprecated, driver requires update.\n");
 		SET_DEFAULT_OP_IF_NULL(*device, socket);
 		SET_DEFAULT_OP(*device, open);
 		break;
@@ -242,7 +250,11 @@ int rtdm_dev_register(struct rtdm_device *device)
 		xnlogerr("RTDM: missing non-RT close handler\n");
 		return -EINVAL;
 	}
-	if (!device->ops.close_rt)
+	if (device->ops.close_rt &&
+	    device->ops.close_rt != (void *)rtdm_no_support)
+		xnlogerr("RTDM: RT close handler is deprecated, driver "
+			 "requires update.\n");
+	else
 		device->ops.close_rt = (void *)rtdm_no_support;
 
 	SET_DEFAULT_OP_IF_NULL(device->ops, ioctl);
-- 
1.6.0.2


