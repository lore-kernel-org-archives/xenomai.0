Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCE17B03D
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601504; cv=none; b=Jj2v3HTJNctg3n4V6hX+nb/udadFOkKm2fINGysdZwQ0+2JvtZWZwUvgPjogUZGmN5N2u+Tef0ITQbqxYLDzKVwmisrCpcrj+ImHxVo64//JUthiRXjZjYgDA5TXc6U8rvpembaIYcjPLFUMkVQg0KVfntVxK7scRSujAvf2ooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601504; c=relaxed/simple;
	bh=QQGmAByeCuxoHPPgDU+NO63GOAp5XnLSOdZ4y3MIrTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LRJ/A4x3XHFAbCHQnkRv1jMRrdI5guXxagTm+qc3EzbBHaIaS4QPZ/irUzfRzQw7U8xEQsudTFky4Vrv5fpOQxbIdQ2v0SyvknmUSkrPnOQk/NNq1G2VvyzXDx0Ym49uXbDlEOuiYQIr0nBTVC0EM+xpG8MtO4es7m9IQSEEnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426717a2d12so3351515e9.0
        for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 01:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601500; x=1721206300;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz8mdKz4PRBte9TBGN5yAwajAONQkjuhOS6XKSBHUQo=;
        b=ejiwi7EOPEqielcqaFdzcjZVTW2uOY+Gb7rEHWzwZec0E1ujdqxS2f7Cwrjo+dtvq7
         n8osbp7NAH0YWuG+W5xPX0q3n87BLJAEAI2yHs3MZgXHs8MkTB8NiD8tJQa0DJal2HU+
         4P8RjBNdh9CqQtIZJf5acuc7pH4l8USOHTGgSwgw+PvDRwB+cC/YzavdPSJXPAWz7TI9
         SbGdxTa4GustmgnXtHM69nFbNjjbHPhek7IIrPdn3cVjqyqUv2D9JLFwgN15Aq8j0nY1
         rxZfY1ihyYu+MO/3lUWM+IJd+SaySlldTjAX98KGkCrgnSW25MjpQxIQGMTwUH0+BXwb
         e6wA==
X-Gm-Message-State: AOJu0YwjC2pi6bMTx773lac8v2/tVhgiRE2SSXfhFSwTKU7zGu66f4Je
	Hq4Ho0em1lUXNbBFc2RfbAtOxc8jIAEGXhGOLVf28E18FbmYZAAqi0FICUxZ
X-Google-Smtp-Source: AGHT+IEaWVcJHED6diUCkhbjRa4Jj42MyM+eto23MUF/MdtuC0vGfE0ZqMefY2b0maEWZ2uKC/kcew==
X-Received: by 2002:a05:600c:1790:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-426722cccb9mr41611545e9.7.1720601500015;
        Wed, 10 Jul 2024 01:51:40 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84707sm4667548f8f.35.2024.07.10.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:51:39 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL documentations issues
In-Reply-To: <06cf758c-5d93-2304-203b-c4e0a242351d@bela.io> (Giulio Moro's
	message of "Tue, 9 Jul 2024 17:07:58 -0500")
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
	<87wmluff5e.fsf@xenomai.org>
	<06cf758c-5d93-2304-203b-c4e0a242351d@bela.io>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 10 Jul 2024 10:51:38 +0200
Message-ID: <87y169wrxh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Giulio Moro <giulio@bela.io> writes:

> Thanks for getting the fixes in.
>
> This one is still wrong:
>
>> -EINVAL if usecs is invalid, i.e. not in the [1..1000] range.
>
> It should be [1..1000000] ...
>
> I am also wondering whether returning -EINVAL when the argument is 0
> is the best choice. FWIW, usleep(0) returns 0. I believe I have seen
> code use usleep(0) as an equivalent to sched_yield(), which I guess
> evl_usleep() would be "for free" if it didn't do the early return for
> usecs < 1 : evl_sleep_until() would return immediately because `next`
> would be in the past. Similarly glibc (I checked 2.39) goes through
> with the sleep even if the argument is 0. I guess the rationale would
> be that no matter of short the sleep, it should always at least cause
> a reschedule. As this function aims "to match usleep(3)", maybe it's
> worth considering using the same approach?
>

I'm unsure usleep(0) should amount to a manual round-robin, at the very
least the POSIX standard does not states that [1]. I cannot find any
explicit reference to such behavior in the manpages either. However,
evl_usleep() seems wrong nevertheless regarding this if we want to stay
close to the POSIX behavior when this makes sense.

evl_yield() may be what you are looking for in order to do a manual
round-robin.

> Also evl_get_thread_mode() hasn't yet been removed from the function list.

Fixed, thanks.

[1] https://pubs.opengroup.org/onlinepubs/7908799/xsh/usleep.html

-- 
Philippe.
