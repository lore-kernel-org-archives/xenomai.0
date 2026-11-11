Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399058;
	b=aJtXVZNa4YxUweT+x2YqtfqKjWkOxdIQWkeuedKZRUAvNfHsG8Ain9mWK2DhTPzyLMIs
	 TUJAuqCs1t0sDX6kaoNrhWmWNp49SMTQ20CxK4KITeoEBQLbbJqAy5X47+dXUw/FyoMWs
	 Pu6MBC3eRVpUGVxtiF8ZUhWRgAZJtCZpQJq1IXkUZjD6YWR7PXFDJAF1fKuSf2j5YMm2C
	 CzV27nzc0n71jnZ0KBzjh8iqxININ7/FzxOBS/m6QywjI9+lSFZCLZalR15shVtaaU66g
	 +nOy3HFNSfnsHvqd4tntmhi+lZxRaJnc6+P2RjQKzys+waYWlv0MRSR9FZbuyQYiaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399058;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-Cause:X-GND-State:X-GND-Score;
	bh=jG5tGH9uwtxyc64uQ4slEsGZEMpOA1TZsXOtyCl+Ol0=;
	b=T4SEO482CO98L27H4msf/4ayxT+8wrDjS2fIxhi1ufES9Ge82mCS53A2bg9BhIug13si
	 18zGGStbDn/FI7ffmTfACjf7Xt8UKUtcsfGcDVsNfPSfgboR81aD5HoxTC1KiJYHwwcyz
	 gBQwv/jBh+ZHy1gO3vwRC5pVkTjgl5T2atsJfSpjr+PCkvT7AE7wElL0GDBfG8UxK8/Sj
	 ME/XxbH77CFNfC7aupTlCOLBbiH1m9RYEiDCOf6Qy07As4tLhBvxzTQgiU77K5i/FwVAw
	 75gx6CSoGBAZx4aprDVydKYXra58RQh62VOS2+AS4fvWcTwf4lmUElK+29xoOLvS6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=h5jSwudM;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667F606A330
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3667F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=h5jSwudM
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id E444A3EE88
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 874C65600D0
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=h5jSwudM;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202611111210491a46dba13e000207e0-XX_bT9@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-294854-202611111210491a46dba13e000207e0-XX_bT9@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202611111210491a46dba13e000207e0
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jG5tGH9uwtxyc64uQ4slEsGZEMpOA1TZsXOtyCl+Ol0=;
 b=h5jSwudMehHSOmf+FmuXhTyJxU96WpMrnFpb/KUNgNReZxanetHvJPy6TW/wg0p7lI/0N6
 pipGQedUbcnCGk3JIcNdfWp6kyAcwkEWP1KUuxb8wA2ArRGIjKtHnpL/j3wf+s94JszLsWL+
 xerSUcmuLY2aflwCzfI+X666t5Jek7FtBzjuhC+Yo6Gaw03zzurijL9Y4qpNlfSq9VTLoSCY
 SFWXUYFfQtrOmh8I8VndEBia+zcqgutkZlHnjDTK/KrHA/7x3Syx8qO89zL7CQZWPLpEEASj
 3tqBDQ9mCVqqBczrsJ0MjXS3/PkuXT34aQlNiVorOsBlj0rD2Vyrj6tA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH v2 4/4] ARM: dovetail: Fix VFP exception trap notification
Date: Wed, 11 Nov 2026 13:10:47 +0100
Message-ID: <d37403e68eecae282d169dafe0a582acc273a607.1794399047.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794399047.git.jan.kiszka@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-GND-Cause: dmFkZTFEuMWFhQbo1YFDxks+CGkCk3E6JqAJB/kulAOV3ku3Xw7hxtb9ytyR92m3d7czrNFdgsLaBNjo8CnXcZmC5TkA4XocQ6Rj+Ni17pUp1ReOKNB7/DrEDG5JMs3as7rVAS6Zzc6bxOkNF+rc3WGMcEqCTinKpkGl4Nsccru4yLGgd6AiOseB2u44R9NvJlQfvJwgPokSMqhjo7KoHq92CBAX61aFz6L8Nvl0x2yzJYa1kzq0r23vDtjd5DJIKgGQ/pdiDMic6jYE9N5urYNSU6HK5Wg1QdkprRqs03/+CgpPiGfvqOepUql2aGcKFoS0mVLI2LAKvQirAmHJqzgX2HBISOV/JpSDU0j/8t6choAUaVnU0HU9lHhlE4UB76MhZPNKPmNtL7YTKKpcAxUKNwlusSnjlBEL4BrwSC3zGhcf9cvTChlQ9kQZu46TBx63TTS84FWMrPjFnSb1SArQ3WTmfAfF/21G9+PgBl4DzIN+/sWPu0sVqqCQpMubZKUGSspCeIZvcJrmaFkQvtxYe84uC6BiuUyRunMmt98jS6vZtuR8q78hUONGeWAftwr7egmaQ8YtunvqiN3Wdh1CM37ddaQUHaDpVGsM34ttU8bchJHyd2SIaPm/ps4RbDXFvlsrFlWoL/PczTWpRdOwsSe0VnaI2NC63dtg2dMa0EaRGg
X-GND-State: clean
X-GND-Score: -100

