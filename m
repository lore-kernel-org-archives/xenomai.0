Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CA286419
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914475; cv=none; b=ayC+ccbXFCCr2+8h9n2QRi5OW3gM26xx/4EzkSxb5lUgO5hqZ0hqaAE6wYfqnrIJMA3AtXn3NTN3X8XZRWHvhJh1oCOjOZVDOpbsfRqswBbfjmydo6sExg2bv2lMu6+efumMFHJwpQFcSO9ZCTn2nwkPMM5Q6ApgPSOhUKgwKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914475; c=relaxed/simple;
	bh=4UDqVB9hLSU2ioi+FeoOAMddxYaTPy7nvRUC5NUMp0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKQgIC1ccd5s6moJOpBDEbeYEmozr3vro1y9izjgm/+Kyk+Hw5xpE61z9l8tYVephpvXLI6SxmWMZ5Z+qbHuQ4NA9wWHBRd62Ea2wKIl9OZD5IJP7q6gpTVcAfrU0oto1x32dknkTn8jVVhKYZ1fuSEE+OBO0XzicUSsKkjFH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGXOFEqH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGXOFEqH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d2564399a5so50637f8f.1
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756914472; x=1757519272; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cieWFgWQxmFP6RqE7d8iIzFawXx6K5m6BR7r26vLYmU=;
        b=XGXOFEqHGxqhXj/kwrILfTQplTTxh8/sKdeJc6kgIRqAHZSKFlQQBGTFeP1+cciBqo
         JL10ICQcBTf8r9EMQmC5M5PfG1p/hsuzehMvs6pkLqOKta4eyr2O89qgSA1Qi6QQkqGp
         KDXvqOJuoLN2Qsn0JappZLpEjRTAOtTZj70yXl2ggGozFjWw2tB/yN8YkDxDD0+gNKxK
         kGajqaXZvscVwOfXh4m1pJlxjeLZ9qN13mxYt5W2sa+St0odEr41DqdRlui/nkee/UK6
         Yyj3M55VdRqJNi4xukA9s8mkDXcZZNnfVnkLY/KNnyMxkHs2sCibFL6hx6mq0VTTC8/I
         fhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914472; x=1757519272;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cieWFgWQxmFP6RqE7d8iIzFawXx6K5m6BR7r26vLYmU=;
        b=r9x1rqCcrVqv2tkJEz+tTYLcH2pkWgIdbHmXSx5+xGDm9LBJ4fLNhM1sl2FfYckxaY
         1oiu6PFuGSJ1iQZxBIOR6rx9OMcXcKZKoevPxbTPEpLNgdBGW4+rAhpcP2rAZvN04/gL
         JkesDW2IbhNxoGe9+MJYtYc3jkYQaJ5qqq0uL+yaWGkJS5KDXLw/18DJdXISwEPlZjgB
         ANbsAHY89eJu935XAQkuZl2IreOqkSQjI8PsLbX2juboXMlZAIlYUXeyWAfC3JbN5Pdo
         dAYgHwCAIK6Aea8RqPnURT1k/s5V/QGN/vQEWGVQ7W+BqMBkRriQ3zypRqnTPD1NRsWJ
         7Jpw==
X-Forwarded-Encrypted: i=1; AJvYcCUhLUZGaFkl4ROedMOEY0Dos9AfsjOFNS5ZHoX6K5EArykwN9qRbmKoa1j/wHmVcWveoWdciVOq@lists.linux.dev
X-Gm-Message-State: AOJu0YzJYAi+szgT146GwgAtuerbVYYGFzUPIvelpKmuP+U29jAFxRuR
	cRpG1CsDjWfRMYnnSFhhN/Mu7Z9MVdehRlcJV8k2aoSfq04Ira+dUpX7FC/sCWZ9
X-Gm-Gg: ASbGncu8AbtFEPNdDfJtrbl34Bn7D2BX2uzub2YKUFbOPzCZPFoRgsnYcnb0CPPmryZ
	39XduWul7cEqAu4tY9eQJtCEahJVjljLSqTER/1QuU5mRtmyKwd9mRLpZhYAweHGqRm6AKZhmJl
	f+ZTSMd1S2OdRzq67gQVJmEiIO9BC9iKVKDG2OI0+7Eime1xLlw8AjEajEha+q1BbOfYYVOY3qt
	BgDHPE/05uXMGzdLJMpGbv8nf6pHAvYbV4mTJ8BsyCldpLOP5dI9NmoBaAjMKfPJRm69frFwJwB
	vJvnPQ+2FcvJZuF1STpU7zKdhHNMoePnT8oKNjiWZzJAHbS8vYB+xQ4UA/V9yhjSSTVtKLNXdkc
	/npsch/5K0d73nbHq6nfa+BBC+bJsybhrRRsHsQ==
