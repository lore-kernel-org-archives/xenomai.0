From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D238EED.6010403@domain.hid>
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid> <4D23785B.5050108@domain.hid>
	<4D2379EF.5@domain.hid> <4D237A89.3010205@domain.hid>
	<4D237CA9.2090408@domain.hid> <4D237F62.2030609@domain.hid>
	<4D2381B6.80304@domain.hid> <4D238C56.40906@domain.hid>
	<4D238EED.6010403@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Jan 2011 22:38:11 +0100
Message-ID: <1294177091.1837.119.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tamas Szklenar <tszklenar@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-01-04 at 16:19 -0500, Tamas Szklenar wrote:
> Sorry, I forget to write down, that the previous computer (the older) 
> works great with Xeno...
> 

Please try this patch.

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -637,8 +637,10 @@ void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_IPIPE
 #define default_to_mwait force_mwait
+#define maybe_c1e  0
 #else
 #define default_to_mwait 1
+#define maybe_c1e  1
 #endif
 #ifdef CONFIG_SMP
 	if (pm_idle == poll_idle && smp_num_siblings > 1) {
@@ -655,7 +657,7 @@ void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 		 */
 		printk(KERN_INFO "using mwait in idle threads.\n");
 		pm_idle = mwait_idle;
-	} else if (check_c1e_idle(c)) {
+	} else if (maybe_c1e && check_c1e_idle(c)) {
 		printk(KERN_INFO "using C1E aware idle routine\n");
 		pm_idle = c1e_idle;
 	} else

> Tamas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



