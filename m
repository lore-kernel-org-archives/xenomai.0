Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4DDF4F
	for <xenomai@lists.linux.dev>; Sun, 26 Nov 2023 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3316c6e299eso2351659f8f.1
        for <xenomai@lists.linux.dev>; Sun, 26 Nov 2023 09:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701020308; x=1701625108;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7Jx1DcmRdCZGhqdrXKZljzmtgVZ0Jvo/otcZHvqTcU=;
        b=oF8aT2GyE4qLzbF2cSwsO2PzXBEPAsQcpgNlWgzsmP2jbs2rCEdjm4wEMZLtsvZJXk
         vUEt66Qb4o/gjcZIGCwTQiQDYUWrMJ1uTQtjBbFVqa3Gbbu9Vbvwi8LZ7aMX5qeEq9+g
         +Som2HVZozSGcbVZe04c8AtXgDenq2Xmt/rYXWdn6BhZnLu87BF9Smfc84673Nyw4Ypo
         qNkbsQwtDKVDvV72kWDXZsJrEZ6GOalqKnbS0BDVPzc+GGPtAch4RyFKvMNb/y0LTPyt
         J7gFb/JXHmudcZm/zxFWeDBGvsq1x48TNDmEwGdz2N8dcH+RX1sa24WjpLwB73o4nUSK
         eMAA==
X-Gm-Message-State: AOJu0Yyw3volu4YqnAaRSnbsPRzOxZyW9FQofyEvfnQx2SiPHFtpTof6
	O2UQrwEBWldUSSiifRXpLWM=
X-Google-Smtp-Source: AGHT+IHWZL1oSQk9/kyYu1NhGwo44kauXiTQ8EC3tyL3xP05RXcDnqS16QSF/lrtwpIdy24Z190Qhg==
X-Received: by 2002:a5d:404d:0:b0:332:e745:f50b with SMTP id w13-20020a5d404d000000b00332e745f50bmr6842681wrp.31.1701020307734;
        Sun, 26 Nov 2023 09:38:27 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id g6-20020adff3c6000000b00333009b151dsm654094wrp.22.2023.11.26.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 09:38:27 -0800 (PST)
References: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>
Subject: Re: evl: Problems while trying to build up a debianization 2
Date: Sun, 26 Nov 2023 18:36:54 +0100
In-reply-to: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87zfz0tnxp.fsf@xenomai.org>
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
> =C2=A0
> The build works if I remove the $UAPI/asm/evl check completely. Then I ge=
t an image in which the evl testsuite runs successfully. Is this path still=
 needed for other build scenarios? Do you have an idea how to solve this pr=
oblem?
> =C2=A0

We currently need these bits only for testing the fp support
actually. I'll have a look this week and let you know.

--=20
Philippe.
