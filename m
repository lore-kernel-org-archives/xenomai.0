Message-ID: <503B637F.4060302@xenomai.org>
Date: Mon, 27 Aug 2012 14:09:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201208262252.27556.paul_c@tuxcnc.org>
In-Reply-To: <201208262252.27556.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/26/2012 11:52 PM, Paul wrote:

> 
> Finally got hold of an RS232 interface for my ARM1176 board and have 
> been trying to capture a fatal kernel crash log. Have compiled various 
> kernels and pared the config down to a bare minimum - The trace for the 
> latest crash is attached. This happens when unloading xeno-nucleus, 
> kinda at a loss as to where to go from here, so any pointers would be 
> much appreciated.


Please try the following patch:
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 5eb7c52..052fcb5 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -92,8 +92,19 @@ static inline void init_hostrt(void)
 	nkvdso->hostrt_data.live = 0;
 	rthal_catch_hostrt(&hostrt_event);
 }
+
+static inline void cleanup_hostrt(void)
+{
+	rthal_catch_hostrt(NULL);
+}
 #else
-static inline void init_hostrt(void) { }
+static inline void init_hostrt(void)
+{
+}
+
+static inline void cleanup_hostrt(void)
+{
+}
 #endif /* CONFIG_XENO_OPT_HOSTRT */

 MODULE_DESCRIPTION("Xenomai nucleus");
@@ -235,8 +246,9 @@ int __init __xeno_sys_init(void)

 	xnpod_umount();

-      cleanup_arch:
+	cleanup_hostrt();

+  cleanup_arch:
 	xnarch_exit();

 #endif /* __KERNEL__ */
@@ -261,7 +273,7 @@ void __exit __xeno_sys_exit(void)

 	xntbase_umount();
 	xnpod_umount();
-
+	cleanup_hostrt();
 	xnarch_exit();

 #ifdef __KERNEL__

-- 
                                                                Gilles.

