Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67F244694
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442609; cv=none; b=oiMopNxZuQ13KomkFmIZau6KSxp9RocGDpueCBgnjdPwXQH8AsAl2QC3M4rwHMkWk0beI4zjH2E2o6G3fxwzGwnBG3+jktnEf2n8zZfHrA3M0t+e4BbAW1FA6vs914CNiWgUFTHOPRXhlWSTlj92Ce4XXmEh4rDS2UnnNHg5oUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442609; c=relaxed/simple;
	bh=nGroIsFzSgvlWMTuQyVs/B2SS3zLnE5WdeiZiZwzGKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYdCgJ1z5ZoJ7PFrLWQL0vAAGsvl411wKZWMgpbXoKVNtZTltRtghiQRtlJqiC32sS4sZdF9qGGY965Ck/NEWg4ikPAkeBL00q5/jbgXcsSVJtrj5afnyfkwIo04kevg7alTjE8xzrYmbynwMetX97DyIZRlBImNz+qAN+jqxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NN91pipZ; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NN91pipZ"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id DF4C443630
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:50:03 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7F7D72680A57
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 16:50:03 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=NN91pipZ;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-202601261550027674ca2078000207db-0r5E7_@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-68982-202601261550027674ca2078000207db-0r5E7_@rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202601261550027674ca2078000207db
        for <xenomai@xenomai.org>;
        Mon, 26 Jan 2026 16:50:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MFKtMPI8BdbdnU78TOESoHeeV6vV5VU00cuVtazBh/w=;
 b=NN91pipZOGc5DXlYeI/4l6Fl91NTeXQS1FNw8BHaxyaoJtDA1wTi8SgJYeCgRN7UxCtw81
 JnbETiDVf0n5yYEjaPSzB8UFViBzMpqiHe57LhLSXyz5piB4wFMSIE3wiHCDCF3Aw8rflF8D
 rHE/gZX1/Ipng+ecu5L9fiLBHUdjNJ/DmEnc+dHvrKi8zDFvPFdQEzvi7REcn611um1bKYMZ
 P1NrnjAXrJ9oVXFkWbuzzUimff+vSW5gM5m5RPe7N9/GflOAnFXijpNo/dBqClH1I6EprjjO
 2t3a2MdCMrC73004Snr/YYcQCRnppKjLCw8oJNZx7V+JLW/jSvGMhKKg==;
Message-ID: <e3c92da16a134131ab9f0e958da4844d7394e6e2.camel@siemens.com>
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
Cc: upstream+xenomai@sigma-star.at
Date: Mon, 26 Jan 2026 16:50:01 +0100
In-Reply-To: <20260126125701.21000-1-richard@nod.at>
References: <20260126125701.21000-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheektdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfggsehtqhertddttdejnecuhfhrohhmpefhlhhorhhirghnuceuvgiiuggvkhgruceofhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnheptdevgffhvddvvdeikeefueeiteevvddvteffkeffleffieduteehhfevkeetfffhnecukfhppedvudejrdejtddrudejkedrvdduvddpudekhedrudefiedrieehrddvvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddvpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqdeikeelkedvqddvtddviedtuddvieduheehtddtvdejieejgegtrgdvtdejkedttddtvddtjegusgdqtdhrhefgjegpsehrthhsqdhflhhofihmrghilhgvrhdrshhivghmvghnshdrtghomhdpqhhiugepfffhgeevgeegfeeifedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-State: clean

On Mon, 2026-01-26 at 13:57 +0100, Richard Weinberger wrote:

General note: xenomai@xenomai.org is the old address. Not sure if those
mails make it to all the inboxes.=20

New: xenomai@lists.linux.dev

> [snip]=20
> =20
> +static inline int __rtdm_task_should_stop(void)
> +{
> +	return xnthread_test_info(xnthread_current(), XNCANCELD);
> +}

^ Is that used somewhere? Haven't looked into more details yet.

> +
> +static inline void rtdm_task_test_sigshadow(void)
> +{
> +	if (signal_pending(current)) {
> +		xnthread_relax(0, 0);
> +		XENO_WARN_ON(COBALT, kernel_dequeue_signal() !=3D SIGSHADOW);
> +		xnthread_harden();
> +	}
> +}
> +
>  static inline int rtdm_task_should_stop(void)
>  {
> +	rtdm_task_test_sigshadow();
> +
>  	return xnthread_test_info(xnthread_current(), XNCANCELD);
>  }
> =20
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 607f115a7..e9baf38e1 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -204,6 +204,8 @@ static int kthread_trampoline(void *arg)
>  		return ret;
>  	}
> =20
> +	allow_signal(SIGSHADOW);
> +
>  	trace_cobalt_shadow_entry(thread);
> =20
>  	thread->entry(thread->cookie);
> @@ -2373,8 +2375,9 @@ void __xnthread_signal(struct xnthread *thread, int=
 sig, int arg)
>  	struct lostage_signal *sigwork;
>  	int slot;
> =20
> -	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
> -		return;
> +	if (!xnthread_test_state(thread, XNUSER))
> +		if (XENO_WARN_ON(COBALT, sig !=3D SIGSHADOW))
> +			return;
> =20
>  	slot =3D get_slot_index_from_sig(sig, arg);
>  	if (WARN_ON_ONCE(slot < 0))
> --=20
> 2.51.0
