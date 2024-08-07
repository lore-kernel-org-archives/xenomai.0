Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CE12AAC6
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053277; cv=none; b=o23Gl4y6Hn0ZFCpLZ7gSkIF4ZNgHdn0iT4fkqMH4ecCU9rTJPQKbgRBU7mR31XN/p0cmCtYZ2URAJVMzi8V+4WWdPhWzXzx7KpP59Wb7oP73jDRdxITXT3jWEvETxhQdsGsBCGadUrVuLu2yi7kCJz7QYcDgI/kozUtDrZ2uJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053277; c=relaxed/simple;
	bh=y0Lo/jo4Ru3tj6USymKYUYhCCPVOl0RpRuZWIK4vBQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs5wIfB1q1ZOSX4nfTs0fkAShd5xwZIHuQmdth1F3MiA+mSVooxlcpP/gMORc9NUj3XLMvIwJ7x0tpvl3odKx6z/fmhi4XJoMRrtG/HnVOQMHcVUAolSXyXcN0EwHTuwxMpN+CHWmSqZG7On9J9CF4QeTZnzluOTw2w1Jy2OQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6cgb1X4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6cgb1X4"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso870891fa.1
        for <xenomai@lists.linux.dev>; Wed, 07 Aug 2024 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053273; x=1723658073; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBjYbAX+/q7b5Tp1fyEL3Q6B0+fAqzhs4bDMbC0u+h4=;
        b=M6cgb1X44LVhucLG1Xd9JtGJQ3ceS/DDTTK2Ly6pWQts/7Rjkd65Rmlc1esJfRYDb0
         tlnpUtR62AScWqRW1R22+O+dW37QKk1pZ+zHfGwcQO6wNeq7K6Imabr9GlPJjwxflw+q
         RRmXd842+2gpEFFXiIzGtn0uqlsJA1hXqiwR3NGv07zt8anwQ5Ri+33J3cLOsEHgLvhm
         VpZAKAtkP8atfpFjuAvguXsdA05MdtrjZydfAAwkYmoLTyXVIB/x4Xnt43htCCQZMrmK
         2uEP5J8mG7KxqCpwLBjuyXmbnIwI9vroo78heBTGGDGpGK0HeEUEknnE5lteOJ+Li1wR
         X2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053273; x=1723658073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBjYbAX+/q7b5Tp1fyEL3Q6B0+fAqzhs4bDMbC0u+h4=;
        b=RFGKtFVzRuGlhU1EKvAoUhlmkkcImFVR1yxEDNm+PmRiREvyYuhN972EmbLWWpDqYI
         /RHi8Bp+eoXc8dLH8WhLa7Fj91jsAp5+Ica+CH8fUYu/HreFrt3K9l7TOIfOZkNVIHTd
         A553Bb89mqCKCf4elxZT1KkOZoE5DeljVBSKyJl+98p2cCDUcQeeqdpv16Omdzi/pt1P
         0XAnQ3/bYPZK/YRwR8RtbznECO3ef3Ksamy71YGyl0I24kFXY8aqtVxDoq/RVs6nh49y
         97qaSk6MLEc5A61ymmF47sfsu+Ua986+z/o4rh+i92eBUYDInXItgWhZ8YZCOig3uSPJ
         w/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVucA+WbQi0Sh0dLgrgHtxGTw3A7R6bSXY5tcyvNn0ly9m2/tavyP3X43ZCzDFqJW8to21BypPuz6mnlouea2j+qUAHMjguWw==
X-Gm-Message-State: AOJu0Yw5JRYz28QMlyhvFIKd5FUvIcVqJ3k4M+qiT7CP/51CmYBsl1eE
	sG7e4k96Qs3YA9ULhQfbUBPz40/Vf7UTSnT3jUPtCDYnwaPDwbB4+xjKU7j9JxNYuxS1UtKFzfD
	jqF0aztWMvshEtxsTYcqgXow0r6abHtKU
X-Google-Smtp-Source: AGHT+IEq8urxgwCfUwMwUdbCEOc+drzhUivL8L6PwiLFPw0QSi/7B49R9yAm4bbQ+HzBQfQQJEOO9fvMYBtCoWDjs5A=
X-Received: by 2002:a05:6512:2315:b0:52e:9beb:a2e2 with SMTP id
 2adb3069b0e04-530bb3b157emr13221182e87.19.1723053272863; Wed, 07 Aug 2024
 10:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
In-Reply-To: <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 7 Aug 2024 10:54:21 -0700
Message-ID: <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:15=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 07.08.24 18:11, Richard Weinberger wrote:
> > Hi!
> >
> > I see a Xenomai 3.1 (yes, yes...) application hang in an sendto() on a
> > IDDP socket.
> > The problem is hard to reproduce and I don't have it on my desk, so I
> > have only limited
> > data.
> > It seems to block on __iddp_alloc_mbuf().
> > What I know that the reprieving thread is gone.
> >
> > For reasons I don't understand yet, the following code does not
> > terminate with -EIDRM:
> > ret =3D rtdm_timedwait_locked(sk->poolwaitq, timeout, &timeout_seq);
> >
> > rtdm_waitqueue_unlock(sk->poolwaitq, s);
> >                                                           if
> > (unlikely(ret =3D=3D -EIDRM))
> >                                                                    ret
> > =3D -ECONNRESET;
> >
> > Does this ring a bell?
> >
>
> Are you sure rtdm_waitqueue_destroy() was called at that point, ie. the
> socket was fully closed?
>
> Jan

(I'm involved in this one too)

The second app (the one which did not stall) is truly killed and thus
disconnected from the socket of the primary (stalled) RT app, if
that's what you're asking. How can I verify that
rtdm_waitqueue_destroy() was called?

thanks,
-C Smith
