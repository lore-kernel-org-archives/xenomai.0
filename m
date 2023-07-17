Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156CA92E
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:36:47 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-553b2979fceso1701921a12.3
        for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689586606; x=1692178606;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMOnlzu7NoTihnUMUWZwBwfjetNJ8HfS4j0E6cjSOx8=;
        b=STLJhFCB1yphCI+PBpMbyyxq+x1bJBcMPQ4/292NIEOZEeFb9HCvc2palTLSTK7HXB
         pCEgIitTgomdb5+2QhVyIHFF1mgvGe+pRN0/C9/iz3pdK2D7+LrxCV08EiRZkXAMvOL+
         O/4yMEQFbMopH5fOI16OFMczdhcgovyKbg4bwgiRkmAfZMeQlQi/3f/3sHVS+iCcoxol
         0GkFa77U9/r+mmoLW6hT/DVIHtXpGJ+yPHZMdZRcYspZwEXggt1inXhRpiRoinbHoX3Y
         hwl3HvyllUotbraoDG3AALKAY05xZQb5dLNFoegiN4LjcluaChvtIpwNmD6tTKOdheIr
         Jjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586606; x=1692178606;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMOnlzu7NoTihnUMUWZwBwfjetNJ8HfS4j0E6cjSOx8=;
        b=SNrwCqONxcqH/wZS0REHmhqyBUu7WqQTq7g9bMw0PSKBANXOKzBIa7KMKtIk02V9Or
         7Su0c0B/04mjidlQNEB5SKwISvInX0+G41gRVt0fZjP+JSfxBrr6ZEc3l8+ywnjq+2Uh
         lRV23k5XPd3yexYNMArMiz7b/iCzUzFLy977XJGp79M3z+Ts3jDAvUP+8mWzozwFsjOB
         zm1yHyxRaxJMq2dlt+5eA+hUhEzwhvFJvxi7XeWoVQ32ErXLfZOM+jJKK1II1SjCVTrN
         T9Y0iY5sl2ao7AUosCgQVF2Dz8gaKpyFBu/Ygf8WmHy0YQwYnc3PWXOA3TD4oPBnKJqT
         neHg==
X-Gm-Message-State: ABy/qLZhcIfTITdVm0E5mFh1i7W+u/EzR4SBxtBxcNHHSLEw/lAnTCNP
	5Xn58UwBBxg4rwVMz/8y8x8s0K/uBuPv5mdh2aH3Wy1He78=
X-Google-Smtp-Source: APBJJlEnxixsPSEsDyGH6YRZZpa/E1EoeQZ0GsOpJC3HYuq/2M/NwN4pHRcw6yyct/K6r5aCk0R3FVF+taifPkOMIUE=
X-Received: by 2002:a17:90b:3505:b0:256:2fd4:e238 with SMTP id
 ls5-20020a17090b350500b002562fd4e238mr10039981pjb.38.1689586606588; Mon, 17
 Jul 2023 02:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
In-Reply-To: <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 17 Jul 2023 11:36:09 +0200
Message-ID: <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
Subject: Re: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Dear All,
>
> I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1.
> It works fine. I would like to upgrade to a more recent kernel, but I
> run into a kernel compilation error very early:
>
>
> In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x suppor=
ts Linux up to 5.15. If you want to update to newer
> Linux versions you have to use Xenomai from master branch. There is no
>3.3 release yet, but we're working on it. We already discussed that
>"missing release" in our community call some days ago. There are some
>features pending that we would like to integrate. So: stay tuned.
>
>Florian

Thank you!
Which kernel do you recommend to start working with. 6.1, or 6.4? Is
the current master in a "working shape", or should I wait for a
release?

Thank you very much!
Tamas

Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont: =
2023.
j=C3=BAl. 17., H, 11:15):
>
> On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > Dear All,
> >
> > I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1.
> > It works fine. I would like to upgrade to a more recent kernel, but I
> > run into a kernel compilation error very early:
> >
> >
> > In file included from ./include/asm-generic/xenomai/syscall.h:26,
> >                  from
> > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
> >                  from ./include/xenomai/pipeline/pipeline.h:12,
> >                  from ./include/xenomai/cobalt/kernel/lock.h:26,
> >                  from ./include/xenomai/cobalt/kernel/sched.h:23,
> >                  from ./arch/x86/include/dovetail/irq.h:12,
> >                  from kernel/irq/pipeline.c:17:
> > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error:
> > asm/fpu/internal.h: No such file or directory
> >    44 | #include <asm/fpu/internal.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] Error =
1
> > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> >
> >
> > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in all
> > combinations, with the same result.
> > In kernel version 5.15 the arch/x86/include/asm/fpu directory contains
> > an internal.h, but I cannot find this file from 5.19 and above. I
> > believe this is the cause of the error.
> >
> > Please help me. What am I doing wrong?
>
> Xenomai 3.2.x supports Linux up to 5.15. If you want to update to newer
> Linux versions you have to use Xenomai from master branch. There is no
> 3.3 release yet, but we're working on it. We already discussed that
> "missing release" in our community call some days ago. There are some
> features pending that we would like to integrate. So: stay tuned.
>
> Florian
>
> >
> > Thank you,
> > Tamas
> >
>
