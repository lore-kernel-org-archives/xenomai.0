Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B3253AD
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 14:52:16 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-345fcf8951fso17823075ab.1
        for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689605536; x=1692197536;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txmBCShHgjgvSA5sBdqBiKWvozV06NBsPHqV509My5s=;
        b=dcVeIFFqkusr4LnZ0yYyMySCa1ervvgSINlvVZuSjmWv4ythb935PBVcdB5vw6f+ec
         efje5pw/1Gyijv/w1HIZgDN/R4e9hQIhENaa6P2yYjDd2sGzrlZm+4r/1JTk28tpt8ZX
         lr2dzXe0LPb12/GNoTb20FB3qaVbn7hM1jkNwL4qAKoylyq6SqRqpalrEbngO0Pr6LGD
         5ucJU3so9tE9zjsq9p1oV8SuRBVd655YORc22Y0eNC9jhyHPJiS5wJ9jWcw/EwAjfe9j
         EXyc8klOYERgLk/L5yNoQiIIQVfpTAWbeZ1RK8OZV8rAsTuKFAU+2/AnXv7xm8LMYTyC
         JBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605536; x=1692197536;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txmBCShHgjgvSA5sBdqBiKWvozV06NBsPHqV509My5s=;
        b=HJjjwyzmlmDhzGgbRd6dQ5STlly3Nw1fEGMSHP21gt8OfpoOb3TFgE3h/wldipgn/U
         p2AqusFXA2M5Lyz90lpxXB4ed7xSp1ouufNGVeplBjIxXF+HxeB74sL55PvFFyUQQI2e
         /E/SpBbwReUMW5XjWCkCDWm+LlAlLs3csV0Rs1UkbCYpZ/JkLv1l4zEnhAJcF1vumgJv
         /ypvEqJKCLg4sWSfmf0RjZC0RvVQDXubu7ZbfDqef56MwidBqabNhMSXx7BFhGeEdP7t
         g6s7gulCbVsY6hNl38XY2IDuMfioF6OFcG0rER5tAiOX37ngJ+/MKC/Jlt8KXEtZSz16
         k9eA==
X-Gm-Message-State: ABy/qLbwPnEEzBLUMA2WePWJIHdsH3xyra4gGX6pg8j1OvRRRAEhdlXW
	QSlZjpHxPGPrR8sPqFC1ZT4GFCYfwhb7FSqtIMlB9dJ41vo=
X-Google-Smtp-Source: APBJJlGfrJcXxClJgEeLK7VW5XEzD1eip1sFQr4q5MJooUw0gM+xJsAAJXBQaLICIoMpmR7gKiOSWVOQY49Exo7sFoc=
X-Received: by 2002:a05:6e02:214f:b0:346:24c2:4f87 with SMTP id
 d15-20020a056e02214f00b0034624c24f87mr7990ilv.32.1689605535827; Mon, 17 Jul
 2023 07:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
 <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
 <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com> <CAH0t8y2U95PXRT4xNKm6fO93XNwrQD4V4MbaQu1B3V6SAQWVmw@mail.gmail.com>
In-Reply-To: <CAH0t8y2U95PXRT4xNKm6fO93XNwrQD4V4MbaQu1B3V6SAQWVmw@mail.gmail.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 17 Jul 2023 16:51:38 +0200
Message-ID: <CAH0t8y321gcc59b_GBtgtwqK8cqSuxcOZu5FHgm78WSoMB5Qzg@mail.gmail.com>
Subject: Re: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > > Dear All,
> > > >
> > > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2=
.1.
> > > > It works fine. I would like to upgrade to a more recent kernel, but=
 I
> > > > run into a kernel compilation error very early:
> > > > >
> > >
> > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x =
supports Linux up to 5.15. If you want to update to newer
> > > > Linux versions you have to use Xenomai from master branch. There is=
 no
> > > > 3.3 release yet, but we're working on it. We already discussed that
> > > > "missing release" in our community call some days ago. There are so=
me
> > > > features pending that we would like to integrate. So: stay tuned.
> > > >
> > > > Florian
> > >
> > > Thank you!
> > > Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> > > the current master in a "working shape", or should I wait for a
> > > release?
> > >
> > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > time, Xenomai support included.
> >
> > 6.4 is just a normal release and will vanish once 6.5. is out. We're
> > testing that in combination with latest Xenomai already (to make sure
> > we stay compatible) but we do not plan to support that specific release
> > over the long run.
> >
> > Florian
>
> Thank you very much!
> Tamas

I downloaded the latest  Xenomai master branch. I compiled a new
kernel (6.1 and 6.4 behaves the same way) . The xeno-test fails:

