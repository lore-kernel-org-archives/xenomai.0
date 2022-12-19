Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308E79D7
	for <xenomai@lists.linux.dev>; Mon, 19 Dec 2022 21:51:40 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id c7so9498447qtw.8
        for <xenomai@lists.linux.dev>; Mon, 19 Dec 2022 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNYOo6LEJcH1OGxZLdyNILodJzL3Zocoe2eYWHUN10g=;
        b=Zl9r5m00LZRGDDbeBLlES2JBl0/oyK1m38ZwxTGgVTISAODDwiOCrhkneS7iKw673v
         ZDHN/7b+su5LL52rkebcJrXJvC69VSNWtJPZ4Q6iVmIDRN14Jggmmyp7g1RPzl/VfOy5
         yU+o40gXh/lqjxny/oDqB9IkEpf/oJ5fNpjnKtQbUIsM/pA0AaSbBNlpJLHDOdQtFCWV
         uESNnXVrRjMomVtRMwgMq9KzUBWpzWrW6773HTw88VzlXT72+iLkQCUb4kXPP+EYoDzo
         XXF02JE0Qc6Z2pIfP+i4vH6TpoBlocePluAThGnPUUAz8L4CmnFjdOrg6XLV3BtLSHue
         UPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNYOo6LEJcH1OGxZLdyNILodJzL3Zocoe2eYWHUN10g=;
        b=3OPUPjv67JmcXf71V0kkg36vCsDbOSaldJcO1mjp8THV8WtLxUq9ulJ4GcCzr2+KhH
         BCJTeQTWPhfxDCz68MJPy3jGGImcdSsOLptDMJwFuATPZUZr3zbLZ1JP0yYBqVpyTGti
         JFU+ReDSMnKrqCQxfhLvbd3mAoU7wKXH7psbSv8NlWy6SvZcN8pS5ocpJwW/BpA/wMKF
         mqvkeCZqE8gSNpSGLPbGRhEeumiCvUphAN38aBgXO8nnwOcMPd8TZBk+4hJ5IchzfLUN
         h/f6vnbPowJO6QJOHv2uLR9dzKmKS2mYnSXsFjINGOTSAxdcEtE2EK66pyUzSy5jSn1b
         m0Ww==
X-Gm-Message-State: ANoB5pmGZzr9JbNa0NS6oJlOH7fatPvukrl4voAEZ4mftT0rPj6qvMhq
	MNw2Yiy1WJAREadJ7ke27gtqULuy6Son3DsUL9s4eVjZ
X-Google-Smtp-Source: AA0mqf7y3mJBD2fmaYiYEazBcOTYoBuvc07DKH/49NklzV3iTHIGZdqSoHDe1DBapdV7yiyLWHxWXb/UXbqZb73AQSc=
X-Received: by 2002:ac8:6713:0:b0:3a8:2719:39c3 with SMTP id
 e19-20020ac86713000000b003a8271939c3mr843642qtp.432.1671486698974; Mon, 19
 Dec 2022 13:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org> <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
 <87359qwclj.fsf@xenomai.org> <CAAm9oxq-=MQ7KcG1G3FQsdsMWHPscRZed2FFMJK0efD04HfUiw@mail.gmail.com>
In-Reply-To: <CAAm9oxq-=MQ7KcG1G3FQsdsMWHPscRZed2FFMJK0efD04HfUiw@mail.gmail.com>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Mon, 19 Dec 2022 13:51:31 -0800
Message-ID: <CAAm9oxqWBMH9TDN8-7CdfH4ZNXCeytvPwvQWc_48vQL4KuqBNw@mail.gmail.com>
Subject: Re: Xenomai crash in timer IRQ
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

I've had no luck reproducing this condition with a simple test. Is
there any useful information in the trace I attached previously? Would
you like me to trace specific events or subsystems?

Thanks
Sri

On Fri, Dec 9, 2022 at 9:05 AM Sri Subramanian
<sridhar.subramanian@gmail.com> wrote:
>
> Hi Philippe,
>
> I was able to reproduce one crash with a trace on evl events! If there
> are other specific events you want me to include, please let me know.
> I can only get it to hang with no output (after an overnight run) if I
> include all events.
>
> To answer your questions, we don't have any custom drivers. I'll check
> the application for stale timers. I had no luck with reproducing the
> crash with a simple test but will continue to pursue it.
>
> Sri
>
> On Wed, Dec 7, 2022 at 11:58 PM Philippe Gerum <rpm@xenomai.org> wrote:
> >
> >
> > Sri Subramanian <sridhar.subramanian@gmail.com> writes:
> >
> > > Hi Philippe,
> > >
> > > With next-evl-rebase, I am not able to reproduce the crash. Instead
> > > the system reboots (from the watchdog) or hangs (if I disable the
> > > watchdog).
> > >
> > > I'll try going back to the original setup and try other experiments --
> > > maybe try to reproduce this with a test program or attach a debugger
> > > to get more data.
> > >
> >
> > Ack, at this point it should be possible to reproduce this bug with a
> > simple test case if you think the core is doing something wrong when the
> > kernel wallclock is set.
> >
> > If you have custom drivers, you may want to check the lifetime of any
> > standalone evl_timer structs it might define for correctness, to make
> > sure there is no stale timers being reprogrammed (unlikely, but worth a
> > check anyway).
> >
> > --
> > Philippe.
