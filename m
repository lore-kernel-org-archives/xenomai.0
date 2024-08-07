Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801E139D07
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047083; cv=none; b=iQHCJrkxw8cWl/QpZLGrVD/AmV+fldgCY5q86zIY7sj/2Fej9XSBbS8HoUUerFEXPpuef+HLYoXAexoIY8jDV6wdKxZjC7QiIOBZUmeSTfSTThk7NgFeCwaupHPdPn/sWGLghKN1bc9Trkiv6aoXeD2hYpZMwysALVdRl1hgZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047083; c=relaxed/simple;
	bh=z5TGbIe/IAsO8Yjh3rLly9KLRNOkjjZskjw8ChbnpKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E6aJPwWSOLJZrZkUu0OrvuvS3d5fUT0VO/lvRHgLArj7Fn0wfSFAxOYJ93nUzTtk4roIkv6oy1c6ZNY/ur/JTcLppM3Jku7K8b9kOdrZlLkv97E6uVNdKnYiAow02eumZNdZrM5L+M/K5T7Q080qzG72RIjmnkNu/2FgKAxP0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwFfP2IL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwFfP2IL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso61959a91.1
        for <xenomai@lists.linux.dev>; Wed, 07 Aug 2024 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723047081; x=1723651881; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fizVaWou11XxU8GOCsifDFNo3jgwZ7DKDlu/TIHqXJE=;
        b=BwFfP2IL6OWsRBG5c/zHQnzhspVUDorAESsNDOSlJHFaV4cqZiNsbRIpGJ12mMtnuK
         f2J3uWmhPp0vwrMNOZv+LZjCCCOAV1AsBdcjy2bjzN1GqbaUCz0RdSaPfOEDVc4TIiKq
         +xIE4N+HCBCZlb3kedEP9eU3XfK3GplD6ox61jwfQzGLWvcMaXDQlA8U1VxgPHHEeQO9
         WGu/vg2styTVVsx4/PDqKTjGGSEeM8GwNaetBaFzttIiG6BqLRNeITUNfzuX/cw9y2pC
         Kr1/9OZL50Mtv60Ar1dTakzHnVFiRVz5MCOLWpTjyRMks8b9X6/lMVpVSY/GpAh4FFUC
         vZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047081; x=1723651881;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fizVaWou11XxU8GOCsifDFNo3jgwZ7DKDlu/TIHqXJE=;
        b=Vy2NiJ0ywuHkzB779GuphqcWuR0A0bGxZ3hxnJmv1P3sonsbYGQf6v38dzKcumNulT
         ArL19RsYLbaRPrcOd/W/ucskxPJ5I0HqmWi+kSyiT4U+mWH1jPs2ohsIB2x+L4fJ7rf6
         E66HVAnnofjpjo7xCKkXwU4GSs02gZ/vdSZvi83l9kjic5Rb/2F/gtSEAt9jUn2lXN1R
         Py7UK8/SDA6/mHlnio8olo9A5JWkywnX0zm6kg55jXSbspMJQmR33mon0EhUVF+fjPrX
         kuqIyKvXqChqDQw178RkK7mfee3HDEvRfagCYfGhDGlS8dSvtK2egKfPC16V3WQfoRrn
         jhNg==
X-Gm-Message-State: AOJu0YzV1dqakIxgB1JSlFE4M7CB5k2Toibc40TP0NzRJ967HZpN+mRW
	0LJ0hUdbRfSdxgKibp1AwIKQgqQG8vOJzMtuc3vHY7o5Ah6ttOHHkQGP8Xn4U6b8mV1sRtFFMdS
	VeUWHM1oV5W1Q44v3kIJuS3iXyFCVHLzv
X-Google-Smtp-Source: AGHT+IGDRn8FhwnmTe67YF5rYT0nDnXhaiatS1mqM/81lsF9u3ZR864yS3tOKwexRLCAjg2S93B5WIrDILbYO/Dy9gI=
X-Received: by 2002:a17:90b:1a87:b0:2cd:2f63:a447 with SMTP id
 98e67ed59e1d1-2cff95696cbmr17370950a91.36.1723047081274; Wed, 07 Aug 2024
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 7 Aug 2024 18:11:08 +0200
Message-ID: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
Subject: Thread stuck in IDDP sendto()
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi!

I see a Xenomai 3.1 (yes, yes...) application hang in an sendto() on a
IDDP socket.
The problem is hard to reproduce and I don't have it on my desk, so I
have only limited
data.
It seems to block on __iddp_alloc_mbuf().
What I know that the reprieving thread is gone.

For reasons I don't understand yet, the following code does not
terminate with -EIDRM:
ret = rtdm_timedwait_locked(sk->poolwaitq, timeout, &timeout_seq);

rtdm_waitqueue_unlock(sk->poolwaitq, s);
                                                          if
(unlikely(ret == -EIDRM))
                                                                   ret
= -ECONNRESET;

Does this ring a bell?

-- 
Thanks,
//richard
