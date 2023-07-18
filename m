Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E26D532
	for <xenomai@lists.linux.dev>; Tue, 18 Jul 2023 14:02:36 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202307181402271f029176eefeefeb19
        for <xenomai@lists.linux.dev>;
        Tue, 18 Jul 2023 16:02:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YKRPremhDCw2UCS+n0QW9NzzHGSBj+odDgPy5gz70tI=;
 b=ZzF/F9NVcCgrc+8YZD7Bhs12DVfhQSXjGXm8D+5FC2t5p2/w1Z2sSw6ewIZpmdSFxO3Tw1
 y7Y6ObYJqVhJewjfsKcE49LPf2RKTg1gJcLTQTBEjcRqFgPoEQDN7MiboIoBv5OnO3WzC3g0
 RIbFqHRVyIfMsbMA8Hv1orgBKcMY4=;
Message-ID: <5f68045ebdd7eb36e7bb326214f512b206ffa91e.camel@siemens.com>
Subject: Re: Missing asm/fpu/internal.h
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Tam=E1s_Pa=E1l?= <paal.tam@gmail.com>, 
	xenomai@lists.linux.dev
Date: Tue, 18 Jul 2023 16:02:26 +0200
In-Reply-To: <CAH0t8y1ZeatWxy_Y31vY5h0fy-fBhUo6SR5hTG1J-XzPiDHMHg@mail.gmail.com>
References: 
	<CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
	 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
	 <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
	 <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com>
	 <CAH0t8y2U95PXRT4xNKm6fO93XNwrQD4V4MbaQu1B3V6SAQWVmw@mail.gmail.com>
	 <CAH0t8y321gcc59b_GBtgtwqK8cqSuxcOZu5FHgm78WSoMB5Qzg@mail.gmail.com>
	 <0a0b0b0482cd9d5b4b816348d01a964673afcd23.camel@siemens.com>
	 <CAH0t8y1ZeatWxy_Y31vY5h0fy-fBhUo6SR5hTG1J-XzPiDHMHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2023-07-18 at 09:49 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > The CI runs that we did on this versions look OK, so I think it's a
> > problem in your setup. Make sure you don't try to run an older (3.2.x)
> > testsuite linked against up to date Xenomai libraries (or the other way
> > around).
> >=20
> > Maybe something got screwed up while testing all those different
> > versions?
> >=20
> > The segfault happens when trying to run the smokey testsuite. Is it a
> > single test that fails, or basically all of them? You may limit the
> > number of tests to be executed by "smokey --run=3D<list of test names>"
>=20
> I renamed the /usr/xenomai directory of the old 3.2.x compilation. I
> am sure that the current /usr/xenomai directory contains the output of
> the last build, that is the current master.
> A lot of tests are ok. This is the full output of the xeno-test procedure=
:
>=20
> Started child 8092: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./xe=
no-test
> ++ echo 0
> ++ testdir=3D/usr/xenomai/bin
> ++ which systemctl
> ++ systemctl is-active --quiet systemd-timesyncd
> ++ timesyncd_was_running=3Dtrue
> ++ systemctl stop systemd-timesyncd
> ++ /usr/xenomai/bin/smokey --run random_alloc_rounds=3D64 pattern_check_r=
ounds=3D64
> arith OK
> bufp skipped (no kernel support)
> can skipped (no kernel support)
> cpu_affinity skipped (no kernel support)
> fpu_stress OK
> gdb OK
> iddp skipped (no kernel support)
> leaks OK
> memory_coreheap OK
> memory_heapmem OK
> memory_tlsf OK
> net_packet_dgram OK
> net_packet_raw OK
> net_udp OK
> posix_clock OK
> posix_cond OK
> posix_fork OK
> posix_mutex OK
> posix_select OK
> rtdm skipped (no kernel support)
> sched_quota skipped (no kernel support)
> sched_tp skipped (no kernel support)
> setsched OK
> sigdebug skipped (no kernel support)
> timerfd OK
> tsc OK
> vdso_access OK
> xddp skipped (no kernel support)
> y2038: sizeof(long) =3D 8, sizeof(time_t) =3D 8
> syscall-tests.c:1027, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
> Address family not supported by protocol
> recvmmsg64: skipped. (no kernel support)
> syscall-tests.c:1503, socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP):
> Address family not supported by protocol
> pselect64: skipped timeout write back test
> y2038 OK
> memory_pshared OK
> x86io OK
> ./xeno-test: line 100:  8099 Segmentation fault      (core dumped)
> $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
> pattern_check_rounds=3D64
> + start_timesyncd
> + true
> + systemctl start systemd-timesyncd
> + timesyncd_was_running=3Dfalse
> child 8092 returned: exited with status 139

