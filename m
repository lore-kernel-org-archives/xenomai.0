Message-ID: <47ED364D.20405@domain.hid>
Date: Fri, 28 Mar 2008 19:17:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5329E61452676CFD7298D9BA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] RTDM: refactor and document select API
	extension
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5329E61452676CFD7298D9BA
Content-Type: multipart/mixed;
 boundary="------------030202040702070806010307"

This is a multi-part message in MIME format.
--------------030202040702070806010307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

unfortunately I missed (or more likely forgot) that the RTDM select=20
extensions already made it into stable and thus now also into a release. =

However, here is an overdue cleanup and documentation patch. Please=20
check if I happen to have written nonsense or broke something (only=20
compile-tested). Don't hesitate to suggest better names for types,=20
fields etc. if you find any.

Thanks,
Jan

--------------030202040702070806010307
Content-Type: text/x-patch;
 name="rtdm-select-refactor-and-document.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-select-refactor-and-document.patch"

---
 ChangeLog                      |    5 +
 doc/doxygen/Doxyfile-common.in |    1=20
 include/rtdm/rtdm.h            |    8 -
 include/rtdm/rtdm_driver.h     |   67 +++++++++++-----
 ksrc/skins/posix/syscall.c     |    7 -
 ksrc/skins/rtdm/core.c         |   84 +++++++++++++-------
 ksrc/skins/rtdm/drvlib.c       |  169 ++++++++++++++++++++++++++++------=
-------
 7 files changed, 234 insertions(+), 107 deletions(-)

Index: b/include/rtdm/rtdm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/rtdm/rtdm.h
+++ b/include/rtdm/rtdm.h
@@ -31,7 +31,7 @@
  * RT/non-RT systems like Xenomai. RTDM conforms to POSIX
  * semantics (IEEE Std 1003.1) where available and applicable.
  *
- * @b API @b Revision: 6
+ * @b API @b Revision: 7
  */
=20
 /*!
@@ -75,7 +75,7 @@ typedef struct task_struct rtdm_user_inf
  * @anchor api_versioning @name API Versioning
  * @{ */
 /** Common user and driver API version */
-#define RTDM_API_VER			6
+#define RTDM_API_VER			7
=20
 /** Minimum API revision compatible with the current release */
 #define RTDM_API_MIN_COMPAT_VER		6
@@ -247,10 +247,6 @@ ssize_t __rt_dev_recvmsg(rtdm_user_info_
 			 struct msghdr *msg, int flags);
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags);
-struct xnselector;
-int __rt_dev_select_bind(rtdm_user_info_t *user_info, int fd,
-			 struct xnselector *selector,
-			 unsigned type, unsigned index);
 #endif /* __KERNEL__ */
=20
 /* Define RTDM_NO_DEFAULT_USER_API to switch off the default rt_dev_xxx
Index: b/include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -4,6 +4,7 @@
  *
  * @note Copyright (C) 2005-2007 Jan Kiszka <jan.kiszka@domain.hid>
  * @note Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>
+ * @note Copyright (C) 2008 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
mail.com>
  *
  * Xenomai is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -49,6 +50,8 @@
 #endif
=20
 struct rtdm_dev_context;
+typedef struct xnselector rtdm_selector_t;
+enum rtdm_selecttype;
=20
 /*!
  * @addtogroup devregister
@@ -98,7 +101,7 @@ struct rtdm_dev_context;
  * @{
  */
 /** Version of struct rtdm_device */
-#define RTDM_DEVICE_STRUCT_VER		4
+#define RTDM_DEVICE_STRUCT_VER		5
=20
 /** Version of struct rtdm_dev_context */
 #define RTDM_CONTEXT_STRUCT_VER		3
@@ -187,6 +190,22 @@ typedef int (*rtdm_ioctl_handler_t)(stru
 				    unsigned int request, void __user *arg);
