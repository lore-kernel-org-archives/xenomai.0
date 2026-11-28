Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863200;
	b=KyOjlNjbpSYEMf9GTR+F5nhg7+24h8JKb0+sxlem4nValSKbcq7L8covBYpRMwLzHCMo
	 PhD/oibhZ0cBJq8eNpqQyPszRoiCKl04fj1sLsHnmYesB2kg+UNDcMGiAMBn3l9EuAwBN
	 /S8mK0sGM+tMvdLNVpWZw/6oSCHixjohRLq653aa5nkL27evE2ZCXJGfLdznChgNBGviZ
	 oxnjyqNRIoeu4CjeHnVprJUqMfosh6jGl3GaWegZIE+EWt39omyC2FplupzVrWv2eJ9BP
	 Ly/drvNaR3vOuAQBlSeAGXpQJnIIUigWG8S1b+OthCb7s19upO6aM3cFo2E9VbxC2GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863200;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=Wp4/l5d+Jw+5DkPLvvy4oGyc9wMtX+EXodEl6KBUulA=;
	b=CjxSOTX9B1IHaLR1LUkEgjeaybh96OvCD36o9InVe0SojVkc/oh4m+lv+NhNj5U6oZ7O
	 vOBbRnz8EcsEqg3Er8u7SCcMYhecxkHb1phrOBbsdz7PiU8jV5841Ti+0Vsw1agBL6pnN
	 u40LXL6moFd8wMKp8PSZyCAzoe8DMZC3oqABv3AqWzqRnnaxVs5noF6bCdbBGowNf6tIG
	 JxGti735Q5oQy3fQJRPU4W/5TGUaP19pipNOYvQIeGVMowF1zn51SDvJ/JwCLMoQPFPCi
	 Te13l2OZUl7zLsJV5P6YaXl9ylakNoxJpy0GeRto1Tg9bYKtGKSgO0zXU0jP7uvP+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=aPU72AtD;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDC606A31C
	for <xenomai@lists.linux.dev>; Sat, 28 Nov 2026 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55EDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=aPU72AtD
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F87F1FD1A;
	Sat, 28 Nov 2026 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795863189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wp4/l5d+Jw+5DkPLvvy4oGyc9wMtX+EXodEl6KBUulA=;
	b=aPU72AtD/3Ri4Wn1bmIp1fNbxJbiJe3ATyyBrkuasqoV5k0MLVJ2rbPr4FZirBBe0saW7y
	OYGLP00aIRt25dLPlOBGaT3iG2zTii3m/Ner6EX/5IEmRrwC8PJC19EwH4LPm5x8lFMQwu
	4u+r5LFd2KGZzDxpLC33TxyxvNtHzJjHcziNVuUpEJp3f61gK7Swlt6lUAYkXbcDFvJawe
	+eSsiJR7RVQ98inFxWUDmjvcqcodFJ4evphxZmz1UZSTYEQ3mmKwMAPdPzkqAMDeON3bs+
	YxEfXYKZn/YrRbqDuOtKP4DVBPNw0I21tKSoregNEaXxKP1OlEs5qMlXXCqXNw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail][PATCH] lockdep: dovetail: fix unbalanced
 hard_cond_local_irq_restore
In-Reply-To: <e66c29ef-ae08-4371-a00b-de5abeb43a0d@siemens.com> (Jan Kiszka's
	message of "Fri, 27 Nov 2026 14:56:30 +0100")
References: <e66c29ef-ae08-4371-a00b-de5abeb43a0d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 28 Nov 2026 11:53:02 +0100
Message-ID: <87zeutgrch.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGflKcSSPk8fV/Ih+qu+rd9jpvzO9a+BY6k4mNk/qcgLZHBaCDKw8vGngQcoW5wtk6aQyZDbFaN8qyirs+Pp1JTG/VjnIF0HiN04FQjHTmEt8mtjugtLuSs9bAGi61x76KxGKIoWheVgIDd2949jiICcwo/9S348bCVXyIX+nxF1V0pmQsWel5AvLVFajjprOHDHrWBKNJUAqF2JeDUvG0b6DnHd27oAElfZNeTRJ09WdoGjNLjNABFj3r6TZOL2qmYlvrFDOPzG5TBwsgvc8EvplaHp6ckKA4RAxI2IzlpvvaF8/kB6WJO8roFt1yNdS6FDvlcEz+D3Fq5JSW6Y2QvjlL7oJtk19dP5g+gqgP/e2+IMv6uZRTCnE1uu2tI5sJtZDGi3xi9oY5vJ3bFiuoxwGVVEgZZNd0pedStfYQHrmsAkaJmDv7THUUDPt6VMkgcSaZEXznQ3AC6sXRcGT9jaXuocOtp1V2HgSgyh0dvfjo/Y5H0bBP5+bvfpmEdxwRcGPrChNi24IQwQKZEDcqAKhWNBNzjqr/YdFOwZj7IKOduhcWGX/5aTfvhXbIvreGUCbVsXQAz74xmz9VsO/kkErLz+T7GT1xg29jEiWU/dg9xjUi0S2wuY8KXnrmhxA3Fbiakg2Yqw+LFQhh7lhOSVpdqAAXbqLAiZxQ7zJ0IFg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> After the skip_checks block comes a hard_cond_local_irq_restore() - but
> we were not initializing flags when jumping from here.
>
> We are in NMI context here, thus IRQs disabling is technically unneeded
> but a) symmetric to the hard_cond_local_irq_restore and b) truly gone
> when IRQ_PIPELINE is off.
>
> Reported-by: OpenCode:Opus-5.5
> Fixes: f9acdddb8afc, 5.15 ("irq_pipeline: lockdep: fix irq state causing deadlock")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> It took backports from 7.3 down to 5.15, each reviewed by the same AI, to 
> finally make it spot this.
>
>  kernel/locking/lockdep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 08bb0173dad77..4d91327a2a6ce 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4535,6 +4535,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
>  		 *  - hardware state check, because above;
>  		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
>  		 */
> +		flags = hard_cond_local_irq_save();
>  		goto skip_checks;
>  	}

Merged, thanks.

-- 
Philippe.
