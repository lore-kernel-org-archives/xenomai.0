Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306C1952E
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:30:35 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2DCC2CF7E0
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:25:28 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id E8927200008
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:25:19 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E17DC9416A7
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 10:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5D26663CC11B
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 12:25:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id puabaDAxbYHa for <xenomai@xenomai.org>;
	Mon, 12 Jun 2023 12:25:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 04215616B2D6
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 12:25:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BL2X5xgjvRc7 for <xenomai@xenomai.org>;
	Mon, 12 Jun 2023 12:25:17 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id DB9C163CC11B
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 12:25:17 +0200 (CEST)
Date: Mon, 12 Jun 2023 12:25:17 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai <xenomai@xenomai.org>
Message-ID: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
Subject: Massive variations of execution time on x86
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: ecxCFjAboALDcvYMCoVCc8urSYAceA==
Thread-Topic: Massive variations of execution time on x86
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at;
	dmarc=none

Hi!

A well established RT application failed lately in QA.
It fails only on newer x86 systems such as Tremont, Tiger-Lake or Elkhart-Lake.

While analyzing the failure I've noticed that the application never
is interrupted by the CPU scheduler, it has the CPU all the time
and it does not call into the kernel (neither Linux nor cobalt).
It turned out that a CPU bound computation within the application takes sometimes
significant longer.

I can reproduce also using a simple for() loop.
So it is also not a memory bus issue, IMHO.

For example, a pure user space computation takes most of the time 100us
but in about 10% of all executions it can take up to 500us.
The number vary heavily depending on CPU type and generation but
execution is still often way slower than expected.

The most problematic case thus far is with a Tremont-L system,
where the execution time varies between 100us and 500us.
On the other hand, the discrepancy is slightly better with an Elkhart Lake system,
with a delta of "only" 60us.

Initially, I suspected that the CPU frequency governor might not be set to performance,
but I have confirmed that it is indeed configured correctly.
Since the application consistently acquires the CPU when necessary,
latency does not appear to be the issue.
This has been verified by running cyclictest and latency programs plus an in-house test.

I have also experimented with various kernel settings, such as idle=poll, intel_idle.max_cstate=0,
and ensuring that turbo mode is disabled.
However, none of these adjustments have provided any improvement thus far.
Additionally, I have tried using the cpuidle.off=1 setting.
According to the hardware vendor, SMIs are also disabled.

I would greatly appreciate your insights on this matter.
Is there any obvious setting or configuration that I might have overlooked?

Please note that we are currently using kernel 5.15 with Xenomai 3.2,
although I do not believe this to be a significant factor in the issue.

Thanks,
//richard
