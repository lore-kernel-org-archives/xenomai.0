MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="spynN26ryl"
Content-Transfer-Encoding: 8bit
Message-ID: <18340.34885.71145.607715@domain.hid>
Date: Sat, 2 Feb 2008 16:12:05 +0100
In-Reply-To: <47A47E33.4030909@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<47A47E33.4030909@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


--spynN26ryl
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > after some tests, bug fixes and optimizations, here comes a second version of 
 > > the patch-set adding select support to xenomai posix skin.
 > 
 > It's on my agenda for today or tomorrow to have a closer look at this.
 > Just one general question already: Why is it "select" and not "poll and
 > select"? Is it trivial to extend later on?

The patch I sent for adding select support to RTnet sockets was
uselessly complicated. Here is a simpler one.

-- 


					    Gilles Chanteperdrix.

--spynN26ryl
Content-Type: text/plain
Content-Disposition: inline;
	filename="rtnet-select.2.diff"
Content-Transfer-Encoding: 8bit

Index: stack/ipv4/af_inet.c
===================================================================
--- stack/ipv4/af_inet.c	(r������vision 6193)
+++ stack/ipv4/af_inet.c	(copie de travail)
@@ -294,6 +294,7 @@ static struct rtdm_device ipv4_device = 
         ioctl_nrt:      rt_udp_ioctl,
         recvmsg_rt:     rt_udp_recvmsg,
         sendmsg_rt:     rt_udp_sendmsg,
+	select_bind:    rt_socket_select_bind,
 #ifdef CONFIG_RTNET_RTDM_SELECT
         poll_rt:        rt_udp_poll,
         /* there should be only the function poll() */
Index: stack/include/rtnet_socket.h
===================================================================
--- stack/include/rtnet_socket.h	(r������vision 6193)
+++ stack/include/rtnet_socket.h	(copie de travail)
@@ -51,7 +51,7 @@ struct rtsocket {
     unsigned int            priority;
     nanosecs_rel_t          timeout;    /* receive timeout, 0 for infinite */
 
-    rtdm_sem_t              pending_sem;
+    rtdm_select_sem_t       pending_sem;
 #ifdef CONFIG_RTNET_RTDM_SELECT
     wait_queue_primitive_t  *wakeup_select; /* for selecting calls - this
                                                SHOULD be the head of a wait
@@ -96,6 +96,10 @@ static inline struct rtdm_dev_context *r
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
--- stack/packet/af_packet.c	(r������vision 6193)
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
--- stack/socket.c	(r������vision 6193)
+++ stack/socket.c	(copie de travail)
@@ -87,7 +87,25 @@ int rt_socket_init(struct rtdm_dev_conte
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
+    case XNSELECT_WRITE:
+    case XNSELECT_EXCEPT:
+	return -EBADF;
+    }
 
+    return -EINVAL;
+}
+EXPORT_SYMBOL(rt_socket_select_bind);
 
 /***
  *  rt_socket_cleanup - releases resources allocated for the socket

--spynN26ryl--

