MIME-Version: 1.0
Date: Mon, 29 May 2006 11:19:26 -0700
From: "Nathaniel J Villaume" <villaume@domain.hid>
Message-Id: <1148926766-13365.00015.03259-smmsdV2.1.4@domain.hid>
Subject: Re: [Xenomai-help] rt_heap_delete in asynchronous context
In-Reply-To: <17530.60656.867991.966403@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Reply-To: Nathaniel.J.Villaume@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Nathaniel.J.Villaume@domain.hid

Gilles, 

Thanks for the reply. Sure enough, binding to the heap allows me
to delete it.  I wanted to update the documentation, but I'm not
sure I understand it well enough.  Here's my attempt
 --I hope it clarifies rather than obscures! :

--- ksrc/skins/native/heap.c 2006-04-09 14:03:50.000000000 -0700
+++ ksrc/skins/native/heap.c.new 2006-05-27 22:54:44.000000000 -0700
@@ -351,7 +351,8 @@
  * - -EIDRM is returned if @a heap is a deleted heap descriptor.
  *
  * - -EPERM is returned if this service was called from an
- * asynchronous context.
+ * asynchronous context. The heap may first need to be
associated with the
+ * calling process using rt_heap_bind().
  *
  * Environments:
  *



