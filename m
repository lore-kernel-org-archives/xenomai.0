Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10A2585
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 14:57:48 +0000 (UTC)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C5381CB3BA
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 14:57:40 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B5C8E200008;
	Thu,  4 Aug 2022 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1659625053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klCrnBoxg5Bu/do4K44iS3KwbUdb0zJSxLV1YybtTZk=;
	b=QbKEclJuCfkHSJb3WEXjUNShjP1QFQnJSVgYYgXRAzt/m7xokgU6wOE1EQyQ8Pu2cP+Z00
	ptJKtVAdVxOgEWvGwrwXromdbr8DRWNfsPprBLAcNlSVVUaC/6NUjzTwHpsdNYJfTlZufI
	2qGeL7BTh0sm73YonogPt1flKfPnFEUtCizkGXPIvH+gPlyVyVJ7OpfgG5LnFJTbRSKtY8
	NEI7FYHWWL7gSllVx87tHpKctiR+7Nd57tM3+k+K5uwl0455pdXNjMcBsNHoTtwPtCXRv5
	oYDJxJpwJDA0lyN1s1DWXFvQFJshXjed8nMp1TnWPkJveux5Z9wWs6ivzgErmg==
References: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
 <87bkt0yy85.fsf@xenomai.org>
 <CAANaHT9E=73w7_sOugpw7JBToTzfRtDy+aTeW5HgPKZjB_rKQQ@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Gabriel Durante <gabriel@neuraldsp.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai 4 IMX8MM
Date: Thu, 04 Aug 2022 16:39:44 +0200
In-reply-to: <CAANaHT9E=73w7_sOugpw7JBToTzfRtDy+aTeW5HgPKZjB_rKQQ@mail.gmail.com>
Message-ID: <877d3oys2r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Gabriel Durante <gabriel@neuraldsp.com> writes:

> Thanks Philippe,
>
> IRQCHIP_PIPELINE_SAFE flag on gpio-pca953x.c did the trick, no issues on dmesg.
>
> Now only the issue (kernel hangs) with edt_ft5x06 loaded while running
> sched-quota-accuracy.
>
> [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
>

I suspect this may be the outcome of the test overconsuming the CPU
bandwidth on the same processor which runs the (threaded?) IRQ handler
serving the touchpad events. IOW, the IRQ handler cannot run quickly
enough for the touchpad hw and/or driver to be happy, because
sched-quota-accuracy is keeping the CPU (too) busy.

Three options to check this:

- move the test away from CPU1, which might be shared with the IRQ
  handler, using the -c <cpu> option (you can run sched-quota-accuracy
  manually, outside of the 'evl test' scripting).

- change the CPU affinity of the IRQ for the touchpad device, away from
  CPU1. Fixing up /proc/irq/<irqnum>/smp_affinity accordingly may help,
  with <irqnum> matching the proper device in /proc/interrupts.

- try reducing the load imposed on the system by the test, e.g. by
  lowering the number of concurrent threads using the -n <nr_threads>
  option. Defaults to 3, maybe 1 would allow the test to pass in that
  configuration.

You also may want to make sure to switch off
CONFIG_PROVE_LOCKING->CONFIG_DEBUG_LOCK_ALLOC, CONFIG_DEBUG_LIST and
friends which slow down the (regular) kernel code a lot.

-- 
Philippe.
