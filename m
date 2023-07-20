Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2D199E7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 09:56:43 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7673180224bso53667185a.0
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689847002; x=1690451802;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VusONkmpCLpe/ry+1RjKzNyM+nKN6xw88Z/yauZHMBI=;
        b=B+i11pH8MCkzWNi4GguldYT8/XAEQ29d96Ewt9iv8dMveSTGwYbaE3GfTP7HJozYpG
         D7AMuaE5IdEFQX26Tgj+VaFmCJXunw8+wKwvuQmC+CQWdT6n9rsmBo01Y3N+Nxneu4IM
         8JcAXUraPSJXLXOeI6HSGpp+ln3wECqFrD9mGs9boV84+0qvlmQniz12sAzlRmbfJowb
         +pHKVfVP2oNC6bxCULK4+H4EPorXyH1knMo7DMKS2DFTBJWCeVci868UO0j2ZD93AXBh
         WpA03a9khqeRxOh3fNtEm2jqJMFQuHrijIQpbhCKTm40YY/TIUHFKYFE32wo32Lfj5s3
         RJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689847002; x=1690451802;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusONkmpCLpe/ry+1RjKzNyM+nKN6xw88Z/yauZHMBI=;
        b=ShUAl+B3Xo5pkZpVzCyeKWsaHV9DsCDKS7OleUv4TG+NLsjgj877CMZmxfU1wS7zrf
         uD3RpUL+TqAwwg9+5EXIR6QfF9McVC2H/U3VzQ6y3ehdSkgXra3v5zJ2/+dEVzOMMuqP
         lr9eQ5u0tj2tfkOACGMTHFKSUI2vh13psRbNaeNDl9RR7ZIGCPcH5JRH48ggtjJuZOl7
         mXwzgywchetvHY7TV347gLk1Fjcmq9zxWAv4wak4RmezHsaXelKPRzyqH2WeZIaEjuky
         UGIykhp+7nfDCC4o9V75Ku8dur2MIZz+KjtMnZJRXkrhCz4IAeLQE0J7AP31MEUgkpkm
         M5fw==
X-Gm-Message-State: ABy/qLZrJmHr2pIJsjXC6Ucv/NqropAyjGs3gLgG3eFsUB+jme4PJKWi
	KG3eAl7yT9K0gnkHaMyL0AUb3nTop8/07paVHM38aAX1uf4=
X-Google-Smtp-Source: APBJJlEhS6GMiV2aHN+qEubuC7/D6I99trH9eM+edn6NOTAg4RTQM/ESjMYaAqbu/aCq2tOqo3bZ7QErPod66k0Mysw=
X-Received: by 2002:a05:620a:47a6:b0:769:89e2:7646 with SMTP id
 dt38-20020a05620a47a600b0076989e27646mr1175278qkb.10.1689847001875; Thu, 20
 Jul 2023 02:56:41 -0700 (PDT)
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
 <CAH0t8y321gcc59b_GBtgtwqK8cqSuxcOZu5FHgm78WSoMB5Qzg@mail.gmail.com>
 <0a0b0b0482cd9d5b4b816348d01a964673afcd23.camel@siemens.com>
 <CAH0t8y1ZeatWxy_Y31vY5h0fy-fBhUo6SR5hTG1J-XzPiDHMHg@mail.gmail.com> <5f68045ebdd7eb36e7bb326214f512b206ffa91e.camel@siemens.com>
In-Reply-To: <5f68045ebdd7eb36e7bb326214f512b206ffa91e.camel@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Thu, 20 Jul 2023 11:56:07 +0200
Message-ID: <CAH0t8y0O5xkgAsJyqrG2o1EvP+6FJC8V4cGPGvTaNw-KyaQJBw@mail.gmail.com>
Subject: Re: Missing asm/fpu/internal.h
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I guess it's the dlopen test that fails here. Could you please confirm
> that by running "smokey --run=3Ddlopen" ?
>
> Seems the test infrastructure is unable to locate some binaries that
> should be located inside the XENO_TEST_DIR, that seems to fail and then
> we crash... Might be a bug triggered by an invalid "test environment".
>
> I will try to reproduce during my next Xenomai time slot ;-)

I tried to execute the command directly as a shell command, or
modified the xeno-test script and execute it that way. Both returned
the same result:

