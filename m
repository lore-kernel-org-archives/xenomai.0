From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 20 Jul 2007 16:26:50 +0200
References: <E1IBs3G-0000Ky-Pg@domain.hid>
	<2ff1a98a0707200615q30e86381ne9dfdd73ae142c31@domain.hid>
In-Reply-To: <2ff1a98a0707200615q30e86381ne9dfdd73ae142c31@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qYMoGfVD+PtyeH2"
Message-Id: <E1IBtRS-0006cb-0N@mailer.emlix.com>
Subject: Re: [Adeos-main] [PATCH] [arm] user space tsc emulation support for
	s3c24xx
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--Boundary-00=_qYMoGfVD+PtyeH2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles Chanteperdrix wrote:
> On 7/20/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > Hi,
> >
> > On s3c24xx user space tsc emulation is now supported with this patch.
> > Note that the patch for time.c is made against the patch I sent on
> > Wednesday to this list.
>
> Same remark for __ipipe_tscinfo as for __xn_tscinfo.
> I would also vote for creating another variable initialized with tsc + 1

Ok, reworked. See attachment.

-- 
Sebastian

--Boundary-00=_qYMoGfVD+PtyeH2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ipipe_s3c24xx_tsc_emu_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe_s3c24xx_tsc_emu_2.patch"

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bffabf4..cae449a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -730,8 +730,8 @@ ENTRY(__switch_to)
 	.align 5
 	.globl  __ipipe_tsc_area_start
 
-__ipipe_tsc_area_start:	
-	.rep	8
+__ipipe_tsc_area_start:
+	.rep	12
 	.word	0
 	.endr
 #endif /* CONFIG_IPIPE */
diff --git a/arch/arm/mach-s3c2410/time.c b/arch/arm/mach-s3c2410/time.c
index 622ed34..9210456 100644
--- a/arch/arm/mach-s3c2410/time.c
+++ b/arch/arm/mach-s3c2410/time.c
@@ -73,7 +73,8 @@ EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
 int __ipipe_mach_timerint = IRQ_TIMER4;
 EXPORT_SYMBOL(__ipipe_mach_timerint);
 
-static unsigned long long __ipipe_mach_tsc = 0;
+static unsigned long long *tsc;
+static unsigned *last_cnt;
 static unsigned long timer_ackval = 1UL << (IRQ_TIMER4 - IRQ_EINT0);
 static IPIPE_DEFINE_SPINLOCK(timer_lock);
 
@@ -82,7 +83,11 @@ EXPORT_SYMBOL(__ipipe_mach_timerstolen);
 
 void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
 {
-	info->type = IPIPE_TSC_TYPE_NONE;
+	info->type = IPIPE_TSC_TYPE_DECREMENTER;
+	info->u.dec.counter = (unsigned *)0x51000038;
+	info->u.dec.mask = 0xffff;
+	info->u.dec.last_cnt = last_cnt;
+	info->u.dec.tsc = tsc;
 }
 #endif /* CONFIG_IPIPE */
 
@@ -146,7 +151,8 @@ static inline unsigned long getticksoffset_tscupdate(void)
 	tval = timer_freerunning_getvalue();
 	ticks = timer_freerunning_getticksoffset(tval);
 	last_free_running_tcnt = tval;
-	__ipipe_mach_tsc += ticks;
+	*tsc += ticks;
+	*last_cnt = last_free_running_tcnt;
 	return ticks;
 }
 #endif /* CONFIG_IPIPE */
@@ -256,6 +262,10 @@ static void s3c2410_timer_setup (void)
 	}
 
 #ifdef CONFIG_IPIPE
+	tsc = (unsigned long long *)__ipipe_tsc_area;
+	last_cnt = (unsigned *)(tsc + 1);		/* means: +8 bytes */
+	barrier();
+
 	__ipipe_mach_ticks_per_jiffy = tcnt;
 #endif /* CONFIG_IPIPE */
 
@@ -334,7 +344,7 @@ notrace unsigned long long __ipipe_mach_get_tsc(void)
 
 	local_irq_save_hw_notrace(flags);
 	spin_lock(&timer_lock);
-	result = __ipipe_mach_tsc + getticksoffset();
+	result = *tsc + getticksoffset();
 	spin_unlock(&timer_lock);
 	local_irq_restore_hw_notrace(flags);
 	return result;
diff --git a/include/asm-arm/ipipe.h b/include/asm-arm/ipipe.h
index b3d62bf..aa864fa 100644
--- a/include/asm-arm/ipipe.h
+++ b/include/asm-arm/ipipe.h
@@ -103,6 +103,11 @@ struct __ipipe_tscinfo {
                         unsigned long long *tsc; /* 64 bits tsc value. */
                 } fr;
                 struct {
+			unsigned *counter; /* Hw counter physical address */
+			unsigned mask; /* Significant bits in the hw counter. */
+			unsigned *last_cnt; /* Counter value when updating
+						tsc value. */
+			unsigned long long *tsc; /* 64 bits tsc value. */
                 } dec;
         } u;
 };

--Boundary-00=_qYMoGfVD+PtyeH2--

