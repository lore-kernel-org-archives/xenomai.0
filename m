Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939D27F166
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913946; cv=none; b=Od1YGBMXMOQCXme3DFNAkMttIR+neSDR5xzE3/uj0RzjudMKF+l31RXIQVVya6l7kXxVfHWrNvRBcOSQYcFipgdrnho6ZRuMYFYN3FefXbYNaSdJkc50m7P5UoXUWJOGsItYyteXU5Xbp6WKIxgv+jtb0jofcbj3bgb88d2wKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913946; c=relaxed/simple;
	bh=+zvdjkbGAbSNNp2ECyOBAh05sEW0uEd8xHLKcitq7HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUNhxhQY4syUHUly3v5zjDypvPOoieG5ZM+o2Vcel5OKJ+H2dzybT2mQsGiI3VenHuIEkZVkqLFdLdrQMsJ31G6CJJ0EZJhFd0SCdC1XVckHrj05Y3ndldOp2BDw36TFggpo5xssY3ayBDpGhrMS0ievT7Bspl4v7KrPz5e6d58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqeY0d3w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqeY0d3w"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b84c9775cso632705e9.0
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756913943; x=1757518743; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEosbCBuNUO3jHRbJolGb64jvyVY0uqLClgA3IRtUiM=;
        b=JqeY0d3wYC25nRMQ4cJVeNaT8r0mVCzYSm/QTa2RZe9TUnsVim8q78r/5KrJOzslpM
         +jazlpXUaGV3tGmORj5FWZprfZEE9upuMD5R2chuMHeQq8y8bHDw8QWmBi+VZ8CWzG1M
         axyEFeNSUBqdz1IufiWUr4WgB44UtaK1KWZ2zfVpLqQASbZmghow1Lf7DCewCgq/TkB9
         t1+G+dC1xUkZbcqiD8GG/G9PAUuBsaNad0HCq3RwXQAKOZXu0R6At/aIm6GTD4CNrPqN
         MSePp/8AGAF5Yk/K6arqdkhW7yhgKudu/PeUDlB/2dpEvp9mn0AMDgQ12NZSlp76Pur0
         lfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756913943; x=1757518743;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEosbCBuNUO3jHRbJolGb64jvyVY0uqLClgA3IRtUiM=;
        b=MD3CSTQ4r74LLmK7aq8oPBU6o9KmfZo4suEk9b4/e7xWUXtIZYzVIvJdQXT4usiY2G
         8XESOvVUSZD6H6S5+EKXQ2KX4+w3DAoH/hwWycj5RqzljRzFdNPluqYRzAtyVEWxpWHA
         IHEzz1/om/I0+Vsn4z9H8tL0TCN/ZLsTaGevkNC6fDLD02f7COWYuLdv5o0RjNmcc6XJ
         QxxHlW2GKZas/DrmEUXycZixZebx/w2aLnE0qKACaCno/IWvoghaZ/XHmN2MFYJpE+v1
         ZGXjNqPslQ7HXWYpK22LaNd/JMvRMVQiGG22pdVz1RAZktu8RggxYIfqOwXhvKiIV83j
         bjhA==
X-Gm-Message-State: AOJu0YwUuNvZUipJD+sybP+nHi5ocznGcW8RPW71f72EKmZ6IC/fJvM4
	GOLRG8IN28ewy2oGgx+Vg55HrpySq9SbVG2k8se+faT/fPZuw1WJIHnj
X-Gm-Gg: ASbGncu/hwrcTfGlPRl80XXhUSppph3cU8YcTI0vpT5cWnpzKux8LqmdS09Kb3NEFHW
	M9Zyzw1o1FOVKlWyiYqwqNlNSP6Q8EcXPvBn5zfg+NZ+rcfvbCaDhseXYEhEi7lmk8fK0K7YjAD
	RFeWdY5MXT+h7IxWcS0tRUbio4E5pWQk9PEHpp/CyjDflZ9z69fohBY59Y0vsXu+/szsgv167BT
	BHf/zEqSgJwQk1CaLz8mK6KjzJ67mFEhwFgG/VA9FMRkUaaHizDzgVVgrCwgieszFPRE2GwuqWX
	3op6QcQ+ZZcwliL1PT+ImpbgGxefCOPlH/IcUQTJXwRUcbOlYyVrsYkLTvbt0MFGzD7GVEKH+BN
	qn2I5mymEw3SOGVQ=
