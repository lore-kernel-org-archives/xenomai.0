Message-ID: <b647ffbd0604270116j5a32bb22j26e3317488ec8f42@domain.hid>
Date: Thu, 27 Apr 2006 11:16:12 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <b647ffbd0604240228sb8d58a3kc3b780a576c2d95a@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_630_25861044.1146125772069"
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
	<44416943.4070702@domain.hid>
	<b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>
	<444C89F4.3040302@domain.hid>
	<b647ffbd0604240228sb8d58a3kc3b780a576c2d95a@domain.hid>
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_630_25861044.1146125772069
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

this fix prevents possible deadlocks in rt_intr_delete() vs. ISR
handlers that I have mentioned earlier.

--
Best regards,
Dmitry Adamushko

------=_Part_630_25861044.1146125772069
Content-Type: application/octet-stream; name=native-intr.c-delete-rework.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="native-intr.c-delete-rework.patch"

--- intr-CVS.c	2006-04-27 10:29:16.000000000 +0200
+++ intr.c	2006-04-27 10:36:58.000000000 +0200
@@ -331,33 +331,32 @@ int rt_intr_delete (RT_INTR *intr)
     if (!intr)
         {
         err = xeno_handle_error(intr,XENO_INTR_MAGIC,RT_INTR);
-        goto unlock_and_exit;
+	xnlock_put_irqrestore(&nklock,s);
+	return err;
         }
     
     removeq(&__xeno_intr_q,&intr->link);
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     rc = xnsynch_destroy(&intr->synch_base);
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
-    xnintr_detach(&intr->intr_base);
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
     if (intr->handle)
         xnregistry_remove(intr->handle);
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
-    xnintr_destroy(&intr->intr_base);
-
     xeno_mark_deleted(intr);
 
+    xnlock_put_irqrestore(&nklock,s);
+
+    err = xnintr_detach(&intr->intr_base);
+    xnintr_destroy(&intr->intr_base);
+
     if (rc == XNSYNCH_RESCHED)
         /* Some task has been woken up as a result of the deletion:
            reschedule now. */
         xnpod_schedule();
 
- unlock_and_exit:
-
-    xnlock_put_irqrestore(&nklock,s);
-
     return err;
 }
 

------=_Part_630_25861044.1146125772069
Content-Type: application/octet-stream; name=posix-intr.c-delete-rework.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.2
Content-Disposition: attachment; filename="posix-intr.c-delete-rework.patch"

--- intr-CVS.c	2006-04-27 10:39:26.000000000 +0200
+++ intr.c	2006-04-27 10:41:17.000000000 +0200
@@ -174,18 +174,19 @@ int pthread_intr_detach_np (pthread_intr
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     rc = xnsynch_destroy(&intr->synch_base);
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
-    xnintr_detach(&intr->intr_base);
-
-    xnintr_destroy(&intr->intr_base);
 
     pse51_mark_deleted(intr);
 
     removeq(&pse51_intrq, &intr->link);
 
+    xnlock_put_irqrestore(&nklock, s);
+
+    xnintr_detach(&intr->intr_base);
+    xnintr_destroy(&intr->intr_base);
+
     if (rc == XNSYNCH_RESCHED)
         xnpod_schedule();
 
-    xnlock_put_irqrestore(&nklock, s);
     xnfree(intr);
 
     return 0;

------=_Part_630_25861044.1146125772069
Content-Type: application/octet-stream; name=Changelog-delete-rework.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.3
Content-Disposition: attachment; filename="Changelog-delete-rework.patch"

--- ChangeLog	2006-04-06 22:37:32.000000000 +0200
+++ ChangeLog-new	2006-04-27 10:56:03.000000000 +0200
@@ -1,3 +1,10 @@
+
+2006-04-27  Dmitry Adamushko  <dmitry.adamushko@domain.hid>
+
+	* ksrc/skins/native/intr.c (rt_intr_delete):
+	  ksrc/skins/posix/intr.c (pthread_intr_detach_np): Call xnintr_detach()
+	  with nklock unlocked.
+
 2006-04-06  Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
 
 	* ksrc/skins/native/snippets/sigxcpu.c (task_body): Fix parameters

------=_Part_630_25861044.1146125772069--

