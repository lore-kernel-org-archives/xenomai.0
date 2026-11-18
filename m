Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992866;
	b=qNR77abKxqTMaclYEHsuSVzFZ7SGlip9wFrEYO7tMspeRp+d/jFk1LnhyAzPA2uDYjxf
	 wbhAfUZyuaJD/f9GZF9XcAJRW6LgXyHe+13fygy+jSewpKB0ht6WH6xKU85jQVCoPpXkD
	 0VgAfjsP4V7Tn5NAPBDpQpSV2xZhtD11cTAmxG0M7t3tRl/Vh6P6gKJGCsANkXM8Q0Nuj
	 Aii9JDefT3yAYhx7sePgtK38GBICXxk78oAvzn/HFFG1jsWCmuFAE2RcjLOUIipcZHzZc
	 nl0qACDjxVPumTt4I02O/bIfF0GJApduTlTGRciIorp8zSSSeKJzS2vvljutyrAtGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992866;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=oAevkIvKhbVXdfDkwgHAoMYp10H16Nn4V8s8pxVjaTY=;
	b=1C9m70HdarfAN5oTHFW8FUQLB0Bcvz13Mq45ubcEplh35t0WCVWO0WtroAytqPs01kUT
	 MS4C41weFB2tROvV3ufAw0wwm7ZbM0DIw3sOj1XtCpzq+7SZGgEMxAUkFEHnW/fDb6M4f
	 i023WK7ko0cwZfYuJqFkbhHxM9aXOR8ckt385uAKx78yiHv+lffvwxmlDsVHW5hz1BtLO
	 CT2SKoc4l/HNu9cQbhfKW+wE+2hMjGWe3LomVXZrbi/YqNdPk8QCadmnnYY8XXZQoHyN6
	 uK8UKr32VHgc1Zc+Q2TUkl0FKOEX52C8Eve+SJ5k5Y91BvAHP/hxadNDiqRQyCnbFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=UN2UZ7HI;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48606A320
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 09:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C48606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=UN2UZ7HI
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52C4E3E97F;
	Wed, 18 Nov 2026 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794992858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAevkIvKhbVXdfDkwgHAoMYp10H16Nn4V8s8pxVjaTY=;
	b=UN2UZ7HI4ZkCDd0Gn3vey1jNn45YpNrPS3ixIavYccHdPkE53G5f6fPZIS01Z++opA0lSe
	q/DvxU2ZbZ7i5KvOxNzgEeyDK7rNwQ8XNbHHn8YDx7S3fRGctJt6sDI/LKS8Y8RXDc3AE5
	iiLnO+4h9Z3+kJ8ZmJaDMO+AJ+EAnfbunumNVIBC9BGxISAl9T9yMRtFHmowbO2o9O43Kp
	poVjsn+ndHk/MIFl6SenyhXIbOr6pOikZOAe8MLco1fJxoWv8ehhimKUfbIvIo43w1oXSC
	29LW/Sfi1kl8LsxFXGzJX2iPO9P1Yt87n7M8gahkLOy2/A5HkMZ8qpEUlkLKDw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH v2] x86: dovetail: Drop bogus local_irq_disable_full
 from __bad_area_nosemaphore
In-Reply-To: <1bc0efbc-345d-4ba7-8670-c399a5509363@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 16:41:32 +0100")
References: <1bc0efbc-345d-4ba7-8670-c399a5509363@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:07:36 +0100
Message-ID: <87a4n6fqxz.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFsHVTTHJicWckjnETr474oKXdEpNbpSO3FFzhI5p48mrkivAUBhC9FitF2yVZylEESOG9qMauLkuoGe6Lk+ZjoIoqqlsPi2R4UvJL0/9cKGUi0qhoQABWXqHJDn0v15RZNV7LVY/dVbU513xauMFo2wGKdEL4t3VUEKrmu+bCALtzLmuDShMhZ/SoSN1l7piyWwZw3XW0xWWmQ+sN7KGnU3gL/cUUCCf9d8IJ1Qxw+kIv5Mn/8uxdo6ZdJ8L8amt7AaUtdPxLbzaYvVStJF9Ix/6ANlZAQEoX9XZQtmhsCB+htBUn6Pmap0o40JxE5AEKUBBz4DoGJFDfniPX6lPpGeAsBavvErCpZE9C6G9qfY8NI16LWhdGzxTUBx5dWTbolu2yuKevWUv89ugwhsQ4FzvAt3wLIiz+O0JfvxTP5VAr4LLzGc908cFbVN28IQEiK1sr2h4Y2b/RHBUkhe+gbmdKmkEcGkZi5ddNQJmFoo/UrQIBMATiG1aPJociKWJj9CyyTOSdozLbVyaKSiJiuASvD7DDCFlb8UaEIbCyIXYQSArw0ji3gieThsRLofTw4cL3MqmXefj2bpbi+tGQ4zhbws7yNgJPO5MrQ52E7lKlsmIOgB3tEkclH+3lAxJe8bdHJehEuXaN6HHwBWpF48xP3qO448EYsGHrA0FeW8A
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Upstream commit 614da1d3d4cd ("x86: make page fault handling disable
> interrupts properly") moved the local_irq_disable out of
> __bad_area_nosemaphore into handle_page_fault. At this point, our
> previous conversion of local_irq_disable to local_irq_disable_full
> became stale. When commit 614da1d3d4cd was backported to stable trees,
> this was noticed and resolved, but 6.19+ still kept it, incorrectly.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Changes in v2:
>  - clarify the history of upstream and dovetail changes
>
>  arch/x86/mm/fault.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e41ed2092730c..e9a08a5d26e60 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		force_sig_pkuerr((void __user *)address, pkey);
>  	else
>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> -
> -	local_irq_disable_full();
>  out:
>  	oob_trap_unwind(X86_TRAP_PF, regs);
>  }

Merged, thanks.

-- 
Philippe.
