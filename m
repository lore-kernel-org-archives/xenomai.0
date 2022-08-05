Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94810E0
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 14:00:58 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id j2so2564532vsp.1
        for <xenomai@lists.linux.dev>; Fri, 05 Aug 2022 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLTKYcXZjnJzgL8+u1qWnRCoPH2awcb+CcZmXU1B3xo=;
        b=XcfEv7KG7Y6qUP3H+Bmnb8LhF2wXjXxAio6s+nyTvHDZt0QJu7WwuJG1ivTGlfIXkP
         Ve/lwSw0cN5bYfNx/z7IoaHCOvzRiLJGsp5c2+F1nP7T45p7nsNYB0WJy1QU4/xpguHH
         Gd6Yn+6TbIX6qNOTe79yr6n4y5wA4RtcmCarQC+oRPIexevLqoVmHOsgetcyMNzu37F5
         1Q5T0RrqH5EkRB7nOH3tlFAbqnQbvnnwU0uFvQYkf85KzDF7QolOa3rbOiF+1On5/HGC
         NhqnVFBWa/dZPGEamPv4ROB0WWpkvpw4l/0wbkmwXw128b9eiWLgAGCa3HQ7/VtA/w3u
         JrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLTKYcXZjnJzgL8+u1qWnRCoPH2awcb+CcZmXU1B3xo=;
        b=mKUF2apk71jJ+OXw9iRRNpqsMYTqP0odSis4vM4Fbed+X6xVGK+7uD83SeP2/gFgRR
         phKX5c5TgvhNlpBbxHTDF1WLhW1duEU4adltGzbEYF02Xct0wWGbQdur2DN3pHtKhjTI
         5J2TtHbawnwSe3/zioLrkPS/P047cs3grtyVWXS+LdVpOoyPfSPvOnLKK8eigrFFF/O8
         ZceoFlXRjs8JTmrrSfm3dTMeST/Y0fJ8qEGD6+TwN2MPsgfzH0AHOUOYck2EU9+yLGIt
         DJml+ZdjECBfkD1/wSY6KpSHl0e4JIsIRmyT1YNECe17Uo8LxKTBY8qx6seE5NIAywoe
         +6LA==
X-Gm-Message-State: ACgBeo0e8r4hHfnFoytwzRCchx+ytC5/QJZZkGrYh6+bfjIHhU2c4zdB
	a2WHWaciLAK+SP3gUwJZOrVuZZmAPEiMBM89MJY=
X-Google-Smtp-Source: AA6agR6by3zI3D6nLcCSNKmqxBKHH2G5l/DN+2XZqTIfeOy7qgHRHe9EafRMKPSMau+JqqyBi3oXGRNvdmCZXBX42cI=
X-Received: by 2002:a67:d781:0:b0:386:bd65:ea08 with SMTP id
 q1-20020a67d781000000b00386bd65ea08mr3226792vsj.69.1659708057369; Fri, 05 Aug
 2022 07:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220725084231.8584-1-norbert.lange@andritz.com>
 <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com> <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
 <2e3d458a-65ff-6465-9f9c-7fa4ae44c5e8@siemens.com>
In-Reply-To: <2e3d458a-65ff-6465-9f9c-7fa4ae44c5e8@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 5 Aug 2022 16:00:46 +0200
Message-ID: <CADYdroNY6izikGnjnfwba8T84n6rhsj3x9PqODmbYt8__C7Fyw@mail.gmail.com>
Subject: Re: [PATCH v2] fix build with clang
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, Norbert Lange <norbert.lange@andritz.com>
Content-Type: text/plain; charset="UTF-8"

Am Fr., 5. Aug. 2022 um 15:45 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 05.08.22 15:42, Norbert Lange wrote:
> > Am Mo., 25. Juli 2022 um 19:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >>
> >> On 25.07.22 10:42, Norbert Lange wrote:
> >>> clang will never support 'variable length array in structure',
> >>> and there does not seem to be a reason for this weird construct.
> >>>
> >>> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> >>> ---
> >>> v1->v2:
> >>> *   fix algorithm
> >>> ---
> >>>  testsuite/smokey/memcheck/memcheck.c | 6 ++----
> >>>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
> >>> index a33700f49..b11d2babd 100644
> >>> --- a/testsuite/smokey/memcheck/memcheck.c
> >>> +++ b/testsuite/smokey/memcheck/memcheck.c
> >>> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
> >>>
> >>>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> >>>  {
> >>> -     struct {
> >>> -             char x[size];
> >>> -     } __attribute__((packed)) *base = vbase;
> >>> +     char *base = (char *)vbase;
> >>>       unsigned int j, k;
> >>>       double u;
> >>>
> >>> @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> >>>               k = (unsigned int)(j * u) + 1;
> >>>               if (j == k)
> >>>                       continue;
> >>> -             swap(&base[j - 1], &base[k - 1], size);
> >>> +             swap(base + (j - 1) * size, base + (k - 1) * size, size);
> >>>       }
> >>>  }
> >>>
> >>
> >> Thanks, applied.
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Technology
> >> Competence Center Embedded Linux
> >
> > Could you cherry-pick this commit to 3.0.x and 3.1.x aswell please?
> >
>
> I can. I was just not expecting someone starting something new with
> clang on these old versions now. If you change something as fundamental
> as the compiler, why sticking with that versions?

I am trying to setup a build-server which uses clang, for using
sanitzers, codecoverage
and code-quality. We wont change the compiler and don't want to change
the xenomai version.

I guess I could just use a newer version of xenomai for the tests
without adverse effects,
but so far I only have one xenomai version for everything.

Norbert
