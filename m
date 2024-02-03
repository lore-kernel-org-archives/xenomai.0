Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0051640B
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707003854; cv=none; b=oJtPhIiulSJS3Wk7670a+CoB6/0cYX18XP/IgxIgP4izgSWG9dUsdqJM+f9/KM8jmU8pjJLwsaysX49EbGdjLHQACINitUL1iSckwbk2VBv+9Zhb8McJev/gV7ZGRVoHZN6lDSs6SEWnRWDKyqBCljMSWglE6VB41lUihKmv9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707003854; c=relaxed/simple;
	bh=tBRdVeLcoPe3YwIMuC7CSOsYSuRsJjRWWnmdXOk7Lck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bayM/9m8f/anaAi26+le+2Q82pnTTX24LA/6U0wjJV01t+tDcZvuE8CGuzR95GRgi5Cir+cCFtLIONo2g12Trxfe0u2Bty3/qkK4+gpogqv89O8MuEG5ScCPnQmgv+JOlnqw04LplO1fB5V8qatzjMiQQpvBG99qu8P9YqbneUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXNidRoc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXNidRoc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e112826395so1590036a34.0
        for <xenomai@lists.linux.dev>; Sat, 03 Feb 2024 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707003852; x=1707608652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBRdVeLcoPe3YwIMuC7CSOsYSuRsJjRWWnmdXOk7Lck=;
        b=cXNidRocS0Kb3Odgv5jWmqYrpBDYWsgdlFoRamhwY+umHjtfcuTN0Yvbz0rUuBoStc
         +nIpduuIroZui/4ZtySlbcjl+tHZ0CZcsEvk5EtaHdal+hSRTn6t2DVOpDjy3Gk0lcFs
         0ksG7CdOFkgUr0oXvyE16Fyp39zTQ2p6t/zOb5VkcjcfG9tOCBO89P8boeUG8QCpO+Dd
         XdFoC+OUXPqczUegVWVq7fiViYHZL0bm0fpxM/gWwdTHCce2D/FoPEArqyjnDcwhcaQR
         3B85G/Bdg4nglWlUcLoo5zuwtETCvDYw2vsQpSRA5lu/Dzs5fCA5gERnvoahO6obQSGr
         6Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707003852; x=1707608652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBRdVeLcoPe3YwIMuC7CSOsYSuRsJjRWWnmdXOk7Lck=;
        b=WEUB5p1gYv+8WWCKR8H6DFQDUZa9hGKVFdlkRnDIXOgzebfONWmIWfREHmjZeiFhO8
         TFL1Aa8O4jdjuZcJgBl2zj8j94FTOjAOKjg89TJsgqLSpPpU635X3Cd5vZHj32ItEbPp
         9GfAL67qidJXhIvG2M/B0bWOc+ujtRjhkkp23vH1IN6s0XCgQQ3svB6UxoQb+8pqa3Ak
         lVogFWnnvNOplTLbm0HyiSObpq6vlyovHUeG1CJ4icCcOtGaMrp5zryLLUkUvOT0z1Xh
         A0abYRssmZTCQ36DUTH3ZAAPFAJ6CwJ1BSVls/uitE5GoctjbbTOuWv35uwsYzD0huGp
         vqYQ==
X-Gm-Message-State: AOJu0Yx4pq7iDGyrXGRQuRTC3SzAT22vljvOTE75rUHH3jlauBqSW3Kk
	PhO/X35PcAJfzVgtm6aLbn+hCIqnfk6S8TNQFs3ptUIxpAcJUdXlsMoj/SEAf2YLDiU7/eaOhr6
	f3J0b8Lqw+7pX+yBjCmHihWjHBDhuPwjxlaA=
X-Google-Smtp-Source: AGHT+IH9LzmmQRe/kAkYXzNaTYXlry0sk86YG3ud7/hsyp9kKxSjaclK8ZXUMofwrBrMJLq89G2HbCm1UyZjMBfmKFo=
X-Received: by 2002:a05:6830:849:b0:6e1:75e:fddd with SMTP id
 g9-20020a056830084900b006e1075efdddmr12455532ott.7.1707003852308; Sat, 03 Feb
 2024 15:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
 <20240122160105.2452024-6-clara.kowalsky@siemens.com> <CAFLxGvwH5i=u9_7ffN_uwctBHOANFDe3SFfoL9mxYbkpQJx8sg@mail.gmail.com>
 <6ab00f96df765db93faf2c3da14737e1f796a6a1.camel@siemens.com>
In-Reply-To: <6ab00f96df765db93faf2c3da14737e1f796a6a1.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 4 Feb 2024 00:43:59 +0100
Message-ID: <CAFLxGvxxrmZO9_HnVmmZFJn_z61k7tDGQ0c5w7CCbHibvhiENw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] compat support: cobalt/posix/syscall: Use syscall_get_arguments()
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev, rpm@xenomai.org, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 11:38=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> > Hmm, how does this worth with Xenomai arm32 ABI, do you fixup regs
> > somewhere else?
> > It places XENO_ARM_SYSCALL into r7 and uses r0 for the cobalt syscall i=
d.
> > So we're wasting one argument and they need shifting.
>
> This is just a cleanup - in case I recall correctly.
>
> Re-read patch 2 carefully. We changed the register usage, basically
> aligned it with the Xenomai arm64 ABI.

Okay, this explains why you didn't need the changes I had to make to doveta=
il.
Since you're changing the ABI, that's fine.

I briefly read patch 2 but didn't realize the impact of the change.
The commit messages could be more comprehensive IMHO.

--
Thanks,
//richard
