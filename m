Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D98198A3F
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656991; cv=none; b=fjCcV7+cx4r/yBph6HmR27AkeoYGdzdu4WnhucZkDO9NeqbrQyGyWOX+VJgcRljqpz8wJBQ1ETG5DKtuByg+UDJKp7FXRUY9whrqi6zAwYSZJzI/eaIWg3cyEzrcI1hq3kDHXQPVQO1n0AGWo1a2QMA9zRLnfHi8TjT+UnOTt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656991; c=relaxed/simple;
	bh=9H0ZNxuLdYzaL2M/MG7kJ7V3jnuBjM1S6DOEUn1NPx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVOgYE3bLzDnbIQMYDlIt59KcDOQWHLWoXsGSgSU2L2vkazy5OV2doWqCRNiiyIxEbBpwBPIbeqVXxNRGrbsHrHTrfKj0Y6Qh7lltQaD/TrRI8xjKGtkGeTbUNavwgSgQtk/Wb5V89Bbh6fFPuSKdKeteXSs9NSq580Cn/S+wfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4612da0fso1662147f8f.0
        for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656987; x=1729261787;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3hGoVt5zJDS7iwgRdTsDHpBf2lWdMCtFtjBJMKiW48=;
        b=cuDZZkTEQw/1OEYZiizQCCuaDLM5Fv10E/L7tH+tR7s/i/YvOCf35bOnXcqZlCVT76
         aKwR3MAAy8r0sEMWandGYI1nG5uVlzHtRMSErBiGdGlNnJehRNfq/GH2fZ9yrFF+lV0q
         ZpG48N34urkeQypkHB4bTWrjNaMopnNIZfPlv1BLzzAVqxA+R1DBl0RWTje0RhogEGsD
         bmaJWy67Ca3nyKd6TeI0jPRGADt+1PgJeVl+hf5PWdQ7XZCI8ISsKLm5Lp/VmxDMorfL
         h/6btySd56hijWDSmJDLpHQXdQMiFBvgMWxEQBaLGbTIVBbefTz9oyD18cXfOs212Q7A
         ARcg==
X-Gm-Message-State: AOJu0Yzop825VFYvOAuIAtWzAbPTXo6oK63pnrSipijJ1wzuaBcWZUUy
	GfIV6ldkA0NpkRez4nXoL1sMu+L9sccrQrnuO/6DaM18fAhlANVK
X-Google-Smtp-Source: AGHT+IFn/tcQvtgINpA8k5SoRdPm2FIkd1ONV44zLM+qQRa1zwgIf/3VOvd2tJhK9utZ/HAYVo13+Q==
X-Received: by 2002:a05:6000:1251:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-37d4815fa28mr6543476f8f.1.1728656987067;
        Fri, 11 Oct 2024 07:29:47 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f896sm4082783f8f.87.2024.10.11.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:29:46 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
In-Reply-To: <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 11 Oct 2024 15:56:39 +0200")
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
	<87frp4aqmu.fsf@xenomai.org>
	<20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 11 Oct 2024 16:29:45 +0200
Message-ID: <87v7xy7lwm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > The following kernel splat was found when running the Xenomai 3
>> > testsuite in compat on dovetail enabled kernels:
>> > 
>> > [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
>> >                              called an in-band only routine
>> > [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
>> > [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> > [  513.621005] IRQ stage: Xenomai
>> > [  513.621007] Call Trace:
>> > [  513.621011]  <TASK>
>> > [  513.621015]  dump_stack_lvl+0x6f/0xd0
>> > [  513.621202]  __inband_irq_enable+0xb/0x60
>> > [  513.621249]  do_int80_emulation+0x68/0x160
>> > [  513.621265]  asm_int80_emulation+0x1a/0x20
>> > [  513.621285] RIP: 0023:0xf7f692ba
>> > [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
>> > [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
>> > [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
>> > [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
>> > [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
>> > [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> > [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> > [  513.621319]  </TASK>
>> > 
>> > When entering the low level entry code from the out-of-band stage
>> > the in-band IRQ state was changed. That is now avoided by calling
>> > syscall_enter_from_user_enable_irqs() as all other entry points do.
>> > 
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> >  arch/x86/entry/common.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> > index 467e2511df2e..13589f1ca89b 100644
>> > --- a/arch/x86/entry/common.c
>> > +++ b/arch/x86/entry/common.c
>> > @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>> >  
>> >  	nr = syscall_32_enter(regs);
>> >  
>> > -	local_irq_enable_full();
>> > +	syscall_enter_from_user_enable_irqs();
>> >  	nr = syscall_enter_from_user_mode_work(regs, nr);
>> >  
>> >  	if (dovetailing()) {
>> 
>> Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.
>
> Philippe, I have to apologize. The patch is correct for 6.11, but not
> for the older ones. syscall_enter_from_user_enable_irqs() does not
> exist in those branches.
>
> I have to check why the build error was not properly detected on my
> end. Can't tell yet...
>
> I will work on backports, meanwhile you should drop it from 6.6 and
> 6.1. Thanks, and sorry.
>

As Jan pointed out, your patch is fine for all 6.x so far, this helper
appears inline upstream in some header only after 6.6.

-- 
Philippe.
