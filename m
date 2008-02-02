From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TAADMppbIu"
Content-Transfer-Encoding: 7bit
Message-ID: <18340.31323.677695.655702@domain.hid>
Date: Sat, 2 Feb 2008 15:12:43 +0100
In-Reply-To: <18340.31233.591834.293535@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
Subject: [Xenomai-core] [PATCH 1/5] select-like services support to xenomai
	core.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--TAADMppbIu
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


This patch adds select-like services support to xenomai core.

Changes:
- the xnselect function now ignores null fd_sets, which makes it faster in the
common case when several fd_sets are null;
- the timeout is now passed to xnselect as an (xnticks_t, xntmode_t) couple,
  which avoids xnselect to suspend forever the caller when a computed timeout
  happens to be XN_INFINITE.

Stats:
 include/nucleus/select.h |  111 ++++++++++++
 ksrc/nucleus/Makefile    |    4
 ksrc/nucleus/select.c    |  412 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 525 insertions(+), 2 deletions(-)


-- 


					    Gilles Chanteperdrix.

--TAADMppbIu
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-select-core.diff"
Content-Transfer-Encoding: 7bit

--- include/nucleus/select.h	(revision 0)
+++ include/nucleus/select.h	(revision 0)
@@ -0,0 +1,111 @@
+/*!\file select.h
+ * \brief file descriptors events multiplexing header.
+ * \author Gilles Chanteperdrix
+ *
+ * Copyright (C) 2008 Efixo <gilles.chanteperdrix@xenomai.org>
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * \ingroup select
+ */
+
+#ifndef XNSELECT_H
+#define XNSELECT_H
+
+/*! \addtogroup select
+ *@{*/
+
+#include <nucleus/thread.h>
+
+#define XNSELECT_READ      0
+#define XNSELECT_WRITE     1
+#define XNSELECT_EXCEPT    2
+#define XNSELECT_MAX_TYPES 3
+
+struct xnselector { 
+        xnsynch_t synchbase;
+	struct fds {
+		fd_set expected;
+		fd_set pending;
+	} fds [XNSELECT_MAX_TYPES];
+	xnqueue_t bindings; /* only used by xnselector_destroy */
+};
+
+struct xnselect {
+	xnqueue_t bindings;
+};
+
+struct xnselect_binding {
+	struct xnselector *selector;
+	struct xnselect *fd;
+	unsigned type;
+	unsigned bit_index;
+	xnholder_t link;  /* link in selected fds list. */
+	xnholder_t slink; /* link in selector list */
+};
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+void xnselect_init(struct xnselect *select_block);
+
+int xnselect_bind(struct xnselect *select_block,
+		  struct xnselect_binding *binding,
+		  struct xnselector *selector,
+		  unsigned type,
+		  unsigned bit_index,
+		  unsigned state);
+
+int __xnselect_signal(struct xnselect *select_block, unsigned state);
+
+/** 
+ * Signal a file descriptor state change.
+ * 
+ * @param select_block pointer to an @a xnselect structure representing the file
+ * descriptor whose state changed;
+ * @param state new value of the state.
+ * 
+ * @retval 1 if rescheduling is needed;
+ * @retval 0 otherwise.
+ */
+static inline int
+xnselect_signal(struct xnselect *select_block, unsigned state)
+{
+	if (!emptyq_p(&select_block->bindings))
+		return __xnselect_signal(select_block, state);
+	return 0;
+}
+
+void xnselect_destroy(struct xnselect *select_block);
+
+int xnselector_init(struct xnselector *selector);
+
+int xnselect(struct xnselector *selector,
+	     fd_set *out_fds[XNSELECT_MAX_TYPES],
+	     fd_set *in_fds[XNSELECT_MAX_TYPES],
+	     int nfds,
+	     xnticks_t timeout, xntmode_t timeout_mode);
+
+void xnselector_destroy(struct xnselector *selector);
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+/*@}*/
+
+#endif /* XNSELECT_H */
--- ksrc/nucleus/select.c	(revision 0)
+++ ksrc/nucleus/select.c	(revision 0)
@@ -0,0 +1,412 @@
+/*!\file select.c
+ * \brief file descriptors events multiplexing.
+ * \author Gilles Chanteperdrix
+ *
+ * Copyright (C) 2008 Efixo <gilles.chanteperdrix@xenomai.org>
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * \ingroup select
+ */
+
+/*!
+ * \ingroup nucleus
+ * \defgroup select File descriptors events multiplexing services.
+ *
+ * File descriptors events multiplexing services.
+ *
+ * This module implements the services needed for implementing the posix
+ * "select" service, or any other events multiplexing services.
+ *
+ * Following the implementation of the posix select service, this module defines
+ * three types of events:
+ * - \a XNSELECT_READ meaning that a file descriptor is ready for reading;
+ * - \a XNSELECT_WRITE meaning that a file descriptor is ready for writing;
+ * - \a XNSELECT_EXCEPT meaning that a file descriptor received an exceptional
+ *   event.
+ *
+ * It works by defining two structures:
+ * - a @a struct @a xnselect structure, which should be added to every file
+ * descriptor for every event type (read, write, or except);
+ * - a @a struct @a xnselector structure, the selection structure,  passed by
+ * the thread calling the xnselect service, where this service does all its
+ * housekeeping.
+ *@{*/
+
+#include <nucleus/heap.h>
+#include <nucleus/pod.h>
+#include <nucleus/synch.h>
+#include <nucleus/select.h>
+#include <linux/types.h>
+#include <linux/bitops.h>	/* For hweight_long */
+
+#define link2binding(baddr, memb)				\
+	container_of(baddr, struct xnselect_binding, memb)
+
+/** 
+ * Initialize a @a struct @a xnselect structure.
+ *
+ * This service must be called to initialize a @a struct @a xnselect structure
+ * before it is bound to a selector by the means of xnselect_bind().
+ * 
+ * @param select_block pointer to the xnselect structure to be initialized
+ */
+void xnselect_init(struct xnselect *select_block)
+{
+	initq(&select_block->bindings);
+}
+EXPORT_SYMBOL(xnselect_init);
+
+static inline int xnselect_wakeup(struct xnselector *selector)
+{
+	return xnsynch_flush(&selector->synchbase, 0) == XNSYNCH_RESCHED;
+}
+
+/** 
+ * Bind a file descriptor (represented by its @a xnselect structure) to a
+ * selector block.
+ *
+ * @param select_block pointer to the @a struct @a xnselect to be bound;
+ *
+ * @param binding pointer to a newly allocated (using xnmalloc) @a struct
+ * @a xnselect_binding;
+ *
+ * @param selector pointer to the selector structure;
+ *
+ * @param type type of events (@a XNSELECT_READ, @a XNSELECT_WRITE, or @a
+ * XNSELECT_EXCEPT);
+ *
+ * @param index index of the file descriptor (represented by @a select_block) in the bit fields used by the @a selector structure;
+ *
+ * @param state current state of the file descriptor>.
+ * 
+ * @a select_block must have been initialized with xnselect_init(),
+ * the @a xnselector structure must have been initialized with
+ * xnselector_init(), @a binding may be uninitialized.
+ *
+ * This service must be called with nklock locked, irqs off. For this reason,
+ * the @a binding parameter must have been allocated by the caller outside the
+ * locking section.
+ * 
+ * @retval -EINVAL if @a type or @a index is invalid;
+ * @retval 0 otherwise.
+ */
+int xnselect_bind(struct xnselect *select_block,
+		  struct xnselect_binding *binding,
+		  struct xnselector *selector,
+		  unsigned type,
+		  unsigned index,
+		  unsigned state)
+{
+	if (type >= XNSELECT_MAX_TYPES || index > __FD_SETSIZE)
+		return -EINVAL;
+
+	binding->selector = selector;
+	binding->fd = select_block;
+	binding->type = type;
+	binding->bit_index = index;
+	inith(&binding->link);
+	inith(&binding->slink);
+	
+	appendq(&selector->bindings, &binding->slink);
+	appendq(&select_block->bindings, &binding->link);
+	__FD_SET(index, &selector->fds[type].expected);
+	if (state)
+		__FD_SET(index, &selector->fds[type].pending);
+
+	return 0;
+}
+EXPORT_SYMBOL(xnselect_bind);
+
+/* Must be called with nklock locked irqs off */
+int __xnselect_signal(struct xnselect *select_block, unsigned state)
+{
+	xnholder_t *holder;
+	int resched;
+
+	for(resched = 0, holder = getheadq(&select_block->bindings);
+	    holder; holder = nextq(&select_block->bindings, holder)) {
+		struct xnselect_binding *binding;
+		struct xnselector *selector;
+
+		binding = link2binding(holder, link);
+
+		selector = binding->selector;
+		if (state) {
+			if (!__FD_ISSET(binding->bit_index,
+					&selector->fds[binding->type].pending)) {
+				__FD_SET(binding->bit_index,
+					 &selector->fds[binding->type].pending);
+				if (xnselect_wakeup(selector))
+					resched = 1;
+			}
+		} else
+			__FD_CLR(binding->bit_index, 
+				 &selector->fds[binding->type].pending);
+	}
+
+	return resched;
+}
+EXPORT_SYMBOL(__xnselect_signal);
+
+/** 
+ * Destroy the @a xnselect structure associated with a file descriptor.
+ *
+ * Any binding with a @a xnselector block is destroyed.
+ *
+ * @param select_block pointer to the @a xnselect structure associated with a file descriptor
+ */
+void xnselect_destroy(struct xnselect *select_block)
+{
+	xnholder_t *holder;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+	while ((holder = getq(&select_block->bindings))) {
+		struct xnselect_binding *binding;
+		struct xnselector *selector;
+
+		binding = link2binding(holder, link);
+		selector = binding->selector;
+
+		__FD_CLR(binding->bit_index,
+			 &selector->fds[binding->type].expected);
+		__FD_CLR(binding->bit_index,
+			 &selector->fds[binding->type].pending);
+		removeq(&selector->bindings, &binding->slink);
+		xnlock_put_irqrestore(&nklock, s);
+
+		xnfree(binding);
+		
+		xnlock_get_irqsave(&nklock, s);
+	}
+	xnlock_put_irqrestore(&nklock, s);
+}
+EXPORT_SYMBOL(xnselect_destroy);
+
+static unsigned
+fd_set_andnot(fd_set *result, fd_set *first, fd_set *second, unsigned n)
+{
+	unsigned i, not_empty = 0;
+
+	for (i = 0; i < __FDELT(n); i++)
+		if((result->fds_bits[i] =
+		    first->fds_bits[i] & ~(second->fds_bits[i])))
+			not_empty = 1;
+
+	if (i < __FDSET_LONGS
+	    && (result->fds_bits[i] =
+		first->fds_bits[i] & ~(second->fds_bits[i]) & (__FDMASK(n) - 1)))
+		not_empty = 1;
+
+	return not_empty;
+}
+
+static unsigned
+fd_set_and(fd_set *result, fd_set *first, fd_set *second, unsigned n)
+{
+	unsigned i, not_empty = 0;
+
+	for (i = 0; i < __FDELT(n); i++)
+		if((result->fds_bits[i] =
+		    first->fds_bits[i] & second->fds_bits[i]))
+			not_empty = 1;
+
+	if (i < __FDSET_LONGS
+	    && (result->fds_bits[i] =
+		first->fds_bits[i] & second->fds_bits[i] & (__FDMASK(n) - 1)))
+		not_empty = 1;
+
+	return not_empty;
+}
+
+static void fd_set_zerofill(fd_set *set, unsigned n)
+{
+	unsigned i;
+
+	i = __FDELT(n);
+
+	if (i < __FDSET_LONGS)
+		set->fds_bits[i] &= (__FDMASK(n) - 1);
+
+	for(i++; i < __FDSET_LONGS; i++)
+		set->fds_bits[i] = 0;
+}
+
+static unsigned fd_set_popcount(fd_set *set, unsigned n)
+{
+	unsigned count = 0, i;
+
+	for (i = 0; i < __FDELT(n); i++)
+		if (set->fds_bits[i])
+			count += hweight_long(set->fds_bits[i]);
+
+	if (i < __FDSET_LONGS && (set->fds_bits[i] & (__FDMASK(n) - 1)))
+		count += hweight_long(set->fds_bits[i] & (__FDMASK(n) - 1));
+
+	return count;
+}
+
+/** 
+ * Initialize a selector structure.
+ * 
+ * @param selector The selector structure to be initialized.
+ * 
+ * @retval 0
+ */
+int xnselector_init(struct xnselector *selector)
+{
+	unsigned i;
+
+	xnsynch_init(&selector->synchbase, XNSYNCH_FIFO | XNSYNCH_NOPIP);
+	for (i = 0; i < XNSELECT_MAX_TYPES; i++) {
+		__FD_ZERO(&selector->fds[i].expected);
+		__FD_ZERO(&selector->fds[i].pending);
+	}
+	initq(&selector->bindings);
+	return 0;
+}
+EXPORT_SYMBOL(xnselector_init);
+
+/** 
+ * Check the state of a number of file descriptors, wait for a state change if
+ * no descriptor is ready.
+ * 
+ * @param selector structure to check for pending events
+ * @param out_fds The set of descriptors with pending events if a strictly positive number is returned, or the set of descriptors not yet bound if -ECHRNG is returned;
+ * @param in_fds the set of descriptors which events should be checked
+ * @param nfds the highest-numbered descriptor in any of the @a in_fds sets, plus 1;
+ * @param timeout the timeout, whose meaning depends on @a timeout_mode, note
+ * that xnselect() pass @a timeout and @a timeout_mode unchanged to
+ * xnsynch_sleep_on, so passing a relative value different from XN_INFINITE as a
+ * timeout with @a timeout_mode set to XN_RELATIVE, will cause a longer sleep
+ * than expected if the sleep is interrupted.
+ * @param timeout_mode the mode of @a timeout.
+ * 
+ * @retval -EINVAL if @nfds is negative;
+ * @retval -ECHRNG if some of the descriptors passed in @a in_fds have not yet
+ * been registered with xnselect_bind(), @a out_fds contains the set of such
+ * descriptors;
+ * @retval -EINTR if @a xnselect was interrupted while waiting;
+ * @retval 0 in case of timeout.
+ * @retval the number of file descriptors having received an event.
+ */
+int xnselect(struct xnselector *selector,
+	     fd_set *out_fds[XNSELECT_MAX_TYPES],
+	     fd_set *in_fds[XNSELECT_MAX_TYPES],
+	     int nfds,
+	     xnticks_t timeout, xntmode_t timeout_mode)
+{
+	unsigned i, not_empty = 0;
+	xnthread_t *thread;
+	spl_t s;
+
+	if ((unsigned) nfds > __FD_SETSIZE)
+		return -EINVAL;
+
+	thread = xnpod_current_thread();	
+
+	xnlock_get_irqsave(&nklock, s);
+	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+		if (out_fds[i]
+		    && fd_set_andnot(out_fds[i], in_fds[i],
+				     &selector->fds[i].expected, nfds))
+			not_empty = 1;
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (not_empty) {
+		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+			if (out_fds[i])
+				fd_set_zerofill(out_fds[i], nfds);
+		return -ECHRNG;
+	}
+
+	xnlock_get_irqsave(&nklock, s);
+	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+		if (out_fds[i]
+		    && fd_set_and(out_fds[i], in_fds[i],
+				  &selector->fds[i].pending, nfds))
+			not_empty = 1;
+	
+	while (!not_empty) {
+		xnsynch_sleep_on(&selector->synchbase, timeout, timeout_mode);
+
+		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+			if (out_fds[i]
+			    && fd_set_and(out_fds[i], in_fds[i],
+					  &selector->fds[i].pending, nfds))
+				not_empty = 1;
+
+		if (xnthread_test_info(thread, XNBREAK | XNTIMEO))
+			break;
+	}
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (not_empty) {
+		unsigned count;
+
+		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+			if (out_fds[i])
+				fd_set_zerofill(out_fds[i], nfds);
+
+		for (count = 0, i = 0; i < XNSELECT_MAX_TYPES; i++)
+			if (out_fds[i])
+				count += fd_set_popcount(out_fds[i], nfds);
+
+		return count;
+	}
+
+	if (xnthread_test_info(thread, XNBREAK))
+		return -EINTR;
+
+	return 0; /* Timeout */
+}
+EXPORT_SYMBOL(xnselect);
+
+/** 
+ * Destroy a selector block.
+ *
+ * All bindings with file descriptor are destroyed.
+ *
+ * @param selector the selector block to be destroyed
+ */
+void xnselector_destroy(struct xnselector *selector)
+{
+	xnholder_t *holder;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+	while ((holder = getq(&selector->bindings))) {
+		struct xnselect_binding *binding;
+		struct xnselect *fd;
+
+		binding = link2binding(holder, slink);
+		fd = binding->fd;
+		removeq(&fd->bindings, &binding->link);
+		xnlock_put_irqrestore(&nklock, s);
+
+		xnfree(binding);
+
+		xnlock_get_irqsave(&nklock, s);
+	}
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (xnsynch_destroy(&selector->synchbase) == XNSYNCH_RESCHED)
+		xnpod_schedule();
+}
+EXPORT_SYMBOL(xnselector_destroy);
+
+/*@}*/
--- ksrc/nucleus/Makefile	(revision 3455)
+++ ksrc/nucleus/Makefile	(working copy)
@@ -4,7 +4,7 @@ ifeq ($(PATCHLEVEL),6)
 
 obj-$(CONFIG_XENO_OPT_NUCLEUS) += xeno_nucleus.o
 
-xeno_nucleus-y := heap.o intr.o module.o pod.o synch.o thread.o timebase.o timer.o
+xeno_nucleus-y := heap.o intr.o module.o pod.o synch.o thread.o timebase.o timer.o select.o
 
 xeno_nucleus-$(CONFIG_XENO_OPT_PERVASIVE) += shadow.o
 
@@ -26,7 +26,7 @@ obj-$(CONFIG_XENO_OPT_NUCLEUS) := xeno_n
 
 list-multi := xeno_nucleus.o
 
-xeno_nucleus-objs := heap.o intr.o module.o pod.o synch.o thread.o timebase.o timer.o
+xeno_nucleus-objs := heap.o intr.o module.o pod.o synch.o thread.o timebase.o timer.o select.o
 
 opt_objs-y :=
 opt_objs-$(CONFIG_XENO_OPT_PERVASIVE) += shadow.o

--TAADMppbIu--

