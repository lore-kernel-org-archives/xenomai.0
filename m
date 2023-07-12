Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3297FB
	for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 07:24:01 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b708e49059so103883281fa.3
        for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689146639; x=1691738639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgR49JwK7dihHQB/phpVnzcyenUf/zpHDULtYRlMwWE=;
        b=NA+0HtbVGwopg4IvxcPDGNY8+8baCALfS1cxi4ifeX4tTNXCdYpKTKWqorwxEvBrhj
         uFDAm/FA2a7yWdckLk+7EinE10pXIyWGT5bqlvirNVzh9L32PiBdW+DbcmheJ8Voliji
         86VTB9yW+JQYr8PE/AhhsS5+8EMf21VGSE85HF5IErDlLswN44hdm3HKx1p/Afv3SCTR
         7caJuc7ekST8IdinqfOHvWmn89WqesMXxG9rC9XQBciaSXtc9O+VsphKsS+MamYg2+k0
         YO9FbNCPodv3ov4VkyAoyztQ/4fxvDka0ZS6B7sr/gNbbWABcNbgwpKW3wAAsQX7ObOd
         ozOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689146639; x=1691738639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgR49JwK7dihHQB/phpVnzcyenUf/zpHDULtYRlMwWE=;
        b=MIG3wlGM88er6HdQ3H+/zgQEebPTqw8A8pHaGFLnF6KkSafzFWQ2TswzfGLdT2DN+a
         5tSDh5HNzNrPEgXDWF63m3QwlGFstTTrCQosZN2U9SaCLUSlU0hhWpN7X+Ws0KOeJ80L
         GpysIWGfbCk8/My7TWQfMUShqEynq4u3joHLfILLUxfgqWpht8FaVUSvZ7DHBpGSjd9s
         6kJ0cPfP0kcWUnLgh1wvEpB/VPNHusDXpmdcKHibbl2v1TepwEfHzpebyJKM9X4UaohG
         p3exocCk9s924gc4vpodeLfz6a4lKbr2/uIdi9WI/m585WIeEfGzTGue8xRo9dI9wDUJ
         yYSQ==
X-Gm-Message-State: ABy/qLYn8yUObx51xQe8aYMuW12GBPHj0z0E4Q8RoG/ZHOY1KGIXwYnM
	gTYMnISEHwRFH1nEcd2Piq1TTv3pzWTInPaTLMg=
X-Google-Smtp-Source: APBJJlGfUf1YlmwIQZzfvG/UHJpeGVk1VuJMW3uDnXqQC1TUwz6dPj6e9r2z+wRjOGjuHJy2mSEOCluZA0nmqBnE2Io=
X-Received: by 2002:a05:6512:692:b0:4f8:5e11:2cbc with SMTP id
 t18-20020a056512069200b004f85e112cbcmr16951739lfe.36.1689146639280; Wed, 12
 Jul 2023 00:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MN2PR11MB42857040327DF5A2824EC1D1F236A@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB42857040327DF5A2824EC1D1F236A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 12 Jul 2023 09:23:47 +0200
Message-ID: <CAFLxGvy15h7t+TVk-WBwbNAZw9_FOmfTGGC4qz8c6SAfEtnWcw@mail.gmail.com>
Subject: Re: Reminder: Xenomai community call on Wednesday, Jul 12, 2023, UTC
 7:00 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, pierre.ficheux@smile.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 4:33=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@intel=
.com> wrote:
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions.

As discussed in the call, the is the Xenomai related talk by Pierre
Ficheux at EOSS 2023:
https://eoss2023.sched.com/event/1LcQx/the-xenomai-project-current-and-futu=
re-pierre-ficheux-smile

Thank you, Pierre, for presenting on Xenomai at the conference!

--
Thanks,
//richard