I guess it's the dlopen test that fails here. Could you please confirm
that by running "smokey --run=3Ddlopen" ?

Seems the test infrastructure is unable to locate some binaries that
should be located inside the XENO_TEST_DIR, that seems to fail and then
we crash... Might be a bug triggered by an invalid "test environment".

I will try to reproduce during my next Xenomai time slot ;-)

Florian

>=20
> Maybe I prepared the kernel in a wrong way? I did it this way:
>=20
> /usr/src/xenomai-master/scripts/prepare-kernel.sh --arch=3Dx86
> --linux=3D/usr/src/linux-dovetail-v6.1.y-dovetail
>=20
> Should I use --arch=3Dx86_64 instead?
>=20
> Thank you,
> Tamas
>=20
> Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont=
: 2023.
> j=C3=BAl. 18., K, 8:44):
> >=20
> > On Mon, 2023-07-17 at 16:51 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > > Dear All,
> > > > > > >=20
> > > > > > > I am using the 5.15 dovetail based kernel together with Xenom=
ai 3.2.1.
> > > > > > > It works fine. I would like to upgrade to a more recent kerne=
l, but I
> > > > > > > run into a kernel compilation error very early:
> > > > > > > >=20
> > > > > >=20
> > > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai =
3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > Linux versions you have to use Xenomai from master branch. Th=
ere is no
> > > > > > > 3.3 release yet, but we're working on it. We already discusse=
d that
> > > > > > > "missing release" in our community call some days ago. There =
are some
> > > > > > > features pending that we would like to integrate. So: stay tu=
ned.
> > > > > > >=20
> > > > > > > Florian
> > > > > >=20
> > > > > > Thank you!
> > > > > > Which kernel do you recommend to start working with. 6.1, or 6.=
4? Is
> > > > > > the current master in a "working shape", or should I wait for a
> > > > > > release?
> > > > > >=20
> > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for som=
e
> > > > > time, Xenomai support included.
> > > > >=20
> > > > > 6.4 is just a normal release and will vanish once 6.5. is out. We=
're
> > > > > testing that in combination with latest Xenomai already (to make =
sure
> > > > > we stay compatible) but we do not plan to support that specific r=
elease
> > > > > over the long run.
> > > > >=20
> > > > > Florian
> > > >=20
> > > > Thank you very much!
> > > > Tamas
> > >=20
> > > I downloaded the latest  Xenomai master branch. I compiled a new
> > > kernel (6.1 and 6.4 behaves the same way) . The xeno-test fails:
> > >=20
> > > ./xeno-test: line 100:  1746 Segmentation fault      (core dumped)
> > > $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=3D64
> > > pattern_check_rounds=3D64
> > > + start_timesyncd
> > > + true
> > > + systemctl start systemd-timesyncd
> > > + timesyncd_was_running=3Dfalse
> > > child 1739 returned: exited with status 139
> > >=20
> > > Am I doing something wrong?
> > > Thank you,
> > > Tamas
> >=20
> > The CI runs that we did on this versions look OK, so I think it's a
> > problem in your setup. Make sure you don't try to run an older (3.2.x)
> > testsuite linked against up to date Xenomai libraries (or the other way
> > around).
> >=20
> > Maybe something got screwed up while testing all those different
> > versions?
> >=20
> > The segfault happens when trying to run the smokey testsuite. Is it a
> > single test that fails, or basically all of them? You may limit the
> > number of tests to be executed by "smokey --run=3D<list of test names>"
> >=20
> > Florian
> >=20
> > >=20
> > > Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont=
: 2023. j=C3=BAl. 17., H, 11:49):
> > > >=20
> > > > > > > Dear All,
> > > > > > >=20
> > > > > > > I am using the 5.15 dovetail based kernel together with Xenom=
ai 3.2.1.
> > > > > > > It works fine. I would like to upgrade to a more recent kerne=
l, but I
> > > > > > > run into a kernel compilation error very early:
> > > > > > >=20
> > > > > > >=20
> > > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai =
3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > Linux versions you have to use Xenomai from master branch. Th=
ere is no
> > > > > > > 3.3 release yet, but we're working on it. We already discusse=
d that
> > > > > > > "missing release" in our community call some days ago. There =
are some
> > > > > > > features pending that we would like to integrate. So: stay tu=
ned.
> > > > > > >=20
> > > > > > > Florian
> > > > > >=20
> > > > > > Thank you!
> > > > > > Which kernel do you recommend to start working with. 6.1, or 6.=
4? Is
> > > > > > the current master in a "working shape", or should I wait for a
> > > > > > release?
> > > > >=20
> > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for som=
e
> > > > > time, Xenomai support included.
> > > > >=20
> > > > > 6.4 is just a normal release and will vanish once 6.5. is out. We=
're
> > > > > testing that in combination with latest Xenomai already (to make =
sure
> > > > > we stay compatible) but we do not plan to support that specific r=
elease
> > > > > over the long run.
> > > > >=20
> > > > > Florian
> > > >=20
> > > > Thank you very much!
> > > > Tamas
> > > >=20
> > > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=
=91pont: 2023.
> > > > j=C3=BAl. 17., H, 11:46):
> > > > >=20
> > > > > On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > > > > > Dear All,
> > > > > > >=20
> > > > > > > I am using the 5.15 dovetail based kernel together with Xenom=
ai 3.2.1.
> > > > > > > It works fine. I would like to upgrade to a more recent kerne=
l, but I
> > > > > > > run into a kernel compilation error very early:
> > > > > > >=20
> > > > > > >=20
> > > > > > > In file included from ./include/asm-generic/xenomai/ Xenomai =
3.2.x supports Linux up to 5.15. If you want to update to newer
> > > > > > > Linux versions you have to use Xenomai from master branch. Th=
ere is no
> > > > > > > 3.3 release yet, but we're working on it. We already discusse=
d that
> > > > > > > "missing release" in our community call some days ago. There =
are some
> > > > > > > features pending that we would like to integrate. So: stay tu=
ned.
> > > > > > >=20
> > > > > > > Florian
> > > > > >=20
> > > > > > Thank you!
> > > > > > Which kernel do you recommend to start working with. 6.1, or 6.=
4? Is
> > > > > > the current master in a "working shape", or should I wait for a
> > > > > > release?
> > > > >=20
> > > > > 6.1 is a LTS (Long Term Support) release, so it will stay for som=
e
> > > > > time, Xenomai support included.
> > > > >=20
> > > > > 6.4 is just a normal release and will vanish once 6.5. is out. We=
're
> > > > > testing that in combination with latest Xenomai already (to make =
sure
> > > > > we stay compatible) but we do not plan to support that specific r=
elease
> > > > > over the long run.
> > > > >=20
> > > > > Florian
> > > > >=20
> > > > > >=20
> > > > > > Thank you very much!
> > > > > > Tamas
> > > > > >=20
> > > > > > Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=
=C5=91pont: 2023.
> > > > > > j=C3=BAl. 17., H, 11:15):
> > > > > > >=20
> > > > > > > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote=
:
> > > > > > > > Dear All,
> > > > > > > >=20
> > > > > > > > I am using the 5.15 dovetail based kernel together with Xen=
omai 3.2.1.
> > > > > > > > It works fine. I would like to upgrade to a more recent ker=
nel, but I
> > > > > > > > run into a kernel compilation error very early:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > In file included from ./include/asm-generic/xenomai/syscall=
.h:26,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from
> > > > > > > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:2=
4,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/pipelin=
e/pipeline.h:12,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/cobalt/=
kernel/lock.h:26,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/cobalt/=
kernel/sched.h:23,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./arch/x86/include/doveta=
il/irq.h:12,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from kernel/irq/pipeline.c:17:
> > > > > > > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fa=
tal error:
> > > > > > > > asm/fpu/internal.h: No such file or directory
> > > > > > > > =C2=A0=C2=A0=C2=A044 | #include <asm/fpu/internal.h>
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|          ^~~~~~~~~~~~=
~~~~~~~~
> > > > > > > > compilation terminated.
> > > > > > > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeli=
ne.o] Error 1
> > > > > > > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error=
 2
> > > > > > > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2=
.3 in all
> > > > > > > > combinations, with the same result.
> > > > > > > > In kernel version 5.15 the arch/x86/include/asm/fpu directo=
ry contains
> > > > > > > > an internal.h, but I cannot find this file from 5.19 and ab=
ove. I
> > > > > > > > believe this is the cause of the error.
> > > > > > > >=20
> > > > > > > > Please help me. What am I doing wrong?
> > > > > > >=20
> > > > > > > Xenomai 3.2.x supports Linux up to 5.15. If you want to updat=
e to newer
> > > > > > > Linux versions you have to use Xenomai from master branch. Th=
ere is no
> > > > > > > 3.3 release yet, but we're working on it. We already discusse=
d that
> > > > > > > "missing release" in our community call some days ago. There =
are some
> > > > > > > features pending that we would like to integrate. So: stay tu=
ned.
> > > > > > >=20
> > > > > > > Florian
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Thank you,
> > > > > > > > Tamas
> > > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > >=20
> >=20
>=20