=20
 /**
+ * Select binding handler
+ *
+ * @param[in] context Context structure associated with opened device in=
stance
+ * @param[in,out] selector Object that shall be bound to the given event=

+ * @param[in] type Event type the selector is interested in
+ * @param[in] fd_index Opaque value, to be passed to rtdm_event_select_b=
ind or
+ * rtdm_sem_select_bind unmodfied
+ *
+ * @return 0 on success, otherwise negative error code
+ */
+typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *conte=
xt,
+					  rtdm_selector_t *selector,
+					  enum rtdm_selecttype type,
+					  unsigned fd_index);
+
+/**
  * Read handler
  *
  * @param[in] context Context structure associated with opened device in=
stance
@@ -262,11 +281,6 @@ typedef ssize_t (*rtdm_sendmsg_handler_t
=20
 typedef int (*rtdm_rt_handler_t)(struct rtdm_dev_context *context,
 				 rtdm_user_info_t *user_info, void *arg);
-
-typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *conte=
xt,
-					  struct xnselector *selector,
-					  unsigned type,
-					  unsigned index);
 /**
  * Device operations
  */
@@ -282,6 +296,9 @@ struct rtdm_operations {
 	rtdm_ioctl_handler_t ioctl_rt;
 	/** IOCTL from non-real-time context (optional) */
 	rtdm_ioctl_handler_t ioctl_nrt;
+
+	/** Select binding handler for any context (optional) */
+	rtdm_select_bind_handler_t select_bind;
 	/** @} Common Operations */
=20
 	/*! @name Stream-Oriented Device Operations
@@ -309,8 +326,6 @@ struct rtdm_operations {
 	/** Transmit message handler for non-real-time context (optional) */
 	rtdm_sendmsg_handler_t sendmsg_nrt;
 	/** @} Message-Oriented Device Operations */
-
-	rtdm_select_bind_handler_t select_bind;
 };
