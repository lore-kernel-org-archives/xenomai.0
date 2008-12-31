From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 31 Dec 2008 01:19:55 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rqrWJpAGTAd5694"
Message-Id: <200812310119.55867.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PATCH 1/2] RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

--Boundary-00=_rqrWJpAGTAd5694
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch 1: user-side code.

Alexis.

--Boundary-00=_rqrWJpAGTAd5694
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xenomai-rtdm-proposal_p1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xenomai-rtdm-proposal_p1.diff"

 Makefile.am |   15 +
 device.c    |  569 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drvlib.c    |  636 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 init.c      |    6 
 internal.h  |  119 +++++++++++
 wrappers.c  |   95 ++++++++
 wrappers.h  |   26 ++
 7 files changed, 1463 insertions(+), 3 deletions(-)

Index: src/skins/rtdm/Makefile.am
===================================================================
--- src/skins/rtdm/Makefile.am	(revision 4513)
+++ src/skins/rtdm/Makefile.am	(working copy)
@@ -1,4 +1,4 @@
-lib_LTLIBRARIES = librtdm.la
+lib_LTLIBRARIES = librtdm.la librtdm_user.la
 
 librtdm_la_LDFLAGS = -version-info 1:0:0 -lpthread
 
@@ -9,3 +9,16 @@
 librtdm_la_CPPFLAGS = \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
