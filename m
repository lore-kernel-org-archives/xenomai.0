Message-ID: <43830785.6010402@domain.hid>
Date: Tue, 22 Nov 2005 12:56:53 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] define your own pipe heap
References: <4382201C.8040503@domain.hid>	<43825E4C.4030002@domain.hid>
	<4382F115.5010007@domain.hid>
	<4382F81D.8020303@domain.hid>
In-Reply-To: <4382F81D.8020303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFCFB25E2EB4646C3C1951E21"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFCFB25E2EB4646C3C1951E21
Content-Type: multipart/mixed; boundary="------------090706030703050803070102"

This is a multi-part message in MIME format.
--------------090706030703050803070102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>
>>> ...
>>> A patch says more than thousand words. ;)
>>>
>>> As a first approach, I picked the second variant and implemented a ne=
w
>>> function called rt_pipe_setpool. I also had to extend rt_pipe_alloc a=
nd
>>> rt_pipe_free so that the right pool is used by them.
>>>
>>
>>
>> I thought about this variant again, and it seems to me rather unsafe i=
n
>> case some buffer allocation takes place between rt_pipe_create and
>> rt_pipe_setpool. So, here is a patch which extends rt_pipe_create with=
 a
>> new argument poolsize instead.
>>
>=20
> Yep, looks safer to me too.
>=20

Ok, I addressed most your comments, and here is round 2 of variant 2.
The only question for me is if we should rt_pipe_create in kernel space
from RT context with poolsize=3D0 if this is prevented effectively for
userspace task? So far, I deny any non-RT invocation.

Jan

--------------090706030703050803070102
Content-Type: text/plain;
 name="rt_pipe_create-ext.patch2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rt_pipe_create-ext.patch2"

Index: skins/native/pipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/native/pipe.h	(revision 165)
+++ skins/native/pipe.h	(working copy)
@@ -37,6 +37,8 @@
=20
 #ifdef __KERNEL__
=20
+#include <nucleus/heap.h>
+
 #define XENO_PIPE_MAGIC 0x55550202
=20
 typedef xnpipe_mh_t RT_PIPE_MSG;
@@ -57,6 +59,10 @@
=20
     RT_PIPE_MSG *buffer;	/* !< Buffer used in byte stream mode. */
=20
+    xnheap_t *bufpool;		/* !< Current buffer pool. */
+
+    xnheap_t privpool;		/* !< Private buffer pool. */
+
     size_t fillsz;		/* !< Bytes written to the buffer.  */
=20
     u_long flushable;		/* !< Flush request flag. */
@@ -85,7 +91,8 @@
=20
 int rt_pipe_create(RT_PIPE *pipe,
 		   const char *name,
-		   int minor);
+		   int minor,
+		   size_t poolsize);
=20
 int rt_pipe_delete(RT_PIPE *pipe);
=20
@@ -113,9 +120,11 @@
 		     size_t size,
 		     int mode);
=20
-RT_PIPE_MSG *rt_pipe_alloc(size_t size);
+RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,
+                           size_t size);
=20
-int rt_pipe_free(RT_PIPE_MSG *msg);
+int rt_pipe_free(RT_PIPE *pipe,
+                 RT_PIPE_MSG *msg);
=20
 ssize_t rt_pipe_flush(RT_PIPE *pipe);
=20
Index: skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/native/syscall.c	(revision 165)
+++ skins/native/syscall.c	(working copy)
@@ -3194,6 +3194,7 @@
     char name[XNOBJECT_NAME_LEN];
     RT_PIPE_PLACEHOLDER ph;
     int err, minor;
+    size_t poolsize;
     RT_PIPE *pipe;
=20
     if (!__xn_access_ok(curr,VERIFY_WRITE,__xn_reg_arg1(regs),sizeof(ph)=
))
@@ -3213,12 +3214,15 @@
     /* Device minor. */
     minor =3D (int)__xn_reg_arg3(regs);
=20
+    /* Buffer pool size. */
+    poolsize =3D (size_t)__xn_reg_arg4(regs);
+
     pipe =3D (RT_PIPE *)xnmalloc(sizeof(*pipe));
=20
     if (!pipe)
 	return -ENOMEM;
=20
-    err =3D rt_pipe_create(pipe,name,minor);
+    err =3D rt_pipe_create(pipe,name,minor,poolsize);
=20
     if (err =3D=3D 0)
 	{
@@ -3332,7 +3336,7 @@
     /* Zero-sized messages are allowed, so we still need to free the
        message buffer even if no data copy took place. */
=20
-    rt_pipe_free(msg);
+    rt_pipe_free(pipe,msg);
=20
     return err;
 }
