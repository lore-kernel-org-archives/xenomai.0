Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BF154C0C
	for <xenomai@lists.linux.dev>; Mon, 19 Aug 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055445; cv=none; b=GhFuZSeQdTcFI8AJd+k37OWRWBm01EnuhrbpEV8YzBOJhtZ3HgDWwRLiQ4vSCLL1pBtA4On2ZJxb9o4cvxqJUyj5wU2f0fyIGmo2Zlzu5QP47SZ/blEpGvwFCOPO59GgU5IeRPqThvNpjvsr+xBy3T+B53vtPgb1QFgbrRQazbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055445; c=relaxed/simple;
	bh=MlLyXCNzxtwjZrWCmx2B/e4sA4mEUsneMPMq0+/HFKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMBaRpiuTA7cH9Mfs8jxXzciwd19X5Uo2GNL1hC88X5qjgh8Ku/Cxkoh5XrNYL44yzQnLZNLu7DQr4e1A2gHwYAzttet+s90s4iIi/dhFq9ogQGDx12o5JlKtOgArUmyskhzYRWIB1vby5LR+I/PiKOe6md/MXtX+91Eq6xmF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZAwSh4l; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZAwSh4l"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so2828876a12.0
        for <xenomai@lists.linux.dev>; Mon, 19 Aug 2024 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724055443; x=1724660243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlLyXCNzxtwjZrWCmx2B/e4sA4mEUsneMPMq0+/HFKs=;
        b=kZAwSh4lV65hNWP1m6NW9f3bW/NyslLzbbAPZYEvmJkgrgLsttac0Sjnq/aWpzplWJ
         6Wu9j6clSOC7zZKhvBwd3tqSBe4BE/TqdAyvWsUNyCGwj8fSFm5Quu+G3clsxORQeLqv
         r76PRG3/tQcaKV2duoyqVISqD8qK4eV8JMi/nmmVMNrim4dLueYgOo+DQEv1ACgeWlZO
         h+B+Lb07ZJ+0ZO0MZ8hZ3Bv/dP41Ge3kffKOmqamY8Z+MVtw1hfBpXRBSEXB84nZq7+W
         fker0fg0nDwEXJDY6+J62vRNu8KRqZw8wM/JhQ4JNNC6VbeJVlkbUdLYN7j3IQ75V6w3
         uiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055443; x=1724660243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlLyXCNzxtwjZrWCmx2B/e4sA4mEUsneMPMq0+/HFKs=;
        b=d8AHZaDHIdDkJ5s4wSoyNVxfYgeZefVPNoN2uSHoqbCaDGZwnktDpwwIQ/KQDpLSXZ
         AlboihcHVKMFE7Xr5XrjkpJQDPsyEcvYVdLlz6VPbzIEKLD615bTXmU3JG0mOMONDlqw
         DYgaJA5kgWy7v/zp8xeIhkkBD1fUmA8p/FxJOCa2wTq5HiCb9gxiu0J0FWbt1QO/ZsXz
         UutkWw3qQ7DoNEmLy3HoXfqkD75A0bReIagVx7YjyHZa/2+3adJMswKDGKkWdudmzHRF
         EkWbkio4fWUg/Fl1a6lByn6ZkHqhTaWFiYHhi+MWEnf5/GCz0dpsAIRPiVlA3KdiQIfy
         egXw==
X-Forwarded-Encrypted: i=1; AJvYcCXa+dcppgyljuRA5A0WhptiwukjOJFA/ELvJbPLVtorjfhn7+rI7ZXDjyFiiCdDOAseBXwKvCgWDdYfKzf1xPo3aSlQMfDZUg==
X-Gm-Message-State: AOJu0YyhuKC0UAji5jxJkKrmyJssqumHZ81yKIYuHvIJqVUZoGrA49lc
	wg8Tbb4g0/ovNcKPqS+KZFaBLzjbaoWwFP4w2OkVGcByHYq+MX9HkdHvFE2IbzsHPZ+frAX54Yn
	vwTe5h9IAz73rkEhF1U8arYPpFNM=
X-Google-Smtp-Source: AGHT+IF1l+yHphA9rIXwa+WlVBx5MGUqTZr/zhRWfIEQKL2plJ0phR+9h5pjqA88Qa2TJgIm3270aAY5jLn0njzPMOA=
X-Received: by 2002:a05:6a20:d70b:b0:1c4:d4b2:ffe5 with SMTP id
 adf61e73a8af0-1c90507af96mr12731121637.54.1724055443491; Mon, 19 Aug 2024
 01:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
 <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
 <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com> <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
 <20a24332-f53e-4b98-a3ed-fff30d711fb1@siemens.com>
In-Reply-To: <20a24332-f53e-4b98-a3ed-fff30d711fb1@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 19 Aug 2024 10:17:11 +0200
Message-ID: <CAFLxGvzZKafKjsrwBXb4UUp7fAKp5mYMeOb2dmTdB9jz6sY-jg@mail.gmail.com>
Subject: Re: Xenomai Meetup at OSS Vienna in September
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:09=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> Monday is reception at the sponsors (https://sched.co/1eYej), but only
> till 18:30. Tuesday is all-attendee reception.

Then Wednesday sounds like a good option. :-)

--=20
Thanks,
//richard