++ echo 0
++ testdir=3D/usr/xenomai/bin
++ which systemctl
++ systemctl is-active --quiet systemd-timesyncd
++ timesyncd_was_running=3Dtrue
++ systemctl stop systemd-timesyncd
++ /usr/xenomai/bin/smokey --run=3Ddlopen random_alloc_rounds=3D64
pattern_check_rounds=3D64
   0"002.340| WARNING: [smokey] invalid test range in dlopen
   0"002.365| WARNING: [smokey] no test selected
   0"002.375| WARNING: [main] setup call smokey failed
   0"002.385| BUG in __xenomai_init(): [main] initialization failed, EINVAL
+ start_timesyncd
+ true
+ systemctl start systemd-timesyncd
+ timesyncd_was_running=3Dfalse
child 2268 returned: exited with status 1

Tamas

Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont: =
2023.
j=C3=BAl. 18., K, 16:02):
>
> On Tue, 2023-07-18 at 09:49 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > The CI runs that we did on this versions look OK, so I think it's a
> > > problem in your setup. Make sure you don't try to run an older (3.2.x=
)
> > > testsuite linked against up to date Xenomai libraries (or the other w=
ay
> > > around).
> > >
> > > Maybe something got screwed up while testing all those different
> > > versions?
> > >
> > > The segfault happens when trying to run the smokey testsuite. Is it a
> > > single test that fails, or basically all of them? You may limit the
> > > number of tests to be executed by "smokey --run=3D<list of test names=
>"
> >
> > I renamed the /usr/xenomai directory of the old 3.2.x compilation. I
> > am sure that the current /usr/xenomai directory contains the output of
> > the last build, that is the current master.
> > A lot of tests are ok. This is the full output of the xeno-test procedu=
re:
> >
> > Started child 8092: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./=
xeno-test
> > ++ echo 0
> > ++ testdir=3D/usr/xenomai/bin
> > ++ which systemctl
> > ++ systemctl is-active --quiet systemd-timesyncd
> > ++ timesyncd_was_running=3Dtrue
> > ++ systemctl stop systemd-timesyncd
> > ++ /usr/xenomai/bin/smokey --run random_alloc_rounds=3D64 pattern_check=
_rounds=3D64
> > arith OK
> > bufp skipped (no kernel support)
> > can skipped (no kernel support)
> > cpu_affinity skipped (no kernel support)
> > fpu_stress OK
> > gdb OK
> > iddp skipped (no kernel support)
> > leaks OK
> > memory_coreheap OK
> > memory_heapmem OK
> > memory_tlsf OK
> > net_packet_dgram OK
> > net_packet_raw OK
> > net_udp OK
> > posix_clock OK
> > posix_cond OK
> > posix_fork OK
> > posix_mutex OK
> > posix_select OK
> > rtdm skipped (no kernel support)
> > sched_quota skipped (no kernel support)
> > sched_tp skipped (no kernel support)
> > setsched OK
> > sigdebug skipped (no kernel support)
> > timerfd OK
> > tsc OK
> > vdso_access OK
> > xddp skipped (no kernel support)
> > y2038: sizeof(long) =3D 8, sizeof(time_t) =3D 8
> > syscall-tests.c:1027, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
> > Address family not supported by protocol
> > recvmmsg64: skipped. (no kernel support)
> > syscall-tests.c:1503, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
> > Address family not supported by protocol
> > pselect64: skipped timeout write back test
> > y2038 OK
> > memory_pshared OK
> > x86io OK
> > ./xeno-test: line 100:  8099 Segmentation fault      (core dumped)
> > $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
> > pattern_check_rounds=3D64
> > + start_timesyncd
> > + true
> > + systemctl start systemd-timesyncd
> > + timesyncd_was_running=3Dfalse
> > child 8092 returned: exited with status 139
>
> I guess it's the dlopen test that fails here. Could you please confirm
> that by running "smokey --run=3Ddlopen" ?
>
> Seems the test infrastructure is unable to locate some binaries that
> should be located inside the XENO_TEST_DIR, that seems to fail and then
> we crash... Might be a bug triggered by an invalid "test environment".
>
> I will try to reproduce during my next Xenomai time slot ;-)
>
> Florian
>
> >
> > Maybe I prepared the kernel in a wrong way? I did it this way:
> >
> > /usr/src/xenomai-master/scripts/prepare-kernel.sh --arch=3Dx86
> > --linux=3D/usr/src/linux-dovetail-v6.1.y-dovetail
> >
> > Should I use --arch=3Dx86_64 instead?
> >
> > Thank you,
> > Tamas
> >
> > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91po=
nt: 2023.
> > j=C3=BAl. 18., K, 8:44):
> > >
> > > On Mon, 2023-07-17 at 16:51 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > > > Dear All,
> > > > > > > >
> > > > > > > > I am using the 5.15 dovetail based kernel together with Xen=
omai 3.2.1.
> > > > > > > > It works fine. I would like to upgrade to a more recent ker=
nel, but I
> > > > > > > > run into a kernel compilation error very early:
> > > > > > > > >
> > > > > > >
> > > > > > > > In file included from ./include/asm-generic/xenomai/ Xenoma=
i 3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > > Linux versions you have to use Xenomai from master branch. =
There is no
> > > > > > > > 3.3 release yet, but we're working on it. We already discus=
sed that
> > > > > > > > "missing release" in our community call some days ago. Ther=
e are some
> > > > > > > > features pending that we would like to integrate. So: stay =
tuned.
> > > > > > > >
> > > > > > > > Florian
> > > > > > >
> > > > > > > Thank you!
> > > > > > > Which kernel do you recommend to start working with. 6.1, or =
6.4? Is
> > > > > > > the current master in a "working shape", or should I wait for=
 a
