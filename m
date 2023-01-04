Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F936C
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 04:31:24 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id p2so18719361ljn.7
        for <xenomai@lists.linux.dev>; Tue, 03 Jan 2023 20:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZAnl3c2SJswBwGep3XEAWp4TdwK5SorAOGd5wmc4vg=;
        b=dN//z23dfdT0hH/P5+DnytWAH5k5ZmGEBTA8UUwKpsxIuwvkm1dafJEeVEYFPi9ctQ
         VNYbrF0w3T1f4ZRkscMnsgfc9jZ1/+/BAq9Ijv5GbFTHoRmhvENGZsrdy+cKxMAhFfpX
         icExKaKcjdLcdgDlRTF41+JzuNftDAyxRzeHeQuvD0hFf322Q8T2iUoi7R6TTva6s3wH
         DpUpcJ7/ppEURaEu2cuvwL2+3XmlgvnHJpvNKleFYYtG4uG/yLL7e0oWxXJ7J2U90YbI
         GZvSoNZo+wf2zynFe3JQsMHlvODdu30u/O+iicbsluwr91Bw3cUCxoZpRrRDJg4w1oRM
         Viow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZAnl3c2SJswBwGep3XEAWp4TdwK5SorAOGd5wmc4vg=;
        b=Wpa58KyQlvJUILOCqBkEb2P26vtNNjvvzsvYjktxOL/KyRccS1d38ST9yLO4IgTFpQ
         L6AvE3+2+EC6sPxGoynkVqrPyNpoSTYU834MUEpg3xps1iw1uQIaDMRInOAt2DR8jIxM
         sI53cUm890bo6zTBFVESEAMcJ6UfQvRCJXXdQ0NqumAmxx2zbk32yu18gVplfCndHPZc
         5JE6w1/86vJ43f/Sk6b4xdyQFjlxNuc7V18YZvQVpGdPRN0DViO2u4GdUsnIQH1Y3OTh
         BkDFoesKWWvCziTzhh1KUYm22Jf9zpudyYk5R9gLWyhQsYrECwDOid2/xgggR6BUr4XS
         QExw==
X-Gm-Message-State: AFqh2kqO1gbhjclYczlEyVOBp4muHdE+1IBV412sYye+F1Pahn6F4A0A
	3aIFs3nbKSahDdjY9jpwiNXguio3Hh2u/O927CDGnA==
X-Google-Smtp-Source: AMrXdXvrqLIf+A6eAnTPhlX0cBZy0mcgq5XnZDpxhFc+bNm8R4KMM3rQpXbl9GxpiCJHjD7HQ24ri125pBen3AZQGyY=
X-Received: by 2002:a2e:8e2f:0:b0:27f:eb62:c529 with SMTP id
 r15-20020a2e8e2f000000b0027feb62c529mr507030ljk.98.1672806682416; Tue, 03 Jan
 2023 20:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
 <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
 <CALLqZ8T8ZxV2bJD7h47t_cQDkAyb9dMUpA2HOUO0x=0_0Pht2A@mail.gmail.com>
 <15331e9004e2a34e03bada655de9895531befaa8.camel@siemens.com>
 <dda4a74d-84d2-7282-7517-74ec4cd58436@siemens.com> <d00c3c982f41ead3147dcfb2900f2a55606eb9aa.camel@siemens.com>
 <945e3654-e6bb-18ab-9af6-0105cfd15964@siemens.com>
