Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495B358AF
	for <xenomai@lists.linux.dev>; Wed, 29 Nov 2023 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iTQ97J8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701275087; bh=B5kp4h1MrOMh/9GlWGRldHffFKtF4euNCkys01dt7pI=; h=References:In-Reply-To:From:Date:Subject:To:Cc:From:Subject:Reply-To; b=iTQ97J8etqVxe3p5ngoEtYV1k5BFa60X+Bt+HZH2qiRB2WGJ5vmMj77VhA5UatIQo4DjAgQHy0lspyIPT8VEYRsIL2huaq9MZZFPw7SxB+twUwhMqTEA7wUgWgdcvg3ejJr2Pj4OqATc8o/wXmxzgR93iYGnl32z1dqoRYqhlR+b6VL8cyFWxp4eT1QGqcNDLeBjvf+9IMzVzGJIwrW7w0vEA8wiDSyGI9QvdIJS0dz0JZTArvKYvaDBpt0l6RyrurE2e9AY9bPaRTf+RE3pTqNubY22lnUM//4gR0vIQmWHPhXkYzc/Dihv7Eq9FQCmnuoGjOhbsm9VnQS74EZiUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701275087; bh=XdfpF663rGsQ2d+PrTU+6RO7Lrbl+InINz123JhwS4H=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=s40+czJsH4/f3P/kJ8RBjQgjrw475Fhn3/SKSPrn09z8ijGDvlZ/0d+ApOs78kRfxLg9bFsxU0vrL58mE2hrW9ZL6HdY4nWfiyYg1dqsIwkmPnWhXpR94yk4MwzDXadOSuSC7iQGd3tClMgVJ6wdcH1wL9oITn3zPIJOzrjAE7lWqbCw6AW0ghZLt9jXoTClm4/ze+w3WJRNAvp/EwOViJM/Zaqr0ZRVqVN3p8afIlg9mYTl4CUSORxvn+SsQfjDix9k62I5QtDaFKvxWSG1R8qL5Ly6Q1BKQN9y8lPvdndRZMIh6hko4+PH9e1ELRc2Fvx84n2ITRW+On3+Kr4WrQ==