> > > > > > > release?
> > > > > > >
> > > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for s=
ome
> > > > > > time, Xenomai support included.
> > > > > >
> > > > > > 6.4 is just a normal release and will vanish once 6.5. is out. =
We're
> > > > > > testing that in combination with latest Xenomai already (to mak=
e sure
> > > > > > we stay compatible) but we do not plan to support that specific=
 release
> > > > > > over the long run.
> > > > > >
> > > > > > Florian
> > > > >
> > > > > Thank you very much!
> > > > > Tamas
> > > >
> > > > I downloaded the latest  Xenomai master branch. I compiled a new
> > > > kernel (6.1 and 6.4 behaves the same way) . The xeno-test fails:
> > > >
> > > > ./xeno-test: line 100:  1746 Segmentation fault      (core dumped)
> > > > $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D=
64
> > > > pattern_check_rounds=3D64
> > > > + start_timesyncd
> > > > + true
> > > > + systemctl start systemd-timesyncd
> > > > + timesyncd_was_running=3Dfalse
> > > > child 1739 returned: exited with status 139
> > > >
> > > > Am I doing something wrong?
> > > > Thank you,
> > > > Tamas
> > >
> > > The CI runs that we did on this versions look OK, so I think it's a
> > > problem in your setup. Make sure you don't try to run an older (3.2.x=
)
> > > testsuite linked against up to date Xenomai libraries (or the other w=
ay
> > > around).
> > >
> > > Maybe something got screwed up while testing all those different
> > > versions?
> > >
> > > The segfault happens when trying to run the smokey testsuite. Is it a
> > > single test that fails, or basically all of them? You may limit the
> > > number of tests to be executed by "smokey --run=3D<list of test names=
>"
> > >
> > > Florian
> > >
> > > >
> > > > Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91po=
nt: 2023. j=C3=BAl. 17., H, 11:49):
> > > > >
> > > > > > > > Dear All,
> > > > > > > >
> > > > > > > > I am using the 5.15 dovetail based kernel together with Xen=
omai 3.2.1.
> > > > > > > > It works fine. I would like to upgrade to a more recent ker=
nel, but I
> > > > > > > > run into a kernel compilation error very early:
> > > > > > > >
> > > > > > > >
> > > > > > > > In file included from ./include/asm-generic/xenomai/ Xenoma=
i 3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > > Linux versions you have to use Xenomai from master branch. =
There is no
> > > > > > > > 3.3 release yet, but we're working on it. We already discus=
sed that
> > > > > > > > "missing release" in our community call some days ago. Ther=
e are some
> > > > > > > > features pending that we would like to integrate. So: stay =
tuned.
> > > > > > > >
> > > > > > > > Florian
> > > > > > >
> > > > > > > Thank you!
> > > > > > > Which kernel do you recommend to start working with. 6.1, or =
6.4? Is
> > > > > > > the current master in a "working shape", or should I wait for=
 a
> > > > > > > release?
> > > > > >
> > > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for s=
ome
> > > > > > time, Xenomai support included.
> > > > > >
> > > > > > 6.4 is just a normal release and will vanish once 6.5. is out. =
We're
> > > > > > testing that in combination with latest Xenomai already (to mak=
e sure
> > > > > > we stay compatible) but we do not plan to support that specific=
 release