In-Reply-To: <945e3654-e6bb-18ab-9af6-0105cfd15964@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 3 Jan 2023 23:31:11 -0500
Message-ID: <CALLqZ8RiiNhgKvEL22Dv_hDJbp2rX28N8Gs9038X0o01W8cj0Q@mail.gmail.com>
Subject: Re: Synchronization request of supported ipipe kernel versions
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 2, 2023 at 7:38 AM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On 15.12.22 16:25, Florian Bezdeka wrote:
> > On Tue, 2022-11-29 at 08:01 +0100, Jan Kiszka wrote:
> >> On 28.11.22 17:36, Florian Bezdeka wrote:
> >>> On Sun, 2022-11-27 at 22:09 -0500, Greg Gallagher wrote:
> >>>> On Fri, Nov 25, 2022 at 4:13 PM Greg Gallagher <greg@embeddedgreg.co=
m> wrote:
> >>>>>
> >>>>> On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
> >>>>> <florian.bezdeka@siemens.com> wrote:
> >>>>>>
> >>>>>> Hi Jan, Hi Greg,
> >>>>>>
> >>>>>> while tracking down some ipipe issues that appeared while trying t=
o
> >>>>>> modernize the CI toolchain (Debian 11 =3D> 12 update) I had massiv=
e
> >>>>>> problems with all the different kernel versions that we have for
> >>>>>> different architectures.
> >>>>>>
> >>>>>> Currently we have:
> >>>>>>
> >>>>>>             4.19             5.4
> >>>>>> armhf   4.19.229-cip67+    5.4.180+
> >>>>>> arm64   4.19.144+          5.4.180+
> >>>>>> amd64   4.19.264-cip84+    5.4.223+
> >>>>>>
> >>>>>>
> >>>>>> Might I request to synchronize them?
> >>>>>>
> >>>>>> It would simplify things a lot if
> >>>>>>   - all 4.19 versions would be based on the same patch level
> >>>>>>   - all 5.4  versions would be based on the same patch level
> >>>>>>   - The 4.19 and 5.4 versions would be based on the same stable
> >>>>>>     patch set. Currently 4.19.266 and 5.4.224 are recent versions
> >>>>>>     with the "same" set of patches applied.
> >>>>>>
> >>>>>> Concrete example:
> >>>>>>
> >>>>>> I had to update my 4.19 baseline to recent 4.19.264 to make sure t=
hat
> >>>>>> I'm not hunting for something that is already fixed. With that I p=
ulled
> >>>>>> in the following upstream commit:
> >>>>>>
> >>>>>> 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/un=
throttle")
> >>>>>>
> >>>>>> This commit breaks (or will break) the pl011 driver in case ipipe =
is
> >>>>>> enabled. It is part of 4.19.253 and 5.4.207. The only tree that al=
ready
> >>>>>> has this commit is for amd64, but it's not a real problem as x86
> >>>>>> normally doesn't require this driver.
> >>>>>>
> >>>>>> a) I'm currently not able to fix that for arm/arm64
> >>>>>>    (too old but not yet affected)
> >>>>>> b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
> >>>>>>    patch level I have to backport for each arch/ipipe.
> >>>>>>
> >>>>>> Let me know what you think!
> >>>>>>
> >>>>>> Regards,
> >>>>>> Florian
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Sorry if this is a double reply I think my original didn't go throu=
gh.
> >>>>> I=E2=80=99m good with this, I can update the arm/arm64 branches thi=
s weekend.
> >>>>>
> >>>>> -Greg
> >>>>
> >>>> I've got my local branches based on 4.19.266 and 5.4.224, running
> >>>> smoke tests.  I haven't looked into the pl011 driver breaking yet, d=
o
> >>>> we need that fixed before I update 4.19 and 5.4 ipipe? Once I run my
> >>>> local smoke tests I should be ready to update the branches tomorrow =
or
> >>>> Tuesday.
> >
> > Hi Greg,
> >
> > I revisited the pl011 driver problem today and was unable to reproduce
> > so far. I will continue for some time but it might be that the real
> > issue (system hang) is triggered by the wlan driver.
>
> There has been some upstream activity recently. Upstream commit
> 032d5a71ed378ffc6a2d41a187d8488a4f9fe415 [1] touches pl011_unthrottle_rx
> again, which according to the changelog should fix some data loss.
>
> The mentioned commit has been backported to 6.1, 6.0 and 5.15. I guess
> older stable branches will follow soon.
>
> I'm quite optimistic that this fixes my problem.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/tty/serial/amba-pl011.c?id=3D032d5a71ed378ffc6a2d41a187d8488a4f9fe=
415
>
> >
> > Any findings from your tests? Can you update the trees?
>
> Greg, could you update the ARM trees after next stable release?
>
> Florian
>
Sounds good, I have some other updates I need to apply as well.

Thanks

Greg
