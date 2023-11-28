Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5B19447
	for <xenomai@lists.linux.dev>; Tue, 28 Nov 2023 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qWJboEtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701160800; bh=tmcuQzOZWVirOC4EaI4XEiv84A01Dne0HYxuTZk8Efg=; h=References:In-Reply-To:From:Date:Subject:To:Cc:From:Subject:Reply-To; b=qWJboEtEsrA8aXnZoSklTXx2R89Q9uocm0UwP40hZ11AunbBXS6zt+s9isSOi2if4abBSP1mqZWDqz5LovYRSVzvqBQ3jc1p79V3OAHwMskIx2sESLRVyXVQ5yDhTCgFbUxasKSDnlOlacIKLNceY9Rz3ZbzXx6yI5QMaV6kMjvS6zJWjCAZ/iHRZkU3wbtZDWTcsE7ojezimb00Z8NrRp1oAgDM2fAiBBhFwHeJE0d6UlZDjCr73wDKlwDS8KQLeQMS2hwlcoI68j/CUU508sKiV3cn8GvCpvLyO3eHBJLgVN9Hmbm8dkwlvt6mNqO2SPO7ytCsLaCIJDX70eI1vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701160800; bh=VHKEWC4/E9eIcFe4AR6nb2pszhDuL5WwJ5Az0wMfuzn=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=ZQFTVpoH1FAr8BYGTcgi3hJUqP7kutjqm1tYBLLXVIAt7ZroGrsuituMFoN2TwJfb6j2bH/TNDLntAw87t2+748IDH2wwlrSGcMqlbKVFM3YTgAnX2soSgSG6209W6ZfvTHo8gewQlgT10DsN8klGQHOPAFxFDmfZ4oWuCAv+5D7SaKe4uviVyY57m7FhmtNHYcq8c5bwR/31Qt9r69dkYVMs9kLR627OQKZYdkzrynVJxswyQ36YqcbvvfhNv+a0451AqIhFryOHJQvNC4jpLab2uxpY755VpWNl6f8sdxL0Fp3Bvn1H8S5fQYEKWXjzX693NDa4lXz2/lIgm3HaQ==