+
+librtdm_user_la_LDFLAGS = -version-info 1:0:0 -lpthread
+
+librtdm_user_la_SOURCES = \
+	init.c \
+	drvlib.c \
+	device.c \
+	wrappers.c \
+	wrappers.h
+
+librtdm_user_la_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
Index: src/skins/rtdm/device.c
===================================================================
--- src/skins/rtdm/device.c	(revision 0)
+++ src/skins/rtdm/device.c	(revision 0)
@@ -0,0 +1,569 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <string.h>
+#include <errno.h>
+
+#include <rtdm/rtdm.h>
+#include <rtdm/rtdm_driver.h>
+#include <rtdm/syscall.h>
+#include <asm-generic/bits/sigshadow.h>
+#include <asm-generic/bits/current.h>
+
+#include "internal.h"
+
+#define DEV_MAX_COUNT 16
+#define FD_MAX_COUNT 32
+#define MAP_MAX_COUNT 16
+
+#define SET_DEFAULT_OP(device, operation)				\
+	(device).operation##_rt  = (void *)rtdm_no_support;		\
+	(device).operation##_nrt = (void *)rtdm_no_support
+
+#define SET_DEFAULT_OP_IF_NULL(device, operation)			\
+	if (!(device).operation##_rt)					\
+		(device).operation##_rt = (void *)rtdm_no_support;	\
+	(device).operation##_nrt = (void *)rtdm_no_support
+
+struct map_entry {
+	unsigned long map_addr;
+	void *vm_private_data;
+	struct vm_operations_struct *vm_ops;
+};
+
+static atomic_tab_t reg_cxts = {
+	.count = FD_MAX_COUNT,
+	.elements = { [0 ... FD_MAX_COUNT - 1] = { {0}, NULL} }
+};
+
+static atomic_tab_t reg_devs = {
+	.count = DEV_MAX_COUNT,
+	.elements = { [0 ... DEV_MAX_COUNT - 1] = { {0}, NULL} }
+};
+
+static atomic_tab_t reg_maps = {
+	.count = MAP_MAX_COUNT,
+	.elements = { [0 ... DEV_MAX_COUNT - 1] = { {0}, NULL} }
+};
+
+int rtdm_no_support(void)
+{
+	return -ENOSYS;
+}
+
+int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
+				struct xnselector *selector,
+				unsigned type,
+				unsigned index)
+{
+	return -EBADF;
+}
+
+int rtdm_dev_register(struct rtdm_device *device)
+{
+	unsigned int idx = 0;
+	int err = 0;
+
+	if(device->struct_version != RTDM_DEVICE_STRUCT_VER)
+		return -EINVAL;
+
+	switch (device->device_flags & RTDM_DEVICE_TYPE_MASK) {
+	case RTDM_NAMED_DEVICE:
+		SET_DEFAULT_OP_IF_NULL(*device, open);
+		SET_DEFAULT_OP(*device, socket);
+		break;
+	case RTDM_PROTOCOL_DEVICE:
+		SET_DEFAULT_OP_IF_NULL(*device, socket);
+		SET_DEFAULT_OP(*device, open);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!device->ops.close_rt)
+		device->ops.close_rt = (void *)rtdm_no_support;
+
+	SET_DEFAULT_OP_IF_NULL(device->ops, ioctl);
+	SET_DEFAULT_OP_IF_NULL(device->ops, read);
+	SET_DEFAULT_OP_IF_NULL(device->ops, write);
+	SET_DEFAULT_OP_IF_NULL(device->ops, recvmsg);
+	SET_DEFAULT_OP_IF_NULL(device->ops, sendmsg);
+
+	device->ops.select_bind = rtdm_select_bind_no_support;
+
+	err = atab_try_add(&reg_devs, &idx);
+	if(err < 0)
+		return err;
+
+	return atab_do_add(&reg_devs, idx, (void *) device);
+}
+
+int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
+{
+	int i = 0, fnd = 0, err = -EINVAL;
+
+	do {
+
+		err = atab_lock(&reg_devs, i);
+		if(err < 0)
+			return err;
+
+		if(reg_devs.elements[i].element == (void *)device)
+			fnd = 1;
+
+		err = atab_unlock(&reg_devs, i);
+		if(err < 0)
+			return err;		
+
+	} while( fnd == 0 && ++i < DEV_MAX_COUNT);
+
+	err = atab_try_remove(&reg_devs, i);
+	if(err < 0)
+		return err;
+
+	reg_devs.elements[i].element = NULL;
+
+	err = atab_do_remove(&reg_devs, i);
+
+	return err;
+}
+
+int rt_dev_open(const char *path, int oflag, ...)
+{
+	struct rtdm_device *device;
+	struct rtdm_dev_context *context;
+	int i = 0, fnd = 0, err;
+	unsigned int idx;
+
+	do {
+
+		err = atab_lock(&reg_devs, i);
+		if(err < 0)
+			return err;
+
+		device = (struct rtdm_device *)reg_devs.elements[i].element;
+		if(strncmp(path, device->device_name, RTDM_MAX_DEVNAME_LEN) == 0)
+			fnd = 1;
+		
+		err = atab_unlock(&reg_devs, i);
+		if(err < 0)
+			return err;		
+
+	} while( fnd == 0 && ++i < DEV_MAX_COUNT);
+
+	if(fnd == 0)
+		return -ENOENT;
+
+	err = atab_lock(&reg_devs, i);
+	if(err < 0)
+		return err;
+
+	if((device->device_flags & RTDM_EXCLUSIVE) != 0 &&
+	   (xnarch_atomic_get(&reg_devs.elements[i].status) & 
+	    ~(__REGISTERED_ELT)) != 1)
+		return -EBUSY;
+
+	err = atab_try_add(&reg_cxts, &idx);
+	if(err < 0)
+		return err;
+	
+	context = rtdm_malloc(sizeof(struct rtdm_dev_context) + 
+			      device->context_size);
+	if(context == NULL)
+		return -ENOMEM;
+
+	context->device = device;
+	context->fd = idx;
+	context->ops = &device->ops;
+
+	err = device->open_rt(context, NULL, oflag);
+	if(err < 0)
+		goto out_open;
+
+	err = atab_do_add(&reg_cxts, idx, (void *) context);
+
+out_open:
+
+	if(err < 0)
+		rtdm_free(context);
+
+	return err;
+}
+
+int rt_dev_socket(int protocol_family, int socket_type, int protocol)
+{
+	struct rtdm_device *device;
+	struct rtdm_dev_context *context;
+	int i = 0, fnd = 0, err;
+	unsigned int idx;
+
+	do {
+
+		err = atab_lock(&reg_devs, i);
+		if(err < 0)
+			return err;
+
+		device = (struct rtdm_device *)reg_devs.elements[i].element;
+
+		if(protocol_family == device->protocol_family && 
+		   socket_type == device->socket_type)
+			fnd = 1;
+		
+		err = atab_unlock(&reg_devs, i);
+		if(err < 0)
+			return err;		
+
+	} while(fnd == 0 && ++i < DEV_MAX_COUNT);
+
+	if(fnd == 0)
+		return -ENOENT;
+
+	err = atab_lock(&reg_devs, i);
+	if(err < 0)
+		return err;
+
+	if((device->device_flags & RTDM_EXCLUSIVE) != 0 &&
+	   (xnarch_atomic_get(&reg_devs.elements[i].status) & 
+	    ~(__REGISTERED_ELT)) != 1)
+		return -EBUSY;
+
+	err = atab_try_add(&reg_cxts, &idx);
+	if(err < 0)
+		return err;
+	
+	context = rtdm_malloc(sizeof(struct rtdm_dev_context) + 
+			      device->context_size);
+	if(context == NULL)
+		return -ENOMEM;
+
+	context->device = device;
+	context->fd = idx;
+	context->ops = &device->ops;
+
+	err = device->socket_rt(context, NULL, protocol);
+	if(err < 0)
+		goto out_socket;
+
+	err = atab_do_add(&reg_cxts, idx, (void *) context);
+
+out_socket:
+
+	if(err < 0)
+		rtdm_free(context);
+
+	return err;
+
+}
+
+int rt_dev_close(int fd)
+{
+	struct rtdm_dev_context *context;
+	int i = 0, fnd = 0, err;
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_try_remove(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+	
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL)
+		return -EINVAL;
+
+	/* Call the close handler */
+	err = context->ops->close_rt(context, NULL);
+	if(err < 0)
+		goto out_close;
+
+	reg_cxts.elements[fd].element = NULL;
+
+	/* Look for the device in the tab... */
+	do {
+
+		err = atab_lock(&reg_devs, i);
+		if(err < 0)
+			return err;
+
+		if(context->device == reg_devs.elements[i].element)
+			fnd = 1;
+		
+		err = atab_unlock(&reg_devs, i);
+		if(err < 0)
+			return err;		
+
+	} while( fnd == 0 && ++i < DEV_MAX_COUNT);
+
+	if(fnd == 0)
+		return -ENODEV;
+
+	/* ...and unlock it */
+	atab_unlock(&reg_devs, i);
+
+	err = atab_do_remove(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	rtdm_free(context);
+
+out_close:
+
+	return err;
+}
+
+int rt_dev_ioctl(int fd, int request, ...)
+{
+	struct rtdm_dev_context *context;
+	va_list ap;
+	void *arg;
+	int err;
+
+	va_start(ap, request);
+	arg = va_arg(ap, void*);
+	va_end(ap);
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_lock(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL) {
+		err = -EINVAL;
+		goto out_ioctl;
+	}
+
+	err = context->ops->ioctl_rt(context, NULL, request, arg);
+
+out_ioctl:	
+	atab_unlock(&reg_cxts, fd);
+
+	return err;
+}
+ssize_t rt_dev_read(int fd, void *buf, size_t nbyte)
+{
+	struct rtdm_dev_context *context;
+	int err;
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_lock(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL) {
+		err = -EINVAL;
+		goto out_read;
+	}
+
+	err = context->ops->read_rt(context, NULL, buf, nbyte);
+
+out_read:
+	atab_unlock(&reg_cxts, fd);
+
+	return err;
+}
+
+ssize_t rt_dev_write(int fd, const void *buf, size_t nbyte)
+{
+	struct rtdm_dev_context *context;
+	int err;
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_lock(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL) {
+		err = -EINVAL;
+		goto out_write;
+	}
+
+	err = context->ops->write_rt(context, NULL, buf, nbyte);
+
+out_write:
+	atab_unlock(&reg_cxts, fd);
+
+	return err;
+}
+
+ssize_t rt_dev_recvmsg(int fd, struct msghdr *msg, int flags)
+{
+	struct rtdm_dev_context *context;
+	int err;
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_lock(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL) {
+		err = -EINVAL;
+		goto out_recvmsg;
+	}
+
+	err = context->ops->recvmsg_rt(context, NULL, msg, flags);
+
+out_recvmsg:
+	atab_unlock(&reg_cxts, fd);
+
+	return err;
+
+}
+
+ssize_t rt_dev_sendmsg(int fd, const struct msghdr *msg, int flags)
+{
+	struct rtdm_dev_context *context;
+	int err;
+
+	/* Basic checkings on the fd argument */
+	if(fd >= FD_MAX_COUNT)
+		return -EINVAL;
+
+	err = atab_lock(&reg_cxts, fd);
+	if(err < 0)
+		return err;
+
+	context = reg_cxts.elements[fd].element;
+	if(context == NULL) {
+		err = -EINVAL;
+		goto out_sendmsg;
+	}
+
+	err = context->ops->sendmsg_rt(context, NULL, msg, flags);
+
+out_sendmsg:
+	atab_unlock(&reg_cxts, fd);
+
+	return err;
+
+}
+
+ssize_t rt_dev_recvfrom(int fd, void *buf, size_t len, int flags,
+                        struct sockaddr *from,
+                        socklen_t *fromlen)
+{
+	struct iovec iov = { buf, len };
+	struct msghdr msg = {
+		from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0
+	};
+	int err;
+
+	err = rt_dev_recvmsg(fd, &msg, flags);
+
+	if (from && err >= 0)
+		*fromlen = msg.msg_namelen;
+
+	return err;
+}
+
+int __rtdm_map_to_user(void *src_addr, 
+		       void **pptr,
+		       struct vm_operations_struct *vm_ops, void *vm_private_data)
+{	
+	struct map_entry *entry;
+	struct vm_area_struct vma = { vm_private_data };
+	unsigned int idx;
+	int err;
+
+	entry = rtdm_malloc(sizeof(struct map_entry));
+	if(entry == NULL)
+		return -ENOMEM;
+
+	*pptr = src_addr;
+
+	entry->map_addr = (unsigned long) src_addr;
+	entry->vm_private_data = vm_private_data;
+	entry->vm_ops = vm_ops;
+
+	err = atab_try_add(&reg_maps, &idx);
+	if(err < 0)
+		goto out_map;
+
+	err = atab_do_add(&reg_maps, idx, (void *)entry);
+	if(err < 0)
+		goto out_map;
+
+	entry->vm_ops->open(&vma);
+
+out_map:
+	if(err < 0)
+		rtdm_free(entry);
+	
+	return err;
+}
+
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len)
+{
+	struct map_entry *entry;
+	struct vm_area_struct vma;
+	int i = 0, fnd = 0, err;
+
+	do {
+		err = atab_lock(&reg_maps, i);
+		if(err < 0)
+			return err;
+
+		entry = (struct map_entry *)reg_maps.elements[i].element;
+		if(entry->map_addr == (unsigned long)ptr)
+			fnd = 1;
+
+		err = atab_unlock(&reg_devs, i);
+		if(err < 0)
+			return err;		
+
+	} while(fnd == 0 && ++i < MAP_MAX_COUNT);
+
+	if(fnd == 0)
+		return -EINVAL;
+
+	err = atab_try_remove(&reg_maps, i);
+	if(err < 0)
+		return err;
+
+	err = atab_do_remove(&reg_maps, i);
+	if(err < 0)
+		return err;
+
+	vma.vm_private_data = entry->vm_private_data;
+	entry->vm_ops->close(&vma);
+
+	rtdm_free(entry);
+
+	return err;
+}
Index: src/skins/rtdm/drvlib.c
===================================================================
--- src/skins/rtdm/drvlib.c	(revision 0)
+++ src/skins/rtdm/drvlib.c	(revision 0)
@@ -0,0 +1,636 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+
+#include <nucleus/heap.h>
+#include <rtdm/rtdm.h>
+#include <rtdm/rtdm_driver.h>
+#include <rtdm/syscall.h>
+#include <asm-generic/bits/sigshadow.h>
+#include <asm-generic/bits/current.h>
+
+#include "wrappers.h"
+
+#ifdef HAVE___THREAD
+__thread rtdm_task_t __rtdm_current __attribute__ ((tls_model ("initial-exec"))) = {
+	.opaque = XN_NO_HANDLE,
+	.opaque2 = 0
+};
+#else /* !HAVE___THREAD */
+extern pthread_key_t __rtdm_tskey;
+#endif /* !HAVE___THREAD */
+
+
+extern int __rtdm_muxid;
+
+nanosecs_abs_t rtdm_clock_read(void)
+{
+	nanosecs_abs_t clock = 0;
+
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_clock_read, &clock);
+
+	return clock;
+}
+ 
+nanosecs_abs_t rtdm_clock_read_monotonic(void)
+{
+	nanosecs_abs_t clock = 0;
+
+	XENOMAI_SKINCALL1(__rtdm_muxid, 
+			  __rtdm_clock_read_monotonic, &clock);
+
+	return clock;
+}
+
+struct rtdm_task_iargs {
+	rtdm_task_t *task;
+	const char *name;
+	int prio;
+	nanosecs_rel_t period;
+	rtdm_task_proc_t task_proc;
+	void *arg;
+	xncompletion_t *completionp;
+};
+
+static void *__rtdm_task_trampoline(void *cookie)
+{
+	struct rtdm_task_iargs *iargs = (struct rtdm_task_iargs *)cookie;	
+	struct sched_param param;
+	rtdm_task_proc_t task_proc;
+	void *arg;
+	struct rtdm_arg_bulk bulk;
+	int err;
+
+	bulk.a1 = (u_long) iargs->task;
+	bulk.a2 = (u_long) iargs->name;
+	bulk.a3 = (u_long) iargs->prio;
+	bulk.a4 = (u_long) &iargs->period;
+	bulk.a5 = (u_long) iargs->completionp;
+	bulk.a6 = (u_long) xeno_init_current_mode();
+	bulk.a7 = (u_long) pthread_self();
+
+	if(bulk.a6 == 0) {
+		err = -ENOMEM;
+		goto out_task_trampoline;
+	}
+
+	if(iargs->prio > 0) {
+		/*
+		 * Re-apply sched params here as some libpthread
+		 * implementations fail doing this via pthread_create.
+		 */
+		memset(&param, 0, sizeof(param));
+		param.sched_priority = iargs->prio;
+		__real_pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+	}
+
+	/* TODO: does rtdm_task_destroy requires asynchronous cancellation ? */
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+	
+	sigshadow_install_once();
+
+	err = XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_init, &bulk);
+	if(err != 0)
+		goto out_task_trampoline;
+
+#ifdef HAVE___THREAD
+	__rtdm_current = *iargs->task;
+#endif /* HAVE___THREAD */
+
+	/* We must save anything we'll need to use from iargs on our own
+	   stack now before releasing the barrier, since our released
+	   parent could unwind the stack space onto which the iargs struct
+	   is laid on before we actually get the CPU back. */
+
+	task_proc = iargs->task_proc;
+	arg = iargs->arg;
+
+	/* Wait on the barrier for the task to be started. The barrier
+	   could be released in order to process Linux signals while the
+	   Xenomai shadow is still dormant; in such a case, resume wait. */
+	do
+		err = XENOMAI_SYSCALL2(__xn_sys_barrier, NULL, NULL);
+	while (err == -EINTR);
+
+	if(err != 0)
+		goto out_task_trampoline;
+
+	task_proc(arg);
+		
+out_task_trampoline:
+
+	pthread_exit((void *)err);
+	
+}
+
+int rtdm_task_init(rtdm_task_t *task, const char *name,
+		   rtdm_task_proc_t task_proc, void *arg,
+		   int priority, nanosecs_rel_t period)
+{
+	struct rtdm_task_iargs iargs;
+	xncompletion_t completion;
+	pthread_attr_t thattr;
+	struct sched_param param;
+	pthread_t thid;
+	int err;
+
+	/* The task_proc argument is not checked by the kernel-side skin, 
+	   so do it here */
+	if(task_proc == NULL)
+		return -EINVAL;
+
+	/* Migrate this thread to the Linux domain since we are about to
+	   issue a series of regular kernel syscalls in order to create
+	   the new Linux thread, which in turn will be mapped to a
+	   real-time shadow. */
+
+	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+	
+	completion.syncflag = 0;
+	completion.pid = -1;
+
+	iargs.task = task;
+	iargs.name = name;
+	iargs.prio = priority;
+	iargs.period = period;
+	iargs.task_proc = task_proc;
+	iargs.arg = arg;
+	iargs.completionp = &completion;
+
+	pthread_attr_init(&thattr);
+	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
+	memset(&param, 0, sizeof(param));
+	if(priority > 0) {
+		pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
+		param.sched_priority = priority;
+	} else
+		pthread_attr_setschedpolicy(&thattr, SCHED_OTHER);
+
+	pthread_attr_setschedparam(&thattr, &param);
+	pthread_attr_setstacksize(&thattr, RTDM_USER_TASK_STACK_SIZE);       
+	pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_DETACHED);
+
+	err = __real_pthread_create(&thid, 
+				    &thattr, &__rtdm_task_trampoline, &iargs);
+	if(err != 0)
+		return -err;
+
+	err = XENOMAI_SYSCALL1(__xn_sys_completion, &completion);
+	if(err != 0)
+		return err;
+
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_start, task);
+}
+
+void rtdm_task_destroy(rtdm_task_t *task)
+{
+	if(task->opaque2) {
+		int err;
+
+		err = pthread_cancel((pthread_t) task->opaque2);
+		if(err != 0)
+			return;
+		
+	} else if(task->opaque == rtdm_task_current()->opaque)
+		pthread_exit(NULL);	
+
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_destroy, task);
+}
+
+void rtdm_task_set_priority(rtdm_task_t *task, int priority)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_task_set_priority, task, priority);
+}
+
+int rtdm_task_set_period(rtdm_task_t *task, nanosecs_rel_t period)
+{
+	return XENOMAI_SKINCALL2(__rtdm_muxid, 
+				 __rtdm_task_set_period, task, &period);
+}
+
+int rtdm_task_wait_period(void)
+{
+	return XENOMAI_SKINCALL0(__rtdm_muxid, __rtdm_task_wait_period);
+}
+
+int rtdm_task_unblock(rtdm_task_t *task)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_unblock, task);
+}
+
+rtdm_task_t *rtdm_task_current(void)
+{
+	rtdm_task_t *task;
+
+#ifdef HAVE___THREAD
+	task = &__rtdm_current;
+
+	if(task->opaque == XN_NO_HANDLE)
+		return NULL;
+
+#else /* !HAVE___THREAD */
+	task = (rtdm_task_t *)pthread_getspecific(__rtdm_tskey);
+
+	if(task != NULL)
+		return task;
+	
+	task = rtdm_malloc(sizeof(rtdm_task_t));
+
+	if(!task ||
+	   XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_current, task) != 0) {
+		rtdm_free(task);
+		return NULL;
+	}
+
+	pthread_setspecific(__rtdm_tskey, task);
+#endif /* HAVE___THREAD */
+
+	return task;
+}
+
+int rtdm_task_sleep(nanosecs_rel_t delay)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_sleep, &delay);
+}
+
+int rtdm_task_sleep_abs(nanosecs_abs_t wakeup_time, enum rtdm_timer_mode mode)
+{
+	return XENOMAI_SKINCALL2(__rtdm_muxid, 
+				 __rtdm_task_sleep_abs, &wakeup_time, mode);
+}
+
+void rtdm_task_join_nrt(rtdm_task_t *task, unsigned int poll_delay)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid,
+			  __rtdm_task_join_nrt, task, poll_delay);
+}
+
+void rtdm_task_busy_sleep(nanosecs_rel_t delay)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_task_busy_sleep, &delay);
+}
+
+void task_timer_proc(void *arg)
+{
+	rtdm_timer_t *timer = (rtdm_timer_t *)arg;
+
+	while(1) {
+		int err = XENOMAI_SKINCALL1(__rtdm_muxid,
+					    __rtdm_timer_wait, timer);
+		if(err != 0)
+			return;
+
+		timer->handler(timer);
+	}
+}
+
+int rtdm_timer_init(rtdm_timer_t *timer, 
+		    rtdm_timer_handler_t handler, const char *name)
+{
+	int err;
+	char task_name[XNOBJECT_NAME_LEN];
+
+	err = XENOMAI_SKINCALL3(__rtdm_muxid,
+				__rtdm_timer_init, timer, handler, name);
+
+	if(err != 0)
+		return err;	
+
+	snprintf(task_name, XNOBJECT_NAME_LEN, "timer_%s\n", name);
+
+	return rtdm_task_init(&timer->task, 
+			      task_name, 
+			      task_timer_proc, 
+			      timer, RTDM_TASK_HIGHEST_PRIORITY, 0);
+}
+
+void rtdm_timer_destroy(rtdm_timer_t *timer)
+{
+	rtdm_task_destroy(&timer->task);
+
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_timer_destroy, timer);
+}
+
+int rtdm_timer_start(rtdm_timer_t *timer, 
+		     nanosecs_abs_t expiry,
+		     nanosecs_rel_t interval, enum rtdm_timer_mode mode)
+{
+	return XENOMAI_SKINCALL4(__rtdm_muxid,
+				 __rtdm_timer_start, 
+				 timer, &expiry, &interval, mode);
+}
+
+void rtdm_timer_stop(rtdm_timer_t *timer)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_timer_stop, timer);
+}
+
+void rtdm_toseq_init(rtdm_toseq_t *timeout_seq, nanosecs_rel_t timeout)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_toseq_init, timeout_seq, &timeout);
+}
+
+void rtdm_event_init(rtdm_event_t *event, unsigned long pending)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_event_init, event, pending);
+}
+
+void rtdm_event_destroy(rtdm_event_t *event)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_event_destroy, event);
+}
+
+void rtdm_event_pulse(rtdm_event_t *event)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_event_pulse, event);
+}
+
+void rtdm_event_signal(rtdm_event_t *event)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_event_signal, event);
+}
+
+int rtdm_event_wait(rtdm_event_t *event)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_event_wait, event);
+}
+
+int rtdm_event_timedwait(rtdm_event_t *event, 
+			 nanosecs_rel_t timeout, rtdm_toseq_t *timeout_seq)
+{
+	return XENOMAI_SKINCALL3(__rtdm_muxid, 
+				 __rtdm_event_timedwait, 
+				 event, &timeout, timeout_seq);
+}
+
+void rtdm_event_clear(rtdm_event_t *event)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_event_clear, event); 
+}
+
+void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_sem_init, sem, value);
+}
+
+void rtdm_sem_destroy(rtdm_sem_t *sem)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_sem_destroy, sem);
+}
+
+int rtdm_sem_down(rtdm_sem_t *sem)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_sem_down, sem);
+}
+
+int rtdm_sem_timeddown(rtdm_sem_t *sem, 
+		       nanosecs_rel_t timeout, rtdm_toseq_t *timeout_seq)
+{
+	return XENOMAI_SKINCALL3(__rtdm_muxid, 
+				 __rtdm_sem_timeddown, sem, &timeout, timeout_seq);
+}
+
+void rtdm_sem_up(rtdm_sem_t *sem)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_sem_up, sem);
+}
+
+void rtdm_mutex_init(rtdm_mutex_t *mutex)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_mutex_init, mutex);
+}
+
+void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_mutex_destroy, mutex);
+}
+
+void rtdm_mutex_unlock(rtdm_mutex_t *mutex)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_mutex_unlock, mutex);
+}
+
+int rtdm_mutex_lock(rtdm_mutex_t *mutex)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_mutex_lock, mutex);
+}
+
+int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, 
+			  nanosecs_rel_t timeout, rtdm_toseq_t *timeout_seq)
+{
+	return XENOMAI_SKINCALL3(__rtdm_muxid, 
+				 __rtdm_mutex_timedlock, 
+				 mutex, &timeout, timeout_seq);
+}
+
+void task_irq_proc(void *arg)
+{
+	rtdm_irq_t *irq_handle = (rtdm_irq_t *)arg;
+
+	while(1) {		
+		int i, err = XENOMAI_SKINCALL1(__rtdm_muxid,
+					    __rtdm_irq_wait, irq_handle);
+
+		if(err < 0)
+			return;
+
+		for(i = 0; i < err; i++)
+			irq_handle->handler(irq_handle);
+	}
+}
+
+int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
+		     rtdm_irq_handler_t handler, unsigned long flags,
+		     const char *device_name, void *arg)
+{
+	int err;
+	char task_name[XNOBJECT_NAME_LEN];
+
+	err = XENOMAI_SKINCALL3(__rtdm_muxid,
+				__rtdm_irq_request, 
+				irq_handle, irq_no, device_name);
+
+	if(err != 0)
+		return err;	
+
+	irq_handle->handler = handler;
+	irq_handle->arg = arg;
+
+	snprintf(task_name, XNOBJECT_NAME_LEN, "irq_%u\n", irq_no);
+
+	return rtdm_task_init(&irq_handle->task,
+			      task_name,
+			      task_irq_proc,
+			      irq_handle, RTDM_TASK_HIGHEST_PRIORITY, 0);
+}
+
+int rtdm_irq_free(rtdm_irq_t *irq_handle)
+{
+	rtdm_task_destroy(&irq_handle->task);
+
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_irq_free, irq_handle);
+}
+
+void *task_nrtsig_proc(void *arg)
+{
+	rtdm_nrtsig_t *nrt_sig = (rtdm_nrtsig_t *)arg;
+
+	while(1) {
+		int err = XENOMAI_SKINCALL1(__rtdm_muxid,
+					    __rtdm_nrtsig_wait, nrt_sig);
+		if(err < 0)
+			pthread_exit((void*) err);
+		
+		nrt_sig->handler(nrt_sig->virq, nrt_sig->arg);
+	}
+	pthread_exit(NULL);
+}
+
+int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig,
+		     rtdm_nrtsig_handler_t handler, void *arg)
+{
+	int err;
+	
+	err = XENOMAI_SKINCALL1(__rtdm_muxid,
+				__rtdm_nrtsig_init, nrt_sig);
+	
+	if(err != 0)
+		return err;
+	
+	nrt_sig->handler = handler;	
+	nrt_sig->arg = arg;
+
+	return __real_pthread_create((pthread_t*)&nrt_sig->opaque2,
+				     NULL, &task_nrtsig_proc, nrt_sig);
+}
+
+void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig)
+{
+	pthread_cancel((pthread_t) nrt_sig->opaque2);
+
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_nrtsig_destroy, nrt_sig);
+}
+
+void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
+{
+	XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_nrtsig_pend, nrt_sig);
+}
+
+int __rtdm_irqsave(rtdm_lockctx_t *context)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_irq_save, context);
+}
+
+int __rtdm_irqrestore(rtdm_lockctx_t *context)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_irq_restore, context);
+}
+
+rtdm_heap_t __main_heap;
+
+static __attribute__ ((constructor(105)))
+void __init_rtdm_mainheap(void)
+{
+	rtdm_heap_init(&__main_heap, RTDM_MAIN_HEAP_SIZE, 0);
+}
+
+static int __map_heap_memory(rtdm_heap_ph_t *ph)
+{
+	int err, heapfd;
+
+	/* Open the heap device to share the heap memory with the
+	   in-kernel skin and bound clients. */
+	heapfd = __real_open(XNHEAP_DEV_NAME, O_RDWR);
+
+	if (heapfd < 0)
+		return -ENOENT;
+
+	/* Bind this file instance to the shared heap. */
+	err = __real_ioctl(heapfd, 0, ph->opaque2);
+
+	if (err)
+		goto close_and_exit;
+
+	/* Map the heap memory into our address space. */
+	ph->mapbase = (caddr_t) __real_mmap(NULL,
+					     ph->mapsize,
+					     PROT_READ | PROT_WRITE,
+					     MAP_SHARED, heapfd, 0L);
+
+	if (ph->mapbase == MAP_FAILED)
+		err = -ENOMEM;
+
+      close_and_exit:
+
+	__real_close(heapfd);
+
+	return err;
+}
+
+int rtdm_heap_init(rtdm_heap_t *heap, unsigned long size, unsigned long flags)
+{
+	int err;
+	
+	err = XENOMAI_SKINCALL3(__rtdm_muxid, __rtdm_heap_init, heap, size, flags);
+
+	if(err < 0)
+		goto out_heap_init;
+	
+	err = __map_heap_memory(heap);
+	
+	if(err < 0) {
+		XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_heap_destroy, heap);
+		memset(heap, 0, sizeof(rtdm_heap_t));
+	}
+		
+out_heap_init:
+	return err;
+}
+
+int rtdm_heap_destroy(rtdm_heap_t *heap)
+{
+	return XENOMAI_SKINCALL1(__rtdm_muxid, __rtdm_heap_destroy, heap);
+}
+
+void *rtdm_heap_malloc(rtdm_heap_t *heap, size_t size)
+{
+	void *block;
+
+	if(XENOMAI_SKINCALL3(__rtdm_muxid, 
+			     __rtdm_heap_malloc, heap, size, &block) < 0)
+		return NULL;
+
+	return block;
+}
+
+void rtdm_heap_free(rtdm_heap_t *heap, void *ptr)
+{
+	XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_heap_free, heap, ptr);
+}
Index: src/skins/rtdm/init.c
===================================================================
--- src/skins/rtdm/init.c	(revision 4513)
+++ src/skins/rtdm/init.c	(working copy)
@@ -20,12 +20,13 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <rtdm/rtdm_driver.h>
 #include <rtdm/syscall.h>
 #include <asm-generic/bits/bind.h>
 
 int __rtdm_muxid = -1;
 
