Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DEC4963A6
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780877; cv=none; b=Kt7BtD/gNmk+Zmsoyhl4g57MTKtY9uO+73bNgj5mu+0YpJnu9fgDeLh/lfJuXpPR8ne/OceKpxa433MY9eN9iIckaqulYuFuET+g5eWzhu8zTC6/avnCIuMkh4uVVQ8Jwq0nU2qr4OQYlvTyvg+2Urt1j+DKwA8lH9xHPAkRPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780877; c=relaxed/simple;
	bh=mcZTwZa8E9tzfOcBp3lARJ2yCzTwtpDwgIpttPEQ9KA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aX8a19o/BW1IC0/Pkx3Jrn28qxIvTSSi7eNcgDI/PrIl7PxNEFnuQYrzzgML2460ofGlhZFIscp46pJwnTsJgZmJ+40bnCxj4yX7VL8v6CA7yPY4uvKIS42eDvTJeuTFDWwIIOkpACyL2gcqDd5MfcR3tLsNItJ8N47ncHX+T8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=P1+vZnGW; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="P1+vZnGW"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260907113422ac9a4fa02c0002073c
        for <xenomai@lists.linux.dev>;
        Mon, 07 Sep 2026 13:34:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nG7KpWVX7JQ8fi7feMAKi6Z+JugLC3t1WPa/2ljjUPY=;
 b=P1+vZnGWbbRGje4+9kzP1caFM9yW0gUfYqxSxU/K9NP194iSoVyY16PkRnV+5zHqSLs9cQ
 1aWgDR+2fpLXF39sKAOIw/CTtXt0G52VxtqeavmDxv30XAuZZcbiGnakcj7Y7NOTLBz4RhEc
 Z8xdApteQzBP+lCaucGzQh/O9X+3MrfAx8Mtfx52XZ5plpnrmBB8XErsHFXQPiGzapBXhokA
 VgHNuOGpkU5RrWBQt9L0cd6fHbblFPij8SY28LWqEULGGoTlX1uO0AnNTfaWabdwn/ZFU1MU
 k3AErEh+Vp6QthtHxBpm/3WBNYcdYjo6oQxhbH7xFfWnANhZiyDzbUnw==;
Message-ID: <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew MacPherson <andrew@elk.audio>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>, Gerte
 Hoogewerf	 <ghoogewerf@lmi3d.com>
Date: Mon, 07 Sep 2026 13:34:22 +0200
In-Reply-To: <CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	 <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	 <CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
> On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >=20
> > Hi Andrew,
> >=20
> > [CC + Philippe]
> >=20
> > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > > Hello,
> > >=20
> > > We're working on an STM32MP1-based system running Xenomai and found
> > > that perf top shows every symbol as "unknown [00000000]", i.e.
> > > profiling is collecting samples, but they all point at address zero.
> > >=20
> > > I'm not a kernel developer but went through a few debug kernel builds
> > > with an agent which eventually led to the attached patch. This change
> > > does resolve the issue with perf, however I'm not sure if it's the
> > > correct solution.
> > >=20
> > > The reasoning is that arm_arch_timer.c's percpu IRQ registration neve=
r
> > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> > > tick_regs, leaving get_irq_regs() to always return an all-zero
> > > pt_regs, which in turn breaks perf's sample IP.
> >=20
> > Yep, that is wrong. The patch you provided looks OK to me. I'm just
> > wondering if that should be addressed in Linux as well / first.
> >=20
> > @Philippe: Any additional thoughts? Should we take it already?
> >=20
> >=20
> > @Andrew: Could you please provide a formal patch with proper signed-off
> > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2=
.
> > branch? That should help to speed things up. Thanks!
> >=20
> > Florian
> >=20
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
> >=20
> >=20
>=20
> Hi Florian,
>=20
> I've submitted a patch now against dovetail 7.2, let me know if you
> need anything else and thanks for the help!
>=20
>=20

Thanks! We might consider merging that while working on a better
solution - as suggested by Philippe.

The following is build + boot tested on arm, arm64 and x86 using qemu.
Would be nice to get some early feedback.=20

It should fix the problems reported by Andrew and Gerte.

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index a46872cf1384b..553243174368d 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -16,6 +16,9 @@
 # include <linux/ktime.h>
 # include <linux/notifier.h>
 # include <linux/irqstage.h>
+# include <linux/preempt.h>
+# include <asm-generic/irq_regs.h>
+# include <asm/irq_pipeline.h>
=20
 struct clock_event_device;
 struct module;
@@ -259,9 +262,30 @@ struct clock_proxy_device {
=20
 void tick_notify_proxy(void);
=20
+static inline void copy_timer_regs(void)
+{
+	struct pt_regs *regs =3D get_irq_regs();
+	struct irq_pipeline_data *p;
+
+	if (!in_pipeline())
+		return;
+
+	/*
+	 * Given our deferred dispatching model for regular IRQs, we
+	 * record the preempted context registers only for the latest
+	 * timer interrupt, so that the regular tick handler charges
+	 * CPU times properly. It is assumed that no other interrupt
+	 * handler cares for such information.
+	 */
+	p =3D raw_cpu_ptr(&irq_pipeline);
+	arch_save_timer_regs(&p->tick_regs, regs);
+}
+
 static inline
 void clockevents_handle_event(struct clock_event_device *ced)
 {
+	copy_timer_regs();
+
 	/*
 	 * If called from the in-band stage, or for delivering a
 	 * high-precision timer event to the out-of-band stage, call
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 85ec0cbf5fb1e..d160d99e32c5f 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1059,24 +1059,6 @@ bool handle_oob_irq(struct irq_desc *desc)
 	return true;
 }
=20
-static inline
-void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
-{
-	struct irq_pipeline_data *p;
-
-	if (desc->action =3D=3D NULL || !(desc->action->flags & __IRQF_TIMER))
-		return;
-	/*
-	 * Given our deferred dispatching model for regular IRQs, we
-	 * record the preempted context registers only for the latest
-	 * timer interrupt, so that the regular tick handler charges
-	 * CPU times properly. It is assumed that no other interrupt
-	 * handler cares for such information.
-	 */
-	p =3D raw_cpu_ptr(&irq_pipeline);
-	arch_save_timer_regs(&p->tick_regs, regs);
-}
-
 static __always_inline
 struct irq_stage_data *switch_stage_on_irq(void)
 {
@@ -1123,7 +1105,6 @@ void restore_stage_on_irq(struct irq_stage_data *prev=
d)
  */
 int generic_pipeline_irq_desc(struct irq_desc *desc)
 {
-	struct pt_regs *regs =3D get_irq_regs();
 	int irq;
=20
 	if (!desc)
@@ -1137,7 +1118,6 @@ int generic_pipeline_irq_desc(struct irq_desc *desc)
 	}
=20
 	trace_irq_pipeline_entry(irq);
-	copy_timer_regs(desc, regs);
 	generic_handle_irq_desc(desc);
 	trace_irq_pipeline_exit(irq);
=20
