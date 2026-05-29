Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122E3D1714
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053587; cv=none; b=mwAHF5JhwiQG6KUi3dynYgjK0oe8xTbqLaDpveW3wxzSKvpTeaOtQsSFX+9//Fvq0dOKb8zwSqQreqsPnQlVW1kwZVer8HoC9zLXBmZ4BebqzbSvaakdns5P/Ct5Zt0zVXlxTKjWrtWhND+mPtNp7/5qNj896Gm54RDAvop6kpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053587; c=relaxed/simple;
	bh=mwY68ZWmFlv2OioodLPDRwEkV03eD4Anp9wFSwRnzVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5lr/NdVGpoNRl5dTe4cqEEzRyZ6GYu3rFYmoxDIQ3yf/SvaJMVM5QlUVKAqKspxJ9AAth/24MHTdCEhtomY2LVT36bW/+MGTcEb1Klsy55MFuX0yhfqofxCT8RYufJ1wF1yw6L5XeQMZ/eQawVHj8mE9VKYl3Pkwknm0DKPUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=AExztZPc; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="AExztZPc"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9C0CA583557
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 10:43:44 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E89F3EC24;
	Fri, 29 May 2026 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780051417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufsPFlF0k0Mh3hiShJpgJyHdBFiSYbu6FzyrkkDHf8Y=;
	b=AExztZPcSt7L8vDD6Xqkfda3fhkK8YlduPRqAN533RdFYNa1AmW932VRBgB0JfPoPQPx30
	U73uuOFxePcBZJAVWpUZtJQiq48PwlVXDU/cKBcJdF821XJezP2QPq7eSLKW9fOxQhOM+u
	spgcR6xU3djeNg2eMwZLUgseYiOdlbtJJFppgrPosvNkWeCwQf+6rKKv67khTjSZyYcCSb
	tdeQuoqpgTAWxLnzCBDUXqaAyMXDwAILaYbrTY0xwGrMQVtAriS9BUm6ZFhlmiPD177rmF
	+d0R9Z+b4apBWvP+q0SvRNgOtqeOU2r+JBvTWMwARBGzk1PHbrCUg+lbOkHbKA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
In-Reply-To: <030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com> (Jan Kiszka's
	message of "Fri, 29 May 2026 12:21:30 +0200")
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
	<87bjdyil4u.fsf@xenomai.org>
	<030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 29 May 2026 12:43:35 +0200