=20
 struct rtdm_devctx_reserved {
@@ -495,6 +510,26 @@ static inline nanosecs_abs_t rtdm_clock_
  */
=20
 /*!
+ * @anchor RTDM_SELECTTYPE_xxx   @name RTDM_SELECTTYPE_xxx
+ * Event types select can bind to
+ * @{
+ */
+enum rtdm_selecttype {
+	/** Select input data availability events */
+	RTDM_SELECTTYPE_READ =3D XNSELECT_READ,
+
+	/** Select ouput buffer availability events */
+	RTDM_SELECTTYPE_WRITE =3D XNSELECT_WRITE,
+
+	/** Select exceptional events */
+	RTDM_SELECTTYPE_EXCEPT =3D XNSELECT_EXCEPT
+};
+/** @} RTDM_SELECTTYPE_xxx */
+
+int rtdm_select_bind(int fd, rtdm_selector_t *selector,
+		     enum rtdm_selecttype type, unsigned fd_index);
+
+/*!
  * @name Global Lock across Scheduler Invocation
  * @{
  */
@@ -1016,12 +1051,10 @@ typedef struct {
=20
 void rtdm_event_init(rtdm_event_t *event, unsigned long pending);
 #ifdef CONFIG_XENO_OPT_RTDM_SELECT
-int rtdm_event_select_bind(rtdm_event_t *event,
-			   struct xnselector *selector,
-			   unsigned type,
-			   unsigned bit_index);
+int rtdm_event_select_bind(rtdm_event_t *event, rtdm_selector_t *selecto=
r,
+			   enum rtdm_selecttype type, unsigned fd_index);
 #else /* !CONFIG_XENO_OPT_RTDM_SELECT */
-#define rtdm_event_select_bind(e, s, t, b) ({ -EBADF; })
+#define rtdm_event_select_bind(e, s, t, i) ({ -EBADF; })
 #endif /* !CONFIG_XENO_OPT_RTDM_SELECT */
 int rtdm_event_wait(rtdm_event_t *event);
 int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
@@ -1057,12 +1090,10 @@ typedef struct {
=20
 void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
 #ifdef CONFIG_XENO_OPT_RTDM_SELECT
-int rtdm_sem_select_bind(rtdm_sem_t *sem,
-			 struct xnselector *selector,
-			 unsigned type,
-			 unsigned bit_index);
+int rtdm_sem_select_bind(rtdm_sem_t *sem, rtdm_selector_t *selector,
+			 enum rtdm_selecttype type, unsigned fd_index);
 #else /* !CONFIG_XENO_OPT_RTDM_SELECT */
-#define rtdm_sem_select_bind(s, se, t, b) ({ -EBADF; })
+#define rtdm_sem_select_bind(s, se, t, i) ({ -EBADF; })
 #endif /* !CONFIG_XENO_OPT_RTDM_SELECT */
 int rtdm_sem_down(rtdm_sem_t *sem);
 int rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
Index: b/ksrc/skins/posix/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1922,11 +1922,10 @@ static int select_bind_one(struct xnsele
 	pse51_assoc_t *assoc;
 #if defined(CONFIG_XENO_SKIN_RTDM) || defined (CONFIG_XENO_SKIN_RTDM_MOD=
ULE)
 	const int rtdm_fd_start =3D FD_SETSIZE - RTDM_FD_MAX;
-=09
+
 	if (fd >=3D rtdm_fd_start)
-		return __rt_dev_select_bind(current,
-					    fd - rtdm_fd_start,
-					    selector, type, fd);
+		return rtdm_select_bind(fd - rtdm_fd_start,
+					selector, type, fd);
 #endif /* CONFIG_XENO_SKIN_RTDM */
=20
 	assoc =3D pse51_assoc_lookup(&pse51_queues()->uqds, fd);
Index: b/ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -294,34 +294,6 @@ err_out:
=20
 EXPORT_SYMBOL(__rt_dev_socket);
=20
-int __rt_dev_select_bind(rtdm_user_info_t *info, int fd,
-			 struct xnselector *selector,
-			 unsigned type, unsigned index)
-{
-	struct rtdm_dev_context *context;
-	struct rtdm_operations  *ops;
-	int ret;
-
-	context =3D rtdm_context_get(fd);
-
-	ret =3D -EBADF;
-	if (unlikely(!context))
-		goto err_out;
-
-	ops =3D context->ops;
-
-	ret =3D ops->select_bind(context, selector, type, index);
-
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
-
-	rtdm_context_unlock(context);
-
-  err_out:
-	return ret;
-}
-
-EXPORT_SYMBOL(__rt_dev_select_bind);
-
 int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
 {
 	struct rtdm_dev_context *context;
@@ -544,6 +516,62 @@ ssize_t __rt_dev_sendmsg(rtdm_user_info_
=20
 EXPORT_SYMBOL(__rt_dev_sendmsg);
=20
+/**
+ * @brief Bind a selector to specified event types of a given file descr=
iptor
+ * @internal
+ *
+ * This function is invoked by higher RTOS layers implementing select-li=
ke
+ * services. It shall not be called directly by RTDM drivers.
+ *
+ * @param[in] fd File descriptor to bind to
+ * @param[in,out] selector Selector object that shall be bound to the gi=
ven
+ * event
+ * @param[in] type Event type the caller is interested in
+ * @param[in] fd_index Index in the file descriptor set of the caller
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EBADF is returned if the file descriptor @a fd cannot be resolved.=

+ *
+ * - -EINVAL is returned if @a type or @a fd_index are invalid.
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
+int rtdm_select_bind(int fd, rtdm_selector_t *selector,
+		     enum rtdm_selecttype type, unsigned fd_index)
+{
+	struct rtdm_dev_context *context;
+	struct rtdm_operations  *ops;
+	int ret;
+
+	context =3D rtdm_context_get(fd);
+
+	ret =3D -EBADF;
+	if (unlikely(!context))
+		goto err_out;
+
+	ops =3D context->ops;
+
+	ret =3D ops->select_bind(context, selector, type, fd_index);
+
+	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+
+	rtdm_context_unlock(context);
+
+  err_out:
+	return ret;
+}
+
+EXPORT_SYMBOL(rtdm_select_bind);
+
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
=20
 /**
Index: b/ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -4,6 +4,7 @@
  *
  * @note Copyright (C) 2005-2007 Jan Kiszka <jan.kiszka@domain.hid>
  * @note Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>
+ * @note Copyright (C) 2008 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
mail.com>
  *
  * Xenomai is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -764,32 +765,6 @@ void rtdm_event_init(rtdm_event_t *event
=20
 EXPORT_SYMBOL(rtdm_event_init);
=20
-#ifdef CONFIG_XENO_OPT_RTDM_SELECT
-int rtdm_event_select_bind(rtdm_event_t *event,
-			   struct xnselector *selector,
-			   unsigned type,
-			   unsigned bit_index)
-{
-	struct xnselect_binding *binding;
-	int err;
-	spl_t s;
-
-	binding =3D xnmalloc(sizeof(*binding));
-	if (!binding)
-		return -ENOMEM;
-
-	xnlock_get_irqsave(&nklock, s);
-	err =3D xnselect_bind(&event->select_block,
-			    binding, selector, type,bit_index,
-			    xnsynch_test_flags(&event->synch_base,
-					       RTDM_EVENT_PENDING));
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
-}
-EXPORT_SYMBOL(rtdm_event_select_bind);
-#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
-
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy an event
@@ -1036,6 +1011,65 @@ void rtdm_event_clear(rtdm_event_t *even
 }
=20
 EXPORT_SYMBOL(rtdm_event_clear);
+
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+/**
+ * @brief Bind a selector to an event
+ *
+ * This functions binds the given selector to an event so that the forme=
r is
+ * notified when the event state changes. Typically the select binding h=
andler
+ * will invoke this service.
+ *
+ * @param[in,out] event Event handle as returned by rtdm_event_init()
+ * @param[in,out] selector Selector as passed to the select binding hand=
ler
+ * @param[in] type Type of the bound event as passed to the select bindi=
ng handler
+ * @param[in] fd_index File descriptor index as passed to the select bin=
ding
+ * handler
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EIDRM is returned if @a event has been destroyed.
+ *
+ * - -ENOMEM is returned if there is insufficient memory to establish th=
e
+ * dynamic binding.
+ *
+ * - -EINVAL is returned if @a type or @a fd_index are invalid.
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
+int rtdm_event_select_bind(rtdm_event_t *event, rtdm_selector_t *selecto=
r,
+			   enum rtdm_selecttype type, unsigned fd_index)
+{
+	struct xnselect_binding *binding;
+	int err;
+	spl_t s;
+
+	binding =3D xnmalloc(sizeof(*binding));
+	if (!binding)
+		return -ENOMEM;
+
+	xnlock_get_irqsave(&nklock, s);
+	if (unlikely(testbits(event->synch_base.status, RTDM_SYNCH_DELETED)))
+		err =3D -EIDRM;
+	else
+		err =3D xnselect_bind(&event->select_block,
+				    binding, selector, type, fd_index,
+				    xnsynch_test_flags(&event->synch_base,
+						       RTDM_EVENT_PENDING));
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+EXPORT_SYMBOL(rtdm_event_select_bind);
+#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
 /** @} */
=20
 /*!
@@ -1077,30 +1111,6 @@ void rtdm_sem_init(rtdm_sem_t *sem, unsi
=20
 EXPORT_SYMBOL(rtdm_sem_init);
=20
-#ifdef CONFIG_XENO_OPT_RTDM_SELECT
-int rtdm_sem_select_bind(rtdm_sem_t *sem,
-			 struct xnselector *selector,
-			 unsigned type,
-			 unsigned bit_index)
-{
-	struct xnselect_binding *binding;
-	int err;
-	spl_t s;
-
-	binding =3D xnmalloc(sizeof(*binding));
-	if (!binding)
-		return -ENOMEM;
-
-	xnlock_get_irqsave(&nklock, s);
-	err =3D xnselect_bind(&sem->select_block,
-			    binding, selector, type, bit_index, sem->value > 0);
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
-}
-EXPORT_SYMBOL(rtdm_sem_select_bind);
-#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
-
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a semaphore
@@ -1207,7 +1217,7 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
+	if (unlikely(testbits(sem->synch_base.status, RTDM_SYNCH_DELETED)))
 		err =3D -EIDRM;
 	else if (sem->value > 0) {
 		if(!--sem->value)
@@ -1284,6 +1294,63 @@ void rtdm_sem_up(rtdm_sem_t *sem)
 }
=20
 EXPORT_SYMBOL(rtdm_sem_up);
+
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+/**
+ * @brief Bind a selector to a semaphore
+ *
+ * This functions binds the given selector to the semaphore so that the =
former
+ * is notified when the semaphore state changes. Typically the select bi=
nding
+ * handler will invoke this service.
+ *
+ * @param[in,out] sem Semaphore handle as returned by rtdm_sem_init()
+ * @param[in,out] selector Selector as passed to the select binding hand=
ler
+ * @param[in] type Type of the bound event as passed to the select bindi=
ng handler
+ * @param[in] fd_index File descriptor index as passed to the select bin=
ding
+ * handler
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EIDRM is returned if @a sem has been destroyed.
+ *
+ * - -ENOMEM is returned if there is insufficient memory to establish th=
e
+ * dynamic binding.
+ *
+ * - -EINVAL is returned if @a type or @a fd_index are invalid.
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
+int rtdm_sem_select_bind(rtdm_sem_t *sem, rtdm_selector_t *selector,
+			 enum rtdm_selecttype type, unsigned fd_index)
+{
+	struct xnselect_binding *binding;
+	int err;
+	spl_t s;
+
+	binding =3D xnmalloc(sizeof(*binding));
+	if (!binding)
+		return -ENOMEM;
+
+	xnlock_get_irqsave(&nklock, s);
+	if (unlikely(testbits(sem->synch_base.status, RTDM_SYNCH_DELETED)))
+		err =3D -EIDRM;
+	else
+		err =3D xnselect_bind(&sem->select_block, binding, selector,
+				    type, fd_index, (sem->value > 0));
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+EXPORT_SYMBOL(rtdm_sem_select_bind);
+#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
 /** @} */
=20
 /*!
Index: b/doc/doxygen/Doxyfile-common.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/doc/doxygen/Doxyfile-common.in
+++ b/doc/doxygen/Doxyfile-common.in
@@ -691,6 +691,7 @@ PREDEFINED             =3D DOXYGEN_CPP \
         CONFIG_XENO_OPT_RTAI_FIFO \
         CONFIG_XENO_OPT_RTAI_SEM \
         CONFIG_XENO_OPT_RTAI_SHM \
+        CONFIG_XENO_OPT_RTDM_SELECT \
         CONFIG_GENERIC_CLOCKEVENTS
=20
 # If the MACRO_EXPANSION and EXPAND_ONLY_PREDEF tags are set to YES then=
=20
Index: b/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,8 @@
+2008-03-28  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/rtdm, ksrc/skins/rtdm: Refactor and document select API.
+	Finally increment API version.
+
 2008-03-24  Stephane Fillod  <stephane.fillod@domain.hid>
=20
 	* ksrc/skins/native/heap.c: Output oustanding number of heap

--------------030202040702070806010307--

--------------enig5329E61452676CFD7298D9BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH7TZNniDOoMHTA+kRAkYxAJ42RTbIrZrCDjsxNbTqJM6iHs5W7QCaAlv2
ob+fIf/dschEvGwKIZsV7LY=
=upB/
-----END PGP SIGNATURE-----

--------------enig5329E61452676CFD7298D9BA--

