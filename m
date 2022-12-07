Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690133E7
	for <xenomai@lists.linux.dev>; Wed,  7 Dec 2022 21:01:03 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id x24so10250151qkf.5
        for <xenomai@lists.linux.dev>; Wed, 07 Dec 2022 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl691rA2JgN6SegXxU3dvjuTtsdMiSLtnhXXPBwQwrI=;
        b=hSgjQ/rtB/xhGPvmSJFoNiuowynPDyzXevwNEVkI4ItjBmN8IWAPj4QZFaa1+kokly
         z8MnxtFAU9Hm1dPIQXrC1dvv+JLpYWenrwqEtniQtpza7YKYcmr/Ee8rgwQLNFscrP91
         kZ6JG5dCrwkjemDPRR9ASWGq4B4aq8oBQv2DC4BWG60fXBfIyuEcIC+nAqDP+6ey5QqV
         OLrqgBTBqqwPuI+OqEnttrcnPFci8HbaJPtydWLKmYSfWWlPpk4if9sWeo5wFa8ThV0U
         yecipZag6ojf94g+letRZPttTx9RrxY72r/lefzCJ1mxGYMqVKqwvC/BvtsMQrDx5z1j
         LfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl691rA2JgN6SegXxU3dvjuTtsdMiSLtnhXXPBwQwrI=;
        b=g9konPEq99xzkVuHOpQoDCUuDTB0v1IEAQznV/XAuiXicrWvo2dNgaoGNoAHvZqSOj
         dV2zrVY98fRrFo9snEgz0M4yBxRT6Omqu0wY5NNS5+68qNvp1Mb7sLEaUnp5blvhsuAV
         b5ghxzld9CBRj4Wtdww7LnBtg1mhZGtJ14idj+x2K7LK/3l+HjeRS88ryxEce4ds2VsO
         WtKSCUqI3heFECbm6DON4OpleKyjybzw4pNr6DsakppL6/AG+m9aua7FP2I3B5/3s13t
         e4Mtj5o4D6BIztXNSNV6kaI0hM2fI+Hn96ozIa6tHblD/qdQC+5OVaH0V7guSxZMet8T
         /i8g==
X-Gm-Message-State: ANoB5pnACLS7O8CyI+uXeoFXK5ROIUZAo0d+rElpPGMOaC2tXmUpGym6
	GQUIVcWsCC4MAvxJu8FK/I42Di0qtRpRDrEtcDmVBS8n
X-Google-Smtp-Source: AA0mqf7huhqXpdaw4QJY0TG6dpWV8N9c2zvQhWakAtGLUUs4/EetxS77ALK5JPq1FZFELXb66M0UzaosgY7T5x+9bis=
X-Received: by 2002:a37:6047:0:b0:6ea:6c07:6e57 with SMTP id
 u68-20020a376047000000b006ea6c076e57mr72619949qkb.254.1670446862419; Wed, 07
 Dec 2022 13:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org>
In-Reply-To: <87ilish1z0.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Wed, 7 Dec 2022 13:00:51 -0800
Message-ID: <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
Subject: Re: Xenomai crash in timer IRQ
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

With next-evl-rebase, I am not able to reproduce the crash. Instead
the system reboots (from the watchdog) or hangs (if I disable the
watchdog).

I'll try going back to the original setup and try other experiments --
maybe try to reproduce this with a test program or attach a debugger
to get more data.

Sri

On Sat, Dec 3, 2022 at 8:43 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Philippe Gerum <rpm@xenomai.org> writes:
>
> > Sri Subramanian <sridhar.subramanian@gmail.com> writes:
> >
> >> Hello,
> >>
> >> I have an application waking up every 500us (waiting with an
> >> oob_read() on an EVL monotonic clock) and taking action.
> >>
> >> The application also has an interface to enable/disable NTP and set
> >> the clock manually. The system will run over days without any issues.
> >> But if NTP is disabled, and the clock is set manually, then NTP is
> >> re-enabled, a short time after (order of minutes), the OS crashes and
> >> the system reboots. It is reproducible every time.
> >>
>
> I cannot reproduce this using a plain hwclock -s while latmus
> runs.
>
> >> Should the monotonic clock be affected by an RTC clock setting? I was
> >> assuming not, but I am not so sure now.
> >>
> >
> > Not EVL_CLOCK_MONOTONIC.
> >
> >> Hardware environment: Raspberry PI CM4 with a standard CM4-IO board.
> >> Xenomai tag: 5.15.77-evl-rebase
> >> Stack and config as below:
> >>
> >> Thanks for any help,
> >> Sri
> >> ==========
> >> [  363.094612] CPU: 3 PID: 706 Comm: EcatCyclic-tid_ Tainted: G
> >>  C        5.15.35-xeno-v5.15.77-evl1-rebase #1
> >> [  363.094617] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
> >> [  363.094619] IRQ stage: Linux
> >> [  363.094621] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> [  363.094626] pc : evl_get_timer_overruns+0x1b8/0x1c4
> >> [  363.094630] lr : evl_get_timer_overruns+0x54/0x1c4
> >> [  363.094634] sp : ffffffc00a283c40
> >> [  363.094635] x29: ffffffc00a283c40 x28: 0000000000000000 x27: ffffff810103acc0
> >> [  363.094642] x26: ffffff810103ac00 x25: ffffffc008deb320 x24: ffffffc008c6aae8
> >> [  363.094647] x23: 0000000000000000 x22: ffffff81fefde3e0 x21: 0000000000000001
> >> [  363.094652] x20: 000000548931dc32 x19: ffffff810103ac00 x18: 0000000000000000
> >> [  363.094658] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
> >> [  363.094662] x14: 0000000000000000 x13: ffffffc00898a790 x12: 00000000fa83b2da
> >> [  363.094667] x11: 0000000000000029 x10: 0000000000000930 x9 : ffffffc00a283c30
> >> [  363.094673] x8 : ffffff811c496810 x7 : 000000000000b7df x6 : 00000004a520e245
> >> [  363.094678] x5 : 00ffffffffffffff x4 : 0011bdb637657ad8 x3 : 000000000007a120
> >> [  363.094683] x2 : 0000000000000001 x1 : 0000000000000005 x0 : 0000000000000005
> >> [  363.094688] Call trace:
> >> [  363.094691]  evl_get_timer_overruns+0x1b8/0x1c4
> >> [  363.094695]  timerfd_oob_read+0x200/0x290
>
> Since the crash is easily reproducible, you should be able to trace it
> directly into the kernel code, i.e. from evl_get_timer_overruns(), to
> figure out which line is causing this. Or you could disassemble your
> vmlinux image compiled with CONFIG_DEBUG_INFO set, and look for a
> statement which matches $pc as reported in the register dump.
>
> I pushed a change addressing a potential load tearing issue in the timer
> code to the next-evl-rebase. I don't think this fixes the issue you
> observed, but at the very least you may want that change in.
>
> Next step for you would be to enable the ftracer (using next-evl-rebase,
> it contains fixes you need for tracing), then post a snapshot of the
> global trace buffer until the crash happens. ftrace_dump_on_oops may be
> useful if you cannot access the machine after the oops, with a bit of
> luck the snapshot should be sent to the console stream.
>
> --
> Philippe.
