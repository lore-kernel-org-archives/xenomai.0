Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3002594A3
	for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684388; cv=none; b=G6QtFH0wwuoL5CsOuUr3DXjddt7qRYDy1bXQb0mHnh6MEOHNTdQACvUtfbPhHq2IYTnL6fPoGpQ8V/K/hlDWYcT0PBAK+JXbU0iqYJgi9qoDxB9MORFpwLGlESGwJRWVdTAwTzwNE/PCc2JtcjudssdFdCMNfaJVBY7GvInqV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684388; c=relaxed/simple;
	bh=jMecbeKGPKUMLUGt3ckWEQty8CZ2qFW6lZ5Hr6sdm8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJ347LYuU4ZvDgNHoyTOaULkUG5w1CMIAv3xe6ABygPTGNYQd2+0ACoCpuSFPLdCo0WJ0BUJYsAiQQyf17XTRkBFM744sVKqoKSAlHkGgBCjbydrtfMEillVe3YIrT00fhVbGdBrUJFlAKCk86qCqzci8X4q4Fw9ZhY0OfT44AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUIikx+h; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUIikx+h"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-540254357c8so1548635e87.1
        for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734684384; x=1735289184; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMecbeKGPKUMLUGt3ckWEQty8CZ2qFW6lZ5Hr6sdm8k=;
        b=WUIikx+hMu5G7nbMzPfEUIDiMprOqmXZAirRrXhig/4qEmoDe5aVa6S0WTAsbv9s/p
         W5z7DjhAxMdHVseCUJg6hXQAaQfKCohLEOaFercgggSo5SSgMPytvcXwPmyg25JbSdXo
         zWBmuDzd+n7BcpqMmMhXDRPzcDoHOJwTZVcWxTI++hPJPGe5XyAzryoYM687oSdsbnv5
         Y4Sc4zNdJpfFndOOgROSfsKl3SYQtMS9b4lozky8jF+B0BPb6CTDRM3+r8+Ej3+aRavf
         KaLwBJ8UI6q/Oy9OSj5gQYnNl2iVLbQRP/IfHS82Wx8/JV1HWTZ+Pg3oEcthEIr4+IkU
         s6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734684384; x=1735289184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMecbeKGPKUMLUGt3ckWEQty8CZ2qFW6lZ5Hr6sdm8k=;
        b=dLpf2SXJ44Saumh+XuCYxGugyIiUN5P0eULUoUkdWcXEADSIZXN4k35+HjCp2lXZuG
         x2Vzp3HwEEp68LNZBOdr38tx12lawfTkohYSXleygNKkxK78jv1whRu+1xxNxhLKJP9I
         N9VN9Z+WMv12wYVNBLhdictnOetVhXd0jQzZGLd1DdJCFbhbfpdiKM8rN2B+BbgSfVlI
         qnjquhOy2+4aUrhlWCggOGsVNboBf0c2WRITcKQGQR52QmypHdx2H9LTKRDJn+Mfv+3A
         brVyvMks9srvVdb6e7BIb74DAKJUh2pmaggRstxs/74WXdQ/WUkhn8fMYBNGX4LKmgkJ
         6Hgg==
X-Gm-Message-State: AOJu0YywQdvPPKezvfJ784Z0ebg+aU5K5fQg0ljubk1RN7Wwo+1xdtB/
	/k9edYJnljyeM4T30hkFSkNcvYAL5j4zyL+do83hgJHN+F8+AjIEqEWRKI+GPN9pYA+ql0fqTFS
	lTq5xFLO0ThPgWVQVWlL8a5ukjGQ=
X-Gm-Gg: ASbGnctIgalp8HUnghTLxlFUNnDH9QeDeG+iwIgVFqXBxMwfx551VIZM1iPFCUCoEh6
	MsYBOi1X7CnympyusDoiXMb88xtQDyCbLZjVZrhP9ctIfK9HQbA55VON3SZdoc2cy4SgC2l4=
X-Google-Smtp-Source: AGHT+IHX88dUaooOFNrg5jA9d+uadedcMpbwgjqPGbFShHg8jXxmXGLwxA4dnCuTMJxkC5RJ1FCcQoNX9h1+64EOOk0=
X-Received: by 2002:a05:6512:1245:b0:53e:2c74:d65a with SMTP id
 2adb3069b0e04-5422958201dmr663726e87.41.1734684383739; Fri, 20 Dec 2024
 00:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241218122615.1974864-1-ruiqurm@gmail.com> <7c009e16-9ce5-4e50-8a2b-cc216ffedcb3@siemens.com>
