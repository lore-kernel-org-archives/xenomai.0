Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003D371893
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164618; cv=none; b=ppM/4+2qMlokO3qFPcC0X+hpGZcKV3V6p2pD8Jy6Z/oT3JasWvJuHfwcmFbJ2sXg6g9nCQdnJWWrv0qYHNkxfZTXjgm1c76/3gL+wNIBrKK7nq6y050t7A8ssrwpmPO/C3dHefbzVrBIJzDVOFNhYkG9lIt1FAD6a6MZ13rNBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164618; c=relaxed/simple;
	bh=a7yfsscfrL2jvigt9NGJx/dmjIYlR37QQKCU0jViYKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5msgcqdkmxt1msisengcSuqfTbv1IZVj18aqRUXywairYQ4YY8DllJ6hueRew8293WejoAJMXBeVZZQL0JSjUMLPFFZExakBkFUYkeiGj+X7qZt64NdxtrJvuhs78LIhOgjgNu9IIfftUsHiUmVlADaIiFIORpcHu13dtV2LNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=XTvqXTT0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="XTvqXTT0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DB261F68F;
	Thu, 11 Jun 2026 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781164615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZrq7xZLkppyfPgVubxouFNhB/05m8j5JXXV8MmKJHw=;
	b=XTvqXTT0+iP7OALwHwyvKtmxuNeb7+v2VhTVBm2johzXxNe3Rfa52GJ9kl4pOTxPuoWnXV
	qnbODcXCocck5+BEtB8qtfHnFxqQbXtNZjQOujHricgQHnqSKLggab8aawW8Sa3KcQbl2t
	yw+LUdJ4Qw+8b2+ugHcQ6gQiDOx5CXUQHIR4PLFiQvfb+nUEGyZdfL8cJAkLGl75jGDOcG
	ZtP+Luyfav5go3ugFrW3aDqvdM4zwbd2INW+2jBu4Vr2xNkUBp0cfKzSIWpbbsyBZRRso7
	W8A2pfvpp4RJaLvUekMm9oKmthqy04iHnX7Tn2TBxcJ39de0cjZXee1ukDTiBA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: SCHED_SPORADIC in Xenomai 3
In-Reply-To: <2460b105-370d-4cf5-8cb6-e40809763cd3@siemens.com> (Jan Kiszka's
	message of "Thu, 11 Jun 2026 09:42:51 +0200")
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
	<87cxxxcz0n.fsf@xenomai.org>
	<2460b105-370d-4cf5-8cb6-e40809763cd3@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Jun 2026 09:56:52 +0200
Message-ID: <87se6tbjcr.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFOvq8vnNCQ6pyCl4lDT1aIWGXJJg8bOFuvA3CQxxgZcgtfm2NFQNWNrNHFc0/BPVQKr+lv7wV2RFQlUc9DsxF3dnBkZ5ByOdBeztfcBvwBlJqicrwGYcb+kq87/JIjZRaM2zllNQfSCxR7AmQ5nqQO/xx/kVyQJu1KVN6bs/QeLHgJL4i7Wd6DhHHufyq//5vMmTp0KS+O2UKG5rWNMs2mSYU2g/2ribY1mzQ+6MPEZZbKeg6Ey4Eym68pDrqjtLKl1RT+JpXSkR2N6maTTpehLc1Sypx3bg12z4dZ6B2imQaPsyzFIoXdH/3swlWWItAWfHajPaHv1255U5Zt4Z8yg6fjby35QtfRVQLmkoVIMH+pciU3QX2ErxI5oTYh640aR4Ld+17Ahn+oOCCSO2d3AEpXJTvu4oW04+BLQ6a77vR/K0DXavrksHJaz+jeDvO9yFMIx99XrgVSBZ/c/1ZHa2VR/AMJpRlB6guxIWfH9Ji7jKcy0SWm6gRI6ttbQgXwfkQ3UTh9LOR87i04MeZs19cd0t2lyWGQ45xlJ7H1WFJGcfL87fNhGYqF9ZYNWQiKwc3sFpZ3CKSEKmeJKXQ+kjNwRqLb5XP4f2C0AchSDeLf3Vn4phek/hP6M0MCC/ukEZWcSGPug9Adv3CAYPv97HJ4noLO03oeYEU/K33lrw

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.06.26 09:33, Philippe Gerum wrote:
>> 
>> Hi Jan,
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>>> into XNHELD, a state only existing there. I suppose that was once
>>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>>
>>> Turned out it was never documented, not even linked to the POSIX
>>> standard. But it also slightly differs from it (low_prio = -1 -> suspend
>>> on depletion). There is also no test case, so I asked an AI for one.
>>> That worked fairly well as it seems to have revealed an issue:
>>>
>>> Could it be that we are not properly suspending the budget tracking when
>>> a higher-prio task from a different scheduling class is preempting a
>>> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
>>> if a thread is selected from a higher-prio class first, namely sched-rt
>>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>>> limitation/misconfiguration? Is that issue even affecting other
>>> time-slicing classes as well??
>> 
>> Yes, this is a systemic bug. We need to tell classes that some thread of
>> theirs is scheduling out.
>> 
>
> OK, then please have a look of my proposal from today. If it makes
> sense, I'm happy to submit it for x3 as well as linux-evl patch.
>
>>>
>>> That furthermore makes me wonder if we actually have users of
>>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>>> limitation should have been observed earlier under real workload...
>>>
>> 
>> I only know of one user, back in 2009. Never received any feedback since
>> then.
>> 
>
> Hmm, I'm inclined to retire it then.

The sched sporadic implementation is certainly not quite right ATM in
x3, although it could be fixed. This said, the POSIX standard was even
originally broken IIRC and required some amendments. I did not port that
sched class to x4.

-- 
Philippe.
