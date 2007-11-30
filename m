Message-ID: <474FEC18.7040304@domain.hid>
Date: Fri, 30 Nov 2007 11:55:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3C69D@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE3C69D@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/mixed; boundary="------------070702020308090009080203"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write strange behaviour ++
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070702020308090009080203
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Roderik.Wildenburg@domain.hid wrote:
> Sorry, but in my last mail (see below) I had forgotten to tell you my=20
> Xenomai-Version and architecture.
> I still use Xenomai 2.3.2 on PPC.
>=20
> In the meantime I had a deeper look into the Xenomai source code=20
> and I would say, the case we observed (msg->refcount =3D=3D 0 ; see below)
> isn=B4t possible with rt_queue_write, as this function implicitly allocat=
e=20
> its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
> Immediatelly after this rt_queue_send is called, where the=20
> plausibility test if( msg->refcount =3D=3D 0) is done and fails.=20
> So, I can=B4t see a gap where refcount falls back to 0.

Does the attached patch trigger any message when your app fails?

--=20
Philippe.

--------------070702020308090009080203
Content-Type: text/x-patch;
 name="heap-check-block-trace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="heap-check-block-trace.patch"

Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 3224)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -911,8 +911,10 @@
 			break;
 	}
 
-	if (!holder)
+	if (!holder) {
+		printk(KERN_DEBUG "XNHEAP: no extent found: block=%p\n", block);
 		goto bad_block;
+	}
 
 	/* Compute the heading page number in the page map. */
 	pagenum = ((caddr_t) block - extent->membase) >> heap->pageshift;
@@ -922,9 +924,11 @@
 	ptype = extent->pagemap[pagenum].type;
 
 	if (ptype == XNHEAP_PFREE ||	/* Unallocated page? */
-	    ptype == XNHEAP_PCONT)	/* Not a range heading page? */
+	    ptype == XNHEAP_PCONT) {	/* Not a range heading page? */
+		printk(KERN_DEBUG "XNHEAP: bad page type: 0x%x\n", ptype);
   bad_block: 
 		err = -EINVAL;
+	}
 
 	xnlock_put_irqrestore(&heap->lock, s);
 

--------------070702020308090009080203--

