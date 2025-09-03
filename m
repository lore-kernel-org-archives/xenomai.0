Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51A2E2DD0
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916934; cv=none; b=tgu/epO5qhwU/pLXah/Wd/kwL5AjhYZyc0niAa9D6yxhkp36iAgeXuOxE1ljf2vQZBprgz8OaYHKytYzIP1/zL6gy8BpVXPz7WWfyQuEcOAfMOiJ3sRlVUEZMnn4KRQ19/AYepDlSHljIOsQDHlaJHN0mQdIjihYkfSrlC2GylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916934; c=relaxed/simple;
	bh=CGinZQd/RWIAKC+bYQhHlhvob6k6zWgfqic8VkXS/MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJO4LkPp8eqQWcoam2VybXziTxbzkB6xV6BPmofn0bsu8zZ6J388iSoW7hI6352qxMRSuANQCkNJc8f9k/UMyMf0b9/uhpclpJ47ZQgKVEd4Yqi4wM6Uvu+rAQV2s1PcqTrb+1VIl26ClyhKye1yxpx2iuycdeRfdaG3oIfGdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd7xIYAD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd7xIYAD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso875685e9.2
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756916931; x=1757521731; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzg4enxjP3j+B5biZRx7EzECzvRcLyxI1SxPl2Eoh+E=;
        b=Pd7xIYAD20/usvPC2RKlvnE/7F8RCPsxEizKndLb2SJfGM1EotUFLTn2dnTKe3BV3/
         uTBFbNSQWFq6VSHY8x5jmA+cXkvqd7br5XHPm19OdXeOsyPN5nU6pNFjDaeEcFzZNB36
         lo+24hN5M/5TYUuFTij7Sd1QQwGZwzFSJU/mvGJ4QHh6JqRUzLxnr2BdhH07Bw4pJ+T4
         yQOR/7cM5IKeC0fTrcfFq2a4tXo6lqyia8uBKRn2ph4n1gfQagAmOevH2amjBtBJzbVm
         uFwejQ306txkm5MblMOdtPKf0yLa1hM4HHXqUMUEgvk/D73XVc0WhK+asoBuGWmxJb2t
         jIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916931; x=1757521731;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzg4enxjP3j+B5biZRx7EzECzvRcLyxI1SxPl2Eoh+E=;
        b=MiK1/tVGcIYbG5U8eE1FwRcjBGQIhqaN9hDeSQ9SXUBxFKOQSjoJGgIAeN7Yp+AiMP
         YHQ8zJnWVb7Q+PDM62lmUzP3gc43l5N0S+hlctolcxqx9gSIA2ZNZlVftC/OYMBiEb5+
         Jwp5jR7WLqdJ7Z+RkSbeY4dbJOTFwmdLzD/p1Pz4ecO4P6DTI3pymwz7HN4IQplxt0qc
         3N4q7zi12pCeD0badSUfphsBzmNIctLSTeu+Cu8hmjsgR3nBXdKmfnCtUHVgM4L3xKr+
         5FjUCXSI5XsjT3ZHMH3SXbKwwsbviSB6Can5tTOLNn9Bp+Lfyo7RDTFm/a1TynthUBG7
         VsiA==
X-Forwarded-Encrypted: i=1; AJvYcCVx/LXbJnmdP6DrenmJuW8K/XSVGU1+P3Vl4dGHEQSqJizVqWOQxxHRAEX8+AoXqSuJknuJxYQl@lists.linux.dev
X-Gm-Message-State: AOJu0YywJvQ2lczFaI7L3ezzG4tJRluZZfKuWJyJuw3yhtgIPOl4vOt1
	A2h9C7Q9n+6m0bmXz7aJ97PXevQj+t8gEuSur1ncKtQMFMfIECCLjAxg2aOVw1nG
X-Gm-Gg: ASbGncvooa9sZ+gE4YHXdBTc5dpWbjusapLXY9J0PvugX4fMpizcrOOxgQQHY8x2x7R
	h8IHplZ+yq0jwnXKp4yVsTm9+IND8uUYC/Hl0zhCGSdgxBxFiceA44c287FDTJxcWLM1fN8eMSf
	X0ISvc3nM/7pLTwUh2AdGnl4rWpqaExhPa913hn+r+QxNvfi3GC11xjiNI/I2pwaBFnqTZdyK5/
	OfyLU0gVkf4qfKnqrM/nO0C55sxzwUMKrpjrJlK3Y1Dm2n8bo0AKpRq1yKHOTaEJP/b4UJxWRPM
	KncaC6h9U+R37P3LdCHW9wDzkyoHE/c3La3e7hvWnBVmNuVk326VJWyTtt85h+ae84uL2/b9iQU
	s4rhwkZkTaF/ewwNmjHQWrdKk/BWHeJAJFxvLxg==
X-Google-Smtp-Source: AGHT+IEkCxN59bAilQf+U012E2UYxysRWLFcL3tVpfUmpe+pUK1qLpFI292/Z212BCB+TtTY9rKu+Q==
X-Received: by 2002:a05:600c:4692:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-45b855983f8mr111550195e9.20.1756916930536;
        Wed, 03 Sep 2025 09:28:50 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm346461005e9.10.2025.09.03.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:28:50 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Philippe Gerum <philippe.gerum@gmail.com>,  xenomai@lists.linux.dev,
  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
In-Reply-To: <e7d5cddf94d3d1479e987950a07ee7483820ff1a.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 03 Sep 2025 18:01:40 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
	<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
	<87h5xjlf56.fsf@xenomai.org>
	<e7d5cddf94d3d1479e987950a07ee7483820ff1a.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Sep 2025 18:28:48 +0200
Message-ID: <87wm6fjy9r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2025-09-03 at 17:39 +0200, Philippe Gerum wrote:
>> Hard irqs have always been off while running the IRQ flow handlers
>> grabbing the IRQ descriptor lock, this is a fundamental requirement, no
>> change there. handle_irq_event() drops the lock before calling the
>> (user) IRQ handler, then reacquires it before returning to the flow
>> handler.
>
> Thanks. So
>
> 	hard_local_irq_enable();
> 	do_inband_irq(desc);
> 	hard_local_irq_disable();
>
> in sync_current_irq_stage() allows pipeline entries for other IRQ lines
> but the desc->lock prevents this for the same line. Correct?
>

What prevents subsequent triggers of that IRQ from happening while it
flows down the pipeline really depends on its flow handling and the
requirement for delivery to in-band.

- a level-triggered interrupt stays masked until the in-band stage
handles it.

- mere oob-handled interrupts are unmasked as soon as the oob
handler returns.

- non-masked (device) interrupts are serialized by the desc->lock across
multiple CPUs that could receive them.

- the in-band stage is stalled (pipeline-wise) while synchronizing the
interrupt log, so we cannot pile up handlers, although we might receive
and mark a subsequent occurrence of some IRQ which is being propagated
through the pipeline. That is the reason why sync_current_irq_stage() is
a loop: we might have received more (in-band) interrupts while we were
busy handling the current one.

- lastly, oob handlers cannot be preempted by the same IRQ since they
  always run with hard IRQs off.

-- 
Philippe.
