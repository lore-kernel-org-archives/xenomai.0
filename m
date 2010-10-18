Message-ID: <4CBCC40D.8040902@domain.hid>
Date: Tue, 19 Oct 2010 00:02:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <30575170.2609951287430146052.JavaMail.defaultUser@domain.hid>
In-Reply-To: <30575170.2609951287430146052.JavaMail.defaultUser@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] R: Re: Error building xenomai 2.5.5.1 on kubuntu
 10.10 64	bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

gprizzi@domain.hid wrote:
> 
> Here below you can find my .config file.
> 
> What have I missed?
> 
> Thank you for your support.

The problem is that we do not enable CONFIG_CC_STACKPROTECTOR in our
x86_84 build test and that we got caught. Could you try the following patch?

diff --git a/include/asm-x86/wrappers_64.h b/include/asm-x86/wrappers_64.h
index a61f6ba..0d04b9c 100644
--- a/include/asm-x86/wrappers_64.h
+++ b/include/asm-x86/wrappers_64.h
@@ -78,4 +78,8 @@ typedef union thread_xstate x86_fpustate;
 #define x86_fpustate_ptr(t) ((t)->fpu.state)
 #endif

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
+#define per_cpu_var(var) (var)
+#endif /* Linux >= 2.6.34 */
+
 #endif /* _XENO_ASM_X86_WRAPPERS_64_H */

Also note that the configuration you posted is not suitable for running
Linux with Xenomai, please have a look at this page:
http://www.xenomai.org/index.php/Configuring_x86_kernels

-- 
                                                                Gilles.


