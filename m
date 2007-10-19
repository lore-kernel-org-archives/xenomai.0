Message-ID: <4718651D.9070602@domain.hid>
Date: Fri, 19 Oct 2007 10:04:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4717C642.6030002@domain.hid> <1192764423.6252.4.camel@domain.hid>
In-Reply-To: <1192764423.6252.4.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------020104080207000805040208"
Subject: [Xenomai-core] [PATCH] avoid resched test on syscall entry (was:
 xnsched_resched_p test in hisyscall)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020104080207000805040208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> On Thu, 2007-10-18 at 22:46 +0200, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> what's the point about
>>
>> 	if (xnsched_resched_p())
>> 		xnpod_schedule();
>>
>> at the beginning of do_hisyscall_event() [1]? Could you provide a
>> comment for the background of this hunk? Or can we even remove it?
> 
> No, we can't. It's a Blackfin-specific thing in disguise actually, so we
> may make this code conditional through some arch-dependent wrapper
> though.
> http://www.rts.uni-hannover.de/xenomai/lxr/source/include/asm-blackfin/bits/pod.h#141
> 

Something like the attached patch?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020104080207000805040208
Content-Type: text/x-patch;
 name="add-xnarch_hisyscall_entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-xnarch_hisyscall_entry.patch"

---
 include/asm-blackfin/system.h |    7 +++++++
 include/asm-generic/system.h  |    4 ++++
 ksrc/nucleus/shadow.c         |    3 +--
 3 files changed, 12 insertions(+), 2 deletions(-)

Index: xenomai/include/asm-blackfin/system.h
===================================================================
--- xenomai.orig/include/asm-blackfin/system.h
+++ xenomai/include/asm-blackfin/system.h
@@ -95,6 +95,13 @@ static inline void xnarch_free_host_mem 
     kfree(chunk);
 }
 
+static inline void xnarch_hisyscall_entry(void)
+{
+	if (xnsched_resched_p())
+		xnpod_schedule();
+}
+#define xnarch_hisyscall_entry	xnarch_hisyscall_entry
+
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/include/asm-generic/system.h
===================================================================
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -410,6 +410,10 @@ static inline int xnarch_remap_io_page_r
     return wrap_remap_io_page_range(vma,from,to,size,prot);
 }
 
+#ifndef xnarch_hisyscall_entry
+static inline void xnarch_hisyscall_entry(void)	{ }
+#endif
+
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/ksrc/nucleus/shadow.c
===================================================================
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -1878,8 +1878,7 @@ static inline int do_hisyscall_event(uns
 	if (!xnpod_active_p())
 		goto no_skin;
 
-	if (xnsched_resched_p())
-		xnpod_schedule();
+	xnarch_hisyscall_entry();
 
 	p = current;
 	thread = xnshadow_thread(p);

--------------020104080207000805040208--

