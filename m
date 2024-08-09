Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0CE1946BA
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212543; cv=none; b=O1mLT6DHor9oebwY2EjxSM9BKixHcSDgbD4IQ/LKYJYMVthbaW2D7fV7Ec3HjgMYMnFeHg28IxGU3/aEW40c3e1r8BYnxiFTeipd2TKxSRTuS9y3AtheZvqHLKTkbfCsGFwEf65dNmIYdfIemtTz1VKwv45qp77P3HSPjMrBOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212543; c=relaxed/simple;
	bh=CNCecEHCOuYpAyVXUQdkDmEGg5Eq85lUU5EniUEtTMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOYJjEPbD3CuaVQTrN2OdCcpglda2Wpnd2cndrtGlzbxp5yrJiji0by96IaSRRX1AJPEzRsjDBUUUPofjgKbWq3SAOhQeMvtoo3/Vi0GrKX2Ch8joTiaz/kjzYfOb6Gj5pQPauTdvCGWPjaXHGAR5i5e1+dKhF1TmVKEGlKVUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9KDcI0Y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9KDcI0Y"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so1697650a91.1
        for <xenomai@lists.linux.dev>; Fri, 09 Aug 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723212541; x=1723817341; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvOL8/VDOyxr+vxXvsoZBfGNVTsKVaJORxKoFHykzSY=;
        b=B9KDcI0YYSQDvYxFIJo1Nxnlkr4yNDH/uN9N2KfNWVoE2zwZUdjBmKaSThuzleOsaw
         85zttVa6e24LFf1tD6c8G9iSBRbVL5VusQ3jqAtsSU6ZR9DyXME6Q8abmrf4Hc0/PmsN
         yTrs5XkD6NpbBhsxgZMOcZ9buE/ixIB5YP5ORNT3zvYbOOjYKzjeNoblgWOrw/mtHPDg
         MSr3TdhSpL1ppztnlXehokE/NYsMVeF3zuNc9L+WDXeUar56aTzchG1VcPxS+LsrDiu+
         gqcn5q2BQ1wPnB2bZUWPYrIocJBOBFR84EnpF5/Qmc1mEiO5H7RTxn/g/VMfYuDH3RxC
         3a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212541; x=1723817341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvOL8/VDOyxr+vxXvsoZBfGNVTsKVaJORxKoFHykzSY=;
        b=axUwxATmucnfNloxlL1Elti0ZbArkY4H64IchAQ7xFtmGKvvJYG/bPljIRJ1p/xm1I
         0hlwRucy1eC2gCFYOZ7mmLBxMHIJaJr0ifEV/nPdF7abZMFUbz+XsVVrXnLfUv6M8Upo
         5pAy1anBnVuP4RGXCcpQNi0z/sXGHhKwuVrOGI+9u/cSzOsji7w1eM+sLTL/qXPS4cHH
         NJ0YLKArcmqGBPQY1XpzFY/wFNBgM2ea4lhlk7nqLsT5+Hz+6e+MGDLKPslg6IWKpYL4
         rtFyt3XB9ETMrA9dMZIEZO5382Vd1LGwmSLiJ8vJzVL59Ii7EH9ny18QB2o/7jRnAGnF
         ViLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+m5GGX04IRB+bJJceURHBicBTFbAXXiHpSZKXkBGgJq0inVhDkX/hg7hFB4H+uNiMJ2OpmMUDp010/d2R3vvuUMsRKRM7xw==
X-Gm-Message-State: AOJu0Yzx9UcG9JQOE61WPHp5Ut4YQepfnviuBB0gWTHk2MUnpkI+kvBU
	v88TcVl354uPMNdZq5BDbOE4yJ7Z+RrJdbs0AZlsOWrKQf3G2Bh694uhHohFCS7Fe6dm9RHw/Om
	21g+bbMTOtEjIAYuhATD7xXs/8U8=
X-Google-Smtp-Source: AGHT+IFRgur2w/1/JV6GWzHgFGFo6hBzGFvVNniGye0b6l2V84lCd/wcPr+p1azre4XSXhDTpvwFBt0IB0sss+6Pg3I=
X-Received: by 2002:a17:90a:2e83:b0:2c2:f6a2:a5f7 with SMTP id
 98e67ed59e1d1-2d1e7fc6bd8mr1899966a91.13.1723212541547; Fri, 09 Aug 2024
 07:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com> <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
In-Reply-To: <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Aug 2024 16:08:48 +0200
Message-ID: <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:50=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> This confuses me.  So, if a thread dies without calling close() on the
> IDDP socket,
> RTDM will *not* run proto_ops->close() implicitly?
> (The source indicates this).

Well, I has to be like that, of course. It's all within the very same
process. :-S

As soon one side of the IDDP socket vanishes without closing his side
of the socket,
the other side will block in sendmsg() when the buffer is full.

--=20
Thanks,
//richard
