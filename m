Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26C2F49FE
	for <xenomai@lists.linux.dev>; Thu, 11 Dec 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457768; cv=none; b=ic25gcv/h195ySRFfpvlhapaLIzC6cSmOtPFrbG7j+w/w77SqKNYU/KtpUFoSxBAv8vPvItyNafOuuZtpYsWttzNI1KLBQBBnw1FKvXjsy2KpbkBNlbmoM0OS2TfQxtgZQI+RpDFsFjkByedYJjIKRqnSvzx5n7mbLNpGT/3epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457768; c=relaxed/simple;
	bh=OZ9sZMpaD39j2vbf5fLZ0I9Cu3LBIufKNRoCSnhT/1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAZ8CQbg1YZ+Yg30zw1Rr/qMCliN6bC4jDr5Oh7fXHDmxdwClpU709rqBTGMuNuDaWX+T/cQMgMYGM8L2CvQeZrWZBxKgqbkxaM05tnJIlGiaUW3dxfFu4Cl6kOqkSCE6Qlbsz8YUj2re+6vthrsjUlc1Sbmzkq1k4gbz4yVKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZJy5WWU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZJy5WWU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632b0621so388635e9.2
        for <xenomai@lists.linux.dev>; Thu, 11 Dec 2025 04:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765457765; x=1766062565; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twjZ1+WnqzqOG3dMK6U5zZTleBMGax1+v7JALvfnr/I=;
        b=QZJy5WWUzHLhm9YJV7sdqrmv4UJQPHxLSopQXWZX1e73NTHN0QAvlCwDaux7hsYr9E
         hjErZ6aK1D2XZ8oZYSZ2lYlTS2vYuW6kXMriw3Q8WoXee2ECWaPjIGspoWfuNPBIJqtL
         kp7olVkkwXmmq5Y7oEzdLLpCfkYqTWTPALFzGaBAlz0WWNHZLQtnprDvZECjaCATbp8i
         xXbcdZ3ADdXLf2HJ4TwBVDDYqqpjqCvAYVK6amhxrjq2P0+ImhzYUN9O47ULzkhgZltq
         9yOLnl3/wz1zvC0nejJ01yusQ4P41VpFrBnykHMZf3B5ZIEnXO4M6KPuJCuIue1Vuf04
         lDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457765; x=1766062565;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=twjZ1+WnqzqOG3dMK6U5zZTleBMGax1+v7JALvfnr/I=;
        b=NPm0MJxPck0rV8VEsORram01MR/8TQnFqoeNsQgnhUNWRuKtscNw0nyt8oXh0ew85E
         KueIek+gswIyC42qtNsCVRflzD9h606UmBwp+EJQpx/OhymFhIEstkY9bmYTssjwjBd/
         Gt1hsr0EZ8ioSH7yh4eaB7R05KTZkJpaPNIJHtQA+NfQA2frIPjGLfpTDJle3PYPBbnJ
         h2Taq9KHvmQyxR1hySPWbfdcXubwGBAowLMjFjyX35zBJ2/DhgXDYD1Fp/EuCmUoC0NW
         OV2i/Wl/cAnBpKyu4rFuyqPdTAOYzI0bx0fMYeU7jnxEa8I72xpWdTs+LXhlp+sFZ0cv
         d8BA==
X-Gm-Message-State: AOJu0YyrP0i4XHqqwMBW/DqXEFEdNHX02mJu+tq4sM21Uqt3WgFE7ONd
	zcRebNpIfkhRYFOKB8eHMtKMzY2pqdBo5lb8z9WS4vi54x9qMILg1U8B
X-Gm-Gg: AY/fxX6vvFXs7TZvUafyHsevKWQMMUmlWywFiOe7up0p722gSWgsxT9YgBTT0odvFs3
	7wQEgoO6gZwO+4OSSVm7HBRymTrkG+kAwvLct4grObf+IQJGS2qGUMTtmOBhdMKD7rPuN54Y2Xi
	/SJaJ3TG7d396bDwU6PHGKG3kaA0s8w1Qg4PTH74JOG9v9RiuN8ZPQ8hiUzKG+5/7nSGxP6tgPJ
	6vVSz5xqnWuxIuZOPtcS7duImcPgbv+9kvrxn+EU/WEl2Chc94fbCdW15N0MmFFjc0uJlO98bEr
	aH1xmBdk+RFPJ6T+/W6IZlj7/rWR0EOhLDG99qB2S9hH+xdfQHzxzdRLpGZEd7fDZ7TFU8X2CrF
	eLwz8mGJUrH8KHtEbXD/dvvpKsnvRqdKu7ApYnQTUdH4OZ0YvOOpG1YYUXAo2oa+RHCKh8oMVeP
	Y=
X-Google-Smtp-Source: AGHT+IE9nUi6CGxbuXGD6qDQEYVMaDznIIJeW4liuRiyQPeAbEo3cxJC+BkVDiPLI6el7KUZWLkpXA==
X-Received: by 2002:a05:600c:8b37:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-47a8375a595mr61274225e9.12.1765457765331;
        Thu, 11 Dec 2025 04:56:05 -0800 (PST)
Received: from bogeyman ([51.15.199.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89dac074sm33178245e9.8.2025.12.11.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:56:04 -0800 (PST)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
In-Reply-To: <0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 10 Dec 2025 13:14:59 +0100")
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
	<875xaq88tf.fsf@xenomai.org>
	<0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Dec 2025 13:56:02 +0100
Message-ID: <87h5txuqhp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2025-12-01 at 17:29 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi all,
>> > 
>> > these are the necessary backports for dovetail 6.1 that would allow us to
>> > enable the in-kernel FPU usage of switchtest. This is currently not
>> > possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
>> > context switching.
>> > 
>> > I have backported the necessary patches down to 5.10. That would allow
>> > us to unconditionally enable the tests for the xenomai3-next branch. I
>> > will send out the 5.15 and 5.10 series once we agreed that this version
>> > (targeting 6.1) is correct.
>> > 
>> > Please note that there is a small problem with this series. Patch 1
>> > removes the check/flag that was used by the dovetail enablement code to
>> > detect in-band FPU usage. The new flag is implemented differently in
>> > patch 2. Patch 2 also fixes the usage of that flag. I had no better
>> > idea. Otherwise I would have to delete? the in-kernel fpu preemption
>> > code (temporary).
>> 
>> TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
>> using the NEON unit by an oob thread when PREEMPT_RT is disabled, kernel
>> or user for that matter. i.e. It looks like this aspect was overlooked
>> during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
>> broader fix may be required. We may have to use a marker which covers
>> any type of preempted context.
>> 
>
> I agree, but this is something that we should address in addition / on
> top, no?
>

Yep, would make backporting easier.

> This issue seems to affect all versions of dovetail. If we do the
> backports first we can address the issue on the same feature set. That
> should simplify the back-porting again. Did I miss something?
>

Agreed.

-- 
Philippe.
