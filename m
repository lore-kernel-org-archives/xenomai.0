From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Tue, 9 Dec 2014 20:06:03 +0000
Message-ID: <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>,
 <20141207135204.GT10014@hermes.click-hack.org>,
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
In-Reply-To: <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
Hi Gilles,=0A=
=0A=
>> Well, then you need to replace #ifdef CONFIG_PREEMPT_RT with=0A=
>> CONFIG_PREEMPT_RT_FULL, and test the kernel version in wrappers.h to=0A=
>> define CONFIG_PREEMPT_RT_FULL if CONFIG_PREEMPT_RT is dedined for=0A=
>> old kernels.=0A=
=0A=
>I have applied both changes and try if this solves the my problem. If it w=
orks I will publish the patch here.=0A=
=0A=
below you can find the patch. It solves the problem concerning "sleeping fu=
nction called from invalid context" when using PREEMPT RT. Would it be reas=
onable to apply that change to GIT repository?=0A=
=0A=
Index: ksrc/arch/generic/hal.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- ksrc/arch/generic/hal.c	(Revision 1136)=0A=
+++ ksrc/arch/generic/hal.c	(Arbeitskopie)=0A=
@@ -355,7 +355,7 @@=0A=
     rthal_spin_unlock(&rthal_apc_lock);=0A=
 }=0A=
 =0A=
-#ifdef CONFIG_PREEMPT_RT=0A=
+#ifdef CONFIG_PREEMPT_RT_FULL=0A=
 =0A=
 /* On PREEMPT_RT, we need to invoke the apc handlers over a process=0A=
    context, so that the latter can access non-atomic kernel services=0A=
@@ -398,11 +398,11 @@=0A=
 =0A=
 #define rthal_apc_trampoline rthal_apc_kicker=0A=
 =0A=
-#else /* !CONFIG_PREEMPT_RT */=0A=
+#else /* !CONFIG_PREEMPT_RT_FULL */=0A=
 =0A=
 #define rthal_apc_trampoline rthal_apc_handler=0A=
 =0A=
-#endif /* CONFIG_PREEMPT_RT */=0A=
+#endif /* CONFIG_PREEMPT_RT_FULL */=0A=
 =0A=
 /**=0A=
  * @fn int rthal_apc_alloc (const char *name,void (*handler)(void *cookie)=
,void *cookie)=0A=
@@ -495,7 +495,7 @@=0A=
 	clear_bit(apc, &rthal_apc_map);=0A=
 }=0A=
 =0A=
-#ifdef CONFIG_PREEMPT_RT=0A=
+#ifdef CONFIG_PREEMPT_RT_FULL=0A=
 =0A=
 static inline int setup_apc_handler(void)=0A=
 {=0A=
@@ -524,7 +524,7 @@=0A=
 	}=0A=
 }=0A=
 =0A=
-#else  /* !CONFIG_PREEMPT_RT */=0A=
+#else  /* !CONFIG_PREEMPT_RT_FULL */=0A=
 =0A=
 static inline int setup_apc_handler(void)=0A=
 {=0A=
@@ -533,7 +533,7 @@=0A=
 =0A=
 static inline void cleanup_apc_handler(void) { }=0A=
 =0A=
-#endif  /* !CONFIG_PREEMPT_RT */=0A=
+#endif  /* !CONFIG_PREEMPT_RT_FULL */=0A=
 =0A=
 int rthal_init(void)=0A=
 {=0A=
Index: ksrc/nucleus/pipe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- ksrc/nucleus/pipe.c	(Revision 1136)=0A=
+++ ksrc/nucleus/pipe.c	(Arbeitskopie)=0A=
@@ -173,7 +173,7 @@=0A=
 					xnlock_get_irqsave(&nklock, s);=0A=
 				}=0A=
 			}=0A=
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)=0A=
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)=0A=
 			/*=0A=
 			 * Assume a waiter might have entered/left the=0A=
 			 * queue, so we need to refetch the sleep=0A=
@@ -198,7 +198,7 @@=0A=
 			xnlock_put_irqrestore(&nklock, s);=0A=
 			kill_fasync(&state->asyncq, xnpipe_asyncsig, POLL_IN);=0A=
 			xnlock_get_irqsave(&nklock, s);=0A=
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)=0A=
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)=0A=
 			nh =3D getheadq(&xnpipe_asyncq);=0A=
 #endif=0A=
 		}=0A=
Index: include/asm-generic/wrappers.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- include/asm-generic/wrappers.h	(Revision 1136)=0A=
+++ include/asm-generic/wrappers.h	(Arbeitskopie)=0A=
@@ -43,6 +43,12 @@=0A=
 #include <asm/system.h>=0A=
 #endif /* kernel < 3.4.0 */=0A=
 =0A=
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)=0A=
+#ifdef CONFIG_PREEMPT_RT=0A=
+#define CONFIG_PREEMPT_RT_FULL /* after kernel 2.6 CONFIG_PREEMPT_RT was r=
enamed */=0A=
+#endif=0A=
+#endif /* kernel < 3.0.0 */=0A=
+=0A=
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)=0A=
 =0A=
 #include <linux/wrapper.h>=0A=
@@ -664,8 +670,8 @@=0A=
 #ifndef DEFINE_SEMAPHORE=0A=
 /* Legacy DECLARE_MUTEX vanished in 2.6.37 */=0A=
 #define DEFINE_BINARY_SEMAPHORE(sem) DECLARE_MUTEX(sem)=0A=
-#elif defined(CONFIG_PREEMPT_RT)=0A=
-#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem, 1)=0A=
+#elif defined(CONFIG_PREEMPT_RT_FULL)=0A=
+#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)=0A=
 #else=0A=
 #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)=0A=
 #endif=0A=
=0A=
Regards,=0A=
Christoph=

