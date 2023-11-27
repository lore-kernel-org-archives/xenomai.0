Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BCD524
	for <xenomai@lists.linux.dev>; Mon, 27 Nov 2023 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40b27726369so27061545e9.0
        for <xenomai@lists.linux.dev>; Sun, 26 Nov 2023 23:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068813; x=1701673613;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ig8ed3IEtlWVGoCqmU5sff2QIKoVgM9BnD8QuYu9dY=;
        b=CvMqcvo7YmkIyMUyp38hm0vvtyCSii/njEN9I0CAfuktjFPWjoXqcCfxgMOlbKSttC
         gHwjTnVr4N3baW+kHlL4C/LNs5NJO+NTrM+cEBLxqxbylPksuTZwFkoD3UvY5pOMiujT
         Bgrmpke17K/hjD0XqNSACD5PK+fv3uP6qVOHZpPGdCtK3JJeeRy63jJeGegzYfmbO95w
         x3oWqDnuQh1noz/8NcTVpm4jFC83CFNGpRw3ymByeAFGLbL8pHCtOsWj2iTpgmJ8hNth
         gTTbCcld2Tyt0waqdiJ2nAmpgHlvrFeq4i2Kh4ihisfVdmjUTzxZgfQL5JI7BmT54F2p
         VZwg==
X-Gm-Message-State: AOJu0YynBLIolUe923gNxtfPlMDNku4UmWIuVVqzh33Ry3YqS1vb1zik
	V6WrOO11SYgWCpR066QXqBdGDdwcopMHsQ==
X-Google-Smtp-Source: AGHT+IEPtninQmSp1vgtfcvwQFpOR5IqmaSoSgm5wEQXPScfcVnsCct8RnXVbG96XhC8g8OepIvRPg==
X-Received: by 2002:a05:600c:4710:b0:409:c1e:7fe8 with SMTP id v16-20020a05600c471000b004090c1e7fe8mr4168580wmo.19.1701068813273;
        Sun, 26 Nov 2023 23:06:53 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00405c7591b09sm12718612wmp.35.2023.11.26.23.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 23:06:52 -0800 (PST)
References: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
 <87zfz0tnxp.fsf@xenomai.org>
 <ad69fcac-f255-4942-91aa-acf77656bafb@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Kowalsky, Clara" <clara.kowalsky@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: evl: Problems while trying to build up a debianization 2
Date: Mon, 27 Nov 2023 08:05:22 +0100
In-reply-to: <ad69fcac-f255-4942-91aa-acf77656bafb@siemens.com>
Message-ID: <87v89nu12r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 27.11.23 01:36, Philippe Gerum wrote:
>>=20
>> "Kowalsky, Clara" <clara.kowalsky@siemens.com> writes:
>>=20
>>> Hi Philippe,
>>> =C2=A0
>>> regarding the enabling of xenomai-images to generate images for EVL, th=
ere are still difficulties.
>>> When using the linux-libc-dev package produced during the linux-evl bui=
ld to provide the kernel headers needed for the libevl build, the libevl bu=
ild fails.=C2=A0
>>>
>>> The setup-uapi.sh script throws an error because it is missing the path=
 to asm/evl ("/usr/include/asm/evl is missing"). The other two paths /usr/i=
nclude/asm-generic and /usr/include/evl can be found.
>>> =C2=A0
>>> In fact, the path /usr/include/asm/evl does not exist in the linux-libc=
-dev package, instead only /usr/include/x86_64-linux-gnu/asm is present (De=
bian multi-arch support).
>>> =C2=A0
>>> The build works if I remove the $UAPI/asm/evl check completely. Then I =
get an image in which the evl testsuite runs successfully. Is this path sti=
ll needed for other build scenarios? Do you have an idea how to solve this =
problem?
>>> =C2=A0
>>=20
>> We currently need these bits only for testing the fp support
>> actually. I'll have a look this week and let you know.
>
> But I wouldn't drop them just because of this. I think we are just
> missing awareness for the Debian multiarch layout when headers have been
> properly installed into a system.
>

We won't drop them for sure, at worst we might duplicate them into
libevl (this is a couple of helpers), only if there is really no other
option wrt packaging.

--=20
Philippe.
