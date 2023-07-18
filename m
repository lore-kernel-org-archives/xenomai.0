Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50453BF
	for <xenomai@lists.linux.dev>; Tue, 18 Jul 2023 07:49:40 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-262e44b8bf6so2622207a91.1
        for <xenomai@lists.linux.dev>; Tue, 18 Jul 2023 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666579; x=1692258579;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7skPHdL2XBFyPerwPjmKlIE3GUfItt1y6ouH0fZatg=;
        b=RiH1BlaW/WTs+h95g4HbbKBxMMpb9OeWyX9SCXsOMIW9S1XW6ZIub1SEQ0Fv7GIdn5
         8w1ymMXJWIL+Vyv8UkyBsmcN7gzBoAL010qgrrwns7RgXBjp0Glf7BBq1g9q6HS0vHyc
         BCoQeRNJHv6/zXQG62ps/6YxRoNUgjNGGKcGeWW797CxwksqNp+Ozy7zRYzU0aFn9vi+
         g3WNO5Pf18uq6O/kABL7TsiQ3ihY5tJD3ENSGkYD1BtNlj4aTKuOc2xpaWZujZECBfLc
         Sosl8x3RhJm6EHAB0SKNShxpoond6yeP0bsdoaMrYPJHYC5J0qF+GBbzvISHfj4ShIfV
         BuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666579; x=1692258579;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7skPHdL2XBFyPerwPjmKlIE3GUfItt1y6ouH0fZatg=;
        b=brq3ZG05wQPIS/oNbhNpLdLPRPJyubOHp9AtAcgfK7CJv9VY9WaFfHS/p2c9390NXl
         oYRPqEnu8r+bcJyCLLPSEVjFf4njufw5hDh57lTRWUFogo2zTu4K9/puh7MPfij9Pzvm
         XO2DtWzycRbQkbMo/Q+u4xiVhf14zU0wJMAvt8LK+8Yr7Fo+uYTeeTpJdwhnD47R02ts
         RyswCR6Hu9jxbhJq3NBxNgCocxwVrYzNmj8BuKaDVFYadkpQX0ecHcVzioPCeTVUGot3
         vuNkTLikjqvE2bK9XFqk7Z65b0jxfr1lD7Dub7+BAqEYYfnd9uMxwJdgpSA6Opx19Sez
         HCbA==
X-Gm-Message-State: ABy/qLZF1HdI6Oc5EdppGiYaWAN1qWbarWN4v21cbgPLIhW/LLm1jl4f
	kG0PluL/ULKLuO924cePYxQ1cl+LLFgC86fgbFXAGZAQkhE=
X-Google-Smtp-Source: APBJJlEPx5f9hjZQk5yxN9SUTAh85M7kkYuE6VOuj6hV2ZEAE4gry3svWL+mJ2zAMBgMs8yShUJNOXoxnITT1GUT1Js=
X-Received: by 2002:a17:90b:102:b0:263:f62b:3601 with SMTP id
 p2-20020a17090b010200b00263f62b3601mr11388112pjz.10.1689666579408; Tue, 18
 Jul 2023 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
 <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
 <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com>
 <CAH0t8y2U95PXRT4xNKm6fO93XNwrQD4V4MbaQu1B3V6SAQWVmw@mail.gmail.com>
 <CAH0t8y321gcc59b_GBtgtwqK8cqSuxcOZu5FHgm78WSoMB5Qzg@mail.gmail.com> <0a0b0b0482cd9d5b4b816348d01a964673afcd23.camel@siemens.com>
In-Reply-To: <0a0b0b0482cd9d5b4b816348d01a964673afcd23.camel@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Tue, 18 Jul 2023 09:49:03 +0200
Message-ID: <CAH0t8y1ZeatWxy_Y31vY5h0fy-fBhUo6SR5hTG1J-XzPiDHMHg@mail.gmail.com>
Subject: Re: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The CI runs that we did on this versions look OK, so I think it's a
> problem in your setup. Make sure you don't try to run an older (3.2.x)
> testsuite linked against up to date Xenomai libraries (or the other way
> around).
>
> Maybe something got screwed up while testing all those different
> versions?
>
> The segfault happens when trying to run the smokey testsuite. Is it a
> single test that fails, or basically all of them? You may limit the
> number of tests to be executed by "smokey --run=3D<list of test names>"

I renamed the /usr/xenomai directory of the old 3.2.x compilation. I
am sure that the current /usr/xenomai directory contains the output of
the last build, that is the current master.
A lot of tests are ok. This is the full output of the xeno-test procedure:

