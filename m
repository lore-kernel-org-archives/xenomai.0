Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E362E737C
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067813; cv=none; b=rentyFfeXTfNSlWd82UtnaAACSWQ4o7jv67R/TfjW34RnW7/fiskrLckI+xxpfBDVYoT1gftARdREAR60K8UN51iczXLtDevuyrt0zWQbW3s9H5s7q/tjmbsUZrClm5ejh3N2AnewwCVOPdB6i0Or6J8ZHac8jGBRhxUuv/Oo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067813; c=relaxed/simple;
	bh=s7NovrluHMF1FWm8R0Vt23luQG1S3C6FAsgspbVYZZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RqwLlhY1XXePeFhh43wUCHi+703u0gbLC7PvpKgQVeF5aUDJ/gBDlbbPjv5xplGesKCOnJdcKsDfoP2JZ/wt63sS6K64IuSD/qDOq5AgAgQ5hM8qLO9ym/AtbWBSw9T5rS2QjBLs7Ea2WTmntcJwdZ34ucQOciL1CG3tlvG/8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pVP6G9ha; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pVP6G9ha"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C72F42064C;
	Fri, 29 May 2026 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780067809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yek1qjeLEIXAwsk9+/w+VDncAyF/4Tht52RCi2nk2o=;
	b=pVP6G9hakazW8l61UsxLuKyjd7FsdEqdv0i2QyW0fxAL2+vBty2dGhwjhdDNKgwedAUTlX
	paz33U3RfH6J3qEe0omLvF66XEbtin4fOzBKiTnwZUxiCSRCh+9LHh2BElj+YQnKXM3RrN
	9DFVptmh0719fMUiUBH9ZkQqc/Dom5XJBtqflKeLbhGMwjBb8c4UI5rG7rD+TecjJSU6ki
	Xul6PWByRIgG0/T0mRFcub0eYKL/5zSrLDgyR3vZNH6ESmy0xQ7CCr00zzSTzBDCjGKLdw
	Zeka/NLBslXhZNq6mBpatDONOttodfg93i7W+MFIpOtkYT8pjpP8/6+KKXjOdA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
In-Reply-To: <b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 29 May 2026 12:49:55 +0200")
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
	<87bjdyil4u.fsf@xenomai.org>
	<030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
	<87wlwmh4x4.fsf@xenomai.org>
	<b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 29 May 2026 17:16:48 +0200
