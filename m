Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B3100AE
	for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 14:13:08 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso115956381fa.1
        for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1689171186; x=1691763186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL97uqzxsLMYZyzhypOZSyh+6JJNJZo8StN94zBsy1I=;
        b=cul7LQTU2no0Azk0mA946qkbGXFjUcYGq5HCy/uK0kmOgWZ9C0MW0C4AoxiYFasmaK
         ARu0rhvA2eNynAJU72OdEDjMXo5pnBSxLLqJBRgFztcv1c3p6ekT8lN1P99zlBLGlnQT
         RX7GI9dMdPi3WTBNjudLcZHZmV9lbqiAmvrilMjoTmAy7cniCToZdlpQVgwmlMkE90hh
         G41guXiGRC0hh/cGoMozuZLlOTmdneSE62wJIMYSn6u3cXIAEI3gvq+bu5C4x28K3IIo
         T40GvHxeN7vLLjVutW6HRRXP8GmiK0YlfkLvmmadOwnLlO25M8qKINY5GM3KsSed03Fh
         3rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171186; x=1691763186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL97uqzxsLMYZyzhypOZSyh+6JJNJZo8StN94zBsy1I=;
        b=LUO7yFSFkPyMuqSjbMTWxyhTmZpFp8S7uA4A0OIFa6pvsBVnd/MLO3QuS4huqzoSYj
         KJiutxJDICCPp4DOln4WIZePAtOuvgxRHdXq0wP4uMBu4wygEfUhuTM7PmJXKQHbLoOG
         9oRFhr3ITE75pQ2VsVtwLXZF3uhnbFbd2p5JhyR7XNMkcy1v/77h5hIN8srz6SHdJoPw
         w82HdpQmZANpExXBBam7YuOntvVT7ZcZq5kxgCpBiBbr5nYVPZOu6LLlPjfbuUaHIq83
         /X+15u4CugqtyFOWvscetyOp2ERROhGb3v6kuZCtKFgjLUG/RCjS3AwUcsLjn3t4zLKE
         ypqw==
X-Gm-Message-State: ABy/qLYC+Apj1xJm+yZ5ICT2idFLeSc1S54nNfLRlDNMX8m7TzlAMcH1
	X9Bpwk0IC8DCtgP9gd4d+C9zvkaFmFpXj2+tytOXeg==
X-Google-Smtp-Source: APBJJlH/GNdyCcBdOdfjwCSXVA2uEqQkIgRu4L0vWlLjUM7cVNEPyASpaf1UBfmm+TfWdurB2uhsJWdMeNaYsINWQHY=
X-Received: by 2002:a2e:a309:0:b0:2b6:bf9c:d025 with SMTP id
 l9-20020a2ea309000000b002b6bf9cd025mr15346796lje.8.1689171186545; Wed, 12 Jul
 2023 07:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MN2PR11MB42857040327DF5A2824EC1D1F236A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvy15h7t+TVk-WBwbNAZw9_FOmfTGGC4qz8c6SAfEtnWcw@mail.gmail.com>
In-Reply-To: <CAFLxGvy15h7t+TVk-WBwbNAZw9_FOmfTGGC4qz8c6SAfEtnWcw@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 12 Jul 2023 16:12:55 +0200
Message-ID: <CAFc1U0vX8P=j=9dWAoSRPkrvzBpHFqAVK5C90RMm7MczWwb7bQ@mail.gmail.com>
Subject: Re: Reminder: Xenomai community call on Wednesday, Jul 12, 2023, UTC
 7:00 AM
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It's always a pleasure to talk about such a great project , Steven
Rostedt was here !

I noticed  several nice conferences about Linux RT :

https://sched.co/1LcOa
https://sched.co/1LcOp
https://sched.co/1OBtv

Regards


Le mer. 12 juil. 2023 =C3=A0 09:24, Richard Weinberger
<richard.weinberger@gmail.com> a =C3=A9crit :
>
> On Wed, Jul 12, 2023 at 4:33=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@int=
el.com> wrote:
> > Topics may include but are not limited to upstream/downstream project
> > plans, status updates, and technical discussions. It's an open online
> > meeting that anyone can join and ask questions.
>
> As discussed in the call, the is the Xenomai related talk by Pierre
> Ficheux at EOSS 2023:
> https://eoss2023.sched.com/event/1LcQx/the-xenomai-project-current-and-fu=
ture-pierre-ficheux-smile
>
> Thank you, Pierre, for presenting on Xenomai at the conference!
>
> --
> Thanks,
> //richard



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