From: Jan Kiszka <jan.kiszka@siemens.com>

The trap annotation of the VFP bounce path predates upstream
commit c0b5195bad63 ("ARM: 9426/1: vfp: Move sending signals outside of vfp_state_hold()ed section.")
which turned vfp_raise_exceptions() into returning the si_code,
deferring vfp_raise_sigfpe() to the exit of VFP_bounce() after
vfp_state_release(). The Dovetail hunk was kept in place verbatim,
which is now wrong in three ways:

- for VFP_EXCEPTION_ERROR, SIGFPE is sent twice: once from the
  annotated block in vfp_raise_exceptions(), once more from the exit
  path of VFP_bounce() via the returned si_code,

- the deferred signals for regular FP exceptions enabled in FPSCR
  (divide by zero, overflow, ...) are not annotated at all, so an oob
  thread sends them from the oob stage,

- the annotated block runs within the vfp_state_hold() section, which
  under Dovetail is a hard_preempt_disable() section. If the core
  demotes the thread to in-band from there, hard_preempt_enable()
  pairs an oob-stage hard_preempt_disable() which did not touch the
  preemption count with an in-band preempt_enable_no_resched(),
  unbalancing it. Besides, that was the very reason for the upstream
  change on PREEMPT_RT.

Move the notification to the exit path of VFP_bounce(), after the
VFP state was released: if any signal is to be raised, have the
companion core demote the thread, or skip the signal if the core
decided to handle the trap from the oob stage. This mirrors what
arm64 does for ARM64_TRAP_FPE in do_fpsimd_exc().

vfp_raise_exceptions() does not need the register frame anymore,
restore its upstream signature.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4bbe92c619f2d..5589eb76379b5 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -283,7 +283,7 @@ static void vfp_panic(char *reason, u32 inst)
 /*
  * Process bitmask of exception conditions.
  */
-static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_regs *regs)
+static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr)
 {
 	int si_code = 0;
 
@@ -291,10 +291,6 @@ static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_r
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		if (mark_cond_trap_entry(ARM_TRAP_VFP, regs)) {
-			vfp_raise_sigfpe(FPE_FLTINV, regs);
-			mark_trap_exit(ARM_TRAP_VFP, regs);
-		}
 		return FPE_FLTINV;
 	}
 
@@ -437,7 +433,7 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 		 * unallocated VFP instruction but with FPSCR.IXE set and not
 		 * on VFP subarch 1.
 		 */
-		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr, regs);
+		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr);
 		goto exit;
 	}
 
@@ -462,7 +458,7 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 	 */
 	exceptions = vfp_emulate_instruction(trigger, fpscr, regs);
 	if (exceptions)
-		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 
 	/*
 	 * If there isn't a second FP instruction, exit now. Note that
@@ -476,13 +472,28 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 emulate:
 	exceptions = vfp_emulate_instruction(trigger, orig_fpscr, regs);
 	if (exceptions)
-		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 exit:
 	vfp_state_release(flags);
+
+	if (!si_code && !si_code2)
+		return;
+
+	/*
+	 * Dovetail: the companion core may handle the FP exception of
+	 * an oob thread entirely from the oob stage, in which case it
+	 * does not demote us to in-band and we must not raise the
+	 * signal. Otherwise, we run in-band from this point.
+	 */
+	if (!mark_cond_trap_entry(ARM_TRAP_VFP, regs))
+		return;
+
 	if (si_code2)
 		vfp_raise_sigfpe(si_code2, regs);
 	if (si_code)
 		vfp_raise_sigfpe(si_code, regs);
+
+	mark_trap_exit(ARM_TRAP_VFP, regs);
 }
 
 static void vfp_enable(void *unused)
-- 
2.47.3