-static __attribute__ ((constructor))
+static __attribute__ ((constructor(101)))
 void __init_rtdm_interface(void)
 {
 	/* The following call may fail; binding errors will be
@@ -35,5 +36,6 @@
 	__rtdm_muxid =
 		xeno_bind_skin_opt(RTDM_SKIN_MAGIC, "rtdm", "xeno_rtdm");
 	__rtdm_muxid = __xn_mux_shifted_id(__rtdm_muxid);
+}
 
-}
+
Index: src/skins/rtdm/internal.h
===================================================================
--- src/skins/rtdm/internal.h	(revision 0)
+++ src/skins/rtdm/internal.h	(revision 0)
@@ -0,0 +1,119 @@
+#ifndef __INTERNAL_H__
+#define __INTERNAL_H__
+
+#if __GNUC__ >= 3
+#define GCC_ZERO_LENGTH_ARRAY
+#else
+#define GCC_ZERO_LENGTH_ARRAY 0
+#endif
+
+#define __REGISTERING_ELT 0x80000000
+#define __REGISTERED_ELT 0x40000000
+#define __REMOVING_ELT 0x20000000
+
+struct atomic_element {
+	xnarch_atomic_t status;
+	void *element;
+};
+
+typedef struct {
+	unsigned int count;
+	struct atomic_element elements[GCC_ZERO_LENGTH_ARRAY];
+} atomic_tab_t;
+
+static int atab_try_add(atomic_tab_t *tab, unsigned int *index)
+{
+	unsigned int i = 0;
+
+	while(xnarch_atomic_cmpxchg(&tab->elements[i].status,
+				    0, __REGISTERING_ELT) != 0 &&
+	      ++i < tab->count);
+	
+	if(i >= tab->count)
+		return -EBUSY;
+
+	*index = i;
+
+	return 0;
+}
+
+static int atab_do_add(atomic_tab_t *tab, unsigned int index, void *element)
+{
+	unsigned long status;
+
+	tab->elements[index].element = element;
+	
+	status = xnarch_atomic_cmpxchg(&tab->elements[index].status, 
+				       __REGISTERING_ELT, __REGISTERED_ELT);
+	if(status != __REGISTERING_ELT)
+		return -EPERM;
+
+	return 0;
+}
+
+static int atab_try_remove(atomic_tab_t *tab, unsigned int index)
+{
+	unsigned long status;
+	
+	do {
+		status = xnarch_atomic_get(&tab->elements[index].status);
+		
+		if((status & __REMOVING_ELT) != 0)
+			return -EBUSY;
+
+	} while(status != xnarch_atomic_cmpxchg(&tab->elements[index].status,
+						status, status | __REMOVING_ELT));
+
+	return 0;
+}
+
+static int atab_do_remove(atomic_tab_t *tab, unsigned int index)
+{
+	unsigned long status;
+
+	do {
+		status = xnarch_atomic_get(&tab->elements[index].status);
+		
+		if((status & ~(__REMOVING_ELT | __REGISTERED_ELT)) != 0)
+			return -EAGAIN;		
+		
+	} while(status != xnarch_atomic_cmpxchg(&tab->elements[index].status, status, 0));
+
+	return 0;
+}
+
+static int atab_lock(atomic_tab_t *tab, unsigned int index)
+{
+	unsigned long status;
+
+	do {
+		status = xnarch_atomic_get(&tab->elements[index].status);
+		
+		if((status & __REGISTERED_ELT) == 0 ||
+		   (status & __REMOVING_ELT) != 0)
+			return -EINVAL;
+
+	} while(status != xnarch_atomic_cmpxchg(&tab->elements[index].status,
+						status, status + 1));
+
+	return 0;
+}
+
+static int atab_unlock(atomic_tab_t *tab, unsigned int index)
+{
+	unsigned long status;
+
+	do {
+		status = xnarch_atomic_get(&tab->elements[index].status);
+		
+		if((status & __REGISTERED_ELT) == 0 ||
+		   (status & __REMOVING_ELT) != 0)
+			return -EINVAL;
+
+	} while(status != xnarch_atomic_cmpxchg(&tab->elements[index].status,
+						status, status - 1));
+
+	return 0;
+}
+
+#endif /* __INTERNAL_H__ */
Index: src/skins/rtdm/wrappers.c
===================================================================
--- src/skins/rtdm/wrappers.c	(revision 0)
+++ src/skins/rtdm/wrappers.c	(revision 0)
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2005 Heikki Lindholm <holindho@domain.hid>.
+ * Copyright (C) 2008 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <stdarg.h>
+#include <pthread.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+/*
+ * This file maintains a list of placeholders for routines that we do
+ * NOT want to be wrapped to their Xenomai POSIX API counterparts when
+ * used internally by the RTDM interface.
+ */
+
+__attribute__ ((weak))
+int __real_pthread_setschedparam(pthread_t thread,
+				 int policy, const struct sched_param *param)
+{
+	return pthread_setschedparam(thread, policy, param);
+}
+
+__attribute__ ((weak))
+int __real_pthread_create(pthread_t *tid,
+			  const pthread_attr_t * attr,
+			  void *(*start) (void *), void *arg)
+{
+	return pthread_create(tid, attr, start, arg);
+}
+
+__attribute__ ((weak))
+int __real_open(const char *path, int oflag, ...)
+{
+	va_list ap;
+	mode_t mode;
+
+	if (oflag & O_CREAT) {
+		va_start(ap, oflag);
+		mode = va_arg(ap, mode_t);
+		va_end(ap);
+		return open(path, oflag, mode);
+	} else
+		return open(path, oflag);
+}
+
+__attribute__ ((weak))
+int __real_close(int fd)
+{
+	return close(fd);
+}
+
+__attribute__ ((weak))
+int __real_ioctl(int fd, int request, ...)
+{
+	va_list ap;
+	void *arg;
+
+	va_start(ap, request);
+	arg = va_arg(ap, void *);
+	va_end(ap);
+
+	return ioctl(fd, request, arg);
+}
+
+__attribute__ ((weak))
+void *__real_mmap(void *addr,
+		  size_t len, int prot, int flags, int fd, off_t off)
+{
+	return mmap(addr, len, prot, flags, fd, off);
+}
+
+__attribute__ ((weak))
+int __real_munmap(void *addr, size_t len)
+{
+	return munmap(addr, len);
+}
Index: src/skins/rtdm/wrappers.h
===================================================================
--- src/skins/rtdm/wrappers.h	(revision 0)
+++ src/skins/rtdm/wrappers.h	(revision 0)
@@ -0,0 +1,26 @@
+#ifndef _XENO_WRAPPERS_H
+#define _XENO_WRAPPERS_H
+
+#include <sys/types.h>
+#include <pthread.h>
+
+int __real_pthread_create(pthread_t *tid,
+			  const pthread_attr_t * attr,
+			  void *(*start) (void *), void *arg);
+
+int __real_pthread_setschedparam(pthread_t thread,
+				 int policy, const struct sched_param *param);
+
+
+int __real_open(const char *path, int oflag, ...);
+
+int __real_close(int fd);
+
+int __real_ioctl(int fd, int request, ...);
+
+void *__real_mmap(void *addr,
+		  size_t len, int prot, int flags, int fd, off_t off);
+
+int __real_munmap(void *addr, size_t len);
+
+#endif /* !_XENO_WRAPPERS_H */

--Boundary-00=_rqrWJpAGTAd5694--