X-YMail-OSG: 0_vTteAVM1md_kE3ckKzYLwLh7m4i4Bz5f2G8XkBp0jvejjDFfJqcihfLSmnhjV
 4Sy3ecxsXahEiyUZw6VAn2i_VSepM_CP6KdqGQgaSqSu06pPXJ.S8dpRoNQdGyuFhczXkSEPqtSC
 jWWCBdsJB6PwsrjaWxc_No4cqNDoAJFhGqNsvtXH48uiz9_isqz8MnaaC2GZ7ub5ZK3W_ix1Dw9L
 FPlgQLBM1znGaTHhVumOypNmfcAznTO8PXnslh3aQiLQjCDengdJfzTtLxwZB5wOk6Ww5HKSJX04
 rmOV4XcxfYRnB8XFpF8rZQbI6xdHhqh4w0YyhCM1BbuBbSUkX9kRW5FYhRuinw7b9wIaxBhiAVm5
 Ff69S.A.D3B_YkFzdH3Yc2Iao2oY0K2.xzd20cBS7lIPCK8UZCYI83R3CAqf7cgJODwV6o12yQGc
 Dbf8pOkVM0RG.1Tx31Y60b10b3_Ij.i53HtLda0Pz4rytEtCOPtVMxmxT00edm6JMjfY5_HjCrap
 EDZE52ZpzzL3fP7ds9pVRwBNPb7nScs8MPB6WlUxJIv1fZ693.9_h0eryzIyTI.Hv1uHt90lLzdF
 oX4X0JTczRdET6TI5.HLj_a.9UKatpPVFetYaKKFXRLO3mnc4lQmw0c5WKwjtcLQJzIV3Y4QfWF4
 s8wAmJ1VVgJRgFPQGWs00PBUAHqnam8AwO_rVlYIa4hqE3rn48vLLIEDK7xcXIN9Ru5PjpaPQSZK
 V36oJNz_4Ue0TjfNgtbBrrJbtXE880dO6T8UB9OTYg1AkoHwNWPOVIA_idRN09BBLeo4dowE8_a_
 vQjxvYbvGSJ7wadFQxV_pP7OKOJ7HBczuVuO7Ly24mU5MIvLExHsn52d65xQBlxcZlk_BTfLf7Df
 QCcPypicaji8.mbMYQCqqnK83p74kieqv38q8tDuqEqFqLHAxC743UOw.wirqJG5mg7DJVyLZ0sX
 SIRNJzqtmbzeIXNGyX46EMlgo3JOhWqaReoJ30W5xkfs.jdLKC3ibeUZzuDSBnKGTEIbi8rcVUqP
 7EY.xP27qZ2kE9gBfKAlcQiXBtQ88GZ2NA7.OhneiYpjJEUY2qNXOd0rGdGq4aeBIthbE0RMFfWy
 2T_FH3ATOfOtcer4MeToDoEFY7I7FmnArNNFTgjvI39U8YGm_irhfYa3Mn6suFNqmGwfYHuvWjeG
 E5zv3e4.zyqE51yHAWZgyEuwC0DuXrkGtBz3..6beeNAB518eyRmhWO.i6tIMiTewdISxd1szyWs
 Y3a_fAtdVMRFPG5Jr0JX1Fr2YXI9XxBkQqiB5eO5ko9Y5wqEBhMHioRuHCma1Py4XtsyeIPm4q6u
 1Ft2Z7OSb7SfCrcMsBX_rmxqqsKxP0ErEuPRIbbZy7CVaACj_euBebyNJRUKaow4v36ZePHQCw4Z
 Cz2VkYP88LcR0VUSIjNtlvSRt_C9od6ETQpaLZCQTkkGmhnXNSTzZ98QyjcO1v1t9PuzDVtSQMMx
 4VM8rM3NLL9QuGefkhPqfdqpFWSzu8343gN5vJL9qITDPZsZaG_VP_N6_1NnJlMiRXW4YtAxXIiX
 v4U9iBjLnNlUZVxfXKt54q44T949cBTOOAlW5U890Zosdn31MckjD4BDL0o8rIJdgYrlgAFDi7P6
 vVG6X1USIuE5v_9rBmfGzPhnVdDyPdro.wf8Ji40kBP_nlPu1GIZV_nSWn2T23_mOOCP9jabJO3i
 lmDgNpP6MD3wPP8dDthj5CPUDqkl_hcgDIgfPuKHVDpXMeRKmK4i.opPEHBqAMP1J7lv8t0bgY.R
 G2PmxI91Wg.s4Tcg1uwtaexlJ4NRwiXCprW0qG1NfbBUw4T01AGHFkAUi_ZDpWpULGcEzEg31FFu
 d5kvHyV0FMrid4EKL5HUm_Z2rXsEXH.7mZ31ipU8gAW.NlVQzVL6JpAZWxtad1fhMy4x2hRp9C1a
 vHaHIpVAy7LnLlRqCCz7cdm49hLAdl.lXrephzKMODLsBZRzsgEL3dX.36XGQLS1KGXptpRqoDFV
 I5gvIS1TDWksLpUsXS5NwM1Tt40vOsNc3RiSCLCl._Llv4xvbeSoW9macUVO42T39tPTxR3bF563
 HkutsLmnSqtA41tMB9a0xNh16LfnKi5UsfHh9KWjXg5gLEUFVe0ltH_IaTDOY1r5ZRBax_geSDnt
 9BbGTA9NgUQqqm7nBhNaKZ6I3GGt4llKFnMM0hvt8gRH6uByJ9iifn7L7V5.Lmbwu
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 326b5c3b-06e9-472a-a58d-f62cb1bfc7cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 29 Nov 2023 16:24:47 +0000
Received: by hermes--production-ne1-59f584dc4c-687wx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 90fd35c1ccae18691aff9a4b5969b416;
          Wed, 29 Nov 2023 16:24:42 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce2988d62eso4118991a34.1
        for <xenomai@lists.linux.dev>; Wed, 29 Nov 2023 08:24:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwgpxYQgmuxWVIh3Q1aJtEGtGEnp8zdVQeMAt54SCz7Wdslm933
	IhNLf95AAISj+vy4gNe66BMkApLJFBDwrVtBZJg=
X-Google-Smtp-Source: AGHT+IHIuA8JQMrUji7Oe8s6l7/ohqgfQXMZlq3lUBOUehzo4MASBka6j4h5JasNBIDFRHmsYgtzldDu+q/ATDeHReA=
X-Received: by 2002:a05:6870:80c9:b0:1fa:2b53:cbef with SMTP id
 r9-20020a05687080c900b001fa2b53cbefmr16875080oab.32.1701275080785; Wed, 29
 Nov 2023 08:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com> <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com> <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com> <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
