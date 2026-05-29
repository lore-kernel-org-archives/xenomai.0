Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892213C1985
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068861; cv=none; b=UExHvk3MacHrQKlSkt2FkD34zZlA2ydzBbch9p+4BoaOKmt8u9BOBrMtPA3NYVfIy/QSGECr/ZFMqcX574tSaLnHX67IMxX8wUkKqE0/v5jTSA6fL3ovg4o2GCHPgvk+sCXp3eeynTV52CXUDmtXO42//MVpP3fmJjAqDlh0Kx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068861; c=relaxed/simple;
	bh=yCoRm8OQJGnm7vlDFpgJF/LeeS5MkD7u3M6i3sGOSdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rp1fZV68H95QnpfxJ+WuTUS8V2DWm/4VpwDxmHP663CCQsfZWp5AB4ZgrJm+4fhdY+XTUPo0d6kkPV+fUNz4N6QY8U8vWoFU6u0Clnwh6Kfna34HSxgRC4y21pa9oUMy18QKLW+R7M+5LKqGn8hr+pEq3kj7FYDt6X63LwHEt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QQ/DpVTq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QQ/DpVTq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 822973EC47;
	Fri, 29 May 2026 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780068856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uyvK5w18aa/TAiAMySKXQAeHmqqoSmNw9+R5vWRjdeY=;
	b=QQ/DpVTqpg8dQIkt+aZZBUqbSnjByRlRIyRvLpGBEpNM4VMamDeRfpS/3Qp6R0iCPLlFMN
	SDG2hyf/Xu7S6C5I4sW4xIo3QBQ9i7xMzIQO80BDfbqouho7F49XcXW14gOwQP//1j5UQK
	PqUymAyXNdbNuouJZfdjLyqLfyAcbfAVh6o/aMoT2ilnQMW6UIOOm/P/sLAK8Cys/4Sqdj
	RvPBiFBwY6gsKtremV+NX0mV8A7HDKGc16QfPLwZe5SwRCwvi9itknwmsncPQs5wYg2sCT
	zPveny7yQBTSkI5B87INJsPQcxV0TWEMO2RGDn8sP4wdTKzTRCoWOFvXmG/ZUQ==
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
Date: Fri, 29 May 2026 17:34:15 +0200
Message-ID: <87fr3agrgo.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE3tOg7BSR7+YZg+XU79Dn8WT391hLYFC1hl9hO3bq+4ZZLOjbIJ9jPG3jHV8QhYwnZ5Fau8Xt2b1agtweGelBXr3J2ysif7vohw58+v/il7uHDHOokGZR1Wd7SN09wLZJlkbp6cuN/8jMuodo5Z26UqZFKUOSeIbzuJWqhJJFxKt7Q8Qv/Fq54339ZYnDh8oxG30D6LM2mXu0H2l0h1pcvpkByJ3+s9L3SGilsts3rWQR44frIs6OuEdP39XAJWowGOM5yr/gepTUQBJWVKYW+0f1xUhGLgrCpcPtXZWxUJ4Q549jU4FNpOqKFYKjRqPM0+KeaZh/Ew31i6ZaQ4z6Ut5n3+Vai4LdbIORbUZpt0aZ97WXkpKEgSpRC3DjeHu+lJ51lb6FG732CFrIVkZERs6fWOY3D84r7mOoAUFXCYrauOsNC8EdPwXNzRwFjEgrl51UDQ+mtEwFIvgg8sNuW74bkAv7nCJslKPyaSSvZZ8goX2CRdcScQQXLi3PStUBw6MHusoJOcwz4BcDPa2IWhc8gcG/3ZL7cHfSeGNKCXUz2G1kJnEIGM2haBAKH8P3XvZh7YPfWJACuvYQ7dNDWc42E+1H9Trr2YfF7KaqHA9NEQa1oCVJciJbbnQGKVbOV9pJuiQW5Nq1tXjPkt+uL2M36odj8+ikbDeUOfNPl1Q

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
> count underflow. evl_open_file() will always return 0 - still keeping
> the error handling - and if copy_to_user() failed, I think there is no
> reason to call it. Right?
>
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/flo/v7.1-evl-rebase

Btw, this is exactly the kind of fixups the GPIO core required over time
while forward porting evl. Generic code cleanups or in this case, use of
a fairly recently introduced kernel features like auto-drop of file
refs. This may require careful review as upstream may be keen on moving
code around in this area of the kernel, but all in all, nothing really
tricky.

The only thing that might bite some day is the removal of the legacy
gpio_cdev V1 interface we are still using, but moving to V2 would not be
a massive work anyway.

-- 
Philippe.
