Subject: Re: [Xenomai-core] Build problems with xenomai PPC vxworks skin
	for target TQM8555 board
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FA9961D07FD27B4EB6058C0F35F3D0D124112A@CSGMX.es.xeroxlabs.com>
References: <FA9961D07FD27B4EB6058C0F35F3D0D124112A@CSGMX.es.xeroxlabs.com>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 20:50:54 +0200
Message-Id: <1160938254.4962.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Chau, Ngaiman" <Ngaiman.Chau@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-10-12 at 17:40 -0700, Chau, Ngaiman wrote:

>   Question 1)
> 
> >     The Satch runs ok except the size return from the msqQRecive()
> is 
> 
> > always -1, not sure why? (vxwork api size return should be the
> number of bytes
> 

There was a subtle bug causing spurious argument shadowing when
attempting to pass the result code back to user-space. The following
patch fixes the issue for ppc. All archs need to be fixed, and have been
updated accordingly, both in the maintenance and development branch.
Thanks for reporting this issue.

--- include/asm-powerpc/syscall.h	(revision 1719)
+++ include/asm-powerpc/syscall.h	(working copy)
@@ -54,9 +54,9 @@
    have checked for bad range before using the copy macros, so we
    should not have to care about the result. */
 #define __xn_copy_from_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_from_user_inatomic(dstP,srcP,n); err; })
+    ({ int __err__ = __copy_from_user_inatomic(dstP,srcP,n); __err__; })
 #define __xn_copy_to_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_to_user_inatomic(dstP,srcP,n); err; })
+    ({ int __err__ = __copy_to_user_inatomic(dstP,srcP,n); __err__; })
 #define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
 #define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
 #define __xn_strncpy_from_user(task,dstP,srcP,n)    __strncpy_from_user(dstP,srcP,n)

> > received)
> 
>  
> 
> > Question 2)
> 
> >     I try and proceed to add the Koan.c file to the Makefile,
> however, 
> 
> > it runs into compilation error even thought I add the main() and 
> 
> > RootTask as in Satch.c does.

koan.c won't run in this context. It was aimed at demonstrating the
capabilities of the UVM, which has been deprecated recently. Basically,
the issue is that you don't have access to kernel hooks such as
tickAnnounce() and friends in mere user-space context with a direct
syscall interface. This file will be removed from the trunk/ shortly.

-- 
Philippe.