In-Reply-To: <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
From: Mauro Salvini <mau.salvi@yahoo.com>
Date: Wed, 29 Nov 2023 17:24:29 +0100
X-Gmail-Original-Message-ID: <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
Message-ID: <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
Subject: Re: Process stuck in cobalt_monitor_enter
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
<mau.salvi@yahoo.com> ha scritto:
>
> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
> <jan.kiszka@siemens.com> ha scritto:
> >
> > On 27.11.23 22:02, Mauro Salvini wrote:
> > > Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
> > > <jan.kiszka@siemens.com> ha scritto:
> > >>
> > >> On 20.11.23 22:23, Mauro S. wrote:
> > >>> On 13/11/23 18:54, Jan Kiszka wrote:
> > >>>> On 11.11.23 16:03, Mauro S. wrote:
> > >>>>> Hi all,
> > >>>>>
> > >>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
> > >>>>>
> > >>>>> The application I'm running (a complex application, with about 60-70 RT
> > >>>>> threads) has a simple loop in the main function, something like that:
> > >>>>>
> > >>>>> while (stay_in) {
> > >>>>>      ret = rt_buffer_read(...);  // with 50ms timeout
> > >>>>>      if(ret) do_something
> > >>>>> }
> > >>>>>
> > >>>>> The main loop reads the buffer to receive some commands from outside,
> > >>>>> and when the application gets a SIGINT, the custom signal handler simply
> > >>>>> does "stay_in = false" breaking the main loop, and then the program
> > >>>>> closes.
> > >>>>> During normal running, I can see the timer associated to the
> > >>>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
> > >>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
> > >>>>>
> > >>>>> 0    291/290         2ms970us           -           myapp
> > >>>>> ...
> > >>>>> 0    609/608         34ms860us           -           myapp
> > >>>>>
> > >>>>> I also see the thread in "w" state (waiting for a resource with timeout)
> > >>>>> doing "cat cat /proc/xenomai/sched/threads":
> > >>>>>
> > >>>>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
> > >>>>>
> > >>>>> Sometimes, in a non reproducible way (at least for the moment), when the
> > >>>>> process get the SIGINT it never exits, remaining in this status:
> > >>>>>
> > >>>>> /proc/xenomai/sched/threads:
> > >>>>>    0  16328  rt     cobalt     50   -             W          flxcore
> > >>>>>
> > >>>>> The state becomed "W" (waiting for a resource without timeout) and in
> > >>>>> fact the remaining timeout is not present in the row, also in
> > >>>>> /proc/xenomai/timer/coreclk:
> > >>>>>
> > >>>>> 0    291609/291362         -           -           myapp
> > >>>>>
> > >>>>> (BTW, seems that some timeouts got lost, because scheds are many that
> > >>>>> shots, and this happens also on other timers in coreclk)
> > >>>>>
> > >>>>> This is the backtrace in gdb:
> > >>>>>
> > >>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
> > >>>>> /usr/lib/libcobalt.so.2
> > >>>>
> > >>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
> > >>>>
> > >>>>          /*
> > >>>>           * If we got interrupted while trying to re-enter the monitor,
> > >>>>           * we need to redo. In the meantime, any pending linux signal
> > >>>>           * has been processed.
> > >>>>           */
> > >>>>          if (ret == -EINTR)
> > >>>>                  ret = cobalt_monitor_enter(mon);
> > >>>>
> > >>>> But the problem is that the lock (monitor) is no free. Someone else
> > >>>> holds it, and your interrupted reader does not proceed.
> > >>>>
> > >>>> If you dive into mon at this point via gdb, you may find the owner
> > >>>> (according to libcobalt's view) when you resolve manually what
> > >>>> get_monitor_state() does.
> > >>>>
> > >>>> Jan
> > >>>>
> > >>>
> > >>> Thank you Jan.
> > >>>
> > >>> I rebuilt the Xenomai libraries with debugging symbols enabled.
> > >>> But when I try to print the mon variable, I get
> > >>>
> > >>> (gdb) print mon
> > >>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
> > >>> (gdb) print *mon
> > >>> Cannot access memory at address 0x7f3cb524e62c
> > >>>
> > >>> Seems that the memory address is not in the core dump, but I'm wondering
> > >>> why
> > >>
> > >> Did you create a core dump or tried to attach live the hung process?
> > >> Maybe the former was incomplete - for whatever reason.
> > >>
> > >> Jan
> > >
> > > Sorry for the delay, but every time I modify something I need to wait
> > > for the issue to arise.
> > >
> > > I'm working on core dumps. The previous core was incomplete, as you said.
> > > I needed to set the coredump_filter kernel cmdline argument to 0x7f to
> > > have the complete coredump.
> > >
> > > Now, I can see also the values into the Xenomai lib memory space:
> > >
> > > (gdb) print *mon
> > > $8 = {state_offset = 1047984, flags = 1, handle = 44}
> > > (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
> > > mon->state_offset)
> > > $9 = {owner = {v = -2147483638}, flags = 0}
> >
> > This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
> > thus 10 is the owner. Unintended recursion?
> >
> > Jan
>
> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
> that atomic_t is treated as a 2-complement number.
> Then, the owner is the caller ID. I'm wondering how it could be a
> recursion: the main thread is a simple while(..) rt_buffer_read(..);
> I will investigate a bit more on it.
>
> Thanks.

Maybe I found something: in the backtrace of every core (cores are
generated with SIGABRT) the first two frames are referring both to
cobalt_monitor_enter(): frame #0 is at the source line where the
program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
function declaration source line:

Program terminated with signal SIGABRT, Aborted.
#0  cobalt_monitor_enter (mon=0x7f0d7583862c)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
[Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
#0  cobalt_monitor_enter (mon=0x7f0d7583862c)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
#1  cobalt_monitor_enter (mon=0x7f0d7583862c)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
#2  0x00007f0d76612748 in cobalt_monitor_wait
(mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
ts=ts@entry=0x7ffe7d7380f0)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
#3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
#4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
    at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
#5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
ptr=<optimized out>, size=<optimized out>,
    abs_timeout=0x7ffe7d7380f0) at
../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
#6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
size=19216, ptr=0x55b104844180 <Request>,
    bf=0x55b104844168 <ReqBuf>)
    at /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
#7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410

Could that be a clue?

TIA

-- 
Mauro