X-Google-Smtp-Source: AGHT+IEPOLlwIwNX4iWY+NdNvnLqWGXwBk5AuK8mFO/5aW47yWYVY/0f/8uhk8CbTPetouqiSho/nQ==
X-Received: by 2002:a5d:5885:0:b0:3c7:84b4:e76 with SMTP id ffacd0b85a97d-3d1de4b90a8mr13195752f8f.25.1756914471877;
        Wed, 03 Sep 2025 08:47:51 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm24310840f8f.27.2025.09.03.08.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:47:51 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@lists.linux.dev,
  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
In-Reply-To: <87h5xjlf56.fsf@xenomai.org> (Philippe Gerum's message of "Wed,
	03 Sep 2025 17:39:01 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
	<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
	<87h5xjlf56.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Sep 2025 17:47:50 +0200
Message-ID: <87bjnrleqh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Gerum <philippe.gerum@gmail.com> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Wed, 2025-08-20 at 01:08 +0200, Florian Bezdeka wrote:
>>> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
>>> is interrupted while syncing the IRQ log - for the very same IRQ - as
>>> hard IRQs are enabled while processing the IRQ log.
>>> 
>>> The pipeline entry code will set the IRQS_PENDING flag and bail out
>>> forcing the sync code (still in handle_edge_irq()) to loop to infinity
>>> as the (periodic) IRQ might fire again after calling unmask_irq() from
>>> inside the loop.
>>> 
>>> Delaying the call to unmask_irq() until the loop has been left fixes
>>> this problem.
>>> 
>>> There is a "race window" involved. To trigger looping to infinity the
>>> IRQ(s) must arrive while processing the IRQ log for the same IRQ.
>>> Enabling some debug options like CONFIG_PROVE_LOCKING widens this
>>> window as execution time increases.
>>> 
>>> This time the problem could be observed during IO APIC initialization
>>> on a virtual machine. That simplified debugging a lot.
>>> 
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>> Hi all,
>>> 
>>> the problem could be observed and debuged quite well on hyper-v with
>>> lockdep enabled and a slightly modified NMI handler to print out the
>>> current call stack.
>>> 
>>> This seems to be a long standing issue for Dovetail. We had several
>>> reports in the past that debug options (like lockdep) on hypervisors
>>> (like VirtualBox) ended up in a boot failure.
>>> 
>>> Once we agree that the patch is correct I can send backports, if
>>> necessary, haven't checked that yet.
>>> 
>>> Best regards,
>>> Florian
>>> 
>>> CC: Philippe Gerum <rpm@xenomai.org>
>>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  kernel/irq/chip.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>> index 8a0831193d74..578e79d60de3 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -1010,6 +1010,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
>>>  void handle_edge_irq(struct irq_desc *desc)
>>>  {
>>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	bool delay_unmask = false;
>>>  	int flow;
>>>  
>>>  	guard(hybrid_spinlock)(&desc->lock);
>>
>> I spend some time today and trying to understand what is going on here,
>> but I'm still not able to fully understand what exactly is killing my
>> IOAPIC uart IRQ while everything else is fine (when this patch is
>> applied).
>>
>> Big question:
>>
>> guard(hybrid_spinlock) (see above): This is "new". Older versions (like
>> 6.1) were using raw_spinlock_lock() which does not touch the IRQ mask.
>> That is relevant while syncing the IRQ log on our way back after an
>> hard IRQ delivery.
>>
>> Hard IRQs are always OFF now. I always thought that this is the trick:
>> We allow hard IRQs to be enabled while syncing the log.
>>
>
> Hard irqs have always been off while running the IRQ flow handlers
> grabbing the IRQ descriptor lock, this is a fundamental requirement, no
> change there. handle_irq_event() drops the lock before calling the
> (user) IRQ handler, then reacquires it before returning to the flow
> handler.

With the above in mind, you may want to check __hybrid_spin_unlock()
which handles hybrid spinlocks, how it reinstates the hardware interrupt
state observed at lock time. If interrupts were enabled in the CPU at
locking time, __hybrid_spin_unlock re-enables them on exit.

-- 
Philippe.