Started child 8092: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./xeno=
-test
++ echo 0
++ testdir=3D/usr/xenomai/bin
++ which systemctl
++ systemctl is-active --quiet systemd-timesyncd
++ timesyncd_was_running=3Dtrue
++ systemctl stop systemd-timesyncd
++ /usr/xenomai/bin/smokey --run random_alloc_rounds=3D64 pattern_check_rou=
nds=3D64
arith OK
bufp skipped (no kernel support)
can skipped (no kernel support)
cpu_affinity skipped (no kernel support)
fpu_stress OK
gdb OK
iddp skipped (no kernel support)
leaks OK
memory_coreheap OK
memory_heapmem OK
memory_tlsf OK
net_packet_dgram OK
net_packet_raw OK
net_udp OK
posix_clock OK
posix_cond OK
posix_fork OK
posix_mutex OK
posix_select OK
rtdm skipped (no kernel support)
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
setsched OK
sigdebug skipped (no kernel support)
timerfd OK
tsc OK
vdso_access OK
xddp skipped (no kernel support)
y2038: sizeof(long) =3D 8, sizeof(time_t) =3D 8
syscall-tests.c:1027, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
Address family not supported by protocol
recvmmsg64: skipped. (no kernel support)
syscall-tests.c:1503, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
Address family not supported by protocol
pselect64: skipped timeout write back test
y2038 OK
memory_pshared OK
x86io OK
./xeno-test: line 100:  8099 Segmentation fault      (core dumped)
$testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
pattern_check_rounds=3D64
+ start_timesyncd
+ true
+ systemctl start systemd-timesyncd
+ timesyncd_was_running=3Dfalse
child 8092 returned: exited with status 139

Maybe I prepared the kernel in a wrong way? I did it this way:

/usr/src/xenomai-master/scripts/prepare-kernel.sh --arch=3Dx86
--linux=3D/usr/src/linux-dovetail-v6.1.y-dovetail

Should I use --arch=3Dx86_64 instead?

Thank you,
Tamas

Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont: =
2023.
j=C3=BAl. 18., K, 8:44):
>
> On Mon, 2023-07-17 at 16:51 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > Dear All,
> > > > > >
> > > > > > I am using the 5.15 dovetail based kernel together with Xenomai=
 3.2.1.
> > > > > > It works fine. I would like to upgrade to a more recent kernel,=
 but I
> > > > > > run into a kernel compilation error very early:
> > > > > > >
> > > > >
> > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.=
2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > Linux versions you have to use Xenomai from master branch. Ther=
e is no
> > > > > > 3.3 release yet, but we're working on it. We already discussed =
that
> > > > > > "missing release" in our community call some days ago. There ar=
e some
> > > > > > features pending that we would like to integrate. So: stay tune=
d.
> > > > > >
> > > > > > Florian
> > > > >
> > > > > Thank you!
> > > > > Which kernel do you recommend to start working with. 6.1, or 6.4?=
 Is
> > > > > the current master in a "working shape", or should I wait for a
> > > > > release?
> > > > >
> > > > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > > > time, Xenomai support included.
> > > >
> > > > 6.4 is just a normal release and will vanish once 6.5. is out. We'r=
e
> > > > testing that in combination with latest Xenomai already (to make su=
re
> > > > we stay compatible) but we do not plan to support that specific rel=
ease
> > > > over the long run.
> > > >
> > > > Florian
> > >
> > > Thank you very much!
> > > Tamas
> >
> > I downloaded the latest  Xenomai master branch. I compiled a new
> > kernel (6.1 and 6.4 behaves the same way) . The xeno-test fails:
> >
> > ./xeno-test: line 100:  1746 Segmentation fault      (core dumped)
> > $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
> > pattern_check_rounds=3D64
> > + start_timesyncd
> > + true
> > + systemctl start systemd-timesyncd
> > + timesyncd_was_running=3Dfalse
> > child 1739 returned: exited with status 139
> >
> > Am I doing something wrong?
> > Thank you,
> > Tamas
>
> The CI runs that we did on this versions look OK, so I think it's a
> problem in your setup. Make sure you don't try to run an older (3.2.x)
> testsuite linked against up to date Xenomai libraries (or the other way
> around).
>
> Maybe something got screwed up while testing all those different
> versions?
>
> The segfault happens when trying to run the smokey testsuite. Is it a
> single test that fails, or basically all of them? You may limit the
> number of tests to be executed by "smokey --run=3D<list of test names>"
>
> Florian
>
> >
> > Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont: =
2023. j=C3=BAl. 17., H, 11:49):
> > >
> > > > > > Dear All,
> > > > > >
> > > > > > I am using the 5.15 dovetail based kernel together with Xenomai=
 3.2.1.
> > > > > > It works fine. I would like to upgrade to a more recent kernel,=
 but I
