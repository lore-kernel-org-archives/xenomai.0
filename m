Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25101E49F
	for <xenomai@lists.linux.dev>; Mon, 11 May 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492792; cv=none; b=chV8v7S6LBdsl2WttT05Dwpb0+o19bqDF27CvWIPj8Sw2Oi8paDEBv9xaaVn+9vl4OyrRrguZYZVzHZ7gUcj4kdtgw/WvoA9/HiP9vNkkdck6hT788CGZwCiprM3Mcoyo4rrsQiXiZrXZ3J43wYLk1HTNm/XvT8vmDhmyul58ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492792; c=relaxed/simple;
	bh=xUYllkTALgt5tQkJauvchBk8PWSCJx8n3kWSKMQl7T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sp2+8Jdo+6nAQmn0PdmldM0sAO4O4UHDW9CGJPR4Om8b6EMTZkGXyx2oM9pNwNdsjRBMfE+yXlGGQf/Vcd04Q95Dkzu5QUfYLsgyHR+WZq9CyQsXBhtCL5avPgPPXqnK7AoOEJj9lgkTg5lL87XwCQmVASAuEjilFFXZe5x7c7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=jJKuwGmx; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="jJKuwGmx"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id AF337581554
	for <xenomai@lists.linux.dev>; Mon, 11 May 2026 09:29:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09E533EBC5;
	Mon, 11 May 2026 09:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778491746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnZQdDhmzYMrHGVCSP9PjTWX8uV89SJw2BVS3NxXttQ=;
	b=jJKuwGmx/VpPCgxuOiNv1R7SW0Jg6x9DE2f0GYpS6/TmZ3uEHVhKZ8DULY0qYr42fadkfp
	kBUG69FT8d7DiSiafSinxzbn1ES2q8sY1B2/cBzKUdS9x0wWKwFlY94OsZ3qL0sgHCKPsa
	ylDTZ2dlCMVi/MQTk62JGSJSQUN9NNs8gF7mgEx73PVocUHZ/VDWfStjXe3770v/PGtmVJ
	xJIX/j40Wwz4vzHVLB4/EVdZIXxlHF+Npc15CSF46fXO5nYIBNNNC+uXhiFYT/odlvb1G8
	txLaKCtisIsphkZLuRaL9NuThHE8GTp+y/zIA+Oxeq6QCEGt9cV87PbxokhEHA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail v7 00/11] riscv: Add dovetail support
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 30 Apr 2026 13:10:50 +0200")
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 11 May 2026 11:29:01 +0200
Message-ID: <87ik8u2t2a.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFd4uk6/LrB9sO685xFgIGN5K+oIAp3+DYvaUWottC+zg1SNExd8bEUq4fuG5q6dUwoweD+SuerZkmVRDcc23bNo1xh0AGOv6V7hXvIRfiNNLx3ouqXJzKlKvQbZDHfNAeiEwZblKTS8V6mUScsV85MI6Ecy1UdyvE/I5w/9Nm2utD2Uh2F+vbAXAtmkLnN2d1ip5MS8gGfARbefdjAEKOMY3iv7IAJNsH48xKTR8XsYianZGl0L21KD4YoCUT8CIQVgwKd+/dMfsaZ7Bhbt96mdalPT+mY6dtFMQ4ZOGVsbFxXfLgXcSXNG5hn5EkKsoz6gXXVH1G/M/0PWW1M1wfCCd0dXVwD0RL2uUWZr4Ws/6jbDFR2hBFXcXP1Pk+/HlUAkMoxXj37w1Y9UuW9pdNeLOyCloZ5uvXZg9Mb4QRNI2qlwE/D23nB4dzNALuPWSXUGFbh2cb0gXr0istO8bIT5/tn4eU/HerFtrVr9qP6OA28Sec7fyuIx/hOgP/dS9KExo2C7qXhIOhgW930JVF4ic+rGl4t7cwCYzlgQwwy2zA2vfWPX9Zf2sBWpcLHXxkFGLVaAUgw3OZC3tSTSp5wfbMksvNaBtdlOXSJunVy83B2uGnL14bpmMOSYqZljeeDXbTFsMUR+MsDgfQVGrUzskRene6uniYXEsYcqQ8IKQ

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi all,
>
> this series introduces initial support for Dovetail on RISC-V.
>
> Feedback, suggestions, and especially reviews are very welcome.
>
> Changes since v1:
>  * Disable independent irq/softirq stack usage when pipelining
>  * Drop KVM changes as long as they can not be properly tested
>
> Changes since v2:
>  * Rework trap handling
>
> Changes since v3:
>  * Included the IRQ pipelining patches to have all riscv specific
>    patches included
>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>  * Merged most of the fixes
>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>
> Changes since v4:
>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Added starfive-visionfive2 board support
>  * Introduced raw console device based on sbi debug console
>  * Reworked pipelined irq handling
>
> Changes since v5:
>  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>    irqs to stay off. This may be be subject to further optimization at
>    a later stage, but I do not see any negative impact latency wise in
>    my tests.
>
> Changes since v6:
> Address the review comments from the last patch set:
>  * Keep the virtual irq state in sync with the hard irq state in trap
>    handlers
>  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>

Ok, this is ready for inclusion. We should target 7.2 since the 7.1-rc
series is already running.

-- 
Philippe.
