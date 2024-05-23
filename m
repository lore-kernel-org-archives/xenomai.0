Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DA2628D
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436051; cv=none; b=gV0gcSV+SW+9jRp83SWUEyDRDBuucOmbz+Rwj56uQ+mf6cYQRnW5KZXq24Aa8nOC+xxv48igErPXFKukNAfyufeYwak74dcoYtQ0iQOnctQopwQ/mtPq6Zj0IB0ekIuAkicqqREpcqmBbdfiw5tcq0/BhTLkZ/8++/KSFHjj1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436051; c=relaxed/simple;
	bh=213LevUYXx83yWbDc69VQxfas9Fa/mWmZ6O/EThcxJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QB0dQAMaPgTpbE4Ihd5kIv8Z4dAMYjhCfFpCJfdLLfgJyXQshrdHSBQ3ejdnxYKff4tEPTNSm51fY4fdUsAhPK91FQ5WAP1DNILCI5PecdJqucKXplJ/7NG0COnvCQ5J3mkIA+vMUwSCF3VaZ6+d3Q5MlnkOiDn1pfv7RHcFGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nMGdtuBJ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nMGdtuBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:Reply-To:MIME-Version:
	Content-Type; bh=213LevUYXx83yWbDc69VQxfas9Fa/mWmZ6O/EThcxJM=;
	b=nMGdtuBJPtXzoPHA7seER4vIEYShpRJYs7pIGaH4vPcTO+A3zPgvyVBa2Rwlb6
	SJuigVA0ihskovlcwtvICVQQGeH/paWd5vRjzQllph0aw49hqBKcKHMDvMMsMUZQ
	JCvyyq1QxVDj4Z/DRXk8SDsJ1NjNEZT8CgrGuPnCTyOGo=
Received: from 2956c958a175 (unknown [106.39.130.120])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDXP7FDvE5mBMNwBw--.55075S2;
	Thu, 23 May 2024 11:47:16 +0800 (CST)
Date: Thu, 23 May 2024 03:47:15 +0000
From: JiajunDu <wonderboy512@163.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Message-ID: <Zk68Q+2tgdwEkcS9@2956c958a175>
Reply-To: 87ed9urpex.fsf@xenomai.org
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wDXP7FDvE5mBMNwBw--.55075S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1xGr4kGr45KryfZr1DWrg_yoW8Wry7pr
	4xKa4UZF4DJ340kws2vr48ZFyI9r4DXFW7CF13trWjyw4kCwn5trZ3trZ0yFyrZFn5Xw1v
	vFWDAa1UJFyDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piU73DUUUUU=
X-CM-SenderInfo: xzrqvv5uer5kirs6il2tof0z/xtbBFQbnG2XAljrUZQAAsX

Thanks for your reply!

By using a barrier to synchronize all evl kthreads, I did achieve the
effect of multiple processes running in parallel. My solution is
in the next patch, and the branch I tried on is the latest
`v5.13-evl-rebase`.

But I still ran into two other problems while trying this solution.

The first problem is that `evl_flag` cann't solve the problem. The wait
condition in `evl_wait_flag_timeout` is `evl_read_flag`, in which the
flag is set to false as soon as the flag is found to be raised in
`evl_raise_flag`, so `evl_raise_flag` can only wake up one waiting process
at a time. And it's not possible to wake up more processes by calling
`evl_raise_flag` multiple times, because it's not possible to determine
the time when processes are woken up in the SMP environment. If we did, it's
possible to have a situation where two processes are woken up at the same
time after the flag was raised twice, and then only one of them can be
woken up at the same time. So in light of this, I defined two new functions,
`evl_wait_flag_same` and `evl_wait_flag_timeout_same`, to read flags using
`evl_peek_flag`.

The second problem is that after using barrier, load balancing is no longer
possible when creating processes using `kthread_run`, which is called in
`evl_run_kthread`. The phenomenon is that all processes are created on the
same CPU. Therefore, I can only specify CPUs manually for load balancing
purpose by calling `evl_run_kthread_on_cpu`.

The code I tried is available in the next patch. Is there anything we can do
about these two problems?

Best regards,
Jiajun