Message-ID: <87wlwmh4x4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEAIOjWg+eaj3GByKXW3EhUU+k3JcFTjyZKXyFwKGU8OmoBxVU1MFRXUpHKVFXOi9YRKYQHYMCus8LjRa99QRSSGKg87oKY0y/WFyh84DTuav2vWb3QSUAmrtGQ6/0qPOlij4KKt8VdD++2820/goxRggYptGqQUytGrtmpbDN9qjiNIJHkmKDiR908oUnQlj/dMKbPyDbGJZYCSfdnzMufO2LuR7AjJB5bZeGVNGsGQB96tfHpNlhVY258jQ63EUJ/n1uz7fZGUDNEY7V4BYgBBmEYgJmbaM2kIu+rvsfkFDnUzxfo0hQYC82+5wlNUtB7fxdENK9GoD8b0W8kXZImJug10/F6bPk5vjvl2eg2H+TPMFmN4OWdPttGrCHDT/aHW3gyEXFPJbs34oj8ajXnkLpVO2inT8XiIkJD1h+CHT8fACd8J4QsljHnEawMEZFAnAV26WkQtvVdby7b1+sR+AbJGUB6Ou3I0jXnObSZNprGKUSI7TA2tNKhz7hoQhVnhQxwRFHFbQdSoHKlAZO6S7uZ3ALHQ0U/qKCYec68lnI9xLxn5BnIGx5eXTko1LjAj5TzCtXTxb86UYcGuARQnUZVtzim5chAgQB+beA4WpjXb7H2clBfFj4AM63CyxfCvkt8xGoiUOarrdi+H5tfv8Y4sOpsApkxgGDn6/RH3Q
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 29.05.26 12:08, Philippe Gerum wrote:
>> 
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> I'm currently waiting for a v8 of Tobias' risc-v implementation. A
>>> couple of minor things still need fixing, but overall I would say that
>>> we are looking good - ready for merging - assuming that currently
>>> running tests are successful.
>>>
>> 
>> Really nice stuff, thanks to anyone involved.
>> 
>>> From my point of view there is one issue left, that needs a discussion:
>>> Testing and forward porting in the future.
>>>
>>> Up to now I was able to test all architectures using cobalt / x3. That
>>> will change now, as we don't have risc-v support in x3.
>>>
>>> I see the following options:
>>>
>>> 1: Additionally forward port linux-evl in the future, so that we can run
>>> tests against risc-v using x4. Additional effort for me, especially
>>> because we don't have an in-house user for that. Can you estimate how
>>> much time it takes you to forward port linux-evl in comparison to linux-
>>> dovetail?
>>>
>> 
>> Porting evl to a new arch kernel-wise is fundamentally trivial, the real
>> work is done by Dovetail. For every currently supported arch, the amount
>> of arch-specific evl code is 60 lines of C, merely wrappers in headers
>> (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
>> libevl needs to support risc-v.
>> 
>>> 2: Add risc-v support to x3 as well. To my understanding there were no
>>> plans yet, but it might be worth it to limit forward porting efforts. I
>>> could focus on x3 for testing. This might also help to compare risc-v
>>> against the other architectures.
>>>
>> 
>> Although this may require a little more effort compared to x4, such port
>> would still be tractable since Dovetail does most of the work here as
>> well. Adding risc-v support to x3 is Jan's call.
>> 
>>> 3: Ignore risc-v during forward porting. Yes, this option exists, but I
>>> don't consider it as a real / valid option.
>>>
>> 
>> Neither do I. Merged implies maintained.
>> 
>>> 4: Merge the risc-v support into linux-evl. That would make risc-v
>>> support exclusive to evl, where we could already test it. Would that be
>>> an valid option for the evl side?
>>>
>> 
>> No, I believe that we can deal with one arch more such as risc-v in the
>> Dovetail maintenance process. Besides, we really want the generic
>> Dovetail code to be shared by all architectures, otherwise this would
>> become a maintenance nightmare for the risc-v port.
>> 
>>> Any additional option available, that I missed?
>>>
>> 
>> I'd say, the simpler the better. Today, enabling risc-v for x4 would be
>> straightforward while keeping the current maintenance model for Dovetail
>> mostly unaffected.  Granted, forward porting to the latest kernel
>> release may require a bit more work in order to maintain the risc-v part
>> too, but my understanding is that Tobias is willing to help with this in
>> the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
>> fairly reasonable in size as well.
>> 
>> So, first step would be to merge the Dovetail risc-v support into
>> linux-dovetail like other supported archs, enabling it for x4/evl in the
>> same move. It could be enabled for x3 next, when time allows on your end
>> if desired.
>> 
>
> To my understanding, Florian's concerns are not about the first-time
> enabling or risc-v but its future testing when going to a new kernel
> version. While arch-wise, most work is done in dovetail, testing would
> only be possible once linux-evl is ported to a new kernel as well. And
> that porting is widely arch-agnostic but for other reasons (drivers
> e.g.) quite some generic effort.

This proved to be a limited effort over time. Porting issues in generic
driver code for linux-evl can only affect the GPIO core, all the rest is
on the Dovetail side (NIC drivers, SPI and DMA cores), so already ported
actually.

Those issues did happen but rarely, and the complexity to address them
always were an order of magnitude smaller than it has been for Dovetail
over time. Most importantly, those merge conflicts were all due to
changes in symbol names and routines moving around due to upstream
refactoring/cleaning up the code, still keeping the original logic
untouched though. I'd say such porting work still qualifies as simple.

-- 
Philippe.
