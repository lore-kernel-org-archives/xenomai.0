Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D561E9B3A
	for <xenomai@lists.linux.dev>; Tue,  2 Sep 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804399; cv=none; b=nhlYG8FJwfmHSKZbH6G3wQ94Ic5KX5OAalrk+PEhuUcEfXDhWrK4A0b/qw4fPtOVrgxHNi+u2D69LRze4UWFQCIs6QzvxI82rm0if6s43pU0KVEALGotHaudVp4Q62y1UPRaR6d+z4GdzDlyIUIicG+oC/UKkoRutGuf1cEIDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804399; c=relaxed/simple;
	bh=RmEvyfJv5bBNMhpjGB+F9gvfDQucke+55De8w8U+p7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lA3jObQCybRCtc7e9B482o61TeK0HNFhj8mMlXezuu4E7H8KL5QT9qRqLXnWqya8skLPcScDRZKlqcRonJarZS48zXNXiJwC9vVtZrgXDMj/C+LH44UH035pVy6PnOkB5lQ7pwGxCvAGTU4C9wbMXFF7j9N3sp988dXI94fDMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZneEq+6F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZneEq+6F"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so18029215e9.1
        for <xenomai@lists.linux.dev>; Tue, 02 Sep 2025 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756804396; x=1757409196; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQGn8ezBGpyWRrVyE58ROXQ1+bCpAjCpK+es40mSvkc=;
        b=ZneEq+6F8kmbFVNN6kTqEsZXo7zXHOmll0mOPJO8aYAyfX1yuxRPu706SxqILmY/Kk
         Cemm2bqIeN+8Eb/1r7U4BkV385GakAv3bFXnoaFCi9Xg97LV04oaHV3vaFrYVRui8wNS
         AoRG065PJbko5bnf48xka4WopUEQhhTWPyd2gcOydFSH9iANwqdUSVyuIAs4NQgJNTkX
         Yohl98vbWcO+tfP84LELM3b0nmJghXPmf0fMiCjzjxzDhirB3vCi6QV8ljadT2o+z9jR
         wu9hZZu/kqSdVyAl/nWp28xOV8PXh9vmpoYX5PGoV5mLL60LM1S/ic1zWMXLDHilfmeD
         4l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804396; x=1757409196;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQGn8ezBGpyWRrVyE58ROXQ1+bCpAjCpK+es40mSvkc=;
        b=i9vt0WpKD8M/vxzQIWJkstKIwyD7gHA/qlwG4erVCNS/Z4j6mZ/WNhEc5XfuYiAkeu
         nNWcG1UINVxeFC/C9ePFqaTxFGyNtIVQ/yC3dB+Sek+dZ+zTj8aFniiVV1l+2obg7YnK
         PqowTHqTv9M8nyK5osroIZq0IVgyoSEBeeTvjiIoFuR5XlbekCualoN4RofZPO1jUGla
         Kgi7LRcaEFB8SFYRYuQr/l+ZZEzVDxvKfyiBkaoJ7rdrGN1lqPAouH26cddnQRs9WDye
         wGe1ouEhC9KqMds0tEjl2w01b2h5L64tlAZ7szhD7S2m6kNnc+taI4hJobmPE1+GZatI
         ymdA==
X-Forwarded-Encrypted: i=1; AJvYcCWa/yArh1MSffF4ZySXcJ7PFXNGYGSbiciSjzBi6j5cVzytCEbfgnKnqoPbnISbrTOTaGxFsDB1@lists.linux.dev
X-Gm-Message-State: AOJu0YyYyNy6sm7+m5e+95Y/vkeiOhCBfMyXZeQX5IZbR8RwV48/Ii/q
	sc4lUTUOs43Lq3K6wwUcK6gLHJRVf+lp0BlMQTmMcKksOm2yfgyLdLV3NWEw3GZe2Wo=
X-Gm-Gg: ASbGncvxuquonNNYR3v3HPIHsylKH6qWD/8U95YC5M0ETZe6l5Rtf3hrH3NCks3IGz9
	SMPst94BDd/qIMOY1EbmAZp+ErVrIKkwI7MBWS1u/6TQiMBvLoAHjboIqRYtXaC3eBXrd+fn51F
	KJJ6qF/tswxVKPjZDLo3eXFyWx9tRNthesvW8O74dsROx0dbgcGbpz9pTo2cQMH0gV0iRvwu4kF
	DpNFmQicMy5FMYqfb07ZI7sCRzH5hstgI0GBrsTXGSftzXp6HK5fLqn4m1bbHTS4vUHKq8NUmjZ
	dBDyGBBafmQBbIx8Y/4QIjHos5nqmuEyh9rB55Al8YUE89YsjuGXl/6REDV5m4QyCOrrW9dj/rO
	JIU/VtXJZhSwX4fZ2eqWjk6g/TNNrXsG/GwnPQQ==
X-Google-Smtp-Source: AGHT+IHB+uBASCtv165jCzVCst9xpQmoZMLRHOmyx/X6F0rT0pDj9zF5saGbeqtMUmoXpzuFEw1R5A==
X-Received: by 2002:a05:600c:4f83:b0:45b:7deb:3f0f with SMTP id 5b1f17b1804b1-45b84c2256bmr96633395e9.2.1756804395619;
        Tue, 02 Sep 2025 02:13:15 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e887fdcsm191402555e9.13.2025.09.02.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:13:15 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <philippe.gerum@gmail.com>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
In-Reply-To: <df36ef6e-7909-43a1-94ba-a0159c0eaad3@siemens.com> (Jan Kiszka's
	message of "Mon, 1 Sep 2025 18:49:06 +0200")
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
	<bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
	<87zfbe19bn.fsf@xenomai.org>
	<df36ef6e-7909-43a1-94ba-a0159c0eaad3@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.2
Date: Tue, 02 Sep 2025 11:13:14 +0200
Message-ID: <87qzwp1al1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 01.09.25 17:28, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 29.08.25 17:59, Florian Bezdeka wrote:
>>>> Recent Dovetail versions complained about an invalid wait context in
>>>> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
>>>> function is called from the inband IRQ context (while syncing the IRQ
>>>> log) with hard IRQs enabled and inband stage stalled.
>>>>
>>>> The call graph looks like that:
>>>> xnpipe_wakeup_proc()
>>>>     wake_up_interruptible()
>>>>         __wake_up_common_lock()
>>>> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
>>>>
>>>
>>> So, the warning is issued independent of PREEMPT_RT being enabled but
>>> the bug would be limited to that configuration, right?
>>>
>>> Since when is the kernel complaining? It is wrong since PREEMPT_RT is
>>> available, officially 6.12 then. Then this should go into 3.3-stable as
>>> well - noted.
>>>
>>>> As confirmed by Philippe in the discussion linked below, we have to
>>>> migrate the wakeup code from using a synthetic IRQ to irq_work to address
>>>> that issue.
>>>>
>>>
>>> Hmm, can't we use something that is a thread when needed and an IRQ
>>> otherwise?
>>>
>> 
>> Unless PREEMPT_RT is enabled, we can't guarantee threaded handling, but
>> we can always guarantee irq-based handling by setting IRQ_WORK_HARD_IRQ
>> for the irq_work struct.
>> 
>
> This was not what I was thinking of. To my understanding, we need
> threading here ONLY if PREEMPT_RT is enabled because only then __wake_up
> can be sleepy. With the conversion to irq_work, we would go via an extra
> kernel thread even when not needed.

If PREEMPT_RT is disabled, irq_work does run on top of a synthetic irq,
no thread involved.

-- 
Philippe.
