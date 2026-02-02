Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DF36607B
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041055; cv=pass; b=L7NfigbvQDL8L51+teZbnHh/FyRVOTJMiWrtvusEx+g1FX6Z0JQPKKvukhkR6imhb+6kAf5zPexeLk3s+CX68LpCheMveIyk1gLdnZje2DVgo99A/bshreDw+mmWEsANn/U6eRHGSO25baPZIR3aDHamy2tZMFCGGqVm97ytNvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041055; c=relaxed/simple;
	bh=q0373vM7Equ/RribMgKVR2NSarYR5N4R8JikMhA9rh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sstlSTlArrHQUgKwbHAofy65B5fXuSMmQuYw6o3T+ut8eOfPKsFfxAz5j0RV0i2fRtU5st8lURTb7VX0+jQeZbvkdN3R4nBiW4oYwNf1iHSZ2FvbW/sfpBthYsbPAyMc7R0hKMSQvWVsC0kLFvrRfLaxtZd41ngretq3cowp0Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=3q0xhrNu; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="3q0xhrNu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8871718b00so762420866b.3
        for <xenomai@lists.linux.dev>; Mon, 02 Feb 2026 06:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770041052; cv=none;
        d=google.com; s=arc-20240605;
        b=kwJhqYNdXHkY5Aplbdaj2x2s8i1o9R5ApD5A0BUMeR4OrwAv664jKpeUruBrzHL5OB
         fJZ6UswsahQWhqYoM6VwGpz4/SJdHNUugRI3Cgn4k/Z3rD1WE8Dw1I3qZpc5klFnmRo2
         +l8B7osPvqy/c+2YiSYXdHTpLxkjzpb86r063ZnWcSeWpZIVZAmOWjqoZ2U1xLBSbaaq
         brTf0m64KQBmNsCBp0Wh1GJg0oLbaj0Sy7M5IbPYLK2V9CEDFNqEnHB//WnGvXhxmAYF
         e1/HaSIa5gVq06ZS5yP6RA04pA2s0mxe3q2zgZ3FwjWMsiT1ubVpcTIQxUqSEnNPzLj6
         zbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZJZrMpkecMaCQVX2n2yc6VyMBcfrvHzg/Iaf1oG6nxo=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=Pi5NGP0jaZmHgCDp9McPD5ZHhxlgJmotBV4B/gTaKJCPRY0MeQGaQkss+oQjxBFfvB
         /Fugv/B6HmG3Bm3fZ4NYBjfh60ZP2B7ilIJpCJyIe+JOvYGwOmfyLQSBRyNaKEgB8yGQ
         nW7Mq+ZVyPySYbZdXhcMHKg34gLHORtQh5GTj+k3vJSBTFHgrxYxe4yQe2FEir07SCPp
         EIVc3bijESm5ICK7NK9dhqwkYkcDW/ElNNm+7IkBO3I2Y6JCy6m1jGXsZL30NqmUwGbi
         uBbWSTxDw4P3EIzxlC/V9QmWRpa3AKvsgeKPfvfGQq1AzCpaZ905eeMYDKpcdpN7AaNK
         sA6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770041052; x=1770645852; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJZrMpkecMaCQVX2n2yc6VyMBcfrvHzg/Iaf1oG6nxo=;
        b=3q0xhrNufhhcRSB32RUVnDPwnigm8Qv1lstUvtH2kwESJkB4DoppxqX2nBn1bAS7hu
         XIygy1o/JxJL8povURhDkqTwXR7+pagOWmwBDNUxrs4Yq+kXu47oUToHjOdEIHUTzOnK
         RR08ex8NT6vcWFB/YFG/m8d6JfX3CfHvJrDs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770041052; x=1770645852;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJZrMpkecMaCQVX2n2yc6VyMBcfrvHzg/Iaf1oG6nxo=;
        b=Uik0kSogsCwUoLJudRVuOSGHbQ3PbfGELtzwZDJRK2VPLchMWj+K610opSoE8xRuS6
         nwE8cwmEl8lhmQksG/BOZJFEv90beu9Dw6UjdZlFAToMe9bZSiCic6r3SoYN4nxCq2R0
         HBK/Z5fesC5sqxTfpYIAfq5GmVgBVXeYOtVCAXZtjArvvptRTyjrgttux9OWZDSK4wP2
         eRc9k7FrSkaYOmz6snkGCciIdJbIznG6jJIpFbmaT6J0fQbiDddUTFwCIgWwDg9XlsHT
         Sc98Ueu0VapWPQmh/r3cts5xa1+L1pU9408gDhpIiUuqSJAeFFitURjjpyokbghBSHmR
         bs/w==
X-Gm-Message-State: AOJu0YyelYPjIUI3zIVFXnxYPEMXicS9tzT8bEIxN20P90M/E3mk7z6+
	OGJafozZYcykzwvhcX4tU7pzVMWVyRTRDBf6CTG8bOEeWJpSfQ5qPU4RuTwbcUYdA53uoe2q2b3
	BjKAfvj/HYkOdzXdLUmudyHblAuWNabajISkrGR+ZelZYJsp3BSTFD52ZnQ==
X-Gm-Gg: AZuq6aJEipMKXG48KEilJ/aAHYjVzZbX5co+DExOVZ80azDxydgD8FrJ7cSgpJtOPr8
	ZYfQR8869vrJ23iVk17qzAZDMy7avb6T7O+8gX1ystraabfVxZ+VHtvMLo0GVHXRPrJhKX5oSHP
	6F570bS5RVme9D3dK3gecV8B5v4K01FXfhggGwz5300NHsAkQ1RUyUejbH/PnDrI9k9T9SMCNRM
	26sDnSIT2Iayh4sYCzXsx4V4/G7tW/9xn9W0Oe5DW8GezfoHf+x0BXzyHsVeGpeTPnxd+c8hIAt
	NTJZRdRE02PxCtmtP+FgmTva9FFGzhLypN73zkqqq5d/zNefCZmUYF7YTAOlVfwZYdOFN7PH
X-Received: by 2002:a17:907:e158:b0:b8a:f2cb:8088 with SMTP id
 a640c23a62f3a-b8e460d2c09mr278426766b.33.1770041052267; Mon, 02 Feb 2026
 06:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tqO9SstMLehsKRhNT89fp0_U-9Q8_nKj4VeD8C5A5ZtQ@mail.gmail.com>
In-Reply-To: <CAFc1U0tqO9SstMLehsKRhNT89fp0_U-9Q8_nKj4VeD8C5A5ZtQ@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 2 Feb 2026 15:05:21 +0100
X-Gm-Features: AZwV_QhaDUiN92-WOySFe-R_GC5HiDRByA356ELa0ka5a-qVw2XdaVO-X46VtWQ
Message-ID: <CAFc1U0uojGV4Tg2cD+c-aK3MxjvUnjWgCLrX+dP46hBsi7Nh+Q@mail.gmail.com>
Subject: Re: /proc/xenomai/irq for Xenomai 3.3
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forget about my question, found it in /proc/interrupts with oob flag...

272:         99          0          0          0      GPC  26 Level
oob  rtser0

Le lun. 2 f=C3=A9vr. 2026 =C3=A0 14:58, Pierre FICHEUX <pierre.ficheux@smil=
e.fr> a =C3=A9crit :
>
> Hi,
>
> I notice /proc/xenomai/irq is not available anymore (?)
>
> What is the way to know the IRQ used by a RTDM driver ?
>
> Regards
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
