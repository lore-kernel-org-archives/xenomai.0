Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D6256C97
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914371; cv=none; b=cYvOXmu3K6ZM/3L1NMML1Dvrwmiwhbrn4j6ytHj5Jh/8BQxFgfJeUGMY+rZuqqUWF9+ygDuZKcNbvIUehy99Eycv1X6+jNsklYn2TkuZigfNRifgTORSgzfud211CSuOJUUmF80YPlaFEDPXwB142TSK+X+2R54vXrNN8lcMrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914371; c=relaxed/simple;
	bh=fwtTZg1nmUnVUg/tdpM8sN9KqltyzHDziniVx902Fwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6fs9KGBjUfo+oUgMtpI/rHLour3ZSLt5+OO5XZHoAFHzRmpJrw5eYr3XVDj7d8C3nkPAqByMnUbxKW4a3+4zhr0nksvBmSaiX46UMlDuxnkG91sCmWkpeoUpVLzNFfj6ov0OlAogTRo50vg+sl/LXqlA7cBmILIGg2XkPLn1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuKfEkXU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuKfEkXU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2aeada833so220881666b.0
        for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744914368; x=1745519168; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzcy/FuPVkIGgbtj6rplZsziv/7PTxItz0sFcR5LmKo=;
        b=kuKfEkXUpabGrlWJTsmVQjFkQ0RyLjrk+lpRn2a9YZitRnCr0V3SxnyGgW0BnpV4iN
         0X7sly0xBB+pCssp5M4rLgSeJtWYJBqMV6/zdDi6FCGRfVILS+sxkLNwSLq9noyygClK
         KDtZozFcI7SHmsJeY5j2LLCRkGR6r3Y4MQJk2kTnRZRCwzh/ME/Lbk/Sw+llUxLUUajg
         MPNKnXJ2OwUPvhW9mcYJeNHua5y95ivgyzJIBJg6gyHMyQloob6boZyH1rGQmiquDnC3
         ru8piLSXC02yKVrW48nx3/4oUb9bOuQSNmDR0EikVwV2u79IeFdW+IpZVcYi9Od/qTWH
         OXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744914368; x=1745519168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzcy/FuPVkIGgbtj6rplZsziv/7PTxItz0sFcR5LmKo=;
        b=vnDkde3SU1/LCsioKXxy9BIKDLr7BRDvbes68ZZHj2isyxKd9pDg3sBmlpcK0P4bR0
         dnLg9K13KSaBp5BirQjp3TwTVmXh19QINn/B3/VkHvVVyUQ7hG1+RIkJx5fLQYarMg3q
         5ElMFsw/nzuHpvenQDZmyDiN0zGG/IMxBErnegryqY81j/IdEvWbEwByEenlHb32/3ug
         njPRQK5KUU79LKPfoQDxIgYeR2v6sJ5l4RsgXQtjC8U2sh3QP77UYSIOlL7kOuyAm4cw
         NNh89AGIvYEQ1DZ7NevWukzw9kkVZUaga5jol/BdSQLXaZ+sYL17yBwYFQFlB30WA/SD
         pWlw==
X-Gm-Message-State: AOJu0YysJoaiAWEQB2vfHF/HnbtRS1C219E6F2zO3LqsZDKsapATlG6X
	bEW1Qrk722ehis4laCtdYco78Z94WQSnLzSj7GeDV5IvihV2jP9S7ffbkemlt2e8FuAr5NPaOJi
	8ThhvJkTUVVBalQz1OPECtXxxTt4=
X-Gm-Gg: ASbGnctn5ZM4owjFRU0qeYSmznRZ87wUhuiNcsK5yMLYDF0oKAcCzWks8dIA0o3Hcdd
	9MkY5x6sInsHPHXv8pTVGr6vIjkRh1ElcNN4t84awpg5cAlzgvuNz7CG4xTNcLk7/wl5/jyFvQE
	4fYOImOJ+eaDYjSyrouQ30ENAT
