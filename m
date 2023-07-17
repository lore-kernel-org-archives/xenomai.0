Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC62A927
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:50:33 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4813422f311so1417116e0c.2
        for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689587432; x=1692179432;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcCv0vweFUe5v8YQrBIuM03gM/GB3c3Hd6Bkylki60U=;
        b=k3hyi7gAaczNpyF/I2tf58X+D2O52ZLk5nunczdN8yRc2Ag5ZLsqxVD6F5eGRAawGZ
         1jFqd6NBdeYnxtoX0DMZfUEuRcbZZPqsEUXc309geLPQqPOLG0rN+L5lTbFXQEMGEifV
         ebVxhnF9HAU7DuMvbBaLiDxhwpVAxbSYrkFgbsX8RPAVG4o8Pq3isdg7qrb0d2V7NfXt
         E0yXl3hkN4zI8NiDO+kfm4yDTr6xjni3B1E4/oXpJnSKDJj+eHWxUYxJ0PyVKJstlXBC
         cVxogVBlX0i2M6xZFB7m0P/E1xtY2tji7N8AaOAriXs+MrAmORD9A9aXWTLRE2sKrO7s
         eGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587432; x=1692179432;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcCv0vweFUe5v8YQrBIuM03gM/GB3c3Hd6Bkylki60U=;
        b=T6ZlUZ11QlMYRpZzuLXDLMrkbOiwRn7yrLb/9tfBXq254/7quzpWuoJuPkIhtBEvf7
         8jE+/BD5P2+Cg0rt+JjSrpIhJ8zTweJiek2hx5Q8wCWVAjfT8L5ntTdqGkygWzoPdj0O
         ZXHanfdGjBBhUCRvotfMJN6XglyQLklqRfa3yZRF5Zwh9LGNmKjzgToKL4WrrF0YB7LO
         eiCd8Z1HGFbLy23vAHKyo220TVrhmiLrG9pwlXrRUrJp42caYeN0Ce8Exuxcb4WBT5vN
         t5JpW4y0k5+fJqHMaslTJlxeVoBtOrYZTTmSFLma/bcIKR4W+J6B4j37ttTgJxttMp2Y
         fsJw==
X-Gm-Message-State: ABy/qLaWMZjNMC85bC7vOrQOxmjN436F2njQ2ML/cTwNNeYyi2qOxX8I
	ZQxiwb/RfTkkkMFTs5xzYJ4tdaD+R7XSJ/oU1m/lZB6e1Ts=
X-Google-Smtp-Source: APBJJlG6bldCk5Teya9sCl5Y56BxSpgGtTImF7M0tYgvIBZDDG4fSAKiSi+XkR1OPMa/08lXnB/e+xctdGoY6LeTCDg=
X-Received: by 2002:a1f:ec83:0:b0:481:35ea:10cf with SMTP id
 k125-20020a1fec83000000b0048135ea10cfmr5425994vkh.4.1689587432075; Mon, 17
 Jul 2023 02:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
 <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com> <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com>
In-Reply-To: <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 17 Jul 2023 11:49:54 +0200
Message-ID: <CAH0t8y2U95PXRT4xNKm6fO93XNwrQD4V4MbaQu1B3V6SAQWVmw@mail.gmail.com>
Subject: Re: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > Dear All,
> > >
> > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1=
.
> > > It works fine. I would like to upgrade to a more recent kernel, but I
> > > run into a kernel compilation error very early:
> > >
> > >
> > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x su=
pports Linux up to 5.15. If you want to update to newer
> > > Linux versions you have to use Xenomai from master branch. There is n=
o
> > > 3.3 release yet, but we're working on it. We already discussed that
> > > "missing release" in our community call some days ago. There are some
> > > features pending that we would like to integrate. So: stay tuned.
> > >
> > > Florian
> >
> > Thank you!
> > Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> > the current master in a "working shape", or should I wait for a
> > release?
>
> 6.1 is a LTS (Long Term Support) release, so it will stay for some
> time, Xenomai support included.
>
> 6.4 is just a normal release and will vanish once 6.5. is out. We're
> testing that in combination with latest Xenomai already (to make sure
> we stay compatible) but we do not plan to support that specific release
> over the long run.
>
> Florian

Thank you very much!
Tamas

Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont: =
2023.
j=C3=BAl. 17., H, 11:46):
>
> On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > Dear All,
> > >
> > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1=
.
> > > It works fine. I would like to upgrade to a more recent kernel, but I
> > > run into a kernel compilation error very early:
> > >
> > >
> > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x su=
pports Linux up to 5.15. If you want to update to newer
> > > Linux versions you have to use Xenomai from master branch. There is n=
o
> > > 3.3 release yet, but we're working on it. We already discussed that
> > > "missing release" in our community call some days ago. There are some
> > > features pending that we would like to integrate. So: stay tuned.
> > >
> > > Florian
> >
> > Thank you!
> > Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> > the current master in a "working shape", or should I wait for a
> > release?
>
> 6.1 is a LTS (Long Term Support) release, so it will stay for some
> time, Xenomai support included.
>
> 6.4 is just a normal release and will vanish once 6.5. is out. We're
> testing that in combination with latest Xenomai already (to make sure
> we stay compatible) but we do not plan to support that specific release
> over the long run.
>
> Florian
>
> >
> > Thank you very much!
> > Tamas
> >
> > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91po=
nt: 2023.
> > j=C3=BAl. 17., H, 11:15):
> > >
> > > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > Dear All,
> > > >
> > > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2=
.1.
> > > > It works fine. I would like to upgrade to a more recent kernel, but=
 I
> > > > run into a kernel compilation error very early:
> > > >
> > > >
> > > > In file included from ./include/asm-generic/xenomai/syscall.h:26,
> > > >                  from
> > > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
> > > >                  from ./include/xenomai/pipeline/pipeline.h:12,
> > > >                  from ./include/xenomai/cobalt/kernel/lock.h:26,
> > > >                  from ./include/xenomai/cobalt/kernel/sched.h:23,
> > > >                  from ./arch/x86/include/dovetail/irq.h:12,
> > > >                  from kernel/irq/pipeline.c:17:
> > > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal erro=
r:
> > > > asm/fpu/internal.h: No such file or directory
> > > >    44 | #include <asm/fpu/internal.h>
> > > >       |          ^~~~~~~~~~~~~~~~~~~~
> > > > compilation terminated.
> > > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] Er=
ror 1
> > > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> > > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > > >
> > > >
> > > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in al=
l
> > > > combinations, with the same result.
> > > > In kernel version 5.15 the arch/x86/include/asm/fpu directory conta=
ins
> > > > an internal.h, but I cannot find this file from 5.19 and above. I
> > > > believe this is the cause of the error.
> > > >
> > > > Please help me. What am I doing wrong?
> > >
> > > Xenomai 3.2.x supports Linux up to 5.15. If you want to update to new=
er
> > > Linux versions you have to use Xenomai from master branch. There is n=
o
> > > 3.3 release yet, but we're working on it. We already discussed that
> > > "missing release" in our community call some days ago. There are some
> > > features pending that we would like to integrate. So: stay tuned.
> > >
> > > Florian
> > >
> > > >
> > > > Thank you,
> > > > Tamas
> > > >
> > >
> >
>
