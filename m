Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE22550B1
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908071; cv=none; b=WJCbqros+JJIid8tEdI/+svrpsngPT/HD0jU0FFBXkg2wJgKKcH7qvRBlNL6WszMbYih5JIDZdd2dF6zL4RyIr+PQxqVy9eAhREERm2SE1ry94qd0Mq64NqG6x/wteMXIDa0NSCg1BGF3c3JMz/XEr0ERLQDjAhHKNLtX49mo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908071; c=relaxed/simple;
	bh=JLv5ZdQEIEy5LLGX5vief6VYZHsoSNhxg0Kto0Mj3xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNLSij5/y+2pdqaPKvNPmqbhdRVO1rWG28hG9l39exUIlwTRC+82fx+cQ8/gKqnozxX1lXEFq8jZUsaBfqqtF6rbJ9SGkmKCwrL+stEuUKrxvpxOTC+JIo8YY7lV4FUsQ3Kv3/ML8jFmzuKnC90p8OfqgE0ZiSi4vXlgzb0sHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz9hWb09; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz9hWb09"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso150931066b.2
        for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744908068; x=1745512868; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uJleS5KAP31Yr/YN8pI/uaw/SwU8cWi/2lwHvxpw8Q=;
        b=Nz9hWb09E6rigmzFzvKm3hO61oqyRtA+UOzp/i2iffJ1QtcUbfeJ7bVFJv3xtbHll5
         tJvYqyyp427Aaa3HZG5HQX7jfNhZ+gk0ycjXH/WyTgxDBz0cZO2zJHlSzdnjxaphKiXG
         GGjnXSJZNGuniqkKrf7DfnQCJXlyHD9cYVVqQr3wNbbXzX6aMY9vOpq/qVL9oDHIAD+i
         so63bzobaGfoHWkkXlUBeu8YZ1EvQbhS38E8Qwh8vZ/cfnLSM7sYLQi9gSHQuA/j5u4i
         8yNxyg1xpchEI8jskfaMiwi4rOeBZ9fJxldmXSH9p+tIDaMWA71qmLdpTe7KBWHV1f0N
         JD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908068; x=1745512868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uJleS5KAP31Yr/YN8pI/uaw/SwU8cWi/2lwHvxpw8Q=;
        b=S1eOIasolKchvEKwhBdSZkYNXVeQrC7YpX8ectrSSPWp5+Dpu41Y2feCUs72UlAx5t
         8M8kUCslRWiHjrXHLBq0di+enkWZBv8Y87xFm3mpgEaQYLZi6EW8qGouPYstQsb+S/qT
         z3Krsiq0JoHCv52RZ47YFqNyKTQSxqJESv/3IkmTlkZsYi6necf28jv+Bz5cJlDs3z6Z
         p5VpYegTLmyrGsTC752yMh5DN2ezzBXJnyrysd21AsIBeblVamLYVpxUAxpWyUrZfEY/
         d8ZqjwZqpRTXoPFuDj3foygE15quNMng66KPSnnHEwt0z4nyrkPhHLRG1MLLRsbySg7A
         Ofdw==
X-Gm-Message-State: AOJu0YwfK/f8Q6nhAoKE3g5QTt8rUU3UDKZQraw/VXAWo9Xuqm4pQhol
	gonpr69NqiwrFITVJ6PKBMLJ8kKNN4pBo3EWREfSQYfqgbSFw/vpv+gPsvaILSCVUfQ4bWdKsym
	nRD0C43GOVWIpV4DUODJx7L4sLNe0dVx+
X-Gm-Gg: ASbGncuBi6GO3/xq77IWRLCFSqLKZ4lP3ORvlHyVNJAXebyuvFyAkkuZ9Z09DjJN01p
	WTJUalDdIr6qbVqkPl7jONYE0kuSRGVovh6eMGjEe/X0zKtM96/Y+Af3pYm2437/KMyvAA2wGEB
	KSOPOfLY6/RYkP+Z4i6fdnE77Y
X-Google-Smtp-Source: AGHT+IGFAd2BPw3SUY0YFSJFZKk3eTZ/Ioqc7uF1bCkzywqj70kuny9OBTA9SvqhzR3QcFjDtdnNimbogE634xhpUJg=
X-Received: by 2002:a17:907:97cd:b0:aca:c532:cf07 with SMTP id
 a640c23a62f3a-acb42a03b46mr550115366b.35.1744908067442; Thu, 17 Apr 2025
 09:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
 <f76f5f55-a793-4fb4-9870-770adad60c2c@siemens.com>
In-Reply-To: <f76f5f55-a793-4fb4-9870-770adad60c2c@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 17 Apr 2025 09:40:54 -0700
X-Gm-Features: ATxdqUFhcC8MIXNJAlclxIrgT_CE4XWSYSdbk02S7uZQKK49m2NDBySpKHLMplo
Message-ID: <CA+K1mPH9ddmD6wSXLfrs_SqPRhcsJQtMrv2Q84ri5SrU8xHKyQ@mail.gmail.com>
Subject: Re: select() sets -EBADF
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 1:09=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 16.04.25 20:26, C Smith wrote:
> > I am having a problem with select() in a Xenomai RT Task. A valid file
> > descriptor is associated with the serial device but select() thinks
> > the fd is invalid. A snippet of the code is shown below:
> >
> > struct rtser_config Serial::serial_config =3D {
> >     .config_mask =3D 0xFFFF,
> >     .baud_rate =3D 115200,
> >     .parity =3D RTSER_NO_PARITY,
> >     .data_bits =3D RTSER_8_BITS,
> >     .stop_bits =3D RTSER_1_STOPB,
> >     .handshake =3D RTSER_NO_HAND,
> >     .fifo_depth =3D RTSER_FIFO_DEPTH_8,
> >     .reserved =3D 0,
> >     .rx_timeout =3D 250000,
> >     .tx_timeout =3D RTSER_DEF_TIMEOUT,
> >     .event_timeout =3D RTSER_TIMEOUT_NONE,
> >     .timestamp_history =3D RTSER_RX_TIMESTAMP_HISTORY,
> >     .event_mask =3D RTSER_EVENT_RXPEND,
> >     .rs485 =3D 0 };
> >
> > int rtser0_fd =3D open("/dev/rtdm/rtser0", O_RDONLY);
> > ioctl(rtser0_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
> > fd_set read_fds;
> > FD_ZERO(&read_fds);
> > FD_SET(rtser0_fd, &read_fds);
> > struct timeval timeout;
> > timeout.tv_sec =3D 0;
> > timeout.tv_usec =3D 250;
> >
> > int ret =3D select(rtser0_fd + 1, &read_fds, NULL, NULL, &timeout);
> >
> > The expectation is that select() will unblock once data is received,
> > with no errors. However, select returns -1 and an errno is set to
> > -EBADF.
> > My app prints the strerr() below:
> > [ERROR] 10.746 ms IO Thread Select Error: Bad file descriptor
> >
> > To verify that the file descriptor is valid, immediately after the
> > select() call, a read() is performed and valid bytes are returned OK.
> > Why is select returning -1 and setting errno to -EBADF when my file
> > descriptor is valid?
>
> Did you double-check if the cobalt select syscall is actually issued?
> Maybe there is some wrapping problem.
> Jan

I single-stepped the select() call  and indeed it goes into the cobalt libr=
ary.
It was this call:
XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,  __readfds, __writefds,
__exceptfds, __timeout);
which returned -9

I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281 (I must
develop on this version of our product, BTW)

thanks  -C Smith
