Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71E18E34A
	for <xenomai@lists.linux.dev>; Thu, 12 Sep 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133923; cv=none; b=AfqzrAfO9/ED7SxFlZBcF1GOL71n3bKSfnQDBiwDp+jhKZb2CGzzNSqB+tXFFjOK/QIQWmesFHFYtCbNqtziRdlBy0Hdvazs+ga6zfCoFKwEh16kYnsenFD3JUgdZ+nJsxPp61ibX+UbxV73cofeSxw9WRj0WPuhUj3IylxR9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133923; c=relaxed/simple;
	bh=hMRPGBa7A+JtUYxYCAFGxnQT9RQHASo+MNCjNXnQoCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pbO0jm9mN3Icf94qrntALSZ7Z6HMttT15d+S2oCarDQ5vaGiKUeCprJv26eA1B0wp5P7FWqhBA6LNipGykCUg1xbZ4jxHokMFtHXatc6K/00OyIBXRr33pNaIsRU1J6eMmRqajM+gosR4e/gGy356dWEFaejLw7EyW7HADO6qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvp9E8Yr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvp9E8Yr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so604951a91.1
        for <xenomai@lists.linux.dev>; Thu, 12 Sep 2024 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726133921; x=1726738721; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMRPGBa7A+JtUYxYCAFGxnQT9RQHASo+MNCjNXnQoCE=;
        b=fvp9E8Yre46yKlgUPf0ik94ufuUevI6QAvdcvYjVhKt3ZNsa2k5z3ac6B/UwR+qIoc
         ETY6NjebZzbS3R1UsVW81UHlReKOvNLLu3kuJ3il9hTk0a2A7JZvEulwvJGBK48HiuBA
         YqA1t+HkTVsFR/AhJvZuRyazQh1yAy8caeNk7KSTXhju3fiychA9U/QultwVyRFNUuZA
         WqA8D6dgKt8Lk5XZ4llb+QtL4xoXZVKjArp04DlL9hHda7bhoQAtgEqsvhn6dVcb91P3
         Ntjv8JHiVHGkq5DMn7mc2zKzNBjVHnPRRcctErE9d0bhy1/cbpi+9C03bFxernmkrBMq
         pT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133921; x=1726738721;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMRPGBa7A+JtUYxYCAFGxnQT9RQHASo+MNCjNXnQoCE=;
        b=nJNmyROO6qWXN7dr1WcwZQhtDlbP7XkN3wdV7hqXcG0ggkmomLrzGEbTcT2b3EmQQz
         z1Ww1Dhkta1N8C4n8r5u6NZeffDzPzxV/h0AS4cgBjyJxaJl/WjZh2JPEOfClagB6DXI
         z3Su8DeXI+ozGVOUT14F6WHFU7Y+a5TPTSRFTniY3iFcEVnSB/V/YZER4vbdHh4S8y20
         7cTLdbvO7seiCWBKT03Z+o5wwG3VMlNVVCyHW1vkxgPZ22x036qrOtjZYrsUt/AWMcnn
         emxxwbWOcu3AB+6ElIyOYQQCgXPYYgxhpblwFg6ZUKkBmMDbRJINzn6IAx5Sb2QjQoaq
         FGUA==
X-Gm-Message-State: AOJu0Yy9eSiah9tbK80rvu1MmHp0DC3JScsWO3Vo5jeWZzDxAanrRT6r
	W/OgXpng3PU8I+u4c3mjy0YIV8NV7gDreevIofqDIQjIeaLC5prbyF/rwOXestEt7FezXgXF/Wi
	eUAYz5PgnD9pmnZpCB32U+nje2ocUBk3R
X-Google-Smtp-Source: AGHT+IELS6LUiVzqYhaFIQOjUTJYwhQVWkRuafbBf2RJUYmHOCgYQX0nJMjjPk7zyXyPfVlaCdMIbdt+5V61I8Um87g=
X-Received: by 2002:a17:90a:e48:b0:2d8:c302:a78f with SMTP id
 98e67ed59e1d1-2db9ffe2f7emr2545712a91.23.1726133921218; Thu, 12 Sep 2024
 02:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvyx86iSB1MAZK43qMT2inBHE9ie3KzQtTpEzoctxOsSLw@mail.gmail.com>
In-Reply-To: <CAFLxGvyx86iSB1MAZK43qMT2inBHE9ie3KzQtTpEzoctxOsSLw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 12 Sep 2024 11:38:28 +0200
Message-ID: <CAFLxGvyKm9JyBxOckqcm2ddD-03-wHXujmk0RvJRtk1ZsC=6JQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Xenomai Meetup at Open Source Summit Vienna in September
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:45=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> We plan to have a community meeting on Wednesday, 18.09.2024, around
> 18:00 at a local beer garden.
> Please add your name to this nuudel poll if you plan to attend:
> https://nuudel.digitalcourage.de/kMUiqrUD6cofTEcM
>
> I'll reserve a table a few days before and send a mail with all details.

Looks like we're a pretty big group, nice!
I have booked a table at Praterwirt, it's not far from the venue.

https://praterwirt.com/
https://maps.app.goo.gl/GzkNfUKtQapha9Wk9

In case you won't make it, please let me know such that I can adjust
the table size.

See you next week!

--=20
Thanks,
//richard
