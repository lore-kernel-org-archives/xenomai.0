Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB76139B
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393939; cv=none; b=e4bN7CkiBTqp8wCCsaCPuVBzaUhTT4ujgytHeAas1dPwoh++VnW/59p+8wwzqBvS8I1zdxuBFZASwghOtrOnXr7VQIMxJApTRocEEdx5zcxeoWbNj2VZ3dcetOV7MN5xCOlAuHDD/hAJBPnLd/x8D74V6f5EbvhG85kTT8izBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393939; c=relaxed/simple;
	bh=rc0H+rYBEBGuXMfViZ6Gv+wRn1NStdbwvDtv8EfSxpI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NnkEVDzpgb1OrDsnU25mKmGSrcs1tVaAVTFH6BPbvF8bQwzfZWtnvRLLPwtPMswKiDhYtp3RZprp391SbO28be3CC9o4Ql5bpsKsWQ9LLrujEfcguiHSimgVTRpXJ3hnbLJaMUpccH/9BL3OiwYph12HnzYMHOPsyT4s5Z65kV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 73A19606BA2D;
	Wed, 22 May 2024 18:05:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HRHn-V7-nUes; Wed, 22 May 2024 18:05:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 145FA6195FFF;
	Wed, 22 May 2024 18:05:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lDaTdi3oANDd; Wed, 22 May 2024 18:05:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EC2A16195FD0;
	Wed, 22 May 2024 18:05:32 +0200 (CEST)
Date: Wed, 22 May 2024 18:05:32 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai <xenomai@lists.linux.dev>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <843802480.134113.1716393932934.JavaMail.zimbra@nod.at>
In-Reply-To: <14c584dd-2847-40c3-a9c8-d38c38dae98a@kernel.org>
References: <1716387954-19178-mlmmj-572dc488@lists.linux.dev> <14c584dd-2847-40c3-a9c8-d38c38dae98a@kernel.org>
Subject: Fwd: [CPF] Real-time Micro-conference at LPC
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Real-time Micro-conference at LPC
Thread-Index: Er3nUa6ANimdxRdBiOkam+PxFm6Bfg==

----- Weitergeleitete Mail -----
> Von: "Daniel Bristot de Oliveira" <bristot@kernel.org>
> The real-time community around Linux has been responsible for
> important changes in the kernel over the last few decades.
> Preemptive mode, high-resolution timers, threaded IRQs,
> sleeping locks, tracing, deadline scheduling and formal
> tracing analysis are integral parts of the kernel rooted
> in real-time efforts, mainly from the PREEMPT_RT patch set.
> The real-time and low-latency properties of Linux has
> enabled a series of modern use cases, like low-latency
> network communication with NFV and the use of Linux in
> safety-critical systems.
> 
> This MC is the space for the community to discuss the advances of
> Linux in real-time and low latency features. For example
> (but not limited to):
> 
> - Bits left for the PREEMPT_RT merge
> - Advances in the fully preemptive mode
> - CPU isolation (mainly about how to make it dynamic)
> - Tools for PREEMPT_RT and low latency analysis
> - Tools for detecting non-optimal usages of the PREEMPT_RT
> - Improvement on locks non-protected for priority inversion
> - General improvements for locking
> - General improvements for scheduling
> - Other RT operating systems that run in parallel
>   with Linux and the integration with Linux (e.g., Xenomai).
> - Real-time virtualization
> 
> Examples of topics that the community discussed over the
> last years that made progress in the RT MC:
> 
> - timerlat/osnoise tracers and RTLA
> - DL server for starvation avoidance
> - Proxy execution (still under discussion)
> - Tracing improvements - for example, to trace IPIs
> 
> It is important to notice that it is not _only_ about PREEMPT_RT,
> but anything related to real-time and low latency. For instance,
> CPU isolation, real-time scheduling, timers, other OSs that
> run in parallel... and so on.
> 
> Join us to discuss the future of real-time and low-latency Linux.
> 
> This email has a list of people in Bcc, based on a list of
> commit authors in sched/locking/power/time. It is far from being
> complete. So, please forward this message to the people on
> your team working on scheduling-related topics.
> 
> -- Daniel on behalf the organization: Sebastian Andrzej Siewior, Frederic
> Weisbecker, Steven Rostedt, Juri Lelli and myself.
