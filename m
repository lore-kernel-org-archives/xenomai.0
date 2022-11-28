Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BF364
	for <xenomai@lists.linux.dev>; Mon, 28 Nov 2022 03:09:50 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id y5so2934686lji.0
        for <xenomai@lists.linux.dev>; Sun, 27 Nov 2022 19:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaiistfbusuusykI2c0QyQueMoXZL53VhDGpR977gC0=;
        b=R4LZk5sopFBixPmWpMdF1YJO35U/f8vptfbPMlaq0W5f+WkjTEGzGx9pp+FBV30f+9
         fM0jMdeWkT49NGrY4s52R2DbcEqE/BSuWT0xTZJw68Jh9LPLgcfRDrQVqNXRUeylATjv
         7PBPfWXbalObKgjSRFHFA0ayISDn2bXnQMcvf5dbebHR+HEZC+xEITbKfvFwez74uvDb
         5hUfgPQUrQB580JJ1pdGj5iTTeTnsJTBtZk5E+SrLO6Z3nyjhyLIizWR3yuWWWLOIXGm
         xaxh65LyTYPQlDj3NFDQNSfcYPHWnGDjkUF9bdLc/HmCZZ6TRotKvfs267Eg6fY/hP//
         47SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaiistfbusuusykI2c0QyQueMoXZL53VhDGpR977gC0=;
        b=79RPbInZ3/MR5TDiRt0wknDa+oTzsWLW2ynGyxBPV1WYC3i+A3lC/Rv0PbjGCijO/H
         B71oLB11F5a1JePrbW2+jxvf1hjSOlgNSO8TBvOydKv5ANo5ZPgqpyGdqs0qclGN5l61
         8Ts13zsfqiZg3PI/mo1keIoXCkgMXHBaUdyASjw028IbBhV0JmgJKxZQL1QEnYNPTU/7
         LlbK1lkaPu6MkHzhEbjNX1sjaFipHi/uv/6NT/DccbAMAjmqRxIDE0Q/kp+pPyb1uv8h
         izdjrlgp9BMgIN6YCArOte9MT/u51fjdB20lsqh7nS+wyscgpErOXSKGGJ/UgXh1YFB0
         bgYQ==
X-Gm-Message-State: ANoB5pmeYWHQke3D7KUs6vLzqMrCEeV7bpomVOtmkFP9w2FSMy08yZiK
	vpsS49Hfrn/Wa5RxELdWFh3AkZilYW8BOuCALHVV1+RmtHM7mg==
X-Google-Smtp-Source: AA0mqf49HKR7cZnKPehDnLkTQIxCNfZjOzoc1LQo+YxDToeQbuqI6VxptMuOns1Pj1db75LrwOeX7uw/l7R33a+iN1Y=
X-Received: by 2002:a2e:b5d4:0:b0:279:5fa:8e7c with SMTP id
 g20-20020a2eb5d4000000b0027905fa8e7cmr15026277ljn.62.1669604988776; Sun, 27
 Nov 2022 19:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com> <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
In-Reply-To: <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 27 Nov 2022 22:09:36 -0500
Message-ID: <CALLqZ8T8ZxV2bJD7h47t_cQDkAyb9dMUpA2HOUO0x=0_0Pht2A@mail.gmail.com>
Subject: Re: Synchronization request of supported ipipe kernel versions
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 4:13 PM Greg Gallagher <greg@embeddedgreg.com> wrot=
e:
>
> On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >
> > Hi Jan, Hi Greg,
> >
> > while tracking down some ipipe issues that appeared while trying to
> > modernize the CI toolchain (Debian 11 =3D> 12 update) I had massive
> > problems with all the different kernel versions that we have for
> > different architectures.
> >
> > Currently we have:
> >
> >             4.19             5.4
> > armhf   4.19.229-cip67+    5.4.180+
> > arm64   4.19.144+          5.4.180+
> > amd64   4.19.264-cip84+    5.4.223+
> >
> >
> > Might I request to synchronize them?
> >
> > It would simplify things a lot if
> >   - all 4.19 versions would be based on the same patch level
> >   - all 5.4  versions would be based on the same patch level
> >   - The 4.19 and 5.4 versions would be based on the same stable
> >     patch set. Currently 4.19.266 and 5.4.224 are recent versions
> >     with the "same" set of patches applied.
> >
> > Concrete example:
> >
> > I had to update my 4.19 baseline to recent 4.19.264 to make sure that
> > I'm not hunting for something that is already fixed. With that I pulled
> > in the following upstream commit:
> >
> > 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrot=
tle")
> >
> > This commit breaks (or will break) the pl011 driver in case ipipe is
> > enabled. It is part of 4.19.253 and 5.4.207. The only tree that already
> > has this commit is for amd64, but it's not a real problem as x86
> > normally doesn't require this driver.
> >
> > a) I'm currently not able to fix that for arm/arm64
> >    (too old but not yet affected)
> > b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
> >    patch level I have to backport for each arch/ipipe.
> >
> > Let me know what you think!
> >
> > Regards,
> > Florian
> >
> >
> >
>
> Sorry if this is a double reply I think my original didn't go through.
> I=E2=80=99m good with this, I can update the arm/arm64 branches this week=
end.
>
> -Greg

I've got my local branches based on 4.19.266 and 5.4.224, running
smoke tests.  I haven't looked into the pl011 driver breaking yet, do
we need that fixed before I update 4.19 and 5.4 ipipe? Once I run my
local smoke tests I should be ready to update the branches tomorrow or
Tuesday.

-Greg
