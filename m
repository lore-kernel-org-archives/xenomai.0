Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154B125D6
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225100; cv=none; b=H17d7Rk17aWwyq2G0l0xqvsgxN3WaO5zUMzgcDa8GUCY6k0Y20tth9azsSJS6z/PLg61KsMDe0ARbbHYAlRpYeQ5dmwP0ZWvnvepQtm1ysONrLWB0ZBujXJNpSpr1zXUc/tIXEapxsOCzORabBWZNvs/cbZgTTOpbCBNnInsJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225100; c=relaxed/simple;
	bh=oblWUwTGypa74PbMsguUyUNGneaXLRKdfJDYi8rq7zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXtqqfWtGB8l1jYC3DAhcG8GXz7+cuGxsO9/w5RLObxy8Fs/0MZffcEUGHGJ0od+wUeaPp9FbRbuHcJcdE35aHs9/cWpNBBzE8YhUwPghCqTM1sy/+uz/zwJnfZBIOdghqMkOfIiFLEt5BtTRAKv9OK5BK2iyDCFTQpsR+mhJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=gsFx+gZx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="gsFx+gZx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4218008c613so34520465e9.2
        for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719225095; x=1719829895; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pexNJ4N2D7nQqoW8oGAaWP+kUngVTc7ejXA6W+sWyYo=;
        b=gsFx+gZxkMvxt857UPRJPsCObms2svyAQ5S6JxFua5G5A5NPL9r7fqfyl02wiZWnGt
         Vaubtu6A14ErVsnNC6Tf02clUXym4HvVu0hZGCz7KpFaotE1fIUx4/FdDHjUgIJmv/HF
         A0FMRaMp615HMZghDLsLSN2ZuT1b+6pScax8M0yXv3B8yPe6O9FR2JZRSO/Ly39jBoFc
         xVspKdIlXqMTQNOSpA7nBWCqzK3pVHeyFs5z4QhSm7VbALjyCFeHyrkGMQLYVbQjj4bz
         ZvqzPrHrCW1HDSG9k1oAQMkJXyuhEoR6gTEv7OWNAA7qyW1RXbBkX0eAUhjOjkNuAu4U
         G3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719225095; x=1719829895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pexNJ4N2D7nQqoW8oGAaWP+kUngVTc7ejXA6W+sWyYo=;
        b=GXVdj13bq5x5NGV3wc8w4rdasDueSXaVJu++d8nFSTYxomx4nFst3i4yLFfRSbvgOJ
         yVgBEPrq5UHln0cMwEYbREY+5v8/ZjDY+1n/LJ8mDAvVn7dAnLFDMu8WVVCLwdBG1k9f
         8/ORCPlVeCDbBEJixRtS2JmMEW5pHrtX5Kw3QerBNmqffEo7YO5OlohhZQnUUwZ0r/Y5
         zpP7VfhMPzsYjTIHEeyHt+OvSsiAbEASnAi+imZ2OmEC4Q9w7i/WoUfpedkUokwM5Hh5
         GWYu6uBqVZNKjq0x+QA4ouKXTy/oei7Ojy+yKGHmScoR07fxFamVkrf05vlow9/p/Tv5
         cD7A==
X-Forwarded-Encrypted: i=1; AJvYcCXYS3bYOSeZmyDSsHnQiCajv21nqp3dp3cBBiqpmVeYx140+VyXMdNDMk4MuA1vafJhsMEAngxnA3SXdUjfi7aNWKSHGEAJNg==
X-Gm-Message-State: AOJu0YxP0TvXAO1X0uFp+buvF28+wme/H4sJdj5daqPx2Y65AwE1/bO+
	OMawii35VgrZpnUxPdzhPvVkcu4ZHTsJooHsigfJoXMPSM3pu9C+0BghmBTD1ts=
X-Google-Smtp-Source: AGHT+IHAnF2XdLqcM0al7R5/hsBArhQ0+eWRxHBV3XXo/E60fXAJ1DzmHEWnb1tiv2+90AbUMbzT4A==
X-Received: by 2002:a05:600c:54e1:b0:424:9024:d45e with SMTP id 5b1f17b1804b1-4249024d4c3mr18164045e9.4.1719225094629;
        Mon, 24 Jun 2024 03:31:34 -0700 (PDT)
Received: from [10.115.255.165] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d2190desm167502875e9.48.2024.06.24.03.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:31:34 -0700 (PDT)
Message-ID: <64890924-793c-4e36-9db4-761c391b9906@sigma-star.at>
Date: Mon, 24 Jun 2024 12:31:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] testsuite: smokey - new testcase alchemy/task-11
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
 <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
 <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
Content-Language: en-US
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 18:45, Jan Kiszka wrote:
> 
> This causes sporadic failures in qemu, see e.g.
> 
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/852670
> 
> Could it be that we need to add some "VM slack" here, like we have in
> other tests already?
> 

In addition to actual hardware, I did test this on Qemu, including
on a busy build server.

I added some slack for Qemu, and what I though was a generous error
threshold, but I guess the fundamental problem itself won't go away
and always trigger on sufficiently slow/clogged machines.

As I understand it, your fix compltely disables the test on Qemu?

I did find a `smokey_on_vm` flag that is used in the mutex test. As an
alternative, the PERIOD_INITIAL and PERIOD_SWITCH macros could be
modified to give it even more slack, depending on that flag.

But then again, the fundamental issue remains. I guess it make sense
to disable it for the Qemu pipline as you already did.

Thanks,

David
