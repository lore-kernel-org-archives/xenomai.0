Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8430CE0
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 15:13:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B20A240008;
	Tue, 26 Sep 2023 15:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695741215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F80m41AXBMixoQn5VYYMBY9VdJVeDnn0/tYtjWC1rBU=;
	b=efQoFgtiMSUMy7RU0RlHqZ+5/SzCaJdlu8lJSSEihijfW4BMy82aaM90CmQxXT+xL5+q4J
	tGd+CBb2IMw6gcUOLmHkMTZ9jHv6FHakP9W1huMbcSFsWL6Z8iDF6N7jUsWsIQE321J6Hj
	sH2pw+G0mzS/AwBj/7c6QkfX3YISw/ynTs89NaJS1g86U2r9ECefUEU1OgWhiqb0IvZ6Fi
	LKCKJm7SW6gD0y3QCJk7hwEaNtBCQhJ4exczs6wNg4PZH5F/2a0M1L1TDsuzjc76ub+UWE
	fr3E9DHQBkk3ifKoxa7U6D3sXfsX5GAHe1RN7ouY9oitWEuLiEeMbIyWstyy4Q==
References: <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] Problems writing to physical memory with mmap on oob context
Date: Tue, 26 Sep 2023 16:15:38 +0200
In-reply-to: <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87sf71nf1h.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jesus Villena <j.villena@ecler.com> writes:

> Hello,
>
> We are using an ARM64 based platform which includes a small Cortex M4 processor to run some algorithms, and both subsystems use an internal shared SRAM memory to implement the inter-processor communication.
>
> In mainline Linux, we open a "/dev/mem" file in the ARM64 core to get access to physical memory, and mmap the shared area to read and write directly to the SRAM from userland.
>
> With EVL, it doesn't work: after opening the file and doing mmap, we call evl_attach_self to switch to the oob context, and then, reading on the shared area works, but writing aborts the program with the message:
>
> EVL: evl_test switching in-band [pid=363, excpt=0, user_pc=0x404b5c]
> oop...
> CPU time limit exceeded
>
> I don't understand why EVL is switching to in-band context.
>
> Do you know where is the problem? Why does reading work but writing doesn't?
>

Looking at the output you get, it most likely behaves the same and does
work in both cases, w/ and w/o EVL involved. In both cases you receive a
so-called major fault when writing to this area: the only difference is
that EVL reports such kind of event which requires heavyweight fixups
when running oob by sending a SIGXCPU signal. You definitely want to
read this doc [1] about these notifications.

Those major faults cannot be handled directly from the oob stage, so EVL
downgrades the thread issuing the write access request to in-band
context first, then notifies the issuer about it via SIGXCPU. You could
disable this signal by clearing the EVL_T_HMSIG flag for that thread
using evl_set_thread_mode(), or set a dummy handler for this signal. But
that would obviously only paper over the problem, which is that the MMU
wants some help from the kernel for dealing with this write access in
particular.

If not already set, you may want to turn CONFIG_STRICT_DEVMEM on,
checking whether mmap() still succeeds or fails with EPERM. That would
give you a first hint about how the kernel views this SRAM range,
i.e. dev exclusive or other. In any case, figuring out why the CPU traps
for that access may require some debug work with the kernel code (I
would start looking at arch/arm64/mm/fault.c, do_page_fault()
typically). You may also want to include the KERN_ALERT log level in the
console output, in order to get a number of low-level memory management
traces on arm64.

PS: Since /dev/mem is a liability when it comes to security, you may
want to write your own (small) driver only for the purpose of creating
memory mappings specifically from the SRAM to your application,
disabling /dev/mem entirely next. EVL would still have no part in this.

[1] https://v4.xenomai.org/core/user-api/thread/#hm-notification-methods

-- 
Philippe.
