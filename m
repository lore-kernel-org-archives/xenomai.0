Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196E1957FD
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658357; cv=none; b=Rh1Ydw+OzRpVd1RN+hvs0CMUzQujCJZHOyJrNQw9HhaT1vuMEZUTYsFHifvusBBIEwkLaUAbgHLPc2K1LSZOmI5qP+w/4KZeiV9KHISSs5Um0WrSVZseAv+PWmd3EeFBdQ18WCDg5Tjod1fIcixrsCg5fo4Z83pCQwdPbjhJEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658357; c=relaxed/simple;
	bh=EZK4NrfhahZkMsKkTpAiFqohnmYv6VftXiW/OydZAnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/ncwK8liOVeCaWIG5xSNd6C34Ke8S2tJjVNhKeOp4/BGyZYI7pMSz3S1zzCQ+gkS9dT0iVh79l+9GDKJ0yhUS/YTsAr6FVHvKf/ehKQcveIr7awTWXKfCeSP4aaYdSYuJ1c/GOVaAtgjPIflfMEABQ8mHl98znBf5nnqeklyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43055b43604so19238655e9.3
        for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658353; x=1729263153;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7wN8OFFdCQUALwdSrK2lpHzS16QeNKGqMjXbG/D7FI=;
        b=GO5KUaCVa6bAw5ZCE8fv3i3qA4lij4MyV2oM9wVW2QSVI7DgIJSkoQ8xqYpUY8Df59
         2bTO4JsBmN0LAZkHKMkoNFfzpz9WmMTicSv5yQZICooEdCEMfFMu+ydizzvxKKi3yRyU
         NP8D8ljDbpOJSzfOJqgnM2N9JGX7t1T8hZGSpaqKwaHczYPoNoILfijfx2s2S0kTfNbc
         PiRCFn9o0Dw4srSWnjoPJ6A3sdlCxTr5AQR5/nfy+7tFbJGq5uDMmQ57w6WnujQ+mJbo
         XbPyGqEgX3jeJkTkHKbW5G933QY0u2R4tztmLImsE+O/76s+VmgqWyATAUFcgh07/C3k
         LnbA==
X-Forwarded-Encrypted: i=1; AJvYcCUdCBySnXwSJM5Fi3f/G1NAEJJOnRpU3q3BOZe4yMJK7idG0r3P7rQmLU5oTQXw2L+7+EphTd1L@lists.linux.dev
X-Gm-Message-State: AOJu0YwnjzjJtS6CtLSwogZzlSOHgehFbSaN2XUwxJ4I6USAFDXlcZdu
	x4IrE8Z4OpbaV5K4fGCb+srEpA5F+VquR5iWjsiDqNThbr5DurZ726HSdEy3
X-Google-Smtp-Source: AGHT+IF8BYSpyXuDNrgD/21wbVUkIuI/zBVYecNSU4uv/wvHn3lI1WptIqmPvbktrA12j+qUhDF5zA==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-4311deae9ccmr27328355e9.5.1728658353315;
        Fri, 11 Oct 2024 07:52:33 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4841asm76643035e9.19.2024.10.11.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:52:32 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
In-Reply-To: <5283127a991ae241c18f0540e2cb9edafeb8de45.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 11 Oct 2024 16:46:25 +0200")
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
	<87frp4aqmu.fsf@xenomai.org>
	<20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
	<87v7xy7lwm.fsf@xenomai.org>
	<5d65f813-3b5e-4dd4-8665-83d1af64a23f@siemens.com>
	<5283127a991ae241c18f0540e2cb9edafeb8de45.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 11 Oct 2024 16:52:31 +0200
