Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9310E0
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 14:02:16 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id m67so2514940vsc.12
        for <xenomai@lists.linux.dev>; Fri, 05 Aug 2022 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnxexAV+xCwmUe6VMPLNpt2zuHqJIn13qeKU8yHjNBg=;
        b=cVHtdmP8+LC+7rfSgHoFXhtao9kjFGt+8M3iziQjF5PoqmavCqia/D7g5BjOYliy4e
         8GDBsod48JUeqmvbenPPaQy/tEHDLr8Bm4tx8uXJ2t3mF3ZoxWBYRVZhfe4/AWh6Hq4Y
         zJv2sCAMWKvpwgphCrk7F+J9xsjPd8hXk6lNcuX770Tha3qdojfxQAyJcVbW+FLX0yZy
         E6FybVBvU9JozlenwAtd3aQV3DK8RG2rSs9wsZeeB/x3nRYr7QuvGrVu0UTn/ApDJZq7
         Ji5uqQRZ7zqJwEc9zhf3h4Cuwhreys9t1jZhq0AqeT9GNGfM4UQufG68X2rJQuM3G3pX
         3qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnxexAV+xCwmUe6VMPLNpt2zuHqJIn13qeKU8yHjNBg=;
        b=x9XhH8fXEOx5Bg8D3PIyM/KqWSs9WjfCltj5I8ReuRpZ6rV06wpcqW97mSogahdlyA
         L/RfGjUs+oh5gONqQpUBtcBpuvCSesCMXczCNidwrBqRxbEdHwyjiZEQtV957jqQ3tbV
         53W+LOjaoiLCSFmU+iOB/5RH96oO7NGSoBFe+aMAoZ2qO93Vd24TYqci7vLLdYqwNDHn
         v+6KNxdrLsJzPuFdqNYvWUvprrVyNBFVLG55Sl09bTVLDeKjhdXsOaZ1h9clLXxRYEyt
         ijaDC/sKr5YHPN+V7AmFLwKtOl+sYxJR1P46LV3Hf1V/51kGPpMc7/jKoq6hmjbxN3i4
         nS6A==
X-Gm-Message-State: ACgBeo2cT5xC5wnKeAdPCt5DSJmcIRmFa3zQgesmPQai/GIshTP/LtKG
	YyJJWKRYQ2DN7LLva0g4Sr5JM4m4IXa4zV98mlU=
X-Google-Smtp-Source: AA6agR5t8i1h6ulE98qHaPv0Tc3fb8ZRWKK95cd+x8MVbnuCsBLyvgNtHgDStb/znncFZURRvtRjIs8oC7pNThiliuc=
X-Received: by 2002:a05:6102:5c4:b0:36c:29c0:412f with SMTP id
 v4-20020a05610205c400b0036c29c0412fmr3049457vsf.32.1659708134936; Fri, 05 Aug
 2022 07:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220725084231.8584-1-norbert.lange@andritz.com>
 <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com> <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
 <2e3d458a-65ff-6465-9f9c-7fa4ae44c5e8@siemens.com> <CADYdroNY6izikGnjnfwba8T84n6rhsj3x9PqODmbYt8__C7Fyw@mail.gmail.com>
In-Reply-To: <CADYdroNY6izikGnjnfwba8T84n6rhsj3x9PqODmbYt8__C7Fyw@mail.gmail.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 5 Aug 2022 16:02:04 +0200
Message-ID: <CADYdroOqOrNQtdy1M6kVm0Bqj_5FP8O9NY7WCDjj5g6RzBamBg@mail.gmail.com>
Subject: Re: [PATCH v2] fix build with clang
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, Norbert Lange <norbert.lange@andritz.com>
Content-Type: text/plain; charset="UTF-8"

Am Fr., 5. Aug. 2022 um 16:00 Uhr schrieb Norbert Lange <nolange79@gmail.com>:
>
> Am Fr., 5. Aug. 2022 um 15:45 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >
> > On 05.08.22 15:42, Norbert Lange wrote:
> > > Am Mo., 25. Juli 2022 um 19:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> > >>
> > >> On 25.07.22 10:42, Norbert Lange wrote:
> > >>> clang will never support 'variable length array in structure',
> > >>> and there does not seem to be a reason for this weird construct.
> > >>>
> > >>> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> > >>> ---
> > >>> v1->v2:
> > >>> *   fix algorithm
> > >>> ---
> > >>>  testsuite/smokey/memcheck/memcheck.c | 6 ++----
> > >>>  1 file changed, 2 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
> > >>> index a33700f49..b11d2babd 100644
> > >>> --- a/testsuite/smokey/memcheck/memcheck.c
> > >>> +++ b/testsuite/smokey/memcheck/memcheck.c
> > >>> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
> > >>>
> > >>>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> > >>>  {
> > >>> -     struct {
> > >>> -             char x[size];
> > >>> -     } __attribute__((packed)) *base = vbase;
> > >>> +     char *base = (char *)vbase;
> > >>>       unsigned int j, k;
> > >>>       double u;
> > >>>
> > >>> @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
> > >>>               k = (unsigned int)(j * u) + 1;
> > >>>               if (j == k)
> > >>>                       continue;
> > >>> -             swap(&base[j - 1], &base[k - 1], size);
> > >>> +             swap(base + (j - 1) * size, base + (k - 1) * size, size);
> > >>>       }
> > >>>  }
> > >>>
> > >>
> > >> Thanks, applied.
> > >>
> > >> Jan
> > >>
> > >> --
> > >> Siemens AG, Technology
> > >> Competence Center Embedded Linux
> > >
> > > Could you cherry-pick this commit to 3.0.x and 3.1.x aswell please?
> > >
> >
> > I can. I was just not expecting someone starting something new with
> > clang on these old versions now. If you change something as fundamental
> > as the compiler, why sticking with that versions?
>
> I am trying to setup a build-server which uses clang, for using
> sanitzers, codecoverage
> and code-quality. We wont change the compiler and don't want to change
> the xenomai version.

(We wont change anything for our *productive software*)

Norbert
