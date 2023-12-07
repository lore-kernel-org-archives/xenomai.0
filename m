Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDF1E4BE
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso3603025e9.1
        for <xenomai@lists.linux.dev>; Thu, 07 Dec 2023 00:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937230; x=1702542030;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q1HUkmxmWI+oLtYCoqvF06/AC3FGGVnTXIn6R5NZf5w=;
        b=QyATWRz0QvGrh5t/AXQbDMgGNTFsgDa0XZjd+NVEJIa0czXlwTeGFqxn+oLzLNErTp
         F5pgfu/+2kV3EWPHkmTdsdXGTTqCGU7OCGJFPJrFqN61guv8e716x2bf0NQbMA6Nildw
         uimushX2usCk2LkzREJybEG729jFNaG+m2hvSoVIMB12De5fXFiuXv26DNKvkgsTiQZv
         6rOaZSojDjJc9L7QHZhPyWIi40expYQDwjIasl5T5t7zb84380qFsmvR7VViHuoEcq01
         uaPCWmwB3uN9gS5d3X+C9+0SqQsyvTLfm6N+PNwRF6yhZWjmQq7mpRqhKwYIVr8uATzl
         qDVg==
X-Gm-Message-State: AOJu0YyaPL4h8o7gkUViCFr8EAVkPB+Puh3SVoVeiH8z+iEcwbHm+VRp
	3DykRJIvhz3UjNBSaRBD5+GRL2UFjoLW9Q==
X-Google-Smtp-Source: AGHT+IG/EkwfO35oSPLpyMvqDAY29HhdDpcJt3IRxvW6Xsebzf8vdoh7CRj8oiU8cYTJ88HFMDTgeA==
X-Received: by 2002:a05:600c:54ca:b0:40c:243f:1f6 with SMTP id iw10-20020a05600c54ca00b0040c243f01f6mr964958wmb.152.1701937229902;
        Thu, 07 Dec 2023 00:20:29 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d6349000000b003333b67f58csm779333wrw.48.2023.12.07.00.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:20:29 -0800 (PST)
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
 <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
 <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "mars_liu2023@163.com"
 <mars_liu2023@163.com>, xenomai <xenomai@lists.linux.dev>
Subject: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
Date: Thu, 07 Dec 2023 08:52:17 +0100
In-reply-to: <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
Message-ID: <87il5al8zb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2023-12-05 at 15:40 +0900, Jan Kiszka wrote:
>> On 03.12.23 15:13, mars_liu2023@163.com wrote:
>> > Hi xenomai,
>> >=20
>> > I tried to learn the Xenomai kernel on =C2=A0Hyper-V=EF=BC=8Cand appea=
r some problems.
>> > xeno-kernel can't boot on the hyper-v ,so i did the following .
>> > I saw such a message in other mails in the community that "prevent CON=
FIG_HYPER from being built if interrupt pipeline is enabled",so i disabled =
CONFIG_HYPER for =C2=A0boot xeno_kernel(version :5.10.180-xenomai.3.2.2)=C2=
=A0 on hyper-v .
>> > it can work well on the fist-generation hyper-v,but it's boot failed o=
n the second-generation hyper-v.
>> > This is also the=C2=A0 case when disabled CONFIG_HYPER on normal linux=
 kernel.
>> > Did i do something wrong ? it seems linux (vesrion 5.10.180) disabled =
CONFIG_HYPER can't work on the second-generation hyper-v.
>> > Is xeno-kernel(dovetail) not allowed to work on the second-generation =
hyper-v? if not ,how do i do it ?
>> > thanks for any reply.
>>=20
>> I vaguely recall some very unfortunate internal dependencies of Hyper-V
>> device drivers support on CPU paravirt features, at least Kconfig-wise,
>> but I don't recall all details. Florian, do you?
>
> No. The situation is a bit strange here. Adding Philippe, we might have
> a typo in drivers/hv/Kconfi:
>
> Taken from drivers/hv/Kconfig:
>
> config HYPERV
> 	tristate "Microsoft Hyper-V client drivers"
> 	depends on ACPI && !IRQ_PIPIPELINE && \
> 		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> 		|| (ARM64 && !CPU_BIG_ENDIAN))
>
> !IRQ_PIPIPELINE will always be true (due to the typo).
>

Yep, was fixed in 6.4 and above.

> That explains why one of my kernel configurations with
> 	CONFIG_IRQ_PIPELINE=3Dy
> 	CONFIG_HYPERV=3Dm
> builds, but I have never tried to boot it up on any hyper-v enabled
> machine so far.
>
> Question to Philippe: Why did you try to disable the HYPERV bits? Due
> to the lack of testing or is there more behind it? Building works, so
> it must have been something hat happens during runtime...
>

I did not care about HYPERV, that's pretty much the reason. Which means
no use case, therefore no specific work on enabling/testing interrupt
pipelining for this beast, so I forced it off. Only PARAVIRT_XXL is
officially a no-go for Dovetail ATM, because the current irqflags
implementation for x86 prevents it.

--=20
Philippe.
