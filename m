Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407840C09
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so10112705e9.1
        for <xenomai@lists.linux.dev>; Thu, 07 Dec 2023 05:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957058; x=1702561858;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HP55Jt8rySr5623NN1Gf5KevTRqbqYOu41pflVpxA6U=;
        b=uoFB4UqypTDN4ThrnxDxN5oNPRKnfgHpkNPUjL1nXVOfgEpdj7Dn97Ji3IeEOCFc3X
         Svww1VAshPkohDM8otTmDF8VyEq5XOiSbtCdcMTkUCg362mPWaw3NWT1NLv+aWnq7+We
         G9fwdlFNYW6BHJQ2hHMLcZuB7+zpk85JbcGYjaSTcEmD7UAi4tyGnopQsmLgKJ2b1Mup
         bGWZwZDRGuh7ZokF3c6IE5I/qbUYEPNKs1wbbEh26+Wz6jD+6CxbAXsyl+lOAkbvNLm/
         0A0nOFcjw3DnS35ZUW66g2lz6VDKIs0xaifnhTSUYeteZ4Gj14XpXSVKlCaSeyGBTtBf
         62Jw==
X-Gm-Message-State: AOJu0YzqtfArGBLVTkpcEliuHa9bm32nBZajwVlNFPFeAiPV57iR7+X7
	i4xb77iFK+HWlb8ZAuDbTHVLhsfMlOwjHQ==
X-Google-Smtp-Source: AGHT+IHZsHZXREqpvPP/Uqpp5X73aQKrj339CO7s5bAsU4IYmxtb6W7Jqotz+mZmnXNhK5FUABMWHw==
X-Received: by 2002:a05:600c:45ca:b0:40b:5e1b:54ab with SMTP id s10-20020a05600c45ca00b0040b5e1b54abmr1822828wmo.55.1701957057837;
        Thu, 07 Dec 2023 05:50:57 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b0040b30be6244sm1960893wms.24.2023.12.07.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:50:57 -0800 (PST)
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
 <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
 <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
 <87il5al8zb.fsf@xenomai.org>
 <a7756962bd637d2738611761c600bf81d367aab9.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "mars_liu2023@163.com" <mars_liu2023@163.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, xenomai <xenomai@lists.linux.dev>
Subject: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
Date: Thu, 07 Dec 2023 14:44:03 +0100
In-reply-to: <a7756962bd637d2738611761c600bf81d367aab9.camel@siemens.com>
Message-ID: <87edfyktof.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2023-12-07 at 08:52 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>=20
>> > On Tue, 2023-12-05 at 15:40 +0900, Jan Kiszka wrote:
>> > > On 03.12.23 15:13, mars_liu2023@163.com wrote:
>> > > > Hi xenomai,
>> > > >=20
>> > > > I tried to learn the Xenomai kernel on =C2=A0Hyper-V=EF=BC=8Cand a=
ppear some problems.
>> > > > xeno-kernel can't boot on the hyper-v ,so i did the following .
>> > > > I saw such a message in other mails in the community that "prevent=
 CONFIG_HYPER from being built if interrupt pipeline is enabled",so i disab=
led CONFIG_HYPER for =C2=A0boot xeno_kernel(version :5.10.180-xenomai.3.2.2=
)=C2=A0 on hyper-v .
>> > > > it can work well on the fist-generation hyper-v,but it's boot fail=
ed on the second-generation hyper-v.
>> > > > This is also the=C2=A0 case when disabled CONFIG_HYPER on normal l=
inux kernel.
>> > > > Did i do something wrong ? it seems linux (vesrion 5.10.180) disab=
led CONFIG_HYPER can't work on the second-generation hyper-v.
>> > > > Is xeno-kernel(dovetail) not allowed to work on the second-generat=
ion hyper-v? if not ,how do i do it ?
>> > > > thanks for any reply.
>> > >=20
>> > > I vaguely recall some very unfortunate internal dependencies of Hype=
r-V
>> > > device drivers support on CPU paravirt features, at least Kconfig-wi=
se,
>> > > but I don't recall all details. Florian, do you?
>> >=20
>> > No. The situation is a bit strange here. Adding Philippe, we might have
>> > a typo in drivers/hv/Kconfi:
>> >=20
>> > Taken from drivers/hv/Kconfig:
>> >=20
>> > config HYPERV
>> > 	tristate "Microsoft Hyper-V client drivers"
>> > 	depends on ACPI && !IRQ_PIPIPELINE && \
>> > 		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>> > 		|| (ARM64 && !CPU_BIG_ENDIAN))
>> >=20
>> > !IRQ_PIPIPELINE will always be true (due to the typo).
>> >=20
>>=20
>> Yep, was fixed in 6.4 and above.
>>=20
>> > That explains why one of my kernel configurations with
>> > 	CONFIG_IRQ_PIPELINE=3Dy
>> > 	CONFIG_HYPERV=3Dm
>> > builds, but I have never tried to boot it up on any hyper-v enabled
>> > machine so far.
>> >=20
>> > Question to Philippe: Why did you try to disable the HYPERV bits? Due
>> > to the lack of testing or is there more behind it? Building works, so
>> > it must have been something hat happens during runtime...
>> >=20
>>=20
>> I did not care about HYPERV, that's pretty much the reason. Which means
>> no use case, therefore no specific work on enabling/testing interrupt
>> pipelining for this beast, so I forced it off. Only PARAVIRT_XXL is
>> officially a no-go for Dovetail ATM, because the current irqflags
>> implementation for x86 prevents it.
>>=20
>
> Philippe, thanks for the clarification. I might have to revisit this
> topic in the future as some colleagues had some thoughts about using
> hyper-v during development. If we would report back that it works
> (maybe with some necessary fixes) you would consider removing the
> restriction?

I would, provided the required changes are tractable when it comes to
forward port them, and some interested party does maintain that support.

--=20
Philippe.
