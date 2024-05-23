Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6F13CF82
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451511; cv=none; b=FdiOmDYfHQts5jAmNCJeYIw3+wQxTKMww2HVegyvEu6hnJ7e1TwVQ6RXXDJsqBTh7Hw/UzX6pfEHGZvgxKjOANx1kZe23r3ipz8x/49sQiSkZjrCTTq6mrcVG51j3voC1/iOp0lNl6qId96vxrX6y1TXIR2V9pE4TVYLc7EK1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451511; c=relaxed/simple;
	bh=OH6s1L9BU02nvbfxkpFKy/3Z5xbwIzyQFvYnv93cHhI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=XqTrUdCY9gLnZIy+qWq9ynzxAg6SkxRX+p/n7z6chTxIOa91cBaPKdBkQ2MPP0VSp+JBVg6/UfaY6HbAGgiK4lK73CnY+csSLXJ3AD6PvCe5mzu4ODFEgha4lI5GHGuCPoYZoVqDI89lUphhS8bgTmrbPhmlU5k8R7dm+fn9EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so49039065e9.1
        for <xenomai@lists.linux.dev>; Thu, 23 May 2024 01:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451508; x=1717056308;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmPNfNjxwGlULWUMgme4DlZAUIZKnXssajCRJnjIY4o=;
        b=gZtAb8T0H5T8709h4eMZ/0IthDvA0HNhIP08V0LdwPPX48Crs57eUSm1vzezpCA115
         qC0KeYQGtDHBfh9o4HZeG6QHeWcIJioj5db+DjgLTsGiSN94r3AfQaBp1DWj4bGD3kex
         zCzYWx2i3cBCokJOrTIi9bPO+SWYbvLLzPv4e6thJJhzQCcnQ4ZxX1M0ub+szrk97vW6
         Zqnbjhvzm9B6M6nSN3bWTdxSWxFmDmTgkE9L8mx5w6j/Abt65PzZltj6VfklBUfOhcwf
         G/0fv0wSUSGiMoUZSTKX7ZoM8K3jbRSUJqomQH1yUnXoDtducJiuPQwn+PX7NIesDRtB
         bI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO8HrHTeuI90kTrPX9Y1jXC5yEC0CNvW4FbYhVFsPi4w1BvktnD81YuSYKJ4s/3+uRyBjFAMdoN26Ms57RjR4VnZRyjd7bKg==
X-Gm-Message-State: AOJu0YxtVNRiiu88yAyIUSEI9VodA9pmSH5ye4unyIouN/2BOHXCEjr9
	CMVLpsL8vkXCeb9B1bmXYGahYolCoUj3oLAgXKEhaifSZpxvJO16039unpE/
X-Google-Smtp-Source: AGHT+IH5qPPJmcwbt57vfL4PbIJLLN4PB4cN185wJcYvbtXD46cyz65zPK6vTvmQ2/g6XWEXdH1CNQ==
X-Received: by 2002:a05:600c:55d7:b0:418:29d4:1964 with SMTP id 5b1f17b1804b1-420fd222e3bmr34950295e9.0.1716451508121;
        Thu, 23 May 2024 01:05:08 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f14436sm17537885e9.17.2024.05.23.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:05:07 -0700 (PDT)
References: <Zk68Q+2tgdwEkcS9@2956c958a175> <87r0dtrmbe.fsf@xenomai.org>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Philippe Gerum <rpm@xenomai.org>
Cc: 87ed9urpex.fsf@xenomai.org, xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Date: Thu, 23 May 2024 10:04:07 +0200
In-reply-to: <87r0dtrmbe.fsf@xenomai.org>
Message-ID: <87msohrm1a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> JiajunDu <wonderboy512@163.com> writes:
>
>> Thanks for your reply!
>>
>> By using a barrier to synchronize all evl kthreads, I did achieve the
>> effect of multiple processes running in parallel. My solution is
>> in the next patch, and the branch I tried on is the latest
>> `v5.13-evl-rebase`.
>>
>> But I still ran into two other problems while trying this solution.
>>
>> The first problem is that `evl_flag` cann't solve the problem. The wait
>> condition in `evl_wait_flag_timeout` is `evl_read_flag`, in which the
>> flag is set to false as soon as the flag is found to be raised in
>> `evl_raise_flag`, so `evl_raise_flag` can only wake up one waiting process
>> at a time. And it's not possible to wake up more processes by calling
>> `evl_raise_flag` multiple times, because it's not possible to determine
>> the time when processes are woken up in the SMP environment. If we did, it's
>> possible to have a situation where two processes are woken up at the same
>> time after the flag was raised twice, and then only one of them can be
>> woken up at the same time. So in light of this, I defined two new functions,
>> `evl_wait_flag_same` and `evl_wait_flag_timeout_same`, to read flags using
>> `evl_peek_flag`.
>
> The semantics you are looking for are available from evl_wait_queue,
> which basically implements a condition variable.

This said, I agree that the current implementation of evl_wait_flag()
prevents broadcast, which is wrong.

-- 
Philippe.
