Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15161A726B
	for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685476; cv=none; b=qhq401rWEVOKi2PqUF2/28PFow0qS0qhUr+3/Om6UeOJAR0Tm5AWGllxye2z55zB3rd1TFKDbEOjAg4Zc0nCUZ0y5VcJLAG9u8Mh/SWrTGzHJKrgNqT7H9EyQt4/zlpkwZvnQfWkSSC+4/5nRebq7U+YoTvAjlGtokcKpdLqYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685476; c=relaxed/simple;
	bh=2kJHVUKKKGg0H5zigtqYQdqHugZZj2MnjphIGJvYb8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q7Crm8DOP1PNTbdcuMbMnHjD0mInKi2YBz2gjEFE/Xb1B/g6zeZCsGPX1sVKx6IiSB+PCTH845TBrNwPXyetpgKkL53pSsHFtfNCXzu29Fx7quyf7eIckRA6u3eqnl8K9eY33wqgxsS7LD+QeiMe45uv26T12zg059jbpEwYTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43634b570c1so11904465e9.0
        for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 01:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685473; x=1735290273;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqh/PbsHi7vwVJ6LRzgNU6xM1MY+HTjbDZLB2E0iFjo=;
        b=bRXrKrXDQJfXGdaQtasQusTepjViyiRqKYuj5Im4NcvMBcOu7LrO2wJTT/Lq0T66nZ
         rCFkPxoyKl7Gztt8BSNgPzexmfhBNy7mUWYcXR4LAj0hRAXqf4GqlL8JLKRk64eYq7ZZ
         wfkMIju0fFl6xoO4zkL6nu31Gq/PwxHLmDbgzpRDjJAgh/PYDRDUtGo0v5imI4VOwN91
         fsPvV3+UMVsbk+k2CXs8GxlLy2VUZSbKOcjm9x/ptK4HIRkgm1UddveC327a0ZwSn/Fi
         wTHV6/6PZZgWekb9W8NdYUbEET8ozsfnLWkYax1nx72WDCGGJuugZVvymmJsT2a+i6at
         cRnA==
X-Gm-Message-State: AOJu0YzPpyidXYJZdsUWDcXLGYH8/G9O7nU2d3oiuAZvPyRR00uJPz3E
	X+9QkogGAlio25i5Jg7lUcgWaXSJjYtSTl7XnXIjkt196i7GV+3nyOWb8A==
X-Gm-Gg: ASbGnct37FoXdB5cr1niy7FCCbBHjQ0cifmvBvlKe3mCploqHSMzbQZleSYJG8pF/FA
	gfRuHJKXSTc14RZHIGrgGLH4CQaTq2nei1xDqYxpUYFJ01XGucOSv3BTjhKWxt2/jCZqfXLaMcW
	MmC/xb8kRUKaroEdavABBztF9Pznv5EfuiYzHiViq2uUpeMjN/TwRtQC/nn23soQLTarVEQmfFW
	pMfcoQM56KwevPoBgqmHkxRACHsi7DMEf+gMHJtag==
X-Google-Smtp-Source: AGHT+IHLOWW/5KFVCwOhQ6WDB6BQXqa/loM0tGXQ59RZFyPHbg3XvI+mVuk+BvY4fp9NqRkVx+rtyA==
X-Received: by 2002:a05:600c:450f:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-436686461cbmr16726215e9.17.1734685472889;
        Fri, 20 Dec 2024 01:04:32 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611fc762sm40126015e9.11.2024.12.20.01.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:04:32 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [Draft RFC] Bring POSIX signal to evl
In-Reply-To: <CAHR=ZXGvkXv1vEEitQmjY36xDT0D+s-SNVxW4a8CdD0RFxh1kQ@mail.gmail.com>
	(Qichen Qiu's message of "Fri, 20 Dec 2024 16:57:35 +0800")
References: <20241218122615.1974864-1-ruiqurm@gmail.com>
	<87v7vf1xw2.fsf@xenomai.org>
	<CAHR=ZXGvkXv1vEEitQmjY36xDT0D+s-SNVxW4a8CdD0RFxh1kQ@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 20 Dec 2024 10:04:31 +0100
Message-ID: <87ldwa4teo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Qichen Qiu <ruiqurm@gmail.com> writes:

> Hi.
> Thanks for your suggestions. It is really helpful.
>
>> However, big CAVEAT: the EVL/x4 locking model is fine-grained like the
>> one the regular kernel implements, unlike x3 which exhibits a single
>> coarse 'superlock'. Porting will require to reconsider a significant
>> portion of the original code under this new light.
>
> Do you mean the `nklock` that is used in almost every syscall? I wonder
> what the original purpose of this lock is. Is that a global lock like the BKL?
>

Yes, this is a recursive single lock coming from the Dark Ages, which is
basically used throughout the core to serialize access to almost all
resources. This is why x3 does not scale that well SMP-wise.

-- 
Philippe.
