Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D020EC
	for <xenomai@lists.linux.dev>; Sun, 25 Sep 2022 16:38:09 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id ADE02C0004;
	Sun, 25 Sep 2022 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664123882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wp/HBKsJkyoHhdffLOuSbguE0ZkV94iA3QBTj5/WbP4=;
	b=gH6gOx47WaBK92YslOOLYwqMh6crBkvfAfyR4JagDxMnFrGD70spLyboguNgC3oIYtH6dL
	u7bTYYPEjoWQdfkD2vTQp5ekf/8xgtuidhSuEfFV+k17IqlEYAg/ORH1mreHxbEBEZdcKo
	4cZRvrUUTXKxZMnJoX8JxVxsdPk2m3N13heGMdIFfkUZZ3iVy5t5YuzkxS/9UXaUS4SQbA
	MOkLwQAKORZP4J8fq7Cmah7uouhfPs8HHDZ6cVOyMKVZjfuDpRcwY8PMl5gs+RsvqYRPbV
	TLg/soWIKLDIwE10ypC/rBka7VNCQSeu6LpfK+o+/KUg/ZIYW1GC8C13/apjaQ==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Sun, 25 Sep 2022 18:32:58 +0200
In-reply-to: <87illb8pfs.fsf@xenomai.org>
Message-ID: <87edvz8l5i.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Bryan Butler <Bryan.Butler@kratosdefense.com> writes:
>>
>>> I have another system that behaves slightly differently. When it hits the watchdog, here's what I get:
>>>
>>
>> I have been able to reproduce a bug on an armv7 SoC with the test case
>> you provided. Sometimes the RCU stall detector triggers, sometimes it's
>> a plain hard lockup. I believe these are symptoms of the same bug, which
>> _seems_ to hide in the PI chain management. I'm on it.
>
> Actually, the PI chain was 'only' collateral damage. The bug was a
> fairly silly ABBA deadlock issue elsewhere, in the monitor
> implementation. A fix is under stress test here, I'll follow up with a
> patch asap.
>
> Thanks for the fine test case, having it made a huge difference once
> again.

Please test this branch [1] which addresses the issue, passed a 1h
runtime stress test here. I'll wait for a confirmation from your end
with the real app before merging these bits to the mainline EVL code.

TIA,

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/testing/fix-abba

-- 
Philippe.
