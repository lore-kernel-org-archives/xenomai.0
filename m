From: Paul <paul_c@domain.hid>
Date: Sat, 20 Sep 2008 11:19:02 +0100
References: <200808251743.26012@domain.hid> <200809151504.491@domain.hid>
	<48CE9B69.8010604@domain.hid>
In-Reply-To: <48CE9B69.8010604@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W4M1IJwJAZLWgWN"
Message-Id: <200809201119.02149.paul_c@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_W4M1IJwJAZLWgWN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Philippe

On Monday 15 September 2008, Philippe Gerum wrote:
> Petr Cervenka wrote:
> > I tried the patch on xenomai 2.4.5. After a couple of my long run tests I
> > have found no errors. So I am very satisfied with it ;-)
>
> Ok, thanks. I'm queuing this patch for commit to both branches then.

It would appear that the patch is missing changes in a couple of spots that is 
causing kernel compiles to break - Assuming the secord arg to 
xnheap_destroy_mapped is NULL, the attached (trivial) patch addresses the 
problem in TRUNK.


Regards, Paul.



--Boundary-00=_W4M1IJwJAZLWgWN
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="xnheap_destroy_mapped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xnheap_destroy_mapped.patch"

Index: ksrc/nucleus/module.c
===================================================================
--- ksrc/nucleus/module.c	(revision 4175)
+++ ksrc/nucleus/module.c	(working copy)
@@ -1238,7 +1238,7 @@ void __exit __xeno_sys_exit(void)
 #endif /* CONFIG_XENO_OPT_PIPE */
 #endif /* __KERNEL__ */
 
-	xnheap_destroy_mapped(&__xnsys_global_ppd.sem_heap);
+	xnheap_destroy_mapped(&__xnsys_global_ppd.sem_heap, NULL);
 
 	if (nkmsgbuf)
 		xnarch_free_host_mem(nkmsgbuf, XNPOD_FATAL_BUFSZ);
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 4175)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1954,7 +1954,7 @@ static void *xnshadow_sys_event(int even
 	case XNSHADOW_CLIENT_DETACH:
 		p = ppd2sys((xnshadow_ppd_t *) data);
 
-		xnheap_destroy_mapped(&p->sem_heap);
+		xnheap_destroy_mapped(&p->sem_heap, NULL);
 
 		return NULL;
 	}

--Boundary-00=_W4M1IJwJAZLWgWN--

