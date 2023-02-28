Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85F7EF
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 05:18:23 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id b10so8988695ljr.0
        for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJNKvv1uB/44alPr4dG5KiOHq+5Ft814nmD6Ng6w7A=;
        b=nMFm+CIrqq/HlPjgn7FQujAn8qD1ddbpXi2IvTtyoKsS8BInPHkgGD20dytrCymnWk
         PqiouTZ/zyn2MFTeD9h/jJX7++yl9XybZ2iQARfNDoILks59Rt4cKk3ITgRxuW5whhkb
         Du9iQ2J43SNhwptsYrwpE+5BKwEoeIDFH5uL7hMy23A2OO6L00TeuVltOCfOquaUg6G0
         YYee44tu/UMyFmpCg1CH0u2BM2XdNaKeJhA3PS+gdtICdwJa7RUDDIOzWpgi92NeEeKt
         do2VLFKMYDrOF+khl2xcZIzUmMEhyJCzv1fbHUk0yYCh2neYEzuzwm+BokQa9K/LAmsc
         DC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCJNKvv1uB/44alPr4dG5KiOHq+5Ft814nmD6Ng6w7A=;
        b=WXIRxe/jBzcHJ+g0Mt3p5u7KSK3AtFa8yFqWsvDICZCwzmtclo0fqOmUi09GzCD85t
         k2Dbse1q2JymhzVpd+GxBVvCHOtQu4+fmX2Eb8bPgwIhMEtvsHR7CuP1D9vID9SCUjwM
         p4xLt1W65PHtwmo7lpIZ+7AN9twtaN7yo43ZAVP3P3o1vr2SGbF3eeKyZrlMS4/TvvLQ
         yDVIRxR7aQalDQkMCcD5G7d98J6Df0xHMZnnutvL6nNNBnAZCO7wEcIwrQR1It3u+C5i
         Hdjt6MVROrfnFV7kGm0OWlzoIEPlJvJJIVuz6F5AMt6DQrM97eWbCzDKvJDvwuAy3TtL
         dIww==
X-Gm-Message-State: AO0yUKUO38U4WZOKpNPon7lbHb3IOLoargnIIdkMKOJnbZTMDS+xe1TL
	ltQ2chq5pKPDxmR956MZ1GDSpRQ2L2e8H6+Vg/g/og==
X-Google-Smtp-Source: AK7set8cWMeyIw7fkwqItc/QT+iVGxZonVCVGd9l5DWkPBXX9T4wfn7IgihwFTm/qcxYqFSUG8Ka0fuFoG5qUGuWnR0=
X-Received: by 2002:a2e:b5af:0:b0:295:af0c:33aa with SMTP id
 f15-20020a2eb5af000000b00295af0c33aamr349468ljn.7.1677561501824; Mon, 27 Feb
 2023 21:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com> <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
In-Reply-To: <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 28 Feb 2023 00:18:10 -0500
Message-ID: <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.02.23 06:27, Greg Gallagher wrote:
> > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
> >>
> >> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> >> <florian.bezdeka@siemens.com> wrote:
> >>>
> >>> Hi Greg!
> >>>
> >>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
> >>>> Hi,
> >>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
> >>>> working on stable release 231 since it contains the patch that
> >>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
> >>>> with using 231 let me know.  Finishing my local test this week.
> >>>
> >>> Thanks for letting us know. If there is a chance that you publish a
> >>> public available -rc somewhere, it would be possible to tweak our CI a
> >>> bit and trigger a full test run in our lab.
> >>>
> >>> That should help us to identify any leftovers upfront.
> >>>
> >>> Best regards,
> >>> Florian
> >>>
> >>>
> >>>>
> >>>> Thanks
> >>>>
> >>>> Greg
> >>>>
> >>>
> >>
> >> I'll get -rc releases out this weekend.  I'll post back once they are
> >> done and the -rc tags are pushed up.
> >>
> >> Thanks
> >>
> >> Greg
> >
> > Hi Florian,
> >    I have the rc releases ready to go.  I'm going to push them up to
> > the ipipe tree with the kernel update (5.4.231).  Does the CI system
> > pull the current ipipe release based on the tag?  Would pushing up the
> > new point release (5.4.231) break the current CI?
>
> We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
> ipipe-arm[64], see [1]. It just takes manual triggers so far as there
> are no ci files in our kernel trees (unlike the xenomai repo itself).
>
> Jan
>
> [1]
> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

I put the beta releases here:

https://github.com/ggallagher31/ipipe-arm
https://github.com/ggallagher31/ipipe-arm64

Branch names are the same as gitlab, once CI tests out the branches
where are the results located? I'll look to see what debugging is
needed.

Thanks

Greg