In-Reply-To: <7c009e16-9ce5-4e50-8a2b-cc216ffedcb3@siemens.com>
From: Qichen Qiu <ruiqurm@gmail.com>
Date: Fri, 20 Dec 2024 16:46:13 +0800
Message-ID: <CAHR=ZXHwLQPODV1LV=eNehJ6WUVCuPEEos=gUKt16RE7+sAxSw@mail.gmail.com>
Subject: Re: [Draft RFC] Bring POSIX signal to evl
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Just also keep on eye on the ongoing efforts to use posix signals to
> deliver synchronous fault events to the causing thread in RT.

Yes. I could have a look at the implementation of vanilla Linux signal
and see what I can do


Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On 18.12.24 13:26, Qichen Qiu wrote:
> > Hi all,
> >
> > Currently, EVL does not support POSIX signals. To better align with
> > Xenomai and Cobalt (see the CXP [1]), we need to add POSIX signal
> > support to EVL. As far as I can tell, there may be two potential
> > approaches:
> >
> > # Approach 1: Adapt the current flags mechanism to POSIX signals
> >
> > EVL offers an alternative to signals called flags [1], which allows
> > sending a 32-bit word to another thread. The flags mainly offers the
> > service:
> > * use `evl_create_flags` or `evl_open_flags` to open a flag element.
> > * use `evl_wait_flags` to wait a specific bit and evl_post_flags to
> > post one or some bits.
> >
> > The mechanism is like a POSIX real-time signal without queueing.
> > However, there are notable differences between flags and POSIX signals
> > that would need to be addressed:
> > * Signal Capacity: Cobalt supports 63 signals (excluding pseudo
> > signals), while flags are limited to 32 due to the monitor's design.
> >
> > * Initialization: POSIX signals are pre-configured and require no
> > explicit initialization by the sender or receiver. In contrast, EVL's
> > flags require users to initialize and open them manually.
> >
> > * Target: In POSIX, signals can target either processes or threads,
> > whereas in EVL, the target mechanism is more limited.
> >
> > * Sigqueue: POSIX signals can carry additional data (sigqueue), while
> > EVL flags are restricted to 4 bytes of payload.
> >
> > * Queueing: POSIX real-time signals are queued, whereas EVL flags only
> > store the most recent signal, making them more similar to standard
> > signals.
> >
> > While it is possible to adapt the current flags implementation to
> > address these differences, I believe doing so would overcomplicate the
> > existing mechanism. For this reason, I prefer an alternative approach:
> > migrating the Xenomai POSIX signal subsystem to EVL.
> >
> > # Approach 2: Migrate the Xenomai POSIX Signal Subsystem to EVL
> >
> > Xenomai implements a signal subsystem. For each Cobalt thread, it
> > maintains:
> > * A wait channel (sigwait) to sleep and wake up while waiting for a
> > signal.
> > * A sigqueue structure to store pending signals.
> > * A sigwait_context to hold the user-space waiting context.
> > * A field sigpending to track the current pending signal for the thread=
.
> >
> > Philippe once suggested that the new POSIX-like API "would be
> > implemented as a separate driver using the EVL kernel API" [3], meaning
> > the POSIX signal support would be loaded as an EVL driver. However,
> > since signal sending and receiving are per-thread or per-process
> > operations, the signal module would need to attach data to each EVL
> > thread. This integration seems challenging for a standalone driver.
> > Instead, I propose integrating the implementation directly into the
> > current kernel.
> >
> > Before starting work on this, I would like to gather feedback and
> > suggestions from the community. Thank you for your input.
>
> Going for a careful extension, even of core data structures, sounds to
> me like the best approach as well. Just also keep on eye on the ongoing
> efforts to use posix signals to deliver synchronous fault events to the
> causing thread in RT. That we would love to have with EVL one day, too.
> It should widely be orthogonal to synchronous waiting on signals, but
> better double-check.
>
> Jan
>
> >
> > Best regards,
> > Sam
> >
> >
> > [1] https://lore.kernel.org/xenomai/87mtyr1abi.fsf@xenomai.org/
> > [2] https://evlproject.org/core/user-api/flags
> > [3] https://riot.im/app/#/room/#evlproject:matrix.org/$kFRgs7y48Qr0033G=
Nh-sDnI7GUrrp_mo-OEhDI0GAWk
> >
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
