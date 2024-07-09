Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449112E1E9
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559250; cv=none; b=nRqPvs5bOOQvdbLBNQdndgjPWUVehntmMJJEj5K/MtacVjGGLbflZ724LbwH2JP/WX7qI7fEbVzWhfw7CbVkKCNRBhm2dQxsadkKWDnnMashCvndy8+nxiPMtoeAcfidon4FvC6kOZMWRmtEvBMfwAtVlRnEWTXwNhotqaiVFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559250; c=relaxed/simple;
	bh=lNG8cy+Sh8APa6ij4upbM6S58eSgmsBZJuLj/CW74es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TN+u6xSTL0X2ZNf/dX0b127ZHYeTr9/JEbHgRzoYbGLHlf28RQ58a6U+oJ42Nc1KXDByAPjG0ivKajLWsY7dBjqUVP5vJpkB4kR8DPl/Th9rj+kjEHwnwi1H9HHVxJdkYFPEB/fP7V2MYZTcK82M4/LegypbmycfIkY3hNBlAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42679f33fefso6864035e9.2
        for <xenomai@lists.linux.dev>; Tue, 09 Jul 2024 14:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559247; x=1721164047;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKeHewAT676+rwqlNAYCSn/gARMkQzIFGeGYTGYgIyo=;
        b=h6OJo9EbZS///Nob0QAkNSaYTXqxyhzxXGtmIQ0P1f6RC1d2+VNyXOpvhXzR8za1TR
         XClknO4njznkUqNPvwDoERoz84Xx1FmJATxv4l0PYLkbU6o0Zu5mEHdEpFVKVmn+PaU9
         wnisQBnBt9H9kO8psX4MvEzwW09G0VJSZRhVou0aDj/FFPtun/DfivvkbjO8mvGT4N1R
         I5wwmRTTmVUBad7NvEpySqcSle0+ERsx9eB5tbQwR+j2M1LUwOUww5eMnUj8lQfCTef4
         WBAw6wOrnmN/zXPItQsNEXvqEm5uUl36q31zjo3SaB8swSXQCkgOQAdSe+ppwInu6VZw
         FWNQ==
X-Gm-Message-State: AOJu0YySf9sRMj4yQ9xbLEc9uFI801Hm5GnOuvBTxP78qZT5gwN0iK5a
	OzMAP7HLkbUdAFb6KEvbmufkHQ5Qu1YDjQ3kygig6EQfWtyEcQc8z4VmQQ==
X-Google-Smtp-Source: AGHT+IEcDK7ltZY0P0u0ua5fHbrX7mMrYH+/sP951ZVI9l19o6M4y3iUULYh36TfPLk6PSDQeoFnfg==
X-Received: by 2002:a7b:cd98:0:b0:426:6157:7ad3 with SMTP id 5b1f17b1804b1-426707e388bmr23321275e9.19.1720559246775;
        Tue, 09 Jul 2024 14:07:26 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab136sm3506516f8f.98.2024.07.09.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:07:26 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL documentations issues
In-Reply-To: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io> (Giulio Moro's
	message of "Tue, 9 Jul 2024 10:45:04 -0500")
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 09 Jul 2024 23:07:25 +0200
Message-ID: <87wmluff5e.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Giulio Moro <giulio@bela.io> writes:

> Hi there,
> going through the documentation for EVL I noticed the following:
> - at https://evlproject.org/core/user-api/function_index/ the
> functions evl_udelay(),

Mm, legacy name which eventually became evl_usleep() in order to match usleep(3).

> evl_new_clock(),

Once a forward looking statement which did not go anywhere
eventually. We don't need that call, a custom clock can be accessed by
opening the corresponding clock device in the /dev/evl/clock hierarchy
as soon as some EVL driver implements and advertises it to the EVL
core. The returned fd can be used with the generic oob_read/write()
calls to submit requests to such clock.

> evl_get_thread_mode() (at least) are not going anywhere and they are also not mentioned in the libevl source code.

This fell into the cracks in the early days. This would be an alias to
evl_set_thread_mode(fd, 0, &oldmask), with oldmask containing the
current state.

> - in practical use, evl_usleep() seems to have a limit of 1000000 as an argument. Is that expected? The limit is undocumented and the corresponding -EINVAL return value is also undocumented.

Yes, the 1sec limit is wanted, for longer sleeps evl_sleep_until() can
be used with an absolute timeout though. Documentation mentioning EINVAL
was indeed missing though, fixed now.

> - evl_add_pollfd() and evl_mod_pollfd ()take an undocumented union evl_value pollval. The tests use evl_nil.

Doc is upcoming.

> - there are several broken links. I found these with https://www.deadlinkchecker.com/ entering evlproject.org  as the starting page. I report the result  below for convenience, but the kast column "Source link text" is much more usable when viewed on the site as it is a clickable link to the page containing the broken link
>
>

Thanks, all fixed now.

-- 
Philippe.