X-Google-Smtp-Source: AGHT+IGc88bVp9rEH/PT/EaVbL6teA0W5SI/sVFIOoWT5RjYEjG6OBnpvyAyWcnEr+Vr1kVXpP/2Buxx280rMWRP0W8=
X-Received: by 2002:a17:907:9624:b0:ac4:3d0:8bca with SMTP id
 a640c23a62f3a-acb6f69e0e9mr75900866b.29.1744914367973; Thu, 17 Apr 2025
 11:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
 <f76f5f55-a793-4fb4-9870-770adad60c2c@siemens.com> <CA+K1mPH9ddmD6wSXLfrs_SqPRhcsJQtMrv2Q84ri5SrU8xHKyQ@mail.gmail.com>
 <c5cf98e8-aacc-4e84-aaf7-8714ee57ee04@siemens.com>
In-Reply-To: <c5cf98e8-aacc-4e84-aaf7-8714ee57ee04@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 17 Apr 2025 11:25:56 -0700
X-Gm-Features: ATxdqUEK_OedB1noNz1is7NIoK6qZSGdNMuvr5OLC3tpXhBqZMSktXJVCDN-17E
Message-ID: <CA+K1mPE2DqJssfXgC95Erac3Nw4xXijoC69wxxawFfYHZFugzw@mail.gmail.com>
Subject: Re: select() sets -EBADF
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:19=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 17.04.25 18:40, C Smith wrote:
> > On Thu, Apr 17, 2025 at 1:09=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >>
> >> On 16.04.25 20:26, C Smith wrote:
> >>> I am having a problem with select() in a Xenomai RT Task. A valid fil=
e
> >>> descriptor is associated with the serial device but select() thinks
> >>> the fd is invalid. A snippet of the code is shown below:
> >>>
> >>> struct rtser_config Serial::serial_config =3D {
> >>>     .config_mask =3D 0xFFFF,
> >>>     .baud_rate =3D 115200,
> >>>     .parity =3D RTSER_NO_PARITY,
> >>>     .data_bits =3D RTSER_8_BITS,
> >>>     .stop_bits =3D RTSER_1_STOPB,
> >>>     .handshake =3D RTSER_NO_HAND,
> >>>     .fifo_depth =3D RTSER_FIFO_DEPTH_8,
> >>>     .reserved =3D 0,
> >>>     .rx_timeout =3D 250000,
> >>>     .tx_timeout =3D RTSER_DEF_TIMEOUT,
> >>>     .event_timeout =3D RTSER_TIMEOUT_NONE,
> >>>     .timestamp_history =3D RTSER_RX_TIMESTAMP_HISTORY,
> >>>     .event_mask =3D RTSER_EVENT_RXPEND,
> >>>     .rs485 =3D 0 };
> >>>
> >>> int rtser0_fd =3D open("/dev/rtdm/rtser0", O_RDONLY);
> >>> ioctl(rtser0_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
> >>> fd_set read_fds;
> >>> FD_ZERO(&read_fds);
> >>> FD_SET(rtser0_fd, &read_fds);
> >>> struct timeval timeout;
> >>> timeout.tv_sec =3D 0;
> >>> timeout.tv_usec =3D 250;
> >>>
> >>> int ret =3D select(rtser0_fd + 1, &read_fds, NULL, NULL, &timeout);
> >>>
> >>> The expectation is that select() will unblock once data is received,
> >>> with no errors. However, select returns -1 and an errno is set to
> >>> -EBADF.
> >>> My app prints the strerr() below:
> >>> [ERROR] 10.746 ms IO Thread Select Error: Bad file descriptor
> >>>
> >>> To verify that the file descriptor is valid, immediately after the
> >>> select() call, a read() is performed and valid bytes are returned OK.
> >>> Why is select returning -1 and setting errno to -EBADF when my file
> >>> descriptor is valid?
> >>
> >> Did you double-check if the cobalt select syscall is actually issued?
> >> Maybe there is some wrapping problem.
> >> Jan
> >
> > I single-stepped the select() call  and indeed it goes into the cobalt =
library.
> > It was this call:
> > XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,  __readfds, __writefds,
> > __exceptfds, __timeout);
> > which returned -9
> >
> > I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281 (I must
> > develop on this version of our product, BTW)
> >
>
> OK - some bad news: no serial driver implements the required callbacks
> to provide select support. In fact, only gpio, rt-tcp and udd do that so
> far.
> Jan

Okay, Thank you for letting us know. We do have a work around in the
meantime where we can spawn a thread that blocks on the serial device
until data is received.

thanks  -C Smith