./xeno-test: line 100:  1746 Segmentation fault      (core dumped)
$testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
pattern_check_rounds=3D64
+ start_timesyncd
+ true
+ systemctl start systemd-timesyncd
+ timesyncd_was_running=3Dfalse
child 1739 returned: exited with status 139

Am I doing something wrong?
Thank you,
Tamas

Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2023=
. j=C3=BAl. 17., H, 11:49):
>
> > > > Dear All,
> > > >
> > > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2=
.1.
> > > > It works fine. I would like to upgrade to a more recent kernel, but=
 I
> > > > run into a kernel compilation error very early:
> > > >
> > > >
> > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x =
supports Linux up to 5.15. If you want to update to newer
> > > > Linux versions you have to use Xenomai from master branch. There is=
 no
> > > > 3.3 release yet, but we're working on it. We already discussed that
> > > > "missing release" in our community call some days ago. There are so=
me
> > > > features pending that we would like to integrate. So: stay tuned.
> > > >
> > > > Florian
> > >
> > > Thank you!
> > > Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> > > the current master in a "working shape", or should I wait for a
> > > release?
> >
> > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > time, Xenomai support included.
> >
> > 6.4 is just a normal release and will vanish once 6.5. is out. We're
> > testing that in combination with latest Xenomai already (to make sure
> > we stay compatible) but we do not plan to support that specific release
> > over the long run.
> >
> > Florian
>
> Thank you very much!
> Tamas
>
> Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont=
: 2023.
> j=C3=BAl. 17., H, 11:46):
> >
> > On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > Dear All,
> > > >
> > > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2=
.1.
> > > > It works fine. I would like to upgrade to a more recent kernel, but=
 I
> > > > run into a kernel compilation error very early:
> > > >
> > > >
> > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x =
supports Linux up to 5.15. If you want to update to newer
> > > > Linux versions you have to use Xenomai from master branch. There is=
 no
> > > > 3.3 release yet, but we're working on it. We already discussed that
> > > > "missing release" in our community call some days ago. There are so=
me
> > > > features pending that we would like to integrate. So: stay tuned.
> > > >
> > > > Florian
> > >
> > > Thank you!
> > > Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> > > the current master in a "working shape", or should I wait for a
> > > release?
> >
> > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > time, Xenomai support included.
> >
> > 6.4 is just a normal release and will vanish once 6.5. is out. We're
> > testing that in combination with latest Xenomai already (to make sure
> > we stay compatible) but we do not plan to support that specific release
> > over the long run.
> >
> > Florian
> >
> > >
> > > Thank you very much!
> > > Tamas
> > >
> > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91=
pont: 2023.
> > > j=C3=BAl. 17., H, 11:15):
> > > >
> > > > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > Dear All,
> > > > >
> > > > > I am using the 5.15 dovetail based kernel together with Xenomai 3=
.2.1.
> > > > > It works fine. I would like to upgrade to a more recent kernel, b=
ut I
> > > > > run into a kernel compilation error very early:
> > > > >
> > > > >
> > > > > In file included from ./include/asm-generic/xenomai/syscall.h:26,
> > > > >                  from
> > > > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
> > > > >                  from ./include/xenomai/pipeline/pipeline.h:12,
> > > > >                  from ./include/xenomai/cobalt/kernel/lock.h:26,
> > > > >                  from ./include/xenomai/cobalt/kernel/sched.h:23,
> > > > >                  from ./arch/x86/include/dovetail/irq.h:12,
> > > > >                  from kernel/irq/pipeline.c:17:
> > > > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal er=
ror:
> > > > > asm/fpu/internal.h: No such file or directory
> > > > >    44 | #include <asm/fpu/internal.h>
> > > > >       |          ^~~~~~~~~~~~~~~~~~~~
> > > > > compilation terminated.
> > > > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] =
Error 1
> > > > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> > > > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > > > >
> > > > >
> > > > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in =
all
> > > > > combinations, with the same result.
> > > > > In kernel version 5.15 the arch/x86/include/asm/fpu directory con=
tains
> > > > > an internal.h, but I cannot find this file from 5.19 and above. I
> > > > > believe this is the cause of the error.
> > > > >
> > > > > Please help me. What am I doing wrong?
> > > >
> > > > Xenomai 3.2.x supports Linux up to 5.15. If you want to update to n=
ewer
> > > > Linux versions you have to use Xenomai from master branch. There is=
 no
> > > > 3.3 release yet, but we're working on it. We already discussed that
> > > > "missing release" in our community call some days ago. There are so=
me
> > > > features pending that we would like to integrate. So: stay tuned.
> > > >
> > > > Florian
> > > >
> > > > >
> > > > > Thank you,
> > > > > Tamas
> > > > >
> > > >
> > >
> >
