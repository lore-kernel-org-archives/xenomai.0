Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176C346AED
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433695; cv=none; b=CPhXJjpcLz7CHggzLf8zkDFUYWlsSxNeLZvpD/vtuPC6bRFuwUWdZjW1oGOpeDX0yxhR+l0ukLWiQEHD4flvOKg5KTxYuxc8a4wfSEoObvpYPQoXHiwYkRiP1Ok+WHhTDHxnRsflvBbu1rrZjTXkqYsXd0LAqGzbz8AxfYsthko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433695; c=relaxed/simple;
	bh=4hs5+s3HTC1NooEibUOe9idaCookPWyGQ5QuQ+6V+8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2GLz1qLTjWKjVw0y2Izavf9ulqOkEgdcgKKoGw8ESe9CyLaSjyUaU8IdaP3z1YKUISEHs76euPn/SI+tKWQVUjXY8ItJXb1h0Fp2N7jhBiZwPsXKJmgn1V9bXiArDSEc/Rheh0lqKEbjqOmPEAmsBIhnd6bdD0sX2wl8tzZN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QqwGnieq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QqwGnieq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35EF03EDA2;
	Tue,  7 Jul 2026 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783433692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RXR+OB6pBNK12MMibDiKVypav29K6lsnT5uUhJyrjQ=;
	b=QqwGnieqtAbkTqnpkLdVmNafmMEr6Ky4OTf1NFeTWnzRNkcvCOsAgWaRhAn1K4H7r5Zquy
	sF9DCCJfxsuBz9xEiNwCRnfLm4WbAdmLtGGM7iuBBloab5cgVTTE7oiizDtPT0EmYHmIZl
	UgRrWnMifq0JD/cGFJ0OogGcGeRA9o6ZdWKrp/b0nHPskCbixcLxFPrGXUfXmZBfqDx2MT
	38HPIxnBFyU6doEez1GIRfKzgZU3ttBZnEQo+NGFVmkwrjbo2vTaNfuX0JkUZiZTezz7NQ
	7RGIIVUXATg91Tus3+7gQIN2Nc373nqKz5elAFjp1sYlsZNVn2b7TryrwOJRYQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v4 0/8] Dovetail: arm: Finalize review results
In-Reply-To: <2fff81a403bcd74efac90a1f66ed6d7e8e235c86.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 07 Jul 2026 15:57:00 +0200")
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
	<875x2qx64u.fsf@xenomai.org>
	<2fff81a403bcd74efac90a1f66ed6d7e8e235c86.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 16:14:51 +0200
Message-ID: <87ik6qvqck.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFLvI83ZAMyFv3Ox38Qz7JyasFwcungDDh3qMHTStKndwnctcBFYUUdDyJK4FgL1xIoDeI+5W0xnHvp/n3WXvEXu0lghJl0gt/iUFb8+5diQOt2WaOffCKYiaduauRpffpRGZ+ldU5vDSev+nQebzjA1mLHt+mcmr1aziRkxPP9HiYNfXzyvQ+wMZAZfdlKBrzh8uvyIpjBXrtd86yi6qIRtiNg9E+PMSoKrj0gweZEJpfycpUZIhP61oXCBBL/uIdgTc0JE/iQtyUYkEf9l9h3j/0YSR7XmH12F7BuZ2LtSY24sspaLJk4iut307gyYyKIraZRa1Rps+otcrWMPTOmohyeQyML808cJSABTfxPdOmcnMQMrEjUgiXT7x2EbhSV0CkdrMLSnKa4dJAtK1DrYappfZU6burDYaXxhWh8sinKPod0DYRG05tqvbM0g1NNhQnaL7fVikaWEZ0TEriArPxofyaFSgRa+DAHITvROl2LoiEWSaeJIrEy9NeURzW/jUHy/4GNL9HFqETBUUzKGkxGobhtyCMrNFtPnYBgMmv4rsFxc+3EpiJeKSfGwST7RqtsTCCQZRKqzT/edhJWOtOGNHXI/27kxUAyAY72ath6UJnYRqtpK/+AszeDJVSRDd1fhovLsXQEUixg2A458V5L5TX3wRXiC/3dXcFddg

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-07-07 at 15:48 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi Philippe,
>> > 
>> > This is the first try to fully process the feedback on the
>> > interrupts_enabled() issue mentioned in the former patch series.
>> > 
>> > Input welcome.
>> > 
>> > I tried hard to keep everything easy, but changing the current
>> > implementation triggered a lot of unexpected include / build problems, 
>> > especially within the arch/arm/include/asm folder.
>> > 
>> 
>> LGTM now.
>> 
>
> Nice. Should I apply it to the 7.1-wip branch already?

Sure.

-- 
Philippe.
