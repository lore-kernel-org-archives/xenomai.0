Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1243D0A0
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930345; cv=none; b=A/E/KDefi1ooPNvvMswLDmGfp7NLSFUIIXVuSfjeqhlNpQPsEDWTYlqsOOTGBAtnQAeVH/rJ8dhid7gIz1oqlukc50hweO3D28d/JRmDiAM/2iFANrpoWJoXJto7+AESH91cQZkKwcrk0PLwN4rb2VlxeVOMW5PpW1oK/QoYcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930345; c=relaxed/simple;
	bh=Hd0w2HOH/NO6plt1qMJ4rqzKkq5+GS/+kP+5iLFTO3Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=s/WyI/iPuZFuw9jXpaxIoUKcOB491aFluYETeciEDaLQiGaStf/fNqw52loWPRp8j19DdFw2EVijrOAgJuVZL7PeMkJoPe60/4/rg8y6+Gf9KAKzCZLKKVcJ/OV8Lcbl1VsZty6AbyGxgOGJdfQfCBMF3aKSP9yx0+J5ZT4DwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1786139f8f.0
        for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 05:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705930342; x=1706535142;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hd0w2HOH/NO6plt1qMJ4rqzKkq5+GS/+kP+5iLFTO3Q=;
        b=YZgoW3AmLdr91BWczeFW2Y3lAWEHvF/yIagI5ydYwX2mYeLYl8eiarR/h/m0JqbwMv
         AOZkVbmb6n/NMVLLsnCvjlcGN/u2jDrmA5O8fbS4k0XphS9+nYktq8XkhIpRWx42UdOP
         f7zrdxm8iIiiSzXF8M8p7dub7ZGU9J8kbNXA51obHt9PpD+XuKNIfhLCNW4uy+ULZh8n
         38PlLVdthdGpemGJ97kqkYHV24wYOY5xUtBQCV1oveYPrfWnJg9CF649Hmsw8uJZnQBI
         NsPsCUl4lK0JOAEkS4S5Cd8tOuaWULOOKe9ikGl3UGGiXl43n6SavOFL5Zl0C+J8Ef5Z
         OAbA==
X-Gm-Message-State: AOJu0YwkaqXb0BH0fuqM8zzLDcxSqp+GA15M2b+o1qwTEZ62VMhF4rFj
	5H/1XQAUUcsY4P7z/Mx+mC4+XoX0uXieygfdEQhIR4yfAFOk1sDZd+L1LpzmMMg=
X-Google-Smtp-Source: AGHT+IEN05h5374JSBAcMFEGkEFFs9GMxOo3rQzYATwJQedIwQ5ikGbDc6cimwPhDR63rtVyDKM4Tg==
X-Received: by 2002:adf:e392:0:b0:337:afb7:1acb with SMTP id e18-20020adfe392000000b00337afb71acbmr2091695wrm.114.1705930341836;
        Mon, 22 Jan 2024 05:32:21 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0033936c34713sm2895462wrd.78.2024.01.22.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:32:21 -0800 (PST)
References: <65aab24f.050a0220.e75a1.ee69@mx.google.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?C=C3=A9dric_Ch=C3=A9pied?= <cedric.chepied@drotek.com>
Cc: xenomai@lists.linux.dev
Subject: Re: imx6 flexcan
Date: Mon, 22 Jan 2024 14:26:28 +0100
In-reply-to: <65aab24f.050a0220.e75a1.ee69@mx.google.com>
Message-ID: <87h6j5h4t7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


C=C3=A9dric Ch=C3=A9pied <cedric.chepied@drotek.com> writes:

> Hi,
>
> I'm running linux-evl on my imx6ul and it seems to run fine so far.
>
> Now I want to send can data in an oob thread. I added the SOCK_OOB flag t=
o my
> socket and tried to run oob_write. It returns -1 so I think flexcan drive=
r has
> no oob capabilities.
>
> How much work would it take to give OOB capabilities to the driver? What =
level
> of support can I expect?
>
> Thanks,

Real-time driver support with EVL is documented here:
https://evlproject.org/core/oob-drivers/

There is more than just enabling an oob path for the flexcan driver,
such path should be enabled in the generic CAN stack as well for this to
work, as this was done for the generic DMA engine, the generic SPI core,
and the generic GPIO layer.

--=20
Philippe.
