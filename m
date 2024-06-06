Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8701527AA
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677947; cv=none; b=rKv/d6p+UOBG4wybSKsGwt7Q280hiYYUTz1eai1DC6H1o+GZLqPDxNyyJKEbqpMqBTc698HnLpnHzBNUD5z6CHvOR9zbe/aZpcqKzXDryjWGYnC0YWPCgKeK49zpG7z3pDsjxEe0RzEtjma17NYaDRP+z4SGEc0UNvToiaiCx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677947; c=relaxed/simple;
	bh=EaRYHYwlyuU42jfWBccdkxJQvqJiWH0oXjMbO3Mnf6Y=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lafzgIKj71L6/Hh7J9i1Sx5OyBPPidGPZMMg/WdDsrzLiXKq8lhWDfBkpin0fmB9UHJr5NuTXhxiLKzSYQRUf2PqJH0VUC510TOxx7nzh2/xyBlPUBVC4w9Eb5ljmA1t89gTQjCy3SOxUF8CkoexKfjstPQ82wlI9E01WPniUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42148c0cb1aso10268295e9.3
        for <xenomai@lists.linux.dev>; Thu, 06 Jun 2024 05:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677944; x=1718282744;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpjtk7uA1f17u3ZuesSoEwwtzqbSJhMoC1KtJykU1kw=;
        b=lPx8aX0biX95orqwZ0OaHUGjZ4z4iu5crYwt7EPdrBgyvMq1QXbpa71dVkXI3ER6oA
         8txSFLuPtzdFc9BRRORzC8LdSmRtnB2RwJHyhbKMF76NANCBcchfoYPmNJv/Y3g2KFCp
         kIRXMndmQjs5dywMJp8n3UBayvjpz+MeShpOOzz9mRim3liTYNI+lWXjXJ4UrHSjGmwB
         U/snKFOEXRWzvVp3f+IDBcDeOt+cXzGd6HPFirpKNY3OcF/lWU1ynKnz1aUnYm7UT6aM
         Z80ZjIh9gbLz0d3OWW1JjOL1MbwXiqZ87lmMj1SgKqEqgjpdclzjgdCo/aA1t31LV/VG
         LSrA==
X-Gm-Message-State: AOJu0Yz+oOIZfBwtIRJ5UbGzwpo2bsvSaQubdi4z8nOdNhjskVZP82Bp
	HnaSlAgQ8JEo3tT8FuBo4L0vZHrQTPtfFkg9hMtIod2VZN+Inmn8
X-Google-Smtp-Source: AGHT+IGMQAsbVZYzxVIjpMpr1985yrrH7knbH/92X1TDW2Mu04oaW5dY9sYGYgCoREcfwjTeR0K17A==
X-Received: by 2002:a05:600c:4fc2:b0:421:1f78:1564 with SMTP id 5b1f17b1804b1-421562ce9c7mr43058585e9.9.1717677943861;
        Thu, 06 Jun 2024 05:45:43 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a5f47sm20923505e9.24.2024.06.06.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:45:43 -0700 (PDT)
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
 <87wmn2eawl.fsf@xenomai.org>
 <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
Date: Thu, 06 Jun 2024 14:42:58 +0200
In-reply-to: <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
Message-ID: <87o78edytl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
>> > When running over an OOB task that is currently owning nklock, we will
>> > release the lock unconditionally, leaving the task "unprotected" /
>> > unsynchronized. Right?
>> 
>> No, the only way for a task to hold the ugly lock safely is to disable
>> IRQs if it has to compete with an IRQ handler. So this scenario is by
>> definition a usage bug on the application/driver side, not on the
>> infrastructure's. Meanwhile, the _irqsave() variant prevents spurious
>> lock release in recursion using a special marker in the saved interrupt
>> flags.
>
> I just checked all nklock usages. Most of them are indeed using the IRQ
> safe variants. But:
>
> In xnthread_relax() we have:
>
>     splmax();
>     xnlock_get(&nklock);
>     xnthread_suspend(...);
>         xnlock_get_irqsave(&nklock, s);
>         xnlock_put_irqrestore(&nklock, s);
>     splnone();
>
> As xnthread_suspend() is using the _irqsave() variants, it's basically
> a noop, the recursion will be detected / handled correctly.
>
> What happens, if right after splnone() the Xenomai timer tick is
> handled?

At this point, the current task is relaxed and does not hold the nklock
anymore. It's been released by ___xnsched_run() <- xnthread_suspend(),
on the exit path.

-- 
Philippe.