X-YMail-OSG: fUpzDX8VM1lv2GhkVaGMbQFwOOjIBQgcfSopWob2ePdtc1rhxZYNTGVflKOiE6p
 gbvjoGnR5O8kMRRpdKutEzw3OhhsMwgMknxRauiDa0rq7W1cC.m_RRFCDPPAQTZS5o1jYPbslmfM
 sscnmFS3As8_l0Sa8I78gDHipPs0bqBry8OGOEJb7z7GdpfVXg05dSG_IgLDql6fTqSpOCQmaUqe
 WeSwVe30iBs.dT0wehwopYT1HoZeJXpvVFUoIbo13e3VQgJsnk0o8WcBjco0dxoc6TTU01RP7Wxz
 9nOW8t.ijWHRAKDmamZ_NZU87ajTFhgBkzHFdnHcsYHBe9xhDP3dTdakBLP8pSMQlHFov4Dl7zuY
 H9rW9OaqS51L6kOh11Jkw24M50rK5n9YUBfNLwNiWskeBJLVHV3zCoBfLiUWFQMpO9FVx_ZsG6qf
 WluwcMwuzKGG4L2xmI6GehFhFe6AQRxBPR1C2JOYRR0hyV3nCMvGbiuXscXXvsT_jTE3vQcPu3se
 gWvynzB0kviKKt8au61VrBAWvLnXO9lIwFOejleZE6nIivd3LvJ7gN44XUqRZOXQYnmiCp8OP4io
 igX8acXggj4uillw2uLoJq9zSZcMKVBdbxA0rs_DEGM2yksstHOJczrTBPoYMTrOETEErwrNV8B9
 ZXqMD.vrXcFYAbSRHAiRA8QxE7pNII7ugDsFS5gHyLXueK9cmpu4CF_g6coOJh2.hIXm6RI8hwI5
 7MpfoyrBfTP_J2SGaMxgGkK2LEtXVg4BqzQVqkcPoBpKdtaK.LtKZ49T1RB9FmEyXgaxe9BYwKP6
 mDUje8yWhfPlyZMmHd047LSjPS8pxoh5qywiaJFDbCuR_7iiNFffdQ.G0z2wYbX11.SVl8qXsjoM
 DeEi9unZoCzcHuIAS8zZUjgZvNponXnkFwh3T6PaIALmpKFL32uUvw4Gt0REjkKtEO0OGhHlk6Ed
 jDe._dIIgq6KBJRUhvOEii7vDqUdnNAIYpIqB2cZxb9r8wT3No5hI8QKHB6UB6kN55gvuBKnxcE3
 PJ3tPVu9mGFP9b334Vn_5qyNw_F_vIQuSFsb2mLOvQchZwHY8B0rTMS6SSpMGoyeL_11tJnszR2Y
 cNHOEH8jrKMXZkD663.v0FZwUoQjC1wvrfPaHfujOoPzTV0VTSJSZyxumMPj9mbfjioXXLMN_AZZ
 UVrX53rHeSekOtViicq0Kckr3p8RKnX14Jxef9mn.EwM8bqAPi2p4aZ6p6WmdrKYzLziyfjzmZUA
 tFVTIpa1_LE4p_Fsl4mHpprXgv50wUf04k08dIORDQfEtOKFOCc398R94UzZo2ZmM5DnKDXfsq8A
 mYrJjlCvwFv1pL0EOtilm9V3y_tF5lqKYRMqdi1eCeRfSqrfwfgbTDiqHQQ0MkBSX3eWqfHin_zY
 orFxyrWtOvqHLB1J.Xqf8wdZLQLBawlloicPQujcxH2k0ZxnjubLW3lfsdalU8OmFrc8yIJMX0vO
 9weWfR2HM38dPrbZeCmjRq8La97GZqiGMvd4TEdc1313_.7kRzYafwgMVtczvCcUaNnT3WP5W.3v
 YTabjyfGqgsTVBwtm92msDAON9JsYm7EF2_wnt.hu.5U0o3r5kOKIxNucVVI2Wgag9axc1mPxQVk
 1MTch2Be0Qh_Ks6oUV9kZzI4meLcqnKWwmzeBumJIytWHjH7F9_WWnW0Jj2vC1v5sc64LS3pV54C
 jSJkl8zRje8vuyMpSboSoXKFne9kT8H90hnZJUQYP2SLoOpxrkXGOPWYdleEHFyy_HIYM.E4Xa1R
 rS53fuHOD0oGuPDrOKse5o2JI8Ruruxt1.AIby01hjLi0JjobNnGFu2M9flTLf14X6TyS3xpKadN
 JKPX6sCLjlXkQQZ6StJjY11y4MrypH14LyvS3uDwQB2LP6lAQnRNmjYWGv5hMTdlF4iC4o2AvPZh
 61zCjPgigL9ETYh5YaSPuls1.BfGMiwS1taxuFXsvYSMmbohmsD2oCvUZSl7DNn6NgW13aejeT2.
 RsnP__i_Qy55u4XhvX.1gRuzLWooPTlyBQjUmRxFnoXqX7JwBz2IowBSwK6nlAPa1CiJJYDkmHBU
 JQq4p8jdT14K3lREkJImBgwmpDzFRMPttwankbMvCKywUEgT.KLQMVVIT7Z0.c.CPh.fXycXQgRb
 KyAXgUQmwzylCuU8QZNZiqWzG09Q8OMCcXg70YYM0Oi.REqYUNFw_c4wdzke0NHtLXew-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 09dc2fbe-b36f-407e-91ec-2ccfd9566f7f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Nov 2023 08:40:00 +0000
Received: by hermes--production-ne1-59f584dc4c-xx2tx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 80e02db3df34d67a11f28845fc3c94b6;
          Tue, 28 Nov 2023 08:39:58 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1fa1bcf1d01so1887522fac.0
        for <xenomai@lists.linux.dev>; Tue, 28 Nov 2023 00:39:58 -0800 (PST)
X-Gm-Message-State: AOJu0YwfKKeVDrSMUAySXLTQVB2+IwHPaGUUD1zN2scA6U8rhZpmfZbF
	1UD0IxvGZv+Rsf7LrTQmWMNPDi4MbSOthJG1GiE=
X-Google-Smtp-Source: AGHT+IGL6l66Otgm/FQbc2MnDdXWh71hqMY1efHQZPUxXuW0zT9lw/UHY6/KAvzD63lJtsxOpJgaHUf1Ad9CDIrkOVw=
X-Received: by 2002:a05:6870:6b07:b0:1fa:cdc:2832 with SMTP id
 mt7-20020a0568706b0700b001fa0cdc2832mr13719115oab.13.1701160797254; Tue, 28
 Nov 2023 00:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com> <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com> <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com> <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
