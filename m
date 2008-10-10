Message-ID: <48EF1B17.807@domain.hid>
Date: Fri, 10 Oct 2008 11:06:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3298865.1223620599925.JavaMail.ngmail@domain.hid>
	<48EE2BF6.60300@domain.hid>	<15875130.1223557641586.JavaMail.ngmail@domain.hid>
	<8227750.1223626784795.JavaMail.ngmail@domain.hid>
In-Reply-To: <8227750.1223626784795.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Bug with Xenomai and xeno_heap: Eeek!
 page_mapcount(page) went negative!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hello Gilles,
> 
> I tried a couple of Xenomai/Kernel combinations.
> The result is the following:
> 
> Xeno 2.4.4 and kernel 2.6.25: ok 
> Xeno 2.4.5 and kernel 2.6.25: ok 
> Xeno 2.4.5 and kernel 2.6.26: crash
> (In all tests, I used the adeos patch that was part of the release Xenomai version).
> 
> Thus, some rmap code in kernel 2.6.26 seems to be different than with 2.6.25.
> 
> I hope that helps to find out what is wrong...

Yes, thanks. This is a bug which should have been fixed since then. But 
here is a patch for your version. Could you try it?


diff --git a/include/linux/mm.h b/include/linux/mm.h
index 816cf71..568cd8d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -109,7 +109,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear pages */
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 
-#define VM_PINNED	0x10000000	/* Disable faults for the vma */
+#define VM_PINNED	0x20000000	/* Disable faults for the vma */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS


-- 
                                                 Gilles.