Message-ID: <87qzmugs9r.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEhG+vnld1B+d5eZgnttVRl2hovLAqJwBlwIxzX+fBt1mtR12Xmsp/WIoLOENGr2zwvIsJqSAc9N/i43yxjXkm2x+/VS71MjkZZaUYTPme5+k4daBi85BtM+HewMJqOXncENTjAkAiAeUhfx0UtZhtI8DLYgHLBaj3cnTlfEwr7QBdxYmJGyUuHSD3NLFaOOqffMVndt4tV3DSwziE74k5hWzcvWhqGlQdwpdRuv1DbhbrGROjKwTodETyLg3iMBzed2k4ob0D8TOT16Z4Mq5Wr7y5ldoP4prH/RybobleSBZz2i9ahlCh3hFjUaWjtmX9jqFQukGg5RTYS8C6Fi6SaNbxTzfC1QBO85xn8XlTX58vF0jUIqxDJD2SrgFehsvrUxEcX0/ztTa/WdhHYM9TM4LW/E0nFkNEzej2OlnecsHiwIR02cM4sxCKB/vGd9NNZZ0T5IHvR8lsiv88JIJe1zWWLwfWVftgW3+hhsQbZSYaTPErPz1iTcThpFULLX0uSMLGVWh5WPl2/M3iIlNGQDc8bl67ULDXGphSVI/EiqhXDpMXSONi6Tn6J0FGRTslqphU9lvMXMRh5gi+1sSzd7/UiidFMRrm68AiZXWqXkChElUaW+WPUuInRbih6uTjARiAX85SKM1NKE0ixR3U6SvhS9FGSY26wP7MYuaiPHQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-05-29 at 12:43 +0200, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>> > On 29.05.26 12:08, Philippe Gerum wrote:
>> > > 
>> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > 
>> > > > Hi Philippe,
>> > > > 
>> > > > I'm currently waiting for a v8 of Tobias' risc-v implementation. A
>> > > > couple of minor things still need fixing, but overall I would say that
>> > > > we are looking good - ready for merging - assuming that currently
>> > > > running tests are successful.
>> > > > 
>> > > 
>> > > Really nice stuff, thanks to anyone involved.
>> > > 
>> > > > From my point of view there is one issue left, that needs a discussion:
>> > > > Testing and forward porting in the future.
>> > > > 
>> > > > Up to now I was able to test all architectures using cobalt / x3. That
>> > > > will change now, as we don't have risc-v support in x3.
>> > > > 
>> > > > I see the following options:
>> > > > 
>> > > > 1: Additionally forward port linux-evl in the future, so that we can run
>> > > > tests against risc-v using x4. Additional effort for me, especially
>> > > > because we don't have an in-house user for that. Can you estimate how
>> > > > much time it takes you to forward port linux-evl in comparison to linux-
>> > > > dovetail?
>> > > > 
>> > > 
>> > > Porting evl to a new arch kernel-wise is fundamentally trivial, the real
>> > > work is done by Dovetail. For every currently supported arch, the amount
>> > > of arch-specific evl code is 60 lines of C, merely wrappers in headers
>> > > (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
>> > > libevl needs to support risc-v.
>> > > 
>> > > > 2: Add risc-v support to x3 as well. To my understanding there were no
>> > > > plans yet, but it might be worth it to limit forward porting efforts. I
>> > > > could focus on x3 for testing. This might also help to compare risc-v
>> > > > against the other architectures.
>> > > > 
>> > > 
>> > > Although this may require a little more effort compared to x4, such port
>> > > would still be tractable since Dovetail does most of the work here as
>> > > well. Adding risc-v support to x3 is Jan's call.
>> > > 
>> > > > 3: Ignore risc-v during forward porting. Yes, this option exists, but I
>> > > > don't consider it as a real / valid option.
>> > > > 
>> > > 
>> > > Neither do I. Merged implies maintained.
>> > > 
>> > > > 4: Merge the risc-v support into linux-evl. That would make risc-v
>> > > > support exclusive to evl, where we could already test it. Would that be
>> > > > an valid option for the evl side?
>> > > > 
>> > > 
>> > > No, I believe that we can deal with one arch more such as risc-v in the
>> > > Dovetail maintenance process. Besides, we really want the generic
>> > > Dovetail code to be shared by all architectures, otherwise this would
>> > > become a maintenance nightmare for the risc-v port.
>> > > 
>> > > > Any additional option available, that I missed?
>> > > > 
>> > > 
>> > > I'd say, the simpler the better. Today, enabling risc-v for x4 would be
>> > > straightforward while keeping the current maintenance model for Dovetail
>> > > mostly unaffected.  Granted, forward porting to the latest kernel
>> > > release may require a bit more work in order to maintain the risc-v part
>> > > too, but my understanding is that Tobias is willing to help with this in
>> > > the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
>> > > fairly reasonable in size as well.
>> > > 
>> > > So, first step would be to merge the Dovetail risc-v support into
>> > > linux-dovetail like other supported archs, enabling it for x4/evl in the
>> > > same move. It could be enabled for x3 next, when time allows on your end
>> > > if desired.
>> > > 
>> > 
>> > To my understanding, Florian's concerns are not about the first-time
>> > enabling or risc-v but its future testing when going to a new kernel
>> > version. While arch-wise, most work is done in dovetail, testing would
>> > only be possible once linux-evl is ported to a new kernel as well. And
>> > that porting is widely arch-agnostic but for other reasons (drivers
>> > e.g.) quite some generic effort.
>> 
>> This proved to be a limited effort over time. Porting issues in generic
>> driver code for linux-evl can only affect the GPIO core, all the rest is
>> on the Dovetail side (NIC drivers, SPI and DMA cores), so already ported
>> actually.
>> 
>> Those issues did happen but rarely, and the complexity to address them
>> always were an order of magnitude smaller than it has been for Dovetail
>> over time. Most importantly, those merge conflicts were all due to
>> changes in symbol names and routines moving around due to upstream
>> refactoring/cleaning up the code, still keeping the original logic
>> untouched though. I'd say such porting work still qualifies as simple.
>
> With that: Let me try it. Which branch should be the "source" for v7.1-
> evl-rebase? next/v7.0-evl-rebase or v7.0-evl-rebase? (with or without
> next/)
>

next/

> I would do it the same way as for Dovetail: I would push to something
> like wip/<release>-rebase and ask you to take over / release. Right?
>

yep.

-- 
Philippe.
