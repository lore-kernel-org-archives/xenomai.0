Message-ID: <485174A7.7040505@domain.hid>
Date: Thu, 12 Jun 2008 21:10:31 +0200
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <4850DC9D.4010607@domain.hid>	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid>
In-Reply-To: <48510808.9020304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High latencies on Core2Duo
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:

> I have attached a new trace output with again high latencies and my
> kernel config.
> 

Could you run another trace with that patch applied? TIA,

--- include/asm-x86/bits/pod_32.h	(revision 3965)
+++ include/asm-x86/bits/pod_32.h	(working copy)
@@ -68,7 +68,7 @@

 #define xnarch_enter_root(rootcb)  do { } while(0)

-static inline void xnarch_switch_to(xnarchtcb_t * out_tcb, xnarchtcb_t * in_tcb)
+static void xnarch_switch_to(xnarchtcb_t * out_tcb, xnarchtcb_t * in_tcb)
 {
 	struct task_struct *prev = out_tcb->active_task;
 	struct task_struct *next = in_tcb->user_task;
@@ -110,7 +110,7 @@

 	xnarch_switch_threads(out_tcb, in_tcb, prev, next);

-	if (xnarch_shadow_p(out_tcb, prev)) {
+	if (0 && xnarch_shadow_p(out_tcb, prev)) {

 		loadsegment(fs, fs);
 		loadsegment(gs, gs);

-- 
Philippe.

