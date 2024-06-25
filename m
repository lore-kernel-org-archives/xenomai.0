Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB890169AE4
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330539; cv=none; b=F17oY5HtbQQ41hzkaGEzP8olVI4eyvTGicYr0FmvQWmKVwX0bn6a8SvZEWWpY5NIQfbITuu5pkD7RiLV0w2m6Pe8gelIfdqHUhzLCKKctrou6oci8o7Fpe81KwBjaUwx0V4yROpOVXUxaLT9lmXHFm7wAIRlp9Z+IN7le0EciGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330539; c=relaxed/simple;
	bh=w+u3IDZToh5KxjpqQxfRp2yGsAlyTzO0jc3Ta24qRjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUxS63zoT676xWGgdxBcJSMgoHchGzfgnK45PPjtgQptiUn3EEM2yAZ9FaWYDj4wSMDCbKMevtpzi1lyD6eMeUM9RsWPoP5scFvRA1RwVASWP2R93YuIhHOXeJcYLIeGO8MCNJS3I9AgKInh2K/oF9mDe0BR29VmNOMkZOEsF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=nce9Xjar; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="nce9Xjar"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so4808563e87.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719330533; x=1719935333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvWR0SN0+iHi/vVdzJlYvoOb4ee6okT5mVm57aZTbz0=;
        b=nce9XjarzlQmyRzljXy3sWBjSgTVPGWvWGPwqA8n6GCWDpZYKJdVm1venlqtjpA/wU
         zm/9toFcLEms6iGkYnAZ0NyyIUuK/RFCxUP9MiJpXEAedBVH+ufc/c03KS+2lEowoy5d
         LXTsby8H7lxfa6/ZWx1o8WZ1XbZ44WoTgUqFFNDrJtrfmG9McEkfZTX0WYtjgn5A0WAf
         FRgtrZOVeaVXhaKMnyoiQG4CxQ+YORddUyw8LqPlxQaaF+EjU0n0ZYAHCA/ewdAlXnSN
         gfgiFStjUxAbBXbNHJvRtiBQt+KBe71lWfZYCuI8k1yl2j+tRftvcqdUF7nFYKFhSEVM
         XGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330533; x=1719935333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvWR0SN0+iHi/vVdzJlYvoOb4ee6okT5mVm57aZTbz0=;
        b=vVFNR7z52IuzAcM1TLqq6N38YNFKHi0P8aaBWB3QBKFtMJdOxD3XRDdh+C4IA1ECFX
         hQfiknw3AR7WCsC9EtA/4JBdAPfpucr+SfLfIT75aKL2kZt9S9RvjMwu5iJNbazqTEzy
         mJUE2GIJpAiWVwuOByeomEG7HhNguiGL/5C4hFK7m93UnFgY397sEHMDXss8XRB9ABns
         N28OvhuPN3+RE5EaYvst8BJQMPXcep4MbqtLIVGu2UYrLUE8T5mK64r1amVyG2+pNCzK
         ze5ghtt1im0kS36S0lcfK1tvIMT7gUrhwHOfScSo0jRkWZTTJE2PnldlcXoRwUrKiz5X
         6PDw==
X-Forwarded-Encrypted: i=1; AJvYcCWdwzkj08nP9fhg7eoy2X2ZqQf9K2hS7XID7W9Zc3w8JgZ7qMA/tH5D8vOFCdKr/fjKNPCwIz6+avkaFZvJtLZPbmvQDl2EbQ==
X-Gm-Message-State: AOJu0YwXI/8VrabYe5mX8MVxdXJ4COkGUEfTCqpE3YRxScFEaut4fevI
	8bod1oEp7gvV+NrdQgDWkVYzbxiCFzEDVpumnueMjr1n8Klvt1XuHUfUFf9SFEQ=
X-Google-Smtp-Source: AGHT+IED1kwcQd+voj8FHjjle/3fyxjGVjZN4TLrcumBLXe/42UoxztsoB8zoIZjWryeSHo2n7Mu6g==
X-Received: by 2002:a05:6512:34c5:b0:52c:dec2:a759 with SMTP id 2adb3069b0e04-52ce1839866mr4514927e87.30.1719330532737;
        Tue, 25 Jun 2024 08:48:52 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm13354988f8f.73.2024.06.25.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:48:52 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 02/14] prepare-kernel.sh: Add reverse mode
Date: Tue, 25 Jun 2024 17:48:51 +0200
Message-ID: <19323420.gIjEHFZm8d@somecomputer>
In-Reply-To: <393ed939-97f8-4f53-a719-6f6723e50d97@siemens.com>
References: <20240624203341.6263-1-richard@nod.at> <20240624203341.6263-3-richard@nod.at> <393ed939-97f8-4f53-a719-6f6723e50d97@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 25. Juni 2024, 17:44:47 CEST schrieb 'Jan Kiszka' via upstream:
> >  if test "x$output_patch" !=3D "x"; then
> >  	if test x$verbose =3D x1; then
>=20
> The reverse mode is missing coverage for init/Kconfig. Only patch 14
> introduces it. Fixing up while merging.

Hm, must have happened while reordering patches.
Sorry for that.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


