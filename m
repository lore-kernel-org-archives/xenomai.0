Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8E10E0
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 13:42:36 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id q190so2486560vsb.7
        for <xenomai@lists.linux.dev>; Fri, 05 Aug 2022 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4s5t5VuR+WxZLnrPyTjiKoKbR0ppOEzGNWLpZWBXik=;
        b=a9OJecAJuTZVzjEyOiOv5c8u/scrQl6ZWS1UvqNeMkE8Saiygy8nQeTZxy0GYoC56G
         Uw40PYamOy49k213Vt3cQaxzn3WtegsmmoQgcZvN55TU49lInEmRqbsUjFP5iJnF34Uf
         31lKlNf4t092Au5+1NBpf2DaWjap0ZfnvN2epdYYNQ45d85fivdCn6oeBHr8QUNMrvBj
         ppdekZa4ibXjpesCQVJO050IJRz1bqrCxM5TcyvOqqolxQAuaUCz0678UyK/deJddklV
         Il4hGa+9UgikQSOpE7SIJtZ8HLlY4bblpoYLMdjjdE2udtdpfMyrJNdRdpkAicToyxbF
         FSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4s5t5VuR+WxZLnrPyTjiKoKbR0ppOEzGNWLpZWBXik=;
        b=sGeQnQrkKnjZE9P2v2i6z8ful1T2euFqzdPL0df6Hc521LhfthRcdHqJUG7VJt5boC
         RPQweo/SO4R6u9G0Di8Yrey7o8B3IVvkDMRmdkgHPOeMsCqwMoLzZ5o3+3aT+j5wRJ7t
         nE40pdEtiPb1lOzCmSFnZOJGeou/MR7mKUUrzBuLW8XsU1BjXVbB2isDEFDWgGcAAdNM
         fM8mwZ9gLlGtaELZoUUBcbMXi4l2RfPEcbWdrWe5AJMNzGacBZU7nB1qK+0Qrlay0in3
         DINOekX7nSDcFFemETD4yYMVRkqMmYhds1vJxKR1qUocdUedgJ7xya9KHfDczBP+Nn9s
         ZoNw==
X-Gm-Message-State: ACgBeo0+ufWP+a/8yfoncVos9GAnt79UFxt+TLDoJWtMQqK2H8G1Lv0F
	zDjuufrGSq4RiZHKNC80LtPbvOKQZ6lo4LFOT54=
X-Google-Smtp-Source: AA6agR5YVotCdDPj339cVM1X/Tahwgs0Tz+xPKKl0PgenEP/RrLVARZWxigLQrhQiSBZb8L/By2dKex8KavhXIsFY+E=
X-Received: by 2002:a67:c293:0:b0:388:6c32:bd90 with SMTP id
 k19-20020a67c293000000b003886c32bd90mr2884808vsj.27.1659706955827; Fri, 05
 Aug 2022 06:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220725084231.8584-1-norbert.lange@andritz.com> <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com>
In-Reply-To: <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 5 Aug 2022 15:42:25 +0200
Message-ID: <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
Subject: Re: [PATCH v2] fix build with clang
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, Norbert Lange <norbert.lange@andritz.com>
Content-Type: text/plain; charset="UTF-8"

Am Mo., 25. Juli 2022 um 19:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 25.07.22 10:42, Norbert Lange wrote:
> > clang will never support 'variable length array in structure',
> > and there does not seem to be a reason for this weird construct.
> >
> > Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> > ---
> > v1->v2:
> > *   fix algorithm
> > ---
> >  testsuite/smokey/memcheck/memcheck.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
> > index a33700f49..b11d2babd 100644
> > --- a/testsuite/smokey/memcheck/memcheck.c
> > +++ b/testsuite/smokey/memcheck/memcheck.c
> > @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
> >
> >  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> >  {
> > -     struct {
> > -             char x[size];
> > -     } __attribute__((packed)) *base = vbase;
> > +     char *base = (char *)vbase;
> >       unsigned int j, k;
> >       double u;
> >
> > @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> >               k = (unsigned int)(j * u) + 1;
> >               if (j == k)
> >                       continue;
> > -             swap(&base[j - 1], &base[k - 1], size);
> > +             swap(base + (j - 1) * size, base + (k - 1) * size, size);
> >       }
> >  }
> >
>
> Thanks, applied.
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

Could you cherry-pick this commit to 3.0.x and 3.1.x aswell please?

Norbert
