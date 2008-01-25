From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJdFyvNvsH"
Content-Transfer-Encoding: 8bit
Message-ID: <18330.24789.512501.36428@domain.hid>
Date: Fri, 25 Jan 2008 23:21:09 +0100
In-Reply-To: <18330.24340.328727.760936@domain.hid>
References: <18330.24340.328727.760936@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/4] Support for select-like services.
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


--IJdFyvNvsH
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > 
 > Hi,
 > 
 > the following patchset adds core support to Xenomai for select-like
 > services,

The attached patch is a quick and dirty patch of RTnet to allow using
rtnet sockets of all types with the new select service.

-- 


					    Gilles Chanteperdrix.

--IJdFyvNvsH
Content-Type: text/plain
Content-Disposition: inline;
	filename="rtnet-select.diff"
Content-Transfer-Encoding: 8bit

Index: stack/ipv4/af_inet.c
===================================================================
--- stack/ipv4/af_inet.c	(r���vision 6193)
+++ stack/ipv4/af_inet.c	(copie de travail)
@@ -259,8 +259,6 @@ static void rt_ip_ifdown(struct rtnet_de
     rt_ip_route_del_all(rtdev);
 }
 
-
-
 static struct rtdev_event_hook  rtdev_hook = {
     register_device:    NULL,
     unregister_device:  NULL,
@@ -294,6 +292,7 @@ static struct rtdm_device ipv4_device = 
         ioctl_nrt:      rt_udp_ioctl,
         recvmsg_rt:     rt_udp_recvmsg,
         sendmsg_rt:     rt_udp_sendmsg,
+	select_bind:    rt_socket_select_bind,
 #ifdef CONFIG_RTNET_RTDM_SELECT
         poll_rt:        rt_udp_poll,
         /* there should be only the function poll() */
Index: stack/include/rtnet_socket.h
===================================================================
--- stack/include/rtnet_socket.h	(r���vision 6193)
+++ stack/include/rtnet_socket.h	(copie de travail)
@@ -51,7 +51,8 @@ struct rtsocket {
     unsigned int            priority;
     nanosecs_rel_t          timeout;    /* receive timeout, 0 for infinite */
 
-    rtdm_sem_t              pending_sem;
+    rtdm_select_sem_t       pending_sem;
+    struct xnselect         write_select;
 #ifdef CONFIG_RTNET_RTDM_SELECT
     wait_queue_primitive_t  *wakeup_select; /* for selecting calls - this
                                                SHOULD be the head of a wait
@@ -96,6 +97,10 @@ static inline struct rtdm_dev_context *r
     atomic_dec(&(rt_socket_context(sock)->close_lock_count))
 
 extern int rt_socket_init(struct rtdm_dev_context *context);
+extern int rt_socket_select_bind(struct rtdm_dev_context *context,
+				 struct xnselector *selector,
+				 unsigned type,
+				 unsigned index);
 extern int rt_socket_cleanup(struct rtdm_dev_context *context);
 extern int rt_socket_common_ioctl(struct rtdm_dev_context *context,
                                   rtdm_user_info_t *user_info,
Index: stack/packet/af_packet.c
===================================================================
--- stack/packet/af_packet.c	(r���vision 6193)
+++ stack/packet/af_packet.c	(copie de travail)
@@ -467,7 +467,8 @@ static struct rtdm_device   packet_proto
         ioctl_rt:       rt_packet_ioctl,
         ioctl_nrt:      rt_packet_ioctl,
         recvmsg_rt:     rt_packet_recvmsg,
-        sendmsg_rt:     rt_packet_sendmsg
+        sendmsg_rt:     rt_packet_sendmsg,
+	select_bind:    rt_socket_select_bind,	
     },
 
     device_class:       RTDM_CLASS_NETWORK,
Index: stack/socket.c
===================================================================
--- stack/socket.c	(r���vision 6193)
+++ stack/socket.c	(copie de travail)
@@ -68,6 +68,7 @@ int rt_socket_init(struct rtdm_dev_conte
 
     rtdm_lock_init(&sock->param_lock);
     rtdm_sem_init(&sock->pending_sem, 0);
+    xnselect_init(&sock->write_select);
 
     if (test_bit(RTDM_CREATED_IN_NRT, &sockctx->context_flags))
         pool_size = rtskb_pool_init(&sock->skb_pool, socket_rtskbs);
@@ -87,7 +88,44 @@ int rt_socket_init(struct rtdm_dev_conte
     return 0;
 }
 
+int rt_socket_select_bind(struct rtdm_dev_context *context,
+			  struct xnselector *selector,
+			  unsigned type,
+			  unsigned index)
+{
+    struct rtsocket     *sock = (struct rtsocket *)&context->dev_private;
+
+    switch(type) {
+    case XNSELECT_READ:
+	return rtdm_select_sem_bind(&sock->pending_sem, selector, type, index);
+
+    case XNSELECT_WRITE: {
+	struct xnselect_binding *binding;
+	int err;
+	spl_t s;
+
+	binding = xnmalloc(sizeof(*binding));
+	if (!binding)
+	    return -ENOMEM;
+
+	xnlock_get_irqsave(&nklock, s);
+	/* Writing to a socket is always possible, so the state is 1, forever. */
+	err = xnselect_bind(&sock->write_select,
+			    binding, selector, type, index, 1);
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (err)
+	    xnfree(binding);
+	return err;
+    }
 
+    case XNSELECT_EXCEPT:
+	return -EBADF;
+    }
+
+    return -EINVAL;
+}
+EXPORT_SYMBOL(rt_socket_select_bind);
 
 /***
  *  rt_socket_cleanup - releases resources allocated for the socket
@@ -100,6 +138,7 @@ int rt_socket_cleanup(struct rtdm_dev_co
 
 
     rtdm_sem_destroy(&sock->pending_sem);
+    xnselect_destroy(&sock->write_select);
 
     rtdm_lock_get_irqsave(&sock->param_lock, context);
 

--IJdFyvNvsH--

