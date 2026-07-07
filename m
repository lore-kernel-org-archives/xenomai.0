Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99910416122
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433161; cv=none; b=Len0XtC9m2aJhDpVh3gY2G/Lul+mLJqWp9dLMlYxpoIhEakkb+ehorX6upVhD9tJdcU5syp4LE6rtZ74Eb+q9XdJqSiPSZpqFZuCJRK909Le45TDz0/2BOnYm1w//jfyiMfxL2Ul8RGppqzrSLijPGzSdxaPQ6OaJbtIwx7Rz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433161; c=relaxed/simple;
	bh=JsPRLaDtwWi1xhWVxdXGtwdBP77/sRAG90WT2bcV8rU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kPaekDQDcVbPyyOYsxoHXUY6Qj17aDkCKIUGjI2+Sx/ynItmXh4JJJjxQr5Rtt9em2+lV3q3iYXaQdIETCFBE6BpvVyVVhHHryPpqlykSwsO7c9veM5lJpavids9uWiZrPPbjtu+hl3CDsVerclEbau96OvdV/s2UvCLFjQ0V5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LLjRUw5T; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LLjRUw5T"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 810E9581FE9
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:48:41 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E19B03EC02;
	Tue,  7 Jul 2026 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783432114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INGHf9GA0WmhjR8bwqBTNxy5ZdsWqnpMjzFX7l+QNiQ=;
	b=LLjRUw5TvM7TApX1SqKLDg1AoxoVtqVPnzD3zdI26tZfMMsvFYx33yne22TvNDchcZdzdc
	3heqTn7uMguvpV2JltrVmssywu8HyhootdyncoA5372WJx/C5jK2XKUjyzf+RmUNGV1vAI
	6QiKLHJmT4HOEQnGvLBgnRWpAPsypfQ1qkObE4ptw26KjD50HuH4Mnyj2jwnNQUv4o8yuJ
	govY6asUPpTtJ4ULFk9wg2nF2GFHNFPJhzBbJGnyEELYr5Si4p728exCX87f4zHXMiLm31
	AL7o72p8JLvCGSy4wBxF2viTg0mNvQHOmt9tERG4OvfKDaUU/0ndcvRhrgcTZA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v4 0/8] Dovetail: arm: Finalize review results
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
	(Florian Bezdeka's message of "Tue, 07 Jul 2026 11:50:16 +0200")
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 15:48:33 +0200
Message-ID: <875x2qx64u.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGfJ4ps1lWEoHoN5nCF0gpcds2ZIVMuG+8gDw2YoY9CIJ8IpfOJx5RGzjWSfQQORdVkOpU5xXaWWFwsedFzDHxLp+xUwMAQsfraIrSI1dCuffow238wani6VujqsnIdlYY5NJ2tof6D/JrxaCKSeWGTMQ7hS7hU8z7LjqZeERvXV51B2wJ31/chn2IGV7j/N8SU6INrlOS4EBnNU3um+YemUR0qjlCa7sZ2wyBScNqEV9lN8+u0MXH4f9vxMISh5LmmPumlFGeUkfzvlCCyWwbH7WUlhQd3NjcJ4jnvVv3aeQXfybsS1aOR09Oe96PVYZsnOyvHTrKPQf6yeAPekqd/uDjrh/R22AmqwzsZzWBOcyxw05UinMCRz1J9H8x+4XiHJi3Mf6eY5jZDrDfigjz02HwTExz38uHIaIaBWbXVinwbJuHff3Gm1lFwLRd/116r3YEV7brCpliWWDpsOMiL+PYDxm0afR1G0VWv7DiNzoNXQOJutbg0bvNVdJ/gDXfH8ouo8v/AitZBwP+4zwDmlaAgT25gA6F2YpWlM7D2kAyLVLm/dSYPdxR54RhY1GUvcSKcFZflRysIO6D3GrS1c/oH8J2XgVoG8v4V3hgIuuU7m4jn8g0dCdMPo4HqG/azEtK87pmMRmJ1q0Rnvz7DJMLDohhAKK7gIu1KbFXwyg

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> This is the first try to fully process the feedback on the
> interrupts_enabled() issue mentioned in the former patch series.
>
> Input welcome.
>
> I tried hard to keep everything easy, but changing the current
> implementation triggered a lot of unexpected include / build problems, 
> especially within the arch/arm/include/asm folder.
>

LGTM now.

-- 
Philippe.
