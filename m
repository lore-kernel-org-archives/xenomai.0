Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E753EBF04
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432428; cv=none; b=IlNLLuZCH7efacF+G7bhRDWYY1FLLpe4ZMdkAuX83i+YACN3YU2XdQNMsGvlfiQGpivBDOjqj5iVxV3SMwy/s5OlnooMf2Q+VF1IXP+3ZJUGn9usyjlbdBoZXwYK1QnY2BILQHJSMp4Veoc9VlS7bNH0ba1MFv87jzziXBgINvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432428; c=relaxed/simple;
	bh=6m7cevUuZuUFUzAd/ZRSH47Q5uK/0s0REkag9m8BGJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FB+L+LsBckgy8dqxp4UkhBGgqLDEjsuRmega18ji/kcnLvRkHsLL0f9yxlJyu2ZBy8adhnu5GZ5oCgEcU/u0YifJ+04Lj1F/dZE2FKtTKtB7Q/l4u1um2YQBZfx8mJ+hILmKuelx1cvWnQcuu5bA1LP1nu2WtzReg2McD5wfZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=nk0uiJFb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="nk0uiJFb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 839553EDF3;
	Tue,  7 Jul 2026 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783432417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MQSFT6tNssPfzBcZY4St5hjrUR3S03rdJV1wM6OV7k=;
	b=nk0uiJFb0HXyyKlb13obFIJuMOI6/Rn4PPfVS9592yP5kOEV3/58TYGOqrZDCjdziRLmTS
	XI/NUmiukwVT8ZJazrV8/8Js4Fng9iBZd+fGgeJ8ga8UXNUVm51doYdpnOtReOwoqgJoze
	uOuuvL8zjwlF87QlnIig2k28oomk1V/ZBmq5tCuoeIuFi5wPSCqdSWT+are1SWL6BAHLRN
	iv/7iiqDcGbSyjyZUPVkMhv4jzT8dgNdmIQHjYjakjqyzKWhhoA6IH3qGUm5B+TwvzR8fI
	vgdZZGrBMQRgj5tIgrfFJtRkETsfCi/ROVdMzbo1okCc5TQ7/8DMsxwXr3UPWA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
  xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail v10 00/11] riscv: Add dovetail support
In-Reply-To: <aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 07 Jul 2026 12:02:52 +0200")
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
	<aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 15:53:37 +0200
Message-ID: <87zf02vrby.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEyP2sfVKpQmKvaPEZGG4n6XPTCWPPzISnYg1bF5V0aB7KkJC+5bA2GRQXyc5YhMsc3tUeP+qXNvDQsyAVopHwskD3WfA65m9b0+6zm2DgC9/GjpR20S1PD48m9V6ok5OC4JY6Lgz7ExXfA3G2RewRGoy4ACyBIAqiZoGsFw8vCda+2e5kNZiWYO+kgS80iwjwBErn2XiuHXn13V6zXfV5pNw9yGvYL2H0jlP26w+HMxnjvE2VGNT6WR0LxdqDZekMMuCXRpz1VG1Z2WESJxgHhyUFQOgrd+Rb3LJKtUWm1loFOoKMfOazMfY0SfXpAUKcBJjfaWJ/DjJVhdIyKDmfZZ4NMCKd6vOEXaIHP7lIv80y5IHKUZ3NjUQ91GwzhwNA74mq9UOpXaduMwpkXrb/AqTg+C6r/croaP7DgfmyxyGZFJU/ExYhvGLEL8ulittciqxgKpVcr1A83gHJCngCBlBJgSxJ+a1SNUjEaUyEUfJwwQoiUTjz0wNpQN8Qvbx/brM3yeVBw/rzt1A9c+XxOlzoWlTJS8YR/ECsXQif8+y/My905Dk/kLgdAqN91+uuCCpuTaDNAfzVmjx32So1V05ybxSkpPKvC5GFNoY9EsStCQ0BGS8y7tUWhcPdPrz50Nym6XTVAwnBJQgWqDZiTvMUPz1gDTiDovwJI1jKy3w

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-07-06 at 20:29 +0200, Tobias Schaffner wrote:
>> Hi all,
>> 
>> this series introduces initial support for Dovetail on RISC-V.
>> 
>> Feedback, suggestions, and especially reviews are very welcome.
>> 
>> Changes since v1:
>>  * Disable independent irq/softirq stack usage when pipelining
>>  * Drop KVM changes as long as they can not be properly tested
>> 
>> Changes since v2:
>>  * Rework trap handling
>> 
>> Changes since v3:
>>  * Included the IRQ pipelining patches to have all riscv specific
>>    patches included
>>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>>  * Merged most of the fixes
>>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>> 
>> Changes since v4:
>>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>>  * Applied suggestions from the last patch set
>>  * Added starfive-visionfive2 board support
>>  * Introduced raw console device based on sbi debug console
>>  * Reworked pipelined irq handling
>> 
>> Changes since v5:
>>  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>>  * Applied suggestions from the last patch set
>>  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>>    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>>    irqs to stay off. This may be be subject to further optimization at
>>    a later stage, but I do not see any negative impact latency wise in
>>    my tests.
>> 
>> Changes since v6:
>> Address the review comments from the last patch set:
>>  * Keep the virtual irq state in sync with the hard irq state in trap
>>    handlers
>>  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>> 
>> Changes since v7:
>>  * Simplify Trap handling
>>  * Rebase to wip/flo/v7.1-dovetail-rebase
>> 
>> Changes since v8:
>>  * Further simplify trap handling adressing Florians suggestions and
>>    recent fixes to irq-entry-common
>> 
>> Changes since v9:
>>  * Fix checkpatch finding in patch 11 "riscv: Add dovetail support"
>> 
>
> Thanks, applied to the following branches:
>
> dovetail: wip/flo/v7.1-dovetail-rebase
> evl:      wip/flo/v7.1-evl-rebase
>
> Philippe, final test run has been scheduled, expecting both branches to
> be taken over by you. Any left overs?
>

Nothing in my Dovetail queue at the moment, we should be all set for
releasing Dovetail 7.1. I'll reconcile wip/flo/v7.1-evl-rebase and evl
upstream from that point.

-- 
Philippe.