@@ -3374,7 +3378,7 @@
     if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),size))
 	return -EFAULT;
=20
-    msg =3D rt_pipe_alloc(size);
+    msg =3D rt_pipe_alloc(pipe,size);
 =09
     if (!msg)
 	return -ENOMEM;
@@ -3386,7 +3390,7 @@
     if (err !=3D size)
 	/* If the operation failed, we need to free the message buffer
 	   by ourselves. */
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
=20
     return err;
 }
@@ -3436,7 +3440,7 @@
 	}
     else
 	{
-	msg =3D rt_pipe_alloc(size);
+	msg =3D rt_pipe_alloc(pipe,size);
 =09
 	if (!msg)
 	    return -ENOMEM;
@@ -3449,7 +3453,7 @@
     err =3D rt_pipe_stream(pipe,buf,size);
=20
     if (msg)
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
=20
     return err;
 }
@@ -3595,7 +3599,7 @@
     [__xeno_intr_enable ] =3D { &__rt_intr_enable, __xn_exec_any },
     [__xeno_intr_disable ] =3D { &__rt_intr_disable, __xn_exec_any },
     [__xeno_intr_inquire ] =3D { &__rt_intr_inquire, __xn_exec_any },
-    [__xeno_pipe_create ] =3D { &__rt_pipe_create, __xn_exec_any },
+    [__xeno_pipe_create ] =3D { &__rt_pipe_create, __xn_exec_lostage },
     [__xeno_pipe_bind ] =3D { &__rt_pipe_bind, __xn_exec_conforming },
     [__xeno_pipe_delete ] =3D { &__rt_pipe_delete, __xn_exec_any },
     [__xeno_pipe_read ] =3D { &__rt_pipe_read, __xn_exec_primary },
Index: skins/native/lib/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/native/lib/pipe.c	(revision 165)
+++ skins/native/lib/pipe.c	(working copy)
@@ -23,13 +23,15 @@
=20
 int rt_pipe_create (RT_PIPE *pipe,
 		    const char *name,
-		    int minor)
+		    int minor,
+		    size_t poolsize)
 {
-    return XENOMAI_SKINCALL3(__xeno_muxid,
+    return XENOMAI_SKINCALL4(__xeno_muxid,
 			     __xeno_pipe_create,
 			     pipe,
 			     name,
-			     minor);
+			     minor,
+			     poolsize);
 }
=20
 int rt_pipe_bind (RT_PIPE *pipe,
Index: skins/native/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/native/pipe.c	(revision 165)
+++ skins/native/pipe.c	(working copy)
@@ -50,8 +50,6 @@
 #include <native/registry.h>
 #include <native/pipe.h>
=20
-static xnheap_t *__pipe_heap =3D &kheap;
-
 static int __pipe_flush_apc;
=20
 static DECLARE_XNQUEUE(__pipe_flush_q);
@@ -83,6 +81,14 @@
=20
 #endif /* CONFIG_XENO_NATIVE_EXPORT_REGISTRY */
=20
+static void __pipe_flush_pool (xnheap_t *heap,
+                               void *poolmem,
+                               u_long poolsize,
+                               void *cookie)
+{
+    xnarch_sysfree(poolmem,poolsize);
+}
+
 static inline ssize_t __pipe_flush (RT_PIPE *pipe)
=20
 {
@@ -122,8 +128,10 @@
 				   size_t size,
 				   void *cookie)
 {
+    RT_PIPE *pipe =3D (RT_PIPE *)cookie;
+
     /* Allocate memory for the incoming message. */
-    return xnheap_alloc(__pipe_heap,size);
+    return xnheap_alloc(pipe->bufpool,size);
 }
=20
 static int __pipe_output_handler (int bminor,
@@ -131,8 +139,10 @@
 				  int retval,
 				  void *cookie)
 {
+    RT_PIPE *pipe =3D (RT_PIPE *)cookie;
+
     /* Free memory from output/discarded message. */
-    xnheap_free(__pipe_heap,mh);
+    xnheap_free(pipe->bufpool,mh);
     return retval;
 }
=20
@@ -154,7 +164,7 @@
 }