> > > > > > run into a kernel compilation error very early:
> > > > > >
> > > > > >
> > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.=
2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > Linux versions you have to use Xenomai from master branch. Ther=
e is no
> > > > > > 3.3 release yet, but we're working on it. We already discussed =
that
> > > > > > "missing release" in our community call some days ago. There ar=
e some
> > > > > > features pending that we would like to integrate. So: stay tune=
d.
> > > > > >
> > > > > > Florian
> > > > >
> > > > > Thank you!
> > > > > Which kernel do you recommend to start working with. 6.1, or 6.4?=
 Is
> > > > > the current master in a "working shape", or should I wait for a
> > > > > release?
> > > >
> > > > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > > > time, Xenomai support included.
> > > >
> > > > 6.4 is just a normal release and will vanish once 6.5. is out. We'r=
e
> > > > testing that in combination with latest Xenomai already (to make su=
re
> > > > we stay compatible) but we do not plan to support that specific rel=
ease
> > > > over the long run.
> > > >
> > > > Florian
> > >
> > > Thank you very much!
> > > Tamas
> > >
> > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91=
pont: 2023.
> > > j=C3=BAl. 17., H, 11:46):
> > > >
> > > > On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > Dear All,
> > > > > >
> > > > > > I am using the 5.15 dovetail based kernel together with Xenomai=
 3.2.1.
> > > > > > It works fine. I would like to upgrade to a more recent kernel,=
 but I
> > > > > > run into a kernel compilation error very early:
> > > > > >
> > > > > >
> > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai 3.=
2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > Linux versions you have to use Xenomai from master branch. Ther=
e is no
> > > > > > 3.3 release yet, but we're working on it. We already discussed =
that
> > > > > > "missing release" in our community call some days ago. There ar=
e some
> > > > > > features pending that we would like to integrate. So: stay tune=
d.
> > > > > >
> > > > > > Florian
> > > > >
> > > > > Thank you!
> > > > > Which kernel do you recommend to start working with. 6.1, or 6.4?=
 Is
> > > > > the current master in a "working shape", or should I wait for a
> > > > > release?
> > > >
> > > > 6.1 is a LTS (Long Term Support) release, so it will stay for some
> > > > time, Xenomai support included.
> > > >
> > > > 6.4 is just a normal release and will vanish once 6.5. is out. We'r=
e
> > > > testing that in combination with latest Xenomai already (to make su=
re
> > > > we stay compatible) but we do not plan to support that specific rel=
ease
> > > > over the long run.
> > > >
> > > > Florian
> > > >
> > > > >
> > > > > Thank you very much!
> > > > > Tamas
> > > > >
> > > > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=
=C5=91pont: 2023.
> > > > > j=C3=BAl. 17., H, 11:15):
> > > > > >
> > > > > > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > > Dear All,
> > > > > > >
> > > > > > > I am using the 5.15 dovetail based kernel together with Xenom=
ai 3.2.1.
> > > > > > > It works fine. I would like to upgrade to a more recent kerne=
l, but I
> > > > > > > run into a kernel compilation error very early:
> > > > > > >
> > > > > > >
> > > > > > > In file included from ./include/asm-generic/xenomai/syscall.h=
:26,
> > > > > > >                  from
> > > > > > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
> > > > > > >                  from ./include/xenomai/pipeline/pipeline.h:1=
2,
> > > > > > >                  from ./include/xenomai/cobalt/kernel/lock.h:=
26,
> > > > > > >                  from ./include/xenomai/cobalt/kernel/sched.h=
:23,
> > > > > > >                  from ./arch/x86/include/dovetail/irq.h:12,
> > > > > > >                  from kernel/irq/pipeline.c:17:
> > > > > > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fata=
l error:
> > > > > > > asm/fpu/internal.h: No such file or directory
> > > > > > >    44 | #include <asm/fpu/internal.h>
> > > > > > >       |          ^~~~~~~~~~~~~~~~~~~~
> > > > > > > compilation terminated.
> > > > > > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline=
.o] Error 1
> > > > > > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> > > > > > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > > > > > >
> > > > > > >
> > > > > > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3=
 in all
> > > > > > > combinations, with the same result.
> > > > > > > In kernel version 5.15 the arch/x86/include/asm/fpu directory=
 contains
> > > > > > > an internal.h, but I cannot find this file from 5.19 and abov=
e. I
> > > > > > > believe this is the cause of the error.
> > > > > > >
> > > > > > > Please help me. What am I doing wrong?
> > > > > >
> > > > > > Xenomai 3.2.x supports Linux up to 5.15. If you want to update =
to newer
> > > > > > Linux versions you have to use Xenomai from master branch. Ther=
e is no
> > > > > > 3.3 release yet, but we're working on it. We already discussed =
that
> > > > > > "missing release" in our community call some days ago. There ar=
e some
> > > > > > features pending that we would like to integrate. So: stay tune=
d.
> > > > > >
> > > > > > Florian
> > > > > >
> > > > > > >
> > > > > > > Thank you,
> > > > > > > Tamas
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>
