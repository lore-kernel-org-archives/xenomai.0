Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE30433E7A
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110130; cv=none; b=TdjiBorBOXXOX6x0PiFcHrfKzWylSty2DBdjTNjtIoxMsUfZBfSfMfjd6JNUCGhnV9dbL2qMKPqHaz9A4/PbMmPhWA5rczx44TncRheufvyW/IKdAKGAF37fMm5Jb7DC0hA25yHCb0yjINq1K7SEyV/j3YzVN+eJLfNWWtCdGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110130; c=relaxed/simple;
	bh=XT8GMdwayWx2ZdrnVP+Fj24APcPrT6Z3w7yJUF2OWEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+Ei0gVPinUIZNpVaZmgzgW1E8OUgrTHaz4b2q12d70gXZaf5hmMlRS6aQrUm1tu1dKDzBsY70/uWfPxVStlUc5sfGi3JTqWQJh3MfznjzCbZrXcBv/5CLb/zrHDmjdOoV0NLLgV6cwDGJ6+8hy4o80jU2CY1weJjkTnkg8c9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bMq6Y3C/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bMq6Y3C/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 276AE3EB8E;
	Wed, 15 Jul 2026 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784110120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiqZP59DVe7TkVAY0fcdMORwGWfUvHGx8b9f2uskXXM=;
	b=bMq6Y3C/v7vjwT6/EUDio7i7ubRjeczEsycltiQ/78ZH3Q+XSfGMb7Xv1PnL+olm4N6gpF
	G7ZAjoqst6I3JcUm3SdALyLQXb8HnoYd3YidlJo5MvD6EIzZgtCrxzFYMwebmg6D6qzs2A
	U/lIJ91G3KeVMJRtxiSQUhARBe2xilG3osOrZpk6/54W9EdtGMfv4txNzg1YvyNz+dt+4f
	a/KMqy9MSSElx0VTv2+fcfhkiNc3b5P9DgwHdMkKP1boFfzXvD4d1E179EaJoXwY44Y8eS
	8YtS7yhuKAdtM3AwCbNsyvcrFfkISKL2VevSQk1uYaMOvlc5/nByoMgR2bdB1g==
From: Philippe Gerum <rpm@xenomai.org>
To: Kevin Strell <kstrell@aerotech.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai 4 Allocator Fragmentation Questions
In-Reply-To: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
	(Kevin Strell's message of "Tue, 14 Jul 2026 16:44:19 -0400")
References: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 15 Jul 2026 12:08:39 +0200
Message-ID: <875x2gmuoo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFJu5Get4Skx8sajMbvfu7QF3NdE0IacdF2YDoSD82TtFQVIoj+bLoxMWW2xoqWJF3AS8oCmfl/YCMjEhhzhwcS/mtn8CwclsZSrrg3jQRMuZIFiv9GJ2GawLYGmR6N0RujIoXezG85wk2RJ1FzLo9WdL7PMvNooLeuoam+EBcUGq57RAUsBQ2fWkhwg8XvG4QPEsPk0jSAaTSLB9j66zVeY2CNg44Ro1L+4zO55kdC6XIDyCTcveeRYtLTmvKADsghfkOH5m7hwPpR+RZ1Vlr+890CBNoiHSJpq/fevuLGzsiyNmjYnrRrFFnz0W70ENBLdgC3VzqQcStuNzrdmoCxmmGTxyHZ2FhIDhZF2nFvAd/EzHJb4t7AcCDcmQlIWSo3kLHv8KkiAq7W4gHo7Dg9M0gQySwcRrjeqFlxxPd1MJkHkBaSMIVmzP+XXyesW1FIJX0To60PdqK0fBTm4pWHMX5FbaPCi9HK+kgg3qm8H9ZQsVViOPVOM8WO7esuEdxBSKh1cxcMVQ4Ghh62eiwX3kTPQPqGm4/gcX1X9kubA+yr+SL179tbumRsEM20sC9nBD0kW80eJRf7RyMFMpUysH7ZDyrZyYn0TF6wZNxGAB2gFfuARvaV+y81Lk+MRct/SxENkCmtPJ6z2xoKE/IRngAr0UcDeT8xmOUEXrs7ug
X-GND-State: clean
X-GND-Score: -100

Kevin Strell <kstrell@aerotech.com> writes:

> We have been able to avoid the fragmentation problems by switching to
> using the rpmalloc library (https://github.com/mjansson/rpmalloc)

A note regarding this allocator, which documentation reads as follows
under the "Worst case scenarios" section:

"Since each heap maps a span of memory pages per page type, a thread
that allocates just a few blocks of each size class (16, 32, ...) for
many size classes will commit a memory page for each used size class,
while only using a small fraction of the committed memory. However,
memory pages are committed on demand and blocks are initialized only as
needed, ..."

Assuming that "committing pages" may mean mapping them to the current
address space and/or performing some kind of memcontrol work (msync?),
you may want to make sure that rpmalloc can pre-commit pages, so that
this does not happen in time-critical work loops. Because rpmalloc
operates on a per-thread basis, you would need to ensure this for each
thread attached to the evl core specifically. Failing to do so would
certainly cause those real-time threads to be demoted to the in-band
stage. You may want to check this using the related health monitoring
service [1] (EVL_HMDIAG_SYSDEMOTE).

To sum up, rpmalloc addresses the fragmentation issue by dedicating each
memory page to dealing with a particular block size, for allocation
_and_ release, so it does not have to resort to dynamic garbage
collection. However, in order to meet real-time requirements, you may
want to make sure that alloc and release operations won't ever issue a
regular system call under the hood.

[1] https://v4.xenomai.org/core/user-api/thread/index.html#health-monitoring

-- 
Philippe.