X-Google-Smtp-Source: AGHT+IHvZkoSiiMxUPpflw3WqCb3O5pMkQyEQjHuBYj1csV8h/d1o1l+JaEebI4HpJ/YZyGzch5JUA==
X-Received: by 2002:a05:600c:b90:b0:45b:8b51:b1dd with SMTP id 5b1f17b1804b1-45cb674eda3mr18628915e9.32.1756913942949;
        Wed, 03 Sep 2025 08:39:02 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73c52735sm307351175e9.22.2025.09.03.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:39:02 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
In-Reply-To: <2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 03 Sep 2025 16:29:44 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
	<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Sep 2025 17:39:01 +0200
Message-ID: <87h5xjlf56.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2025-08-20 at 01:08 +0200, Florian Bezdeka wrote:
>> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
>> is interrupted while syncing the IRQ log - for the very same IRQ - as
>> hard IRQs are enabled while processing the IRQ log.
>> 
>> The pipeline entry code will set the IRQS_PENDING flag and bail out
>> forcing the sync code (still in handle_edge_irq()) to loop to infinity
>> as the (periodic) IRQ might fire again after calling unmask_irq() from
>> inside the loop.
>> 
>> Delaying the call to unmask_irq() until the loop has been left fixes
>> this problem.
>> 
>> There is a "race window" involved. To trigger looping to infinity the
>> IRQ(s) must arrive while processing the IRQ log for the same IRQ.
>> Enabling some debug options like CONFIG_PROVE_LOCKING widens this
>> window as execution time increases.
>> 
>> This time the problem could be observed during IO APIC initialization
>> on a virtual machine. That simplified debugging a lot.
>> 
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> Hi all,
>> 
>> the problem could be observed and debuged quite well on hyper-v with
>> lockdep enabled and a slightly modified NMI handler to print out the
>> current call stack.
>> 
>> This seems to be a long standing issue for Dovetail. We had several
>> reports in the past that debug options (like lockdep) on hypervisors
>> (like VirtualBox) ended up in a boot failure.
>> 
>> Once we agree that the patch is correct I can send backports, if
>> necessary, haven't checked that yet.
>> 
>> Best regards,
>> Florian
>> 
>> CC: Philippe Gerum <rpm@xenomai.org>
>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/irq/chip.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 8a0831193d74..578e79d60de3 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -1010,6 +1010,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
>>  void handle_edge_irq(struct irq_desc *desc)
>>  {
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	bool delay_unmask = false;
>>  	int flow;
>>  
>>  	guard(hybrid_spinlock)(&desc->lock);
>
> I spend some time today and trying to understand what is going on here,
> but I'm still not able to fully understand what exactly is killing my
> IOAPIC uart IRQ while everything else is fine (when this patch is
> applied).
>
> Big question:
>
> guard(hybrid_spinlock) (see above): This is "new". Older versions (like
> 6.1) were using raw_spinlock_lock() which does not touch the IRQ mask.
> That is relevant while syncing the IRQ log on our way back after an
> hard IRQ delivery.
>
> Hard IRQs are always OFF now. I always thought that this is the trick:
> We allow hard IRQs to be enabled while syncing the log.
>

Hard irqs have always been off while running the IRQ flow handlers
grabbing the IRQ descriptor lock, this is a fundamental requirement, no
change there. handle_irq_event() drops the lock before calling the
(user) IRQ handler, then reacquires it before returning to the flow
handler.

-- 
Philippe.