=20
 /**
- * @fn int rt_pipe_create(RT_PIPE *pipe,const char *name,int minor)
+ * @fn int rt_pipe_create(RT_PIPE *pipe,const char *name,int minor, size=
_t poolsize)
  * @brief Create a message pipe.
  *
  * This service opens a bi-directional communication channel allowing
@@ -201,6 +211,10 @@
  * /proc/xenomai/registry/pipes/@a name to the allocated pipe device
  * entry (i.e. /dev/rtp*).
  *
+ * @param poolsize Specifies the size of a dedicated buffer pool for the=

+ * pipe. Passing 0 means that all message allocations for this pipe are
+ * performed on the system heap.
+ *
  * @return 0 is returned upon success. Otherwise:
  *
  * - -ENOMEM is returned if the system fails to get enough dynamic
@@ -232,20 +246,55 @@
=20
 int rt_pipe_create (RT_PIPE *pipe,
 		    const char *name,
-		    int minor)
+		    int minor,
+		    size_t poolsize)
 {
     int err =3D 0;
+    void *poolmem;
=20
-    if (xnpod_asynch_p())
+    if (!xnpod_root_p())
 	return -EPERM;
=20
     pipe->buffer =3D NULL;
+    pipe->bufpool =3D &kheap;
     pipe->fillsz =3D 0;
     pipe->flushable =3D 0;
     pipe->handle =3D 0;    /* i.e. (still) unregistered pipe. */
     pipe->magic =3D XENO_PIPE_MAGIC;
     xnobject_copy_name(pipe->name,name);
=20
+    if (poolsize > 0)
+	{
+	/* Make sure we won't hit trivial argument errors when calling
+	   xnheap_init(). */
+
+	if (poolsize < 2 * PAGE_SIZE)
+	    poolsize =3D 2 * PAGE_SIZE;
+
+	/* Account for the overhead so that the actual free space is large
+	   enough to match the requested size. */
+
+	poolsize +=3D xnheap_overhead(poolsize,PAGE_SIZE);
+	poolsize =3D PAGE_ALIGN(poolsize);
+
+	poolmem =3D xnarch_sysalloc(poolsize);
+
+	if (!poolmem)
+	    return -ENOMEM;
+
+	err =3D xnheap_init(&pipe->privpool,
+	                  poolmem,
+	                  poolsize,
+	                  PAGE_SIZE); /* Use natural page size */
+	if (err)
+	    {
+	    xnarch_sysfree(poolmem,poolsize);
+	    return err;
+	    }
+
+	pipe->bufpool =3D &pipe->privpool;
+	}
+
     minor =3D xnpipe_connect(minor,
 			 &__pipe_output_handler,
 			 NULL,
@@ -253,7 +302,12 @@
 			 pipe);
=20
     if (minor < 0)
+	{
+	if (pipe->bufpool =3D=3D &pipe->privpool)
+	    xnheap_destroy(&pipe->privpool,__pipe_flush_pool,NULL);
+
 	return minor;
+	}
=20
     pipe->minor =3D minor;
=20
@@ -337,14 +391,15 @@
     if (!pipe)
 	{
 	err =3D xeno_handle_error(pipe,XENO_PIPE_MAGIC,RT_PIPE);
-	goto unlock_and_exit;
+	xnlock_put_irqrestore(&nklock,s);
+	return err;
 	}
=20
     if (__test_and_clear_bit(0,&pipe->flushable))
 	{
 	/* Purge data waiting for flush. */
 	removeq(&__pipe_flush_q,&pipe->link);
-	rt_pipe_free(pipe->buffer);
+	rt_pipe_free(pipe,pipe->buffer);
 	}
=20
     err =3D xnpipe_disconnect(pipe->minor);
@@ -356,10 +411,11 @@
=20
     xeno_mark_deleted(pipe);
=20
- unlock_and_exit:
-
     xnlock_put_irqrestore(&nklock,s);
=20
+    if (pipe->bufpool =3D=3D &pipe->privpool)
+	xnheap_destroy(&pipe->privpool,__pipe_flush_pool,NULL);
+
     return err;
 }
=20
@@ -572,7 +628,7 @@
     /* Zero-sized messages are allowed, so we still need to free the
        message buffer even if no data copy took place. */
=20
-    rt_pipe_free(msg);
+    rt_pipe_free(pipe,msg);
=20
     return nbytes;
 }
@@ -767,7 +823,7 @@
 	/* Try flushing the streaming buffer in any case. */
 	return rt_pipe_send(pipe,NULL,0,mode);
=20
-    msg =3D rt_pipe_alloc(size);
+    msg =3D rt_pipe_alloc(pipe,size);
 =09
     if (!msg)
 	return -ENOMEM;
