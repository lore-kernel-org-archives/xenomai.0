Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60235202D
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049292; cv=none; b=oIkMsYUys/EDuGOULaZye06HZeedTfZbFbwwTGV47CrHEHl0qiKE2YAAN1KYVIYh9hyGWQZPN3XXuozj6+O13192vCjGtbIQb6+DF7HcA1wpSe76I9eO6vpSbEV4/UTWCmd5uKGPoc8O+n3uO+hSWTDXQik/L54KbugIWq/3/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049292; c=relaxed/simple;
	bh=QW3LHSfJoodXqHS0x9qtUTKEHLg87gOjUxztH1nvP54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVr1y/ZOQJZVX/RNcWW7lMccQ9hhQ6ljFQU6pQA4AIDjCesU0FgyAcIGDk6Ry/HJoxfWf/M/ZA+vOEzJ+HBzjIZrwA4gyM/jK+pyzjq2Tf/UvMbyB3J79l+qygDDN3NRVKy4l71Pp12vwv64YWx81WI+qpLsL+loq/4MRTtQuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GIsIp5xX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GIsIp5xX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B2CD1FCEF;
	Fri, 29 May 2026 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780049282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eX5gpt3GMxj+AymMCoZ9ZisIUz6AFFuTrshwbczht6I=;
	b=GIsIp5xXolPp8ws8bEQA/ojOgX4deAWaRORT9P4oBQOczaIblqsXwqgpGWhpgqJlXnstai
	h+R6aw116ClBQco6LYC9TBsVh4YwGneF1zT3z4Zs0AiLXR9vWlXyTHVBAeMFGvWDdDqD4q
	mX0UMtE52PJ5MM9mkiUqrcxQPBQ0xfJOsatFyPSeSSjmHj9kWFk7DIDIG7wXvyfMkqtNaO
	jCDyo8Icd8kfQ7PbVKDBk3fVtmrgL6jpVrurT1nl7Yxa+/xOt/AMVLd1287gxb6KzN0mab
	L/XywZFprRYx6S3RUxo+UH63DExD+BV/olBCBWiXu/th0oDsnvRXCTI4vuWw4A==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  Jan Kiszka
 <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
In-Reply-To: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 29 May 2026 11:21:12 +0200")
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 29 May 2026 12:08:01 +0200
Message-ID: <87bjdyil4u.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF+YfM9zpiM5eOrFBVuzIsKTg7CW9m0rLoQ1XuiPf/nlO3jCvTYvl2trX1HV42ppI9CQb5Nx8sNAzDvB0cZ3jj5SzAg480+xliBLDAfowDaSsCA+3dkzlXc5vLD7t4GjbS9zIDk4HrPdPFa5RjzJRzBDxHVHJ75sYs1ciYp3kh+J7bMuFoYfL0taKj7a4UbiBqwqwHpnqKNldhty7qohjKa6vOZhY2Ic8WjMpquoYAVLCEzPORKwVp4cSf67QOLEVvp/NvqwsMDn0E44/0PiRl78CaBWhHXAdorryxDAtzC8C38rnYVUTNkcawPa9kHvArPrTGhXH9/9B6Bebl3yMFfffPjPI+TPWh8J6MLfY2lp6boRzyK/bk+PXQ9kuO8S81ZMXqk8gOX4wGEWmLR8qABFj2Na48NKLcd8qE6YzwO0GxaWG84dobYFuVQw8VdGs/yf1pWvdm0n2heD8+M+7DUHQchX3/Vl4byk53Y2zO0AHd21AWFbOigeeGTQU6EcXIwHcxn0CXulAo17NPV7bLNKP+WU83H5JMLZL82HIf3QBL7AWOBIj5TdMgYOog91RDqv9LpzNk6ZTCPag+nItn5MeSo4kA+a+550H9uvp7yIcShQxI5ROt+AsJmEUvWiMobbgGDXxq4tsmJ0QU8cghhj0qcoXPWoq8UQTmHbGliAA


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I'm currently waiting for a v8 of Tobias' risc-v implementation. A
> couple of minor things still need fixing, but overall I would say that
> we are looking good - ready for merging - assuming that currently
> running tests are successful.
>

Really nice stuff, thanks to anyone involved.

> From my point of view there is one issue left, that needs a discussion:
> Testing and forward porting in the future.
>
> Up to now I was able to test all architectures using cobalt / x3. That
> will change now, as we don't have risc-v support in x3.
>
> I see the following options:
>
> 1: Additionally forward port linux-evl in the future, so that we can run
> tests against risc-v using x4. Additional effort for me, especially
> because we don't have an in-house user for that. Can you estimate how
> much time it takes you to forward port linux-evl in comparison to linux-
> dovetail?
>

Porting evl to a new arch kernel-wise is fundamentally trivial, the real
work is done by Dovetail. For every currently supported arch, the amount
of arch-specific evl code is 60 lines of C, merely wrappers in headers
(arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
libevl needs to support risc-v.

> 2: Add risc-v support to x3 as well. To my understanding there were no
> plans yet, but it might be worth it to limit forward porting efforts. I
> could focus on x3 for testing. This might also help to compare risc-v
> against the other architectures.
>

Although this may require a little more effort compared to x4, such port
would still be tractable since Dovetail does most of the work here as
well. Adding risc-v support to x3 is Jan's call.

> 3: Ignore risc-v during forward porting. Yes, this option exists, but I
> don't consider it as a real / valid option.
>

Neither do I. Merged implies maintained.

> 4: Merge the risc-v support into linux-evl. That would make risc-v
> support exclusive to evl, where we could already test it. Would that be
> an valid option for the evl side?
>

No, I believe that we can deal with one arch more such as risc-v in the
Dovetail maintenance process. Besides, we really want the generic
Dovetail code to be shared by all architectures, otherwise this would
become a maintenance nightmare for the risc-v port.

> Any additional option available, that I missed?
>

I'd say, the simpler the better. Today, enabling risc-v for x4 would be
straightforward while keeping the current maintenance model for Dovetail
mostly unaffected.  Granted, forward porting to the latest kernel
release may require a bit more work in order to maintain the risc-v part
too, but my understanding is that Tobias is willing to help with this in
the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
fairly reasonable in size as well.

So, first step would be to merge the Dovetail risc-v support into
linux-dovetail like other supported archs, enabling it for x4/evl in the
same move. It could be enabled for x3 next, when time allows on your end
if desired.

-- 
Philippe.
