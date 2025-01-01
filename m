Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9A10940
	for <xenomai@lists.linux.dev>; Wed,  1 Jan 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735747665; cv=none; b=H5dtqmpTBIvY3DbDiZ4sQ3pu8VVCAk3Lp0Nn6XMcajv83PE28rnUT+kWY+9BX5UBPh6HFQIeD4nYh+D50M9uNFu2rnpxhKsSe+YpTFb+TDV3pIN+6gS2HuR+a1Q8UNckSaubEMzbwvq/aTJv2rhUcG0eb/ajOTK6oovxBULfgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735747665; c=relaxed/simple;
	bh=+OzYPZqVx2VspcSUVDCwU9hot46mIsrJ+KJnoZzXJnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lO4rGFwmVDZgcGKyGBkq2W+vdfYKAlQtEACDMNJxctwHkeM7Lh1bf6qNWCFuafWev8Haz3dIt7eliiFjVNTi/gxzOAmKUpjpf6kbCDvRg3ibMstZxjiAZXdZwnQxFfrTVYzmjUi10c/15k9CTWYT1a0gv1geVaibMsGdZSBVuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso9162584f8f.1
        for <xenomai@lists.linux.dev>; Wed, 01 Jan 2025 08:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735747661; x=1736352461;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPsvz5ZM83yxYRN8PwXWFtsp4gLJwjEChofbaz37Jfs=;
        b=dFIROxeFwsJIrs9mLlSi51MxWw3KRnloiDQp9XLoXU+hU67M33aPU0yjANiIb+litI
         QDFMv2jEqi9h/0nEg6Uddn58UV9ND25NAg+VQPdknCvdP9ts51hBIrBI9yzFKuEfBi97
         HAFGHMnQY1NahIEBAnj6N5clL/UsjiC5sPfur8giMSJck15fIcrqYlX9cookhcD8BTxs
         pTcSuqCPtybGnVMNjU76vXtKQ08edN81hPP2JKTwV/f+J1woN0ddPwTWV5xX/6BrU16o
         CdE4zi3SKTvFP4yRCTGcL4zm6XtS2JwpSCy6pKrqit4sYThLDMbcvwOR2qftvamU4CWM
         SymQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1SMdnfVU02n7ajWvvwouvmdj/OJ9Akz712jWgsbxmf/Cobo7DJgj5oj8Qrj7L+sq1L5+V3IjQ@lists.linux.dev
X-Gm-Message-State: AOJu0YyX2JeNvnOzYtEF/lmQJAHoFnbe8f4mKkYJspgZVsylpbXn6vzO
	nT+fJKbC+l60Tn9IQPJgYOCihq7YfSr1NOBmCafGMtSG2bJQLfeWYhj9TQ==
X-Gm-Gg: ASbGncstqVTpKjc9GdNhbGSgXWfxXjtYDL7oVIt5OQ/Z3ucESssZPpuXVgeKdJ28suO
	OYWt8Wx2o+I8K+Dv+zSo35jjzwnmLp9CVEGDSPKCxPgS9F24BmAzCUd7Ryvs+2XOEFiYB1bR4jf
	AdUmIn0sSrQ+8j6D5N1H3wg7tOI9fbNpkUHM2ch/xPvklIYcOrwgbuEgQcknt64mfSkUk1dspXv
	HGB5DJTGwwA9Eak6YkP+boLcy3/rHcXpmjL0FRk0Q==
X-Google-Smtp-Source: AGHT+IEKcapEuwMjyunPNlHoMgcBUl6otxc2Ux+QYD7I0AguLSZFOrD8osZ/5Tagk/x9AcyXhtUffw==
X-Received: by 2002:a5d:6d0a:0:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a22408d23mr43331583f8f.53.1735747661254;
        Wed, 01 Jan 2025 08:07:41 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8471dcsm35970634f8f.48.2025.01.01.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:07:39 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Cc: "shanmu1901@gmail.com" <shanmu1901@gmail.com>,
  "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH 0/1] *** Simplify RISC-V IPI code ***
In-Reply-To: <71fb755acf4de4a7b7bef35ca1de6e420a091a33.camel@siemens.com>
	(Tobias Schaffner's message of "Tue, 17 Dec 2024 14:40:57 +0000")
References: <20241212163837.326938-1-shanmu1901@gmail.com>
	<71fb755acf4de4a7b7bef35ca1de6e420a091a33.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 01 Jan 2025 17:07:34 +0100
Message-ID: <87wmfe8qm1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Schaffner, Tobias" <tobias.schaffner@siemens.com> writes:

> On Thu, 2024-12-12 at 16:38 +0000, shannmu wrote:
>> RISC-V is different from aarch64. AArch64 has SGI0-15 and use
>> SGI0-7 to send IPIs, so we introduced a feature that we handle
>> inband ipis multiplexed over SGI0. But RISC-V only has one register
>> to inform IPI and the ipi_types are recorded in the PER_CPU
>> variables,
>> which can store `sizeof(atomic_t)` bits. So we don't need to use
>> the same way to send IPIs. We can simplify the code by unifying the
>> IPI handling code and sending code for oob and inband ipis.
>
> Tested-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>
> Looks good to me. Thanks for this improvement.
>

Merged into [1], thanks.

[1] https://source.denx.de/Xenomai/linux-dovetail/-/commits/wip/dovetail-riscv?ref_type=heads

-- 
Philippe.