> > > > > > over the long run.
> > > > > >
> > > > > > Florian
> > > > >
> > > > > Thank you very much!
> > > > > Tamas
> > > > >
> > > > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=
=C5=91pont: 2023.
> > > > > j=C3=BAl. 17., H, 11:46):
> > > > > >
> > > > > > On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > > > Dear All,
> > > > > > > >
> > > > > > > > I am using the 5.15 dovetail based kernel together with Xen=
omai 3.2.1.
> > > > > > > > It works fine. I would like to upgrade to a more recent ker=
nel, but I
> > > > > > > > run into a kernel compilation error very early:
> > > > > > > >
> > > > > > > >
> > > > > > > > In file included from ./include/asm-generic/xenomai/ Xenoma=
i 3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > > Linux versions you have to use Xenomai from master branch. =
There is no
> > > > > > > > 3.3 release yet, but we're working on it. We already discus=
sed that
> > > > > > > > "missing release" in our community call some days ago. Ther=
e are some
> > > > > > > > features pending that we would like to integrate. So: stay =
tuned.
> > > > > > > >
> > > > > > > > Florian
> > > > > > >
> > > > > > > Thank you!
> > > > > > > Which kernel do you recommend to start working with. 6.1, or =
6.4? Is
> > > > > > > the current master in a "working shape", or should I wait for=
 a
> > > > > > > release?
> > > > > >
> > > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for s=
ome
> > > > > > time, Xenomai support included.
> > > > > >
> > > > > > 6.4 is just a normal release and will vanish once 6.5. is out. =
We're
> > > > > > testing that in combination with latest Xenomai already (to mak=
e sure
> > > > > > we stay compatible) but we do not plan to support that specific=
 release
> > > > > > over the long run.
> > > > > >
> > > > > > Florian
> > > > > >
> > > > > > >
> > > > > > > Thank you very much!
> > > > > > > Tamas
> > > > > > >
> > > > > > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (=
id=C5=91pont: 2023.
> > > > > > > j=C3=BAl. 17., H, 11:15):
> > > > > > > >
> > > > > > > > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wro=
te:
> > > > > > > > > Dear All,
> > > > > > > > >
> > > > > > > > > I am using the 5.15 dovetail based kernel together with X=
enomai 3.2.1.
> > > > > > > > > It works fine. I would like to upgrade to a more recent k=
ernel, but I
> > > > > > > > > run into a kernel compilation error very early:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > In file included from ./include/asm-generic/xenomai/sysca=
ll.h:26,
> > > > > > > > >                  from
> > > > > > > > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h=
:24,
> > > > > > > > >                  from ./include/xenomai/pipeline/pipeline=
.h:12,
> > > > > > > > >                  from ./include/xenomai/cobalt/kernel/loc=
k.h:26,
> > > > > > > > >                  from ./include/xenomai/cobalt/kernel/sch=
ed.h:23,
> > > > > > > > >                  from ./arch/x86/include/dovetail/irq.h:1=
2,
> > > > > > > > >                  from kernel/irq/pipeline.c:17:
> > > > > > > > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: =
fatal error:
> > > > > > > > > asm/fpu/internal.h: No such file or directory
> > > > > > > > >    44 | #include <asm/fpu/internal.h>
> > > > > > > > >       |          ^~~~~~~~~~~~~~~~~~~~
> > > > > > > > > compilation terminated.
> > > > > > > > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipe=
line.o] Error 1
> > > > > > > > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Err=
or 2
> > > > > > > > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3=
.2.3 in all
> > > > > > > > > combinations, with the same result.
> > > > > > > > > In kernel version 5.15 the arch/x86/include/asm/fpu direc=
tory contains
> > > > > > > > > an internal.h, but I cannot find this file from 5.19 and =
above. I
> > > > > > > > > believe this is the cause of the error.
> > > > > > > > >
> > > > > > > > > Please help me. What am I doing wrong?
> > > > > > > >
> > > > > > > > Xenomai 3.2.x supports Linux up to 5.15. If you want to upd=
ate to newer
> > > > > > > > Linux versions you have to use Xenomai from master branch. =
There is no
> > > > > > > > 3.3 release yet, but we're working on it. We already discus=
sed that
> > > > > > > > "missing release" in our community call some days ago. Ther=
e are some
> > > > > > > > features pending that we would like to integrate. So: stay =
tuned.
> > > > > > > >
> > > > > > > > Florian
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thank you,
> > > > > > > > > Tamas
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> > >
> >
>
