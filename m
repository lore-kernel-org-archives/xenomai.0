Message-ID: <4677B0CB.30802@domain.hid>
Date: Tue, 19 Jun 2007 12:32:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF87635BE86F775F7322E60C8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] use task_thread_info over 2.6.x
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF87635BE86F775F7322E60C8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

with 2.6.22, task_struct no longer contains thread_info. Users should
have migrated to task_thread_info() already, Xenomai did not yet. This
patch performs this for i386, x86_64, and ia64. ARM still needs to be fix=
ed.

Jan


Index: include/asm-ia64/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-ia64/wrappers.h	(Revision 2609)
+++ include/asm-ia64/wrappers.h	(Arbeitskopie)
@@ -33,7 +33,7 @@
=20
 #else /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,0)  */
=20
-#define wrap_access_ok(task,addr,size) __access_ok((addr),(size),(task)-=
>thread_info->addr_limit)
+#define wrap_access_ok(task,addr,size) __access_ok((addr),(size),task_th=
read_info(task)->addr_limit)
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,16)
 #define task_pt_regs(t)  ia64_task_regs(t)
Index: include/asm-i386/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-i386/wrappers.h	(Revision 2609)
+++ include/asm-i386/wrappers.h	(Arbeitskopie)
@@ -61,18 +61,18 @@ do {				  \
 	unsigned long flag,sum; \
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
 		:"=3D&r" (flag), "=3Dr" (sum) \
-	        :"1" (addr),"g" ((int)(size)),"g" ((task)->thread_info->addr_li=
mit.seg)); \
+	        :"1" (addr),"g" ((int)(size)),"g" (task_thread_info(task)->addr=
_limit.seg)); \
 	flag =3D=3D 0; })
=20
 #define wrap_test_fpu_used(task)  \
-   ((task)->thread_info->status & TS_USEDFPU)
+   (task_thread_info(task)->status & TS_USEDFPU)
 #define wrap_set_fpu_used(task)   \
 do { \
-   (task)->thread_info->status |=3D TS_USEDFPU; \
+   task_thread_info(task)->status |=3D TS_USEDFPU; \
 } while(0)
 #define wrap_clear_fpu_used(task) \
 do { \
-   (task)->thread_info->status &=3D ~TS_USEDFPU; \
+   task_thread_info(task)->status &=3D ~TS_USEDFPU; \
 } while(0)
=20
 static inline void wrap_switch_iobitmap (struct task_struct *p, int cpu)=

Index: include/asm-x86_64/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-x86_64/syscall.h	(Revision 2609)
+++ include/asm-x86_64/syscall.h	(Arbeitskopie)
@@ -61,7 +61,7 @@
 	unsigned long flag,sum; \
 	asm("addq %3,%1 ; sbbq %0,%0; cmpq %1,%4; sbbq $0,%0" \
 		:"=3D&r" (flag), "=3Dr" (sum) \
-	        :"1" (addr),"g" ((long)(size)),"g" ((task)->thread_info->addr_l=
imit.seg)); \
+	        :"1" (addr),"g" ((long)(size)),"g" (task_thread_info(task)->add=
r_limit.seg)); \
 	flag =3D=3D 0; })
=20
 #define __xn_access_ok(task,type,addr,size)	(__xn_range_ok(task,addr,siz=
e))=20


--------------enigF87635BE86F775F7322E60C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd7DLniDOoMHTA+kRAos+AJ9HcyE6f0Cj7hExQix3Z2UIcyxbzQCfSqdg
4XFpi9KGf9c4F4spcm210Kc=
=XZrX
-----END PGP SIGNATURE-----

--------------enigF87635BE86F775F7322E60C8--

