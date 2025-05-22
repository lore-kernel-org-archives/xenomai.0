Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18428244687
	for <xenomai@lists.linux.dev>; Thu, 22 May 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900141; cv=none; b=CgfieRx+EHI5iLi6es/uE2/rCCiBaeLfiV33czaww094uhzXEzpRu/h5unE8L9MgKw6QcFaGfn7931ec3PJjdklhfQ4wUFUMwKDS9+eS/r4d0ap7uqUXxvBJ9bEbSMFUMfkedUEqq2GNVuGUCYv5NVmE9yJMyl2JnGI44ynCDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900141; c=relaxed/simple;
	bh=NuaAASmEJ1T5fdJTqdoL5S/rUp0x/tjJmEc8RX/RxLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9j2ruAbo0S+Y/OQu5mbfw8MR2WPeRUHZ3piTEjq//WtsCDmM9jjJSwvP5CL543qBPMBebL8BkkTxkBVyA9m0aGTvgofpgYOonHzNWok7MjYaxcx3FRSM+4XQfro3QjYJ3k50CAesOeAEq3ID/aBBjI6vedrykGVGlOrofLN0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0wrzHu3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0wrzHu3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30e80f03760so5617946a91.0
        for <xenomai@lists.linux.dev>; Thu, 22 May 2025 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747900139; x=1748504939; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuaAASmEJ1T5fdJTqdoL5S/rUp0x/tjJmEc8RX/RxLI=;
        b=B0wrzHu3p1GRoDxZxrzLM2e7QVFsURxI9cTcX/jHEk4sbvPYZiQA4E/Q3xcaFi8iiZ
         zKlav0xRAQ1uFYcRfWSbOYVuvTAX2PiDuloHQ6BXOTypqiQtlaYxARSPmsBP4mL6b5gG
         SO+X64HRjooIZ7PqPvRH00i478Xh7xm0yH2NKGLGwqpMPzOAbwTS9ZSSx4X7Bk+NzoRS
         gQlAj2JmTbeFQx7qMKl9JLD+MIIWjwZsCypowXCt+dMaH87Ecymhfyi6TT35ECORWr6g
         uI18hZ8CFqCrssKzBb2HT0W++CunyUoHItDymH4v1q/zrj3baa8YCC2SndDuG1NREy5O
         ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747900139; x=1748504939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuaAASmEJ1T5fdJTqdoL5S/rUp0x/tjJmEc8RX/RxLI=;
        b=RHCWW0pRp2oyI7vUXxazzgdcrQmlbzJqr4+CHiHAsiqCzn/++5l4j12ntQTsdZvCeE
         3KdK0ZKVk9RxavXa9Q+l0WlopOKdo+I20gwAev1wV/tRwtmzj6pFNVtLCIejxxnsaTiu
         zjtw/EObCTWDrGmyyMHc1DqRYBnS7w7PnoaxPPEcg0MRD06rVPi/tjCYVPt28Qbbja46
         zCjsrcs14+F8eck1tSSBiZ27R7UtARAddWyC7iCFwfDHXM99OBM15uWwFvNCXI6aGPrr
         BGSTgvZe/HfntCFBWrkQ+9/cSa1hCe2f0nKci4wg2jL5liwPQuv4ankv5G04WibfSPDZ
         L31w==
X-Gm-Message-State: AOJu0Yy2Nd9RoxhEX6O9qFt6ciHLzq5IOwtrOqb4aCpS7Kj22tvPm9Ns
	d3hY3JKYDayisiUeqh65BUYVBfOi79E2F9+raf+41HQPBdGkN5mKXeiZK5hdBLZfgIptFY7HRxG
	V5qKOJW5fGJRF+61BpJ/swjVql8Lu0FQ=
X-Gm-Gg: ASbGncu4YMqPHQMQcKlAMgfrOzg3amevEfYPcHN3qRX7aI6brgtnQknaM5jkYJmciFu
	u15lPMv+7bbNxU1BXvmscpGs2lE/DX4+ObBNMtyRvn7H80uZzb6lhOQXnmBXECQFDhk7ECrdo5i
	Hk0XN+E12sL9szZevJLoz6UKVKjDIG
X-Google-Smtp-Source: AGHT+IEaJNZtEnhf7f3fcFqQTZCCTJlhp8OS1M1VmAFAoLBzoDoY3hU5HKJWTMQL+R8gYueSOIbXR4BlzJhB4CkKZow=
X-Received: by 2002:a17:90b:2709:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-30e831b1731mr29973130a91.21.1747900138938; Thu, 22 May 2025
 00:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
 <f011dc68-e0ba-4fee-b3e8-00d135f2e6b2@siemens.com>
In-Reply-To: <f011dc68-e0ba-4fee-b3e8-00d135f2e6b2@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 22 May 2025 09:48:45 +0200
X-Gm-Features: AX0GCFtKgGoQwiCz4TeQ4ONyeLMHM5tDuaAzFGf8-2XZvW-H5rqQmV8oB8rF5yw
Message-ID: <CAFLxGvz9cpMCFCxbqAvSUsYuDJKbcnLBFX_XfR1QjpCxZMVw0Q@mail.gmail.com>
Subject: Re: schedule_work() from primary domain
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:32=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 21.05.25 15:40, Richard Weinberger wrote:
> > Hello,
> >
> > While debugging a crash, I realized that calling schedule_work() from
> > the primary domain is not allowed.
> > That's why we have rtdm_schedule_nrt_work(). So far, so good.
> >
> > However, it still puzzles me why exactly schedule_work() does not work
> > from the primary domain.
> > I always thought this function more or less just appends to list.
> > Is it because __queue_work() makes certain assumptions about the
> > interrupt state?
>
> It makes assumptions about being able to trigger in-band rescheduling
> when lifting the preempt_disable while releasing a spinlock. What you
> need is an NMI-safe (from in-band perspective) trigger of work. That is
> what irq_work_queue->irq_local_work_raise can provide via the dovetail
> changes.

Hm, I'm still chewing on that.
So, the problem is that schedule_work() makes use of spin_unlock_irqrestore=
()
which can cause rescheduling?

--=20
Thanks,
//richard