@@ -779,7 +835,7 @@
     if (nbytes !=3D size)
 	/* If the operation failed, we need to free the message buffer
 	   by ourselves. */
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
=20
     return nbytes;
 }
@@ -886,7 +942,7 @@
=20
 	if (pipe->buffer =3D=3D NULL)
 	    {
-	    pipe->buffer =3D rt_pipe_alloc(CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ);
+	    pipe->buffer =3D rt_pipe_alloc(pipe,CONFIG_XENO_OPT_NATIVE_PIPE_BUF=
SZ);
=20
 	    if (pipe->buffer =3D=3D NULL)
 		{
@@ -984,15 +1040,17 @@
 }
=20
 /**
- * @fn RT_PIPE_MSG *rt_pipe_alloc(size_t size)
+ * @fn RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,size_t size)
  *
  * @brief Allocate a message pipe buffer.
  *
- * This service allocates a message buffer from the system heap which
+ * This service allocates a message buffer from the pipe's heap which
  * can be subsequently filled by the caller then passed to
  * rt_pipe_send() for sending. The beginning of the available data
  * area of @a size contiguous bytes is accessible from P_MSGPTR(msg).
  *
+ * @param pipe The descriptor address of the affected pipe.
+ *
  * @param size The requested size in bytes of the buffer. This value
  * should represent the size of the payload data.
  *
@@ -1010,10 +1068,11 @@
  * Rescheduling: never.
  */
=20
-RT_PIPE_MSG *rt_pipe_alloc (size_t size)
+RT_PIPE_MSG *rt_pipe_alloc (RT_PIPE *pipe,
+                            size_t size)
=20
 {
-    RT_PIPE_MSG *msg =3D (RT_PIPE_MSG *)xnheap_alloc(__pipe_heap,size + =
sizeof(RT_PIPE_MSG));
+    RT_PIPE_MSG *msg =3D (RT_PIPE_MSG *)xnheap_alloc(pipe->bufpool,size =
+ sizeof(RT_PIPE_MSG));
=20
     if (msg)
 	{
@@ -1025,13 +1084,15 @@
 }
=20
 /**
- * @fn int rt_pipe_free(RT_PIPE_MSG *msg)
+ * @fn int rt_pipe_free(RT_PIPE *pipe,RT_PIPE_MSG *msg)
  *
  * @brief Free a message pipe buffer.
  *
  * This service releases a message buffer returned by
- * rt_pipe_receive() to the system heap.
+ * rt_pipe_receive() to the pipe's heap.
  *
+ * @param pipe The descriptor address of the affected pipe.
+ *
  * @param msg The address of the message buffer to free.
  *
  * @return 0 is returned upon success, or -EINVAL if @a msg is not a
@@ -1049,9 +1110,9 @@
  * Rescheduling: never.
  */
=20
-int rt_pipe_free (RT_PIPE_MSG *msg)
+int rt_pipe_free (RT_PIPE *pipe,RT_PIPE_MSG *msg)
 {
-    return xnheap_free(__pipe_heap,msg);
+    return xnheap_free(pipe->bufpool,msg);
 }
=20
 /*@}*/
Index: testsuite/klatency/latency-module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testsuite/klatency/latency-module.c	(revision 165)
+++ testsuite/klatency/latency-module.c	(working copy)
@@ -83,7 +83,7 @@
 	maxjitter =3D maxj;
 	avgjitter =3D sumj / sample_count;
=20
-	msg =3D rt_pipe_alloc(sizeof(struct latency_stat));
+	msg =3D rt_pipe_alloc(&pipe,sizeof(struct latency_stat));
=20
 	if (!msg)
 	    {
@@ -103,7 +103,7 @@
 	   ourselves. */
=20
 	if (rt_pipe_send(&pipe,msg,sizeof(*s),0) !=3D sizeof(*s))
-	    rt_pipe_free(msg);
+	    rt_pipe_free(&pipe,msg);
 	}
 }
=20
@@ -128,7 +128,7 @@
 	return 2;
 	}
=20
-    err =3D rt_pipe_create(&pipe,"klatency",0);
+    err =3D rt_pipe_create(&pipe,"klatency",0,0);
=20
     if (err)
 	{

--------------090706030703050803070102--

--------------enigFCFB25E2EB4646C3C1951E21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDgweFncNeS9Q0k+IRAnoXAJ4hjXQ4KmSj9P+Wne5h7KjXrTzb3gCgjEwT
qfp+Co6Ds1mBVgeL6uPeOkg=
=UL6H
-----END PGP SIGNATURE-----

--------------enigFCFB25E2EB4646C3C1951E21--