Message-ID: <87plo67kuo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2024-10-11 at 16:36 +0200, Jan Kiszka wrote:
>> On 11.10.24 16:29, Philippe Gerum wrote:
>> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> >=20
>> > > On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
>> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > >=20
>> > > > > The following kernel splat was found when running the Xenomai 3
>> > > > > testsuite in compat on dovetail enabled kernels:
>> > > > >=20
>> > > > > [  513.620975] IRQ pipeline: some code running in oob context 'X=
enomai'
>> > > > >                              called an in-band only routine
>> > > > > [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ =
#76
>> > > > > [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009=
), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> > > > > [  513.621005] IRQ stage: Xenomai
>> > > > > [  513.621007] Call Trace:
>> > > > > [  513.621011]  <TASK>
>> > > > > [  513.621015]  dump_stack_lvl+0x6f/0xd0
>> > > > > [  513.621202]  __inband_irq_enable+0xb/0x60
>> > > > > [  513.621249]  do_int80_emulation+0x68/0x160
>> > > > > [  513.621265]  asm_int80_emulation+0x1a/0x20
>> > > > > [  513.621285] RIP: 0023:0xf7f692ba
>> > > > > [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
>> > > > > [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_=
RAX: 0000000000000127
>> > > > > [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: =
00000000ffeedfa0
>> > > > > [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: =
00000000f7f7aff4
>> > > > > [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: =
0000000000000000
>> > > > > [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000000
>> > > > > [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
>> > > > > [  513.621319]  </TASK>
>> > > > >=20
>> > > > > When entering the low level entry code from the out-of-band stage
>> > > > > the in-band IRQ state was changed. That is now avoided by calling
>> > > > > syscall_enter_from_user_enable_irqs() as all other entry points =
do.
>> > > > >=20
>> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > > > > ---
>> > > > >  arch/x86/entry/common.c | 2 +-
>> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > >=20
>> > > > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> > > > > index 467e2511df2e..13589f1ca89b 100644
>> > > > > --- a/arch/x86/entry/common.c
>> > > > > +++ b/arch/x86/entry/common.c
>> > > > > @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(st=
ruct pt_regs *regs)
>> > > > >=20=20
>> > > > >  	nr =3D syscall_32_enter(regs);
>> > > > >=20=20
>> > > > > -	local_irq_enable_full();
>> > > > > +	syscall_enter_from_user_enable_irqs();
>> > > > >  	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>> > > > >=20=20
>> > > > >  	if (dovetailing()) {
>> > > >=20
>> > > > Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.
>> > >=20
>> > > Philippe, I have to apologize. The patch is correct for 6.11, but not
>> > > for the older ones. syscall_enter_from_user_enable_irqs() does not
>> > > exist in those branches.
>> > >=20
>> > > I have to check why the build error was not properly detected on my
>> > > end. Can't tell yet...
>> > >=20
>> > > I will work on backports, meanwhile you should drop it from 6.6 and
>> > > 6.1. Thanks, and sorry.
>> > >=20
>> >=20
>> > As Jan pointed out, your patch is fine for all 6.x so far, this helper
>> > appears inline upstream in some header only after 6.6.
>> >=20
>>=20
>> I think the issue is that, depending on some compiler settings, the
>> function may or may not found. It is static inline only for
>> kernel/entry/common.c, thus indeed naturally invisible for
>> arch/x86/entry/common.c.
>>=20
>> ../arch/x86/entry/common.c: In function =E2=80=98do_int80_emulation=E2=
=80=99:
>> ../arch/x86/entry/common.c:213:2: error: implicit declaration of
>> function =E2=80=98syscall_enter_from_user_enable_irqs=E2=80=99; did you =
mean
>> =E2=80=98syscall_enter_from_user_mode_work=E2=80=99? [-Werror=3Dimplicit=
-function-declaration]
>>   syscall_enter_from_user_enable_irqs();
>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   syscall_enter_from_user_mode_work
>> cc1: some warnings being treated as errors
>>=20
>> Jan
>
> Close... It moved from kernel/entry/common.c to include/linux/entry-
> common.h in newer releases. That's why it's visible.
>
> Seems we have to do the same in a backport...
>

Changing its visibility to extern in kernel/entry/common.c would likely
be enough. There would be no conflict elsewhere.

--=20
Philippe.
