Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81C846E
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:06:25 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so2993098a91.0
        for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689584784; x=1692176784;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=in/McsOPhW3ALiveMIop5Gy8i4Np3O/bH5xSFo1DBjg=;
        b=sZCnyh0KoyNjX2bRU9DDvHmMAiHqeqoJ40t13Tz6p5teLE4PkWvPR4uaCpFEUas652
         jyh6owNVAVTiGaflG5Q/S8rz7qzkdHB/uGsX4hL8mdE9+lykD6zTHiwYcFbLROjA2xGR
         rZvSdx2aB5KXmksAPdUh1mxrunk3FhFJwpE8qE2QnR8fNTZvwAjOSo7Jy8nMS6624uFe
         WDWv8yHKpGS4pKNsln8UfF2BQLysJcAI6at8gXZCLWEb37tu8d/IVO5kbGmiO31ECgqC
         QSOhOfTXa5V5sn+SaCcWckKGOy7ufMaGM99YFfTV9D0Y/sgaZJTkWwATzCsBSNPJPGFQ
         4mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584784; x=1692176784;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=in/McsOPhW3ALiveMIop5Gy8i4Np3O/bH5xSFo1DBjg=;
        b=D5Uy8awvU4CLBFDoQQsFS78vhJPxQgI7t/jwLYDTJdcdZcZcRt8iq6ZJL/P4uthhwn
         RgAQZarZ+5j3cNa50h7ddAiOZCHqQuiumh/rkJS58f8oNPrSJtHNHWskQ4CfT7/+H82I
         QJf1Z5hgpUO/mvw83ivnbqyX4J5rhq7JFBQRqhr2jkroyoOCQRQfUbedmeyFxbZJ94u/
         yita6YdLMTTW7GtHZtToCXLTeytavpFLIQnY7g+0T2E/7t8CbAR0BJObVHXLYlDVbB+M
         FCwFmxL8ifvjPDiUZxz88q7dj8EBFpk5UsXgTbLfd7IuHhBF5IbykIA9rgJLLtNEivKJ
         66lQ==
X-Gm-Message-State: ABy/qLbYBx0KC/CCsK7s14uvZkH0rTzI44YlIBV6BQ2VBqoqSzCeHlIy
	63dYwklT0vwJOneKmbyvCYt7CE4dVsidzlUUEi9WGCWyjwM=
X-Google-Smtp-Source: APBJJlEJyuuB4bxcITSOE/Vd3KgMG/eZvVbKtybkwN00LiWZbd+vFHFN4gS/pUgwHea1tqZDn/M2W0W+M4VcZR+e2Nc=
X-Received: by 2002:a17:90b:3d4:b0:262:ec13:d3a with SMTP id
 go20-20020a17090b03d400b00262ec130d3amr11969453pjb.28.1689584784444; Mon, 17
 Jul 2023 02:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 17 Jul 2023 11:05:47 +0200
Message-ID: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
Subject: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear All,

I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1.
It works fine. I would like to upgrade to a more recent kernel, but I
run into a kernel compilation error very early:


In file included from ./include/asm-generic/xenomai/syscall.h:26,
                 from
./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
                 from ./include/xenomai/pipeline/pipeline.h:12,
                 from ./include/xenomai/cobalt/kernel/lock.h:26,
                 from ./include/xenomai/cobalt/kernel/sched.h:23,
                 from ./arch/x86/include/dovetail/irq.h:12,
                 from kernel/irq/pipeline.c:17:
./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error:
asm/fpu/internal.h: No such file or directory
   44 | #include <asm/fpu/internal.h>
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] Error 1
make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
make[1]: *** [scripts/Makefile.build:494: kernel] Error 2


I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in all
combinations, with the same result.
In kernel version 5.15 the arch/x86/include/asm/fpu directory contains
an internal.h, but I cannot find this file from 5.19 and above. I
believe this is the cause of the error.

Please help me. What am I doing wrong?

Thank you,
Tamas
