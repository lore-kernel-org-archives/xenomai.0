Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5E1FA84F
	for <xenomai@lists.linux.dev>; Fri,  3 Jan 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929163; cv=none; b=ce/HMrQ5DGWVWxLg8trrSyXccQKegn7QWa3F3ff+AFvITxzstDo1LwX8G6eRnZQgCsh3O1eu/jMHXAPnVmZeDzyyT5GT9F5n6LYfbES9GbeIdd2Vc1AnVdCzo+CryrAtEbvY4koC0BEV1mTrC1jovX2GhnT8DT6YvK1qAcPOCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929163; c=relaxed/simple;
	bh=/Xb62zNl9jdJ8sqbRLHgt0Ra0pi818Hv60KhwTsNPPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oVR+s2Zn0A9pq8o0z3FYV1tEFuKy4hyD0E6nZhRv21c+4ZIrdqsqGqZnisnQcqNqlp2rajkPB+/wVD+DJmfnIugKwYTUgIBBWDwFkNQYnFGhDiyIoaWAT+IXWfs/nhFfKSU+Z2RaZSju/csNT82PAj8zOb2IDurCd9+XvkfnFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436345cc17bso91132585e9.0
        for <xenomai@lists.linux.dev>; Fri, 03 Jan 2025 10:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929160; x=1736533960;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Xb62zNl9jdJ8sqbRLHgt0Ra0pi818Hv60KhwTsNPPI=;
        b=OnM/jpk+hrGAHgpCzIzVj0GelOx2Zi9ZX+ex6UXKtpZV6oYo7SNEWPTbxXpjr1AD+t
         4K2xHVPcs4PkqfcgHiT+oatSW2oyLIgB2pVSna2wOOjmOde100iFS7J/uI95szjG6U6e
         pN1hPg/tCpzHHr4RwjL2x7up8ftudxO56Eb6W6NWnvqNNLY07YbUlexzFW2apj8xafMq
         3swz60yMp+6FOttKSj8VdvLb2gMw+k2QUkUIQyQ5XCMmCHqLOdn9osH5v4CjluGZgcCH
         GwvciQur/Ey+9oXBBanJ9Yx3UeJzi1f00H36SIYwn4u7oJthZ1LFXIdj8pFTyYs97YXd
         20Ew==
X-Gm-Message-State: AOJu0Yy/lOWsIrwWucxtdWBqNjRn+xWUQEU/Mvg6u/qSUsezFtDEDbT2
	0lLMYc6szQ8q52rXoHo5Bl9N257Qyv9q4qyzUDEakPCsnPQzd+QbVWvS9Q==
X-Gm-Gg: ASbGncs/ymFt9tT0rs36sK7s/hMlSdUC3S6UwZYRWxE99+mEkTeUNaNh09gE1ygxvD4
	VRX7f55ImXrHyFOkJigb8TnximEEsdXI7kphXKVBhvvFEvO3pOc9Ct9qy5pysmkF2BBxFntYvgY
	0iFS5KPlyhwEVEHFpZlVyfd8ZVOu1xBLdbnWBfqF6n0dDx6nl347TNxd4MLFB6CHwcu/WY6Evu2
	H7L37zu8wNLllen4u6xkwMnJgnx+M3jbSkJ1ze9lw==
X-Google-Smtp-Source: AGHT+IHO3FjTY7Ve6V/aE2geLzVR04gyYOvmFadf8JLZHzGhSwkkUJ/r4AXUHOgdo0q3BoDKJIfcQA==
X-Received: by 2002:a05:600c:4448:b0:434:fbda:1f36 with SMTP id 5b1f17b1804b1-43668b5e111mr372240155e9.20.1735929159444;
        Fri, 03 Jan 2025 10:32:39 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm41977667f8f.45.2025.01.03.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:32:38 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Hongbo Wang <hongbo.wang@nxp.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: FW: [EXT] Re: =?utf-8?B?6L2s5Y+ROg==?= Performance issue about
 Xenomai4 EVL
 core(v6.6.23-evl2-rebase)
In-Reply-To: <AS8PR04MB8119D818B3D79ADBDBFE980FE13B2@AS8PR04MB8119.eurprd04.prod.outlook.com>
	(Hongbo Wang's message of "Mon, 16 Dec 2024 02:13:07 +0000")
References: <AS8PR04MB8119B0401C5CB0EA31DF207DE1352@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB81198798255FBF290C500120E1372@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119B91C92C4361DDB6FBE2DE1302@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<87ser2wld2.fsf@xenomai.org>
	<AS8PR04MB8119D9E6C982D6BB998B4380E1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119242427AA2F405CBBD9DBE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119EF7586D426724D8ADC6CE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119D818B3D79ADBDBFE980FE13B2@AS8PR04MB8119.eurprd04.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 03 Jan 2025 19:32:34 +0100
Message-ID: <87frlziw8t.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hongbo Wang <hongbo.wang@nxp.com> writes:

> Hi,
>
>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Philippe Gerum <rpm@xenomai.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B412=E6=9C=885=E6=97=A5=
 17:05
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Hongbo Wang <hongbo.wang@nxp.com>
>> =E4=B8=BB=E9=A2=98: [EXT] Re: =E8=BD=AC=E5=8F=91: Performance issue abou=
t Xenomai4 EVL
>> core(v6.6.23-evl2-rebase)
>>=20
>> Caution: This is an external email. Please take care when clicking=20
>> links or opening attachments. When in doubt, report the message using=20
>> the 'Report this email' button
>>=20
>>=20
>> Hongbo Wang <hongbo.wang@nxp.com> writes:
>>=20
>> > Hi Xenomai owner,
>> >
>> > I try to find the root cause of this issue, so I applied the=20
>> > attached linux-evl.patch for kernel, it will reuse RWA counter as=20
>> > timeout counter. if
>> RWA counter is not 0, timeout happens.
>> >
>> > In my test using evl_latency, I indeed captured the case that RWA is n=
ot 0.
>> > after that, I supposed it may be caused by out-of-step between=20
>> > userspace vdso gettime and evl_read_clock(*MONO*) used in EVL core,=20
>> > so, I
>> applied the patch libevl.patch for libevl, to get clock_id that used in =
EVL core.
>> > but it also has same issue, SYS is bigger than CTXSW obviously=20
>> > because of
>> using non-vdso gettime.
>> >

I would find it way more obvious if you could verify that
handle_vdso_fallback() (kernel/evl/syscall.c) is indeed catching
__NR_clock_gettime or __NR_clock_gettime64 when the sampling thread
runs.

Btw, none of your notes mentioned which arm64 SoC you have been working
with to get these results. This information is needed to figure out what
happens.

--=20
Philippe.
