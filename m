Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01042B75F
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068300; cv=none; b=SfQSat5D/oc5z98QF/g3wivLBY/sMErE6redD1HjHFOW0uIZ0jZsQtlsN5qP+/LjbhDtlV554jIdSJIwc9+LVla1Mqt6VuEpi/TlaRVEjU32pI6pK4ueOUfT/JkQuhjRVpMfq6xKOdEbHTDLsR+iNcXkQcw5NYRgvGwrwly15kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068300; c=relaxed/simple;
	bh=C/fBgvqLoRxn36ureb+2cr2R0WA+exu24Hdppbtgvow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIiBAxayFRtAKIZGpEFaCPH5YkQ8Dm+YJFPreBnVBzhOUqIa8xmlqCVJNZ8jXxSzp4Y7gF17MHYWHnUfsJRHfRz8cmuvwP/gLZgFPV6QZaSLqTG2jTfa3J//q+Pf40MVDrR+swIRDHOMBnK/MDc1ontltOkxQQDVUlSVA5atvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gBOoKg+X; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gBOoKg+X"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88AF33EC83;
	Fri, 29 May 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780068296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wblKWd2xxctbVB9stH92R5uRv3hJHZ85eQ/lLaoD4Nc=;
	b=gBOoKg+Xz/ZmTQqzF21x9Agi0NTP1LUWG3DXmR3M6Kw4FxSlTVVOo//617q7NBOD6oAq9+
	b5C8dChpMytn0T4UysCoLOmeEeFw45kwZ7nrZPcU4bHFLbkDD9B4wQJ4KrwT1htiKSFZi9
	fbSeKl2LIRVq1v8c3dkoWm6xQz9GXlfhDMoYDF23cE+HNOOLAQqx1tzHYfLXWgXLD5B2ia
	0eKPr4Z9MO4hqGmKC2Mafd7LMztZdtUmUvVupVfOyt8ru+bhJMbOhg22IPAtUtZBtOLe3o
	kVfu8JYxqe5iPFOY1p4vTp3sBStq/wXQsM7hYHf7X1pH2EgJb1p9y0T+DS9w6Q==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,  "Schaffner, Tobias"
 <tobias.schaffner@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
In-Reply-To: <ac539a660d311083336a970152faec0e44716441.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 29 May 2026 13:53:36 +0000")
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
	<87bjdyil4u.fsf@xenomai.org>
	<030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
	<87wlwmh4x4.fsf@xenomai.org>
	<b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
	<ac539a660d311083336a970152faec0e44716441.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 29 May 2026 17:24:53 +0200
