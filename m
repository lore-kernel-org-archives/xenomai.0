Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18530327
	for <xenomai@lists.linux.dev>; Wed, 29 Nov 2023 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso17911075e9.2
        for <xenomai@lists.linux.dev>; Wed, 29 Nov 2023 09:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278631; x=1701883431;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8Dvg+p4bbw1BKu7AU0MQWVzF3sSSlTPm0JPEGyDqV4=;
        b=HsmQl18G06p8EsyTP1cduq2DgcyNHhZLcYOVa/Vl2+h8wuyhaQd4RmTn2n29308HSK
         lpVebgcAGVuf0e6gNY7wvqh/hVObE9LaW7vSQEghf5FLliumt5jXedwyANVmuECl09e0
         EPX+uEbXxX3lyr38iN8+JWoZMtwerjl9MuYer9kmnNUpbsEmIutODJOPxTNfK0KSYA0I
         g/BJFkQtBN1V6Tsq3HjTNIXCnISAA213MoZznoM0V1WrWUSyafS1BHupQamjics86VG9
         EPZ9SBe+dWxrwEX89J9tIduRniQ/KtpenecjXCt1MUik8lQUy29Hi5H+/0fhXC8JXsPS
         dhRQ==
X-Gm-Message-State: AOJu0YwHsR+TrDI9RkAkQMTzbHg1tB5uoY5LF1pAdgLqL506RTWMwM58
	i9lRQYEcAOOOE/0HLn7T1Uodmz6+IVFpeA==
X-Google-Smtp-Source: AGHT+IF3Jsaku7KEbnrDhe61GfrxRfgb09JJEjN4wHA31GhQUEXgNqguPedbrGSz39c53Ig7bqLtkQ==
X-Received: by 2002:adf:f4c2:0:b0:32d:9d80:4039 with SMTP id h2-20020adff4c2000000b0032d9d804039mr13377803wrp.34.1701278630657;
        Wed, 29 Nov 2023 09:23:50 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000025700b00326dd5486dcsm18361506wrz.107.2023.11.29.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:23:50 -0800 (PST)
References: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>
Subject: Re: evl: Problems while trying to build up a debianization 2
Date: Wed, 29 Nov 2023 18:19:29 +0100
In-reply-to: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87h6l4jwwu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


"Kowalsky, Clara" <clara.kowalsky@siemens.com> writes:

> Hi Philippe,
> =C2=A0
> regarding the enabling of xenomai-images to generate images for EVL, ther=
e are still difficulties.
> When using the linux-libc-dev package produced during the linux-evl build=
 to provide the kernel headers needed for the libevl build, the libevl buil=
d fails.=C2=A0
>
> The setup-uapi.sh script throws an error because it is missing the path t=
o asm/evl ("/usr/include/asm/evl is missing"). The other two paths /usr/inc=
lude/asm-generic and /usr/include/evl can be found.
> =C2=A0
> In fact, the path /usr/include/asm/evl does not exist in the linux-libc-d=
ev package, instead only /usr/include/x86_64-linux-gnu/asm is present (Debi=
an multi-arch support).

I assume that /usr/include/x86_64-linux-gnu/asm/evl/fptest.h is present,
correct?

If so, this is solely a matter about the multiarch prefix, and a
reasonable fix would be to have setup-uapi.sh consider the target host
triplet for finding the asm bits.

--=20
Philippe.
