Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F78137E
	for <xenomai@lists.linux.dev>; Sun, 25 Aug 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724546037; cv=none; b=aYivXWk0L/+ojJdnclXzYrNhI5vRJkfMQGrrQBa0iggfAqrpMoj0iaYVfh4LSF/KeM+IjSEa9hVmddeQVDOvEVRRhLKUt+h+rPS30ykEbqc8wTBwUiIoH3UekzIGhNUGaP8mj4qdg0SnWsjrQK0TwByj09LLDtJM3NV2AhvNut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724546037; c=relaxed/simple;
	bh=jO1FS8VPa/Z4dflBdR/6B4C+47Hq3rtPnF2PPT/0zgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dx+zSJ7eoV9OBTAcvuTe2LJawsB0b1qa+oauEvx8ZC8TbiRMgIdQJoDa1X7KrPNC1heFeJqujihZFJIFEElE2wlmMDNRcVTM8Ywai5seCd8fFwHnPj0T/ca6e0CW8Vy3zMszzgI8B50KU+2I8SDq/fNxcNFbkfFsEiCnsUezi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na7RCAeA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na7RCAeA"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso38606321fa.2
        for <xenomai@lists.linux.dev>; Sat, 24 Aug 2024 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724546033; x=1725150833; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO1FS8VPa/Z4dflBdR/6B4C+47Hq3rtPnF2PPT/0zgE=;
        b=na7RCAeAcoIjl3O4X3VzBTnhQNaL5cGxJoReD4yNgL/foZwmK49XhaanFsj+mHDFHn
         RmXqHD7OMgqOYa/XeRwVFiRN3p3wvsvG+hrdBVlGBjcipvfjOF38HJQREjLA9PeuEIbE
         DOWtYFL+1iTKNPYN9I7AbRKTSIvTiyLnyPxS4Iv8Lw2gxr1VWY1WxHyLAQL6KawpLm/C
         B+nno0USupFn661ZkUoYvbFLNIh2eY9DmaN5qQKkjPk/JRE9/zgiywU7bw0hfWOatGal
         Y6E6al+GG8o0TjxHWfi2K46G7ZPIKqrwM9fuWUIRQ1DX4tQzpgGDHeKVZNa3ph5C9amf
         GX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724546033; x=1725150833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO1FS8VPa/Z4dflBdR/6B4C+47Hq3rtPnF2PPT/0zgE=;
        b=nVOC+iPm1w9PKP1O02WyKYX1CkufT/AZ4l45Zy3QYW43N6eXDF/VXImb48v9TDfJkj
         3GE6K4jPRVoN/fQFl2vwytgrdJ5Wwi7GdW4R8RgzLi5dcYO4muQcSM1nV7Q1JNax36vT
         CIE1d5urVoVIV0d0YIsBE5LrbBM5QDRWRex7JVHN/GzGgw4ZOoeXZZbrmaBxEVFjCcu/
         S4+bfcAQY74JFurL5/oKG/1POY1Y/n8FGd7Hjb7mIq76vUlr+z0O0fgx3NYFYKBfv8I+
         JSj0Z0tIzeXa8GjgfUF5+8KFvo5/zlLvtEc3JMWXkw9UFs9dYW9aEgX25TQreDLbiyxK
         cxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMh4I5d3jEIzygYlTEL4e1VH1e/tZkVfQwVdI3nOHJU/f9OUfOLtPDPHYf5MN/miP4wKsh32dR@lists.linux.dev
X-Gm-Message-State: AOJu0YylqKMUut9Y/jlM+jOip4gPwQdHN0iBR9ZAU4/hNIwWCHc3ZTqf
	UR2RoJ6WqOb3Vi38j4TqUFNu4B1uTqwNpv6QykpBvSmND3GmCYkHQgT/RuV51pppZsq+nS9aCXB
	fuPBotpePHCpXAPWqNv8nGQTCaBM=
X-Google-Smtp-Source: AGHT+IEqxhqc6p4zKFBh7wa1cKT9tUhA3HM8jeTMaAhna+lfbs4CP42yBJIBxSGcJ6AviWUvOqcKSFVUc28qnVStZ0I=
X-Received: by 2002:a05:6512:b86:b0:532:ec7d:9c67 with SMTP id
 2adb3069b0e04-5343887e143mr5833204e87.47.1724546032803; Sat, 24 Aug 2024
 17:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com> <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
 <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com> <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
 <CA+K1mPF9w=QuXFpAsgZQqRj8OjyHNzw9znmpUGNSAcRFgs9hgQ@mail.gmail.com>
 <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com>
 <351a2c7d-4fe2-43a4-ae87-045b194f1919@siemens.com> <CAFLxGvy0Z3TPYN8psZBXSB-idpJbSr+TQ69JguqiGNYaWM3KRw@mail.gmail.com>
 <CAFLxGvw_m1ChknHFRYHSGVjG4vDYOZahfS205OCv7LwRiOSPPA@mail.gmail.com>
In-Reply-To: <CAFLxGvw_m1ChknHFRYHSGVjG4vDYOZahfS205OCv7LwRiOSPPA@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Sat, 24 Aug 2024 17:33:41 -0700
Message-ID: <CA+K1mPH_6SBO2YJt1eta7HFMmsYeoia+qNvFd1mpUUG+ZqqkAw@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:43=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Thu, Aug 15, 2024 at 5:58=E2=80=AFPM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> > On Thu, Aug 15, 2024 at 3:30=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> > > Thread termination has nothing to do with socket closing. It is still
> > > the process that owns an file descriptor, not a thread.
>
> After playing with demo/posix/cobalt/iddp-sendrecv.c and modifying it
> to work across
> two processes I'm sure we have a little problem in IDDP.
>
> The setup is:
> Two processes(!): process A is the IDDP server, process B the client.
> So, A does recvfrom() and B sendto(A).
>
> If process A terminates, iddp_close() is called and a subsequent
> sendto(A) from B will
> fail with -ECONNRESET, all good and expected.
>
> The problem arises when A stops consuming from the socket, the buffer
> fills and A terminates
> while sendto(A) in process B is active in __iddp_alloc_mbuf().
> At this point B has a reference to A's socket, so when A terminates,
> iddp_close() is *not* being called.
> And as a consequence ret =3D rtdm_timedwait_locked(sk->poolwaitq,
> timeout, &timeout_seq) will not
> return with -EIDRM.
> Since the default tx_timeout is RTDM_TIMEOUT_INFINITE, B will block forev=
er.
> --
> Thanks,
> //richard

To clarify: the test case was originally two independent Xenomai RT
userspace processes, not two threads launched by the same original
process.
Also note that an explicit close() of the IDDP socket in process A
(before exit()) did not help, process B still blocks forever.

Using a patch from Richard, I was able to work around the original
problem of blocking infinitely. Essentially the patched iddp.c returns
-ENOBUFS when sendto() experiences the transmit buffer full. Process B
sendto() then does not block at all (I verified this on an
oscilloscope). This is the desired behavior.

It seems to me that at present the IDDP sockets do not exhibit the
correct POSIX behavior in the above respect. This is the case in
xenomai-3.2-stable.

Shall we submit a patch to correct this?

thanks,
-C Smith
