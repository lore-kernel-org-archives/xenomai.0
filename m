Message-ID: <4A9CE653.6060508@domain.hid>
Date: Tue, 01 Sep 2009 11:16:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1251794938.3205.20.camel@domain.hid>
In-Reply-To: <1251794938.3205.20.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai v2.4.9.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
> We had a couple of brown paper bag issues in v2.4.9, particularly in the
> interrupt pipeline for the ARM port, but also a time conversion bug
> which basically affects any architecture with high frequency CPUs
> (x86-ers, this one is for you).

A note for users of Xenomai on the ARM architecture.

A newly added check in Xenomai 2.4.9 allowed us to find a bug in the 
I-pipe patch for ARM, which is actually there since the 
adeos-ipipe-2.6.19-arm-1.7-00 patch. If you are using the 2.4 branch, 
please upgrade to the 2.4.9.1 release.

If you are using an earlier branch, the only thing we can suggest is a 
patch which you should apply to the I-pipe patched kernel:

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index e2b0c3c..e77a017 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -217,7 +217,8 @@ extern struct task_struct *__switch_to(struct task_struct *,
 do {									\
	local_irq_disable_hw_cond();					\
	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));
-	local_irq_enable_hw_cond();					\
+	if (ipipe_root_domain_p) \
+		local_irq_enable_hw_cond(); \
 } while (0)

 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)

Or, for older kernels:

diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index e2b0c3c..e77a017 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -217,7 +217,8 @@ extern struct task_struct *__switch_to(struct task_struct *,
 do {									\
	local_irq_disable_hw_cond();					\
	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));
-	local_irq_enable_hw_cond();					\
+	if (ipipe_root_domain_p) \
+		local_irq_enable_hw_cond(); \
 } while (0)

 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)


-- 
                                          Gilles


