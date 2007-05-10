Message-ID: <4642DAA6.70200@domain.hid>
Date: Thu, 10 May 2007 10:41:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>		<4641CD8B.8050309@domain.hid>		<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>		<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>		<17986.12574.488256.997900@domain.hid>		<17986.15326.243315.427529@domain.hid>		<1178748178.11688.45.camel@domain.hid>		<17986.20728.617772.991566@domain.hid>	<1178784303.11688.108.camel@domain.hid>
	<4642D901.9050304@domain.hid>
In-Reply-To: <4642D901.9050304@domain.hid>
Content-Type: multipart/mixed; boundary="------------030308010509040909000103"
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030308010509040909000103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit

Gilles Chanteperdrix wrote:
> +#define xnfreesafe(thread,ptr,ln) xnheap_schedule_free(&kheap,ptr,ln);

And without the semi-colon.

-- 
                                                 Gilles Chanteperdrix

--------------030308010509040909000103
Content-Type: text/x-patch;
 name="xeno-safer-xnfreesafe.diff"
Content-Disposition: inline;
 filename="xeno-safer-xnfreesafe.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/heap.h	(r=C3=A9vision 3042)
+++ include/nucleus/heap.h	(copie de travail)
@@ -117,13 +117,7 @@
 #define xnmalloc(size)     xnheap_alloc(&kheap,size)
 #define xnfree(ptr)        xnheap_free(&kheap,ptr)
 #define xnfreesync()       xnheap_finalize_free(&kheap)
-#define xnfreesafe(thread,ptr,ln) \
-do { \
-    if (xnpod_current_thread() =3D=3D thread) \
-	xnheap_schedule_free(&kheap,ptr,ln); \
-    else \
-	xnheap_free(&kheap,ptr); \
-} while(0)
+#define xnfreesafe(thread,ptr,ln) xnheap_schedule_free(&kheap,ptr,ln)
=20
 static inline size_t xnheap_rounded_size (size_t hsize, size_t psize)
 {

--------------030308010509040909000103--