Message-ID: <87ldd2grwa.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEVvOBq93aPkJ8PLxYi99GprSxpviauNRcbX/eqJKmtVBJPMpLzyfmhp0WnoGdwbcgVBHdybyDcmxIdhRVs23oRujVWZIfZj3k6ZpynENw7JMNUM+79+x+5bE7oOGNRmSPUWpZBGVeXamAl5W3Ym1utE4axwgsgAlTUDlXg5mII+9z3ugRriobUBR+vY78s/Q++NRyO9C3h1PSlAZ1NuSC5LIXTHJVlP+mj8OPgTmjqne2TMPOa+bA4xkaPdtObxQmtiLVSNfef0s+hoVPV3UuCeerAz2fOqI61wYMsesQQuoeffEvvcBYLOhmoQSOQgjnP8DmamZjsKS9PfCGaFcpaRgWhYc9w+jk+1Vfy9fKG4Z2r7K3J9OFQLLJDMPGHUgew+SiwNvVdt44Jy9sNGX51la33jvalvf8G8FZqASdXwszlnzBZmWXs83o1nhsCog7ZAk3cdKyjmvplyOmdwOaee/lt9gpXVIG+YMN+AmxOAnEG8NTcUr+Vv9Hp/aATBQ2YMm/fzD7XP3hjEmX4uLZd0TY1xIDbqGuRs2z5FkdWydxULE/M5HgAIQLtOypxUAeQEYUBFeKqE0zBgLLV7JhsVT+1CnxCXlqFrxiFyS/N4l8QyxXklarc4yWsWkjmXRJOZisKZxHSBKfCEBsYkSmwk/MThUdeGuVgOQS9++dvhA

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-05-29 at 12:49 +0200, Florian Bezdeka wrote:
>> On Fri, 2026-05-29 at 12:43 +0200, Philippe Gerum wrote:
>> > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> > 
>> > > On 29.05.26 12:08, Philippe Gerum wrote:
>> > > > 
>> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > > 
>> > > > > Hi Philippe,
>> > > > > 
>> > > > > I'm currently waiting for a v8 of Tobias' risc-v implementation. A
>> > > > > couple of minor things still need fixing, but overall I would say that
>> > > > > we are looking good - ready for merging - assuming that currently
>> > > > > running tests are successful.
>> > > > > 
>> > > > 
>> > > > Really nice stuff, thanks to anyone involved.
>> > > > 
>> > > > > From my point of view there is one issue left, that needs a discussion:
>> > > > > Testing and forward porting in the future.
>> > > > > 
>> > > > > Up to now I was able to test all architectures using cobalt / x3. That
>> > > > > will change now, as we don't have risc-v support in x3.
>> > > > > 
>> > > > > I see the following options:
>> > > > > 
>> > > > > 1: Additionally forward port linux-evl in the future, so that we can run
>> > > > > tests against risc-v using x4. Additional effort for me, especially
>> > > > > because we don't have an in-house user for that. Can you estimate how
>> > > > > much time it takes you to forward port linux-evl in comparison to linux-
>> > > > > dovetail?
>> > > > > 
>> > > > 
>> > > > Porting evl to a new arch kernel-wise is fundamentally trivial, the real
>> > > > work is done by Dovetail. For every currently supported arch, the amount
>> > > > of arch-specific evl code is 60 lines of C, merely wrappers in headers
>> > > > (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
>> > > > libevl needs to support risc-v.
>> > > > 
>> > > > > 2: Add risc-v support to x3 as well. To my understanding there were no
>> > > > > plans yet, but it might be worth it to limit forward porting efforts. I
>> > > > > could focus on x3 for testing. This might also help to compare risc-v
>> > > > > against the other architectures.
>> > > > > 
>> > > > 
>> > > > Although this may require a little more effort compared to x4, such port
>> > > > would still be tractable since Dovetail does most of the work here as
>> > > > well. Adding risc-v support to x3 is Jan's call.
>> > > > 
>> > > > > 3: Ignore risc-v during forward porting. Yes, this option exists, but I
>> > > > > don't consider it as a real / valid option.
>> > > > > 
>> > > > 
>> > > > Neither do I. Merged implies maintained.
>> > > > 
>> > > > > 4: Merge the risc-v support into linux-evl. That would make risc-v
>> > > > > support exclusive to evl, where we could already test it. Would that be
>> > > > > an valid option for the evl side?
>> > > > > 
>> > > > 
>> > > > No, I believe that we can deal with one arch more such as risc-v in the
>> > > > Dovetail maintenance process. Besides, we really want the generic
>> > > > Dovetail code to be shared by all architectures, otherwise this would
>> > > > become a maintenance nightmare for the risc-v port.
>> > > > 
>> > > > > Any additional option available, that I missed?
>> > > > > 
>> > > > 
>> > > > I'd say, the simpler the better. Today, enabling risc-v for x4 would be
>> > > > straightforward while keeping the current maintenance model for Dovetail
>> > > > mostly unaffected.  Granted, forward porting to the latest kernel
>> > > > release may require a bit more work in order to maintain the risc-v part
>> > > > too, but my understanding is that Tobias is willing to help with this in
>> > > > the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
>> > > > fairly reasonable in size as well.
>> > > > 
>> > > > So, first step would be to merge the Dovetail risc-v support into
>> > > > linux-dovetail like other supported archs, enabling it for x4/evl in the
>> > > > same move. It could be enabled for x3 next, when time allows on your end
>> > > > if desired.
>> > > > 
>> > > 
>> > > To my understanding, Florian's concerns are not about the first-time
>> > > enabling or risc-v but its future testing when going to a new kernel
>> > > version. While arch-wise, most work is done in dovetail, testing would
>> > > only be possible once linux-evl is ported to a new kernel as well. And
>> > > that porting is widely arch-agnostic but for other reasons (drivers
>> > > e.g.) quite some generic effort.
>> > 
>> > This proved to be a limited effort over time. Porting issues in generic
>> > driver code for linux-evl can only affect the GPIO core, all the rest is
>> > on the Dovetail side (NIC drivers, SPI and DMA cores), so already ported
>> > actually.
>> > 
>> > Those issues did happen but rarely, and the complexity to address them
>> > always were an order of magnitude smaller than it has been for Dovetail
>> > over time. Most importantly, those merge conflicts were all due to
>> > changes in symbol names and routines moving around due to upstream
>> > refactoring/cleaning up the code, still keeping the original logic
>> > untouched though. I'd say such porting work still qualifies as simple.
>> 
>> With that: Let me try it. Which branch should be the "source" for v7.1-
>> evl-rebase? next/v7.0-evl-rebase or v7.0-evl-rebase? (with or without
>> next/)
>> 
>> I would do it the same way as for Dovetail: I would push to something
>> like wip/<release>-rebase and ask you to take over / release. Right?
>> 
>> Florian
>
> So, first evl rebase done. Result available at [1], please review and
> spawn tests.
>
> I had to fix a merge conflict in drivers/pio/gpiolib-cdev.c,
> lineevent_create, where we had the following code flow:
>
> 	if (oob_handling_requested(lflags)) {
> 		ret = evl_open_file(&le->oob_state.efile, file);
> 		if (ret)
> 			goto out_put_file;
> 	}
>
> 	eventreq.fd = fd;
> 	if (copy_to_user(ip, &eventreq, sizeof(eventreq))) {
> 		if (oob_handling_requested(lflags))
> 			evl_release_file(&le->oob_state.efile);
>  
> 		ret = -EFAULT;
> 		goto out_put_file;
> 	}
>
> 	return ret;
>
> out_put_file:
> 	fput(file)
>
>
> I completely removed the fput() call as I considered that a resource-
> count underflow. evl_open_file() will always return 0 -

In the current implementation, yes. This might change.

> still keeping
> the error handling - and if copy_to_user() failed, I think there is no
> reason to call it. Right?

Since 7.1 uses RAII-style management via FD_PREPARE() and friends, no
need for explicit fput() anymore indeed.

>
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/flo/v7.1-evl-rebase

-- 
Philippe.
