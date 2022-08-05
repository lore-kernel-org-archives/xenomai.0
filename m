Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63832EA2
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 09:11:26 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EC06DC1F5B
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 09:00:58 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4F621240002;
	Fri,  5 Aug 2022 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1659690050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4rQWuYySHuh98w5plBoVn24tyVExDLAre5buqYt0zQ=;
	b=JeiytReH2OrJLX674YZcVZrybj6M9RYSU236LsnernVh2lGTE7LFTs0VhKVbVFwPxq0O7O
	HLAtUKEwTCjsC2LxnMW2OLKc42le9Byubas+JHUKw/vskbrk1o3UplVabL6+6uJcTEFZ2p
	Io8FiQbaMTqA4ZlxH2IIiYCcVNrdIkHRanqfiKtJBeiZjHhEfIJvUpT8dOzOwAKndXCBlu
	tRY9dZOAIi4NcbuKlvTLNidJZqV0J0eyBX0VQrWtkJytq2BIM0vwu7Jm435KDYskam09Gg
	KAk7LLJsCuYRY/oVwXhONTaYU+OIwBJ4YnfUM99Au4zogZ2Ape7cXfHD26ngkA==
References: <c2c8a20e-0298-60f3-be88-4477be6c95be@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail-5.10.y] x86: irq_pipeline: fix build error
Date: Fri, 05 Aug 2022 11:00:43 +0200
In-reply-to: <c2c8a20e-0298-60f3-be88-4477be6c95be@siemens.com>
Message-ID: <87les383pb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index a1e7ba5e0ac6..c08c2e21c227 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -369,7 +369,7 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
>  
>  	flags = hard_local_irq_save();
>  	add_nops(instr + off, nnops);
> -	hard_local_irq_restore();
> +	hard_local_irq_restore(flags);
>  
>  	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);

Merged, thanks.

-- 
Philippe.
