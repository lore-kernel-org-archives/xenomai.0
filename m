Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBD7C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 10:08:26 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1BA4FCD743
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 09:58:30 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A07EC40013;
	Wed, 21 Sep 2022 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1663754303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPjS8ZAaI/l95HY72F14E2L1KaBbyM/UISP3eTXczyY=;
	b=EEiQWCXKOWlODzOTRdvgQrTNA1zGp2WkGuMcLsD5QLq5ws8BtlKvlBzCfyGPyBarP1tUCt
	8BsoN0X3geI2AFNfjSv5Kh63eQ8iV25Oa8SjtmfOoeZzoVqtIrIarPUSB9UtCAAskZP0JO
	Qz8nXiMcwytdK7Alunw3nwBk3BrxyliHE5Trd9lr0Ki0+1erzrBwXKGDZvXD758u/hOJ3f
	YxoGjMy8OQ+TJWWl7WgEuQ5LpKzsyQ+puOdWM+oIejGAwfx+jY1j6WqC+VgSZRo4kqUG5C
	IHQXBvRDSrkBbD0Gxnd+Sb5uK9CYG+hfhZtPu4xDcYL7j0WamTrC08JbsA0QyQ==
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr> <87y1ud3vzn.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: How to debug realtime interrupt latency
Date: Wed, 21 Sep 2022 11:44:53 +0200
In-reply-to: <87y1ud3vzn.fsf@xenomai.org>
Message-ID: <87tu513v7m.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Gerum <rpm@xenomai.org> writes:

> Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:
>
>> Hi,
>>
>> Let me introduce myself and what I'm working on. I'm a software
>> engineer working on the real time acquisition and control system of
>> the Virgo interferometer:
>> https://en.wikipedia.org/wiki/Virgo_interferometer . This system is
>> currently based on RTAI 5.2, which allows us to implement control loop
>> up to 50 kHz. Data are exchanged using optical links of in-house PCIe
>> boards. These boards are synchronized using a distributed clock. Each
>> iteration of the control loop is triggered by an interrupt generated
>> by the PCIe board. From the interrupt handler, we are calling a list
>> of computational functions running in user space.
>>
>> I'm currently evaluating Xenomai 3 as a replacement of RTAI 5.2. The
>> first step consist in measuring the interrupt latency. During our
>> tests, one of our machines shown bigger worst case latencies than the
>> RTAI 5.2 based platform running on the same hardware, or even than the
>> same Xenomai 3.1 based platform running on a different hardware. That
>> is why I'm looking for advice on how to debug interrupt latency.
>>
>> Here is my 3 setups:
>>
>> CentOS 7 + Linux 4.14.111 + RTAI 5.2 on Dell PowerEdge R630 Intel(R)
>> Xeon(R) CPU E5-2623 v3 @ 3.00GHz
>> CentOS 7 + Linux 4.14.111 + Xenomai 3.1 on Dell PowerEdge R630
>> Intel(R) Xeon(R) CPU E5-2623 v3 @ 3.00GHz
>> CentOS 7 + Linux 4.14.111 + Xenomai 3.1 on DELL PowerEdge T740
>> Intel(R) Xeon(R) Gold 5222 CPU @ 3.80GHz
>>
>> Except for the kernel, all the systems run the same OS (NFS mounted
>> root file system).
>>
>> The interrupt latency measurements are in this figure:
>> http://emmanuel.pacaud.free.fr/partage/interrupt-latencies.png
>>
>> All the systems have irqaffinity=3D0 and isolcpus=3D1,2,3. The affinity =
of
>> the real time interrupt is set to 1.
>>
>> The real time interrupt is installed using
>> rt_request_irq/rt_assign_irq on RTAI, and xnintr_init/xnintr_affinity
>> on Xenomai.
>> The interrupt latency is measured using the in-house PCIe board (a
>> time register is latched when the board emit an interrupt, and a
>> current time register is read at the beginning of the interrupt
>> handler).
>>
>
> Which is the frequency of the timer event in this test case?
>
>> What would explain the latency distribution on the DELL R630 + Xenomai
>> compared to RTAI on the same machine, or to itself on the other
>> machine ?
>
> Hard to say ATM. 10-15 =C2=B5s could be explained by significantly more c=
ache
> misses, e.g. after a driver for a graphic adapter has issued wbinvd. Or
> simply due to more convoluted code paths running the ISR. I understand
> the test environment between RTAI 5.2 and Xenomai 3.1 does not change,
> so cache invalidation from the kernel should bite the same way
> though. Longer IRQ masking is another reason obviously, which is often a
> function of cache behavior during some interrupt-free section.
>

NOTE: There is a known source of jitter with the Xenomai 3.x series when
it comes to dealing with the core timer (which should apply to RTAI as
well IIRC), which is related to the single-lock model: beyond 4-6 cores
(x86, less with ARM-based SoCs), the lack of SMP scalability this model
causes may induce higher latency. To mitigate this, you would need to
restrict the set of CPUs allowed to deal with real-time business, using
the supported_cpus kernel argument, so that other CPUs do not attempt to
grab that single lock as they catch Xenomai timer events uselessly.

Since your test case does not involve the core timer, but rather a
common PCI device, this locking should not bite until the rescheduling
procedure is called at the end of the ISR though (per-IRQ locking
applies to device interrupts until then, not the ugly big lock).

--=20
Philippe.
