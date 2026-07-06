Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572D3F39C9
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326310; cv=none; b=KVJhfBZK5OT42X0kds/4gbWlVqhO53pT1ckmyIhwexbdRribgKSrY4855ZukX+MUwZW0NBt3qNpChCMKlAOkHM4ZKGG6HbuvnqUOj4wOE40Rcd++FxJ7Lv6lhkevnnBkVXtkltEFRuJzN3k/wAx/j2aY3Iwt0BG17nYELC5Owow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326310; c=relaxed/simple;
	bh=lyAkXCNkLVnZNyWi0qmSzPmpUlMb5l7OWEfj8iEMIRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbNI7EDT2UU6jmyRrs+FrhuFPNeQI4ff36Q+X3C0tCOFiu1EKIj72v4IM16Uc2R4s1DAONy25o6NO4mFiAGDGJm9RoQPnMgko9y0ivRxYcvr0jPerytsmWi7lnWpk2IpmbAYJoCEdAmtcCktz+m7o5vKwtYGvC761QSwgiFrP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=o3sJklIm; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="o3sJklIm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1E813E9F5;
	Mon,  6 Jul 2026 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783326287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBUmesZipgfdgJUR6FrYTCqgy7GTeG1a1LjrkbFNE0g=;
	b=o3sJklImmZyoV6Hv9htJ0UtPdJ0zppRUbP/MQ0oiEoDQsiZkK3cPf53Xm1DA7ztEJipN/g
	eJmLyu3soUJW+KAxGEdX8lANZ15M3OWdNThevjhR6RlQjNyC5BxhchNekhSy7LHrVyYeLp
	iLqNUO9+laOW6M9FYp3Q7gJ4LLKnlsj/RAIlBgyGDtOQGFhxLYi0sZMFdzKq+f1R/x49C8
	6+9mzdsOLD32AYGka2sBRJ7Cdqa/vJK7k/L/IMjCKkEE0YxSoesr254mKy8DIptcsuNYo5
	MVdnLLq/RLDSy7uE3wAUKGb2wcDRNEWaoB9er6QC60uJgTsvympxBfL+NvagxA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
  jan.kiszka@siemens.com,  xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail v9 00/11] riscv: Add dovetail support
In-Reply-To: <08cea22b06a502fb97101869738f0873eec8de12.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 06 Jul 2026 09:38:26 +0200")
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
	<08cea22b06a502fb97101869738f0873eec8de12.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 06 Jul 2026 10:24:46 +0200
Message-ID: <87echgr0dt.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFgfIjjI4feSdarCUhJwCLdbeN4ZjR0/unk+usQMhj4tWrY+o+6rRQSp8+oOmSosF8F4rj/J0LvdJNuAA+s7US2nTe66OuhdSRs2e6S6/L2Ta4C3AyOm/ZAvV2gn743jhWI6ClX+DS+6dIDZ8pAOCxVxlg0jumqac/4HF+PDq223NDLQAys6LszrOlKzYex8/J1TqS1fmV4wiRT6+1IcXJa9ZBgZBPJrcn2YKW9XEzXSQb11YNQSnxfsD1jvmGJUtNlEOIYfOR8PEfUi2IDXoT5gFoZ5vKuEbt8+pM8eLKxFfAtw9J+bHOp00CE39bXO3X3X6CmVNyEd/ZbuuFOYdKWKz3LDQ/k/YAwL9YRJ+FaiQ0VnXO8HclOJRlxG3JBqwydGVikJkrM1XJuoXP9oLrIcNFAuzzfthXLyjj60rEsN9J8CcCBI7Bi0evII5kOdky8NJXt3JBwwa5ZIvzeDbrFdMxLuzpxxEb0PqpEoQlldslMwjimk2wbr932p7tgq1g7l5/Ax48jNVqT91AO09kMca/ALvc3FsnXfZ6oKWb2sJMwuYB6GAbXPDkTEaQPMq0no/agXjual000yRXtZAJVjieLJTDZYk/4cBTjZoF1QCIneKS/7bCKwwZPkOJ4ss28vLA3NTlErIL9NBYNP7lmDRsPW2hOYf6Q4RHuwgXjxg

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
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
>
> Minor:
>
>  - Changelog in reverse order, newest first
>  - Enumeration of changed patches, so we don't have to review all
>    of them again.
>
>
>
> Philippe, how do we proceed here? Do you want me to update the +riscv
> branches that we have for 7.1 and than take over from there? Or should
> we move it to the 7.2 cycle?
>
> Same question for 7.1: How do we proceed as 7.2-rc1 is out... 

Please pick the risc-v port for 7.1, then I'll handle the forward port
to 7.2 from there.

-- 
Philippe.