In-Reply-To: <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
From: Mauro Salvini <mau.salvi@yahoo.com>
Date: Tue, 28 Nov 2023 09:39:46 +0100
X-Gmail-Original-Message-ID: <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
Message-ID: <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
Subject: Re: Process stuck in cobalt_monitor_enter
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
<jan.kiszka@siemens.com> ha scritto:
>
> On 27.11.23 22:02, Mauro Salvini wrote:
> > Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
> > <jan.kiszka@siemens.com> ha scritto:
> >>
> >> On 20.11.23 22:23, Mauro S. wrote:
> >>> On 13/11/23 18:54, Jan Kiszka wrote:
> >>>> On 11.11.23 16:03, Mauro S. wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
> >>>>>
> >>>>> The application I'm running (a complex application, with about 60-70 RT
> >>>>> threads) has a simple loop in the main function, something like that:
> >>>>>
> >>>>> while (stay_in) {
> >>>>>      ret = rt_buffer_read(...);  // with 50ms timeout
> >>>>>      if(ret) do_something
> >>>>> }
> >>>>>
> >>>>> The main loop reads the buffer to receive some commands from outside,
> >>>>> and when the application gets a SIGINT, the custom signal handler simply
> >>>>> does "stay_in = false" breaking the main loop, and then the program
> >>>>> closes.
> >>>>> During normal running, I can see the timer associated to the
> >>>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
> >>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
> >>>>>
> >>>>> 0    291/290         2ms970us           -           myapp
> >>>>> ...
> >>>>> 0    609/608         34ms860us           -           myapp
> >>>>>
> >>>>> I also see the thread in "w" state (waiting for a resource with timeout)
> >>>>> doing "cat cat /proc/xenomai/sched/threads":
> >>>>>
> >>>>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
> >>>>>
> >>>>> Sometimes, in a non reproducible way (at least for the moment), when the
> >>>>> process get the SIGINT it never exits, remaining in this status:
> >>>>>
> >>>>> /proc/xenomai/sched/threads:
> >>>>>    0  16328  rt     cobalt     50   -             W          flxcore
> >>>>>
> >>>>> The state becomed "W" (waiting for a resource without timeout) and in
> >>>>> fact the remaining timeout is not present in the row, also in
> >>>>> /proc/xenomai/timer/coreclk:
> >>>>>
> >>>>> 0    291609/291362         -           -           myapp
> >>>>>
> >>>>> (BTW, seems that some timeouts got lost, because scheds are many that
> >>>>> shots, and this happens also on other timers in coreclk)
> >>>>>
> >>>>> This is the backtrace in gdb:
> >>>>>
> >>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
> >>>>> /usr/lib/libcobalt.so.2
> >>>>
> >>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
> >>>>
> >>>>          /*
> >>>>           * If we got interrupted while trying to re-enter the monitor,
> >>>>           * we need to redo. In the meantime, any pending linux signal
> >>>>           * has been processed.
> >>>>           */
> >>>>          if (ret == -EINTR)
> >>>>                  ret = cobalt_monitor_enter(mon);
> >>>>
> >>>> But the problem is that the lock (monitor) is no free. Someone else
> >>>> holds it, and your interrupted reader does not proceed.
> >>>>
> >>>> If you dive into mon at this point via gdb, you may find the owner
> >>>> (according to libcobalt's view) when you resolve manually what
> >>>> get_monitor_state() does.
> >>>>
> >>>> Jan
> >>>>
> >>>
> >>> Thank you Jan.
> >>>
> >>> I rebuilt the Xenomai libraries with debugging symbols enabled.
> >>> But when I try to print the mon variable, I get
> >>>
> >>> (gdb) print mon
> >>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
> >>> (gdb) print *mon
> >>> Cannot access memory at address 0x7f3cb524e62c
> >>>
> >>> Seems that the memory address is not in the core dump, but I'm wondering
> >>> why
> >>
> >> Did you create a core dump or tried to attach live the hung process?
> >> Maybe the former was incomplete - for whatever reason.
> >>
> >> Jan
> >
> > Sorry for the delay, but every time I modify something I need to wait
> > for the issue to arise.
> >
> > I'm working on core dumps. The previous core was incomplete, as you said.
> > I needed to set the coredump_filter kernel cmdline argument to 0x7f to
> > have the complete coredump.
> >
> > Now, I can see also the values into the Xenomai lib memory space:
> >
> > (gdb) print *mon
> > $8 = {state_offset = 1047984, flags = 1, handle = 44}
> > (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
> > mon->state_offset)
> > $9 = {owner = {v = -2147483638}, flags = 0}
>
> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
> thus 10 is the owner. Unintended recursion?
>
> Jan

Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
that atomic_t is treated as a 2-complement number.
Then, the owner is the caller ID. I'm wondering how it could be a
recursion: the main thread is a simple while(..) rt_buffer_read(..);
I will investigate a bit more on it.

Thanks.

-- 
Mauro
