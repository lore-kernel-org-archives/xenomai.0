Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B281AA7
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372706; cv=none; b=S+8IjpA1GPqwElrlXYLUh8AJXlNp3WG+1G8cJFzQzHdiRMSp9VfhDPydDNx8/SBCyESxSSrPyCYZyOYXmpercSc8Y7Gj71GbPaaB9iYNPuqro+6rxviAKS/NbbmrSosBFxlD/sPKKu5yzAzAkaUVwlxq1MvAzg3j+PBa2RWVJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372706; c=relaxed/simple;
	bh=sp+UQZNi5Ni3+RIU8L+mWH7EhTBTd1oXpnkeJfQZaHg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hLOR6Fp5+5erpiN7Em1IJKEGJqJokTa5z4IK1C9tq1uBbTtbSR9/jMBwpXxEVcnKFkLpnc3LPurWAoKYBIx6LSQ/meGcBrMXvA/Ar1Gj/w4bE3Yb5Sd80XpkcS2Ro9SKH1HV6acvbg4pe1H5BRKLOioaOVDnkk3JR5HCfyZuOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TYe8jHRU; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TYe8jHRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sp+UQZNi5Ni3+RIU8L+mWH7EhTBTd1oXpnkeJfQZaHg=;
	b=TYe8jHRU8yFrRXMTg5vwkRALODbu7umm0WxMplfCoujyEIRSjBpwZiNYP9wmvl
	doN76kw9NUNTriOTBKiZ2R0Bhe0Dr9Jo0nNex4Dka7VAWvAIZz4fOYXqXVb4HjFu
	79gdzyvQ+auK7+EYjouTYC8IEoANhrQ210lHGJYOipWDY=
Received: from 2956c958a175 (unknown [106.39.130.120])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3H__RxE1mB_foFQ--.37267S2;
	Wed, 22 May 2024 18:11:31 +0800 (CST)
Date: Wed, 22 May 2024 10:11:29 +0000
From: JiajunDu <wonderboy512@163.com>
To: xenomai@lists.linux.dev
Subject: A problem regarding SMP
Message-ID: <Zk3E0XfaeikSP2Kr@2956c958a175>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wD3H__RxE1mB_foFQ--.37267S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4UXFWfXr1UAryxtFyrZwb_yoW8tr1DpF
	W3KF15JF1kGa12y397tw4kXryIyrWkZF47GryDKryYkws8Cw1FyrW3tFWjyFW8ursYkw1F
	qr4Ivws7CrZrZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziSksPUUUUU=
X-CM-SenderInfo: xzrqvv5uer5kirs6il2tof0z/1tbizRfmG2V4HTxR-QAAs3

Hello!

Currently I encountered a problem with SMP while using linux-evl core.

I created multiple kernel processes sequentially in the kernel state using
`evl_run_kthread` and would like to have them run in parallel on multiple
CPUs, but the parallelism I was expecting is not happening in EVL core.

After reading the relevant code in the EVL kernel, I discovered the reason
as follows. When calling `evl_run_kthread` in the master process to create
multiple processes sequentially, the master process creates the first process
first and then waits for the first process to finish initializing:

wait_for_completion(&kthread->done);

The newly created process enters the `kthread_trampoline` function and switches
the OOB state first, then calls `irq_work_queue` to put the inband irq_work
that wakes up the master process into the current CPU. However, this results
in that the inband irq_work that wakes up the master process having no way to
be handled until the first created process finishes executing, because it is
OOB. This would also cause the creation and running of the second process being
delayed, since these events occur in the master process. So in summary, there
is no way to run all the processes in parallel.

By the way, the /kernel/evl/thread.c file also exists a comment explaining this
problem:

/*
* We are now running OOB, therefore __evl_run_kthread() can't
* start us before we enter the dormant state because
* irq_work_queue() schedules the in-band wakeup request on
* the current CPU. If we fail switching to OOB context,
* kthread->status tells __evl_run_kthread() not to start but
* cancel us instead.
*/

Now I'm thinking that theoretically this phenomenon is correct for RTOS, since
the main process that creates the new processes is not OOB, so it does should
be woken up using inband ways. But this does cause a lot of wasted CPU
resources in SMP environments, because it would have been possible to have the
inband processes and the OOB processes running at the same time on different
CPUs.

So, here I would like to ask, should this problem to be solved? And is there
anyone in the community working on this?

Best regards,
Jiajun

