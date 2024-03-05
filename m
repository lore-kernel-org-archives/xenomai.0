Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232108BEA
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658439; cv=none; b=Judgiri1a9sGpYU/7tXLXGSKsplojMGKFOubrS1nKfF1xJTWgf6+gPKsNdvrQgrjuvYlfnhcYYkRwEawLupTR66JI8MqtWH8Ni0Ik4V9AAkcCoqVxn3hHcc3ks3DjlKr8qXLt5Gu9GNl9v7e/t8s0c452x0YUlR7Vp1uAX45DkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658439; c=relaxed/simple;
	bh=f8m1QysAnx+9z9rKk+rwOK0pv7fJTuEBp5EQk/IJa3s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Wg2x/TsUKhBXDAdk/+ONiqGJj8a93zErvExSq83Pm8IeVrEZa8AFo99EnuxB4SfGVyhhGzrOba6ZH+zxl0Eui0OkrTGWgPiJdAKFsRntnTJMaMTPFXQuw2PRPmySsM/RH5RyJpLEl6BO2LZ1syn6LugByuLPc0ouf61VLqOvGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412dda84216so22921735e9.3
        for <xenomai@lists.linux.dev>; Tue, 05 Mar 2024 09:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658435; x=1710263235;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3VXWcF1O3vYCHYcQYLDDUEGu+A3EE4u6nKTHo2Wt2I=;
        b=c4oNxPgT0iaFrP/uhKlGN8nhTPqKIOHn+9lvIO6IMLEeekfMPK8CGpBin3xE/fzSV1
         UTndlUloC3RXIPJY2fgNjyUuh42t4W3K92XGMIRiLN1jqKNwUbF73J29xryxZEjIHzYS
         9q2FOxUdDcu8PbNsBilTC4sSI+LXKgoOkLF06xc07iXHuqxYjt3Pt/FaG6mPiXTEizZp
         f/jqfMiI1SA9FBK7I3Cqv1XK4ReJeRKytrCgxzhyOuDXusExhP2w7gQ7KHSrvQ/HzBin
         lmMWcY+xXrKJ0qwoKhxGOM1boJBO14qeuaHzh/Qxijbk/PKl4ykTzZ36f2cf6h2ESh+G
         MQLA==
X-Gm-Message-State: AOJu0YwcQ3LUdPxd0UuNk68ELAY8LUkCEplOQAMVsWEwakMVKEHBx2hr
	llvwcNbnyeuY60n1/9Zjl5WPvpycsv0DwyQHzHlL8LdmdxjiMGpwzCRPyp7R
X-Google-Smtp-Source: AGHT+IEpG10MHy1/kuQzc5X5LUYlB08xp0Z7X885z+DOsFbBazx4qFqFIkNEfwXeqYTY2/0OMcgeLA==
X-Received: by 2002:a05:600c:4f09:b0:412:c760:eaff with SMTP id l9-20020a05600c4f0900b00412c760eaffmr9375926wmq.9.1709658435156;
        Tue, 05 Mar 2024 09:07:15 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c1d0100b00412ea52b102sm3415514wms.34.2024.03.05.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:07:13 -0800 (PST)
References: <5dd4a9f05961fc61aec5f20bb645c50c8a1bf9ad.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: dovetail: Build warning about missing __noreturn annotation
Date: Tue, 05 Mar 2024 17:54:36 +0100
In-reply-to: <5dd4a9f05961fc61aec5f20bb645c50c8a1bf9ad.camel@siemens.com>
Message-ID: <87r0goobeq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> any idea why I get the following build warning on recent dovetail
> branches? I haven't checked that yet, but I think all branches >= 6.0
> might be "affected".
>
> The warning:
>
> vmlinux.o: warning: objtool: arch_do_IRQ_pipelined+0x53f: __sysvec_reboot() is missing a __noreturn annotation
>
> __sysvec_reboot calls stop_this_cpu() which is annotated with
> __noreturn. It's unclear to me why arch_do_IRQ_pipelined() is in the
> game here.
>

Because the call to __sysvec_reboot() is expanded inline in
arch_do_IRQ_pipelined() via run_sysvec_on_irqstack_cond ->
call_on_irqstack_cond. This inner call is missing the annotation.

The following patch would do the trick, although in a fairly ugly way:

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index e4f0cc565fc66..fbeff7f100be8 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -209,6 +209,14 @@ __visible noinstr void func(struct pt_regs *regs)			\
 									\
 __visible void __##func(struct pt_regs *regs)
 
+#define DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN(vector, func)		\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	arch_pipeline_entry(regs, vector);				\
+}									\
+									\
+__visible __noreturn void __##func(struct pt_regs *regs)
+
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
 	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 3566d471d094e..d8d7e37d03a88 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -133,7 +133,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 /*
  * this function calls the 'stop' function on all other CPUs in the system.
  */
-DEFINE_IDTENTRY_SYSVEC_PIPELINED(REBOOT_VECTOR, sysvec_reboot)
+DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN(REBOOT_VECTOR, sysvec_reboot)
 {
 	ack_APIC_irq();
 	cpu_emergency_disable_virtualization();
       
-- 
Philippe.
