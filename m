Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334EDDC8
	for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 20:48:59 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bff27026cb0so8215383276.1
        for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194938; x=1691786938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWuomJ+yJacKutvCdjKRLyCcJXhEPhBabQ+StWYIZnM=;
        b=hwzrqMtiNOmitX2w1wKraYjzq6YkUi+WUtGLmP4gPSDH7mgEwM4+3qfE6Nh4HLq4Zu
         jPV4IusjNhaVizr5W8sWLZhaJcDL3EaXSkt8urenPWOLSXdK2a+fwy0v9dfeD1IR/fvu
         v3MYsZ6znDBp3O7vNaCt4pk2NK35QzSXE+OhGigD6+FOnVv9uU6elfxdpKZOdznqbic2
         /Q+ePaYg7A0W4n2uRaxQvIarWUNoCaGpQUMp6wndeh+pdax9aRQwop6A+z/buUMrdaUQ
         t7GyNawiFo0i8Uy2n0ep0u4kCji2PLIaIDfblcB0T9FmLSwzLm+JpCC8SGlaf9EKCHad
         xrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194938; x=1691786938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWuomJ+yJacKutvCdjKRLyCcJXhEPhBabQ+StWYIZnM=;
        b=B/GZTqAUHFX+K0lpxD26cGFFKg+jBysEX/0TiMaw2/yXz1xzzPG1wyQD+koD+JdVTm
         t9B186M/Wql4bkFWbDyEnuO9/1NLA9CMlKnUpxvITD/CHe/xsrvrrmzx6H3MW2zBO+Bo
         u1XW+NSJwdct111a3LdAoggEmRXiM5jGI1AMMoaHcDpeJMF+EIEORoaXeasN955XA3iG
         HM0ZGFR5TUR+1v5F06QwtC80eDKitcSQIrE6Z2k77mDKdn9+PFVsI2hIObqXWkgiAqXe
         MZ9h4HAXcZ/VaQDqN4xuhHcDI2xWoyJLhalakmF4gaUJnRWIBwl2f05UFvV4N4oUMsTZ
         irGg==
X-Gm-Message-State: ABy/qLZrnidDsE/pMyNfZB1i3PD+P/FwpY3SlJvoQQ1KqTnvgNvfoYZB
	n+VdGI4W8cMV4rNvXOL1arnp6+X+E+8qjgxDfYI=
X-Google-Smtp-Source: APBJJlEkU9ZGWpJtezTGXQIgY9XJJOmYQ9fPukOJkNAvrpaPbL9PX7H+6uBaTOV8yjsi4o/gyPeCt8ZkES39G1bEoNU=
X-Received: by 2002:a5b:bc1:0:b0:c6b:b7c6:8561 with SMTP id
 c1-20020a5b0bc1000000b00c6bb7c68561mr16559408ybr.49.1689194938144; Wed, 12
 Jul 2023 13:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 12 Jul 2023 22:48:44 +0200
Message-ID: <CAFLxGvzhE6rZ2aa=9Qwhyo06PytCQEqam_Yq9scQdJ1cLY13vw@mail.gmail.com>
Subject: Re: Xenomai Community Call Minutes - Jul 12, 2023
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 10:09=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@inte=
l.com> wrote:
>
> Attendees: Jan Kiszka, Richard Weinberger, Florian Bezdeka
>                              Tobias Schaffner, Hao Li, Jianbo Cao, Hongzh=
an Chen

FWIW, my co-worker, David Oberhollenzer, was also present.

--=20
Thanks,
//richard
