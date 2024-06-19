Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE851D54A
	for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809032; cv=none; b=Loo/Os4APkUIPYELlFCYrdZPB+onDWhw9JcJ8dMAC9QgpVwD62+wMn7ujK2cla+53p1pOswLe4y1ZYDqUQnjR8Q3TMLcyh3lKajej7XkYsy7ZkRvcf6w97RimUGIBYRS9ciIpK5UiTJzKt/NDf6rt8mvCbJm/tiJV5VLm9Pt6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809032; c=relaxed/simple;
	bh=cslzY9lLcr6Yq7MoIDXcVrIXf3XltKufRla0QEBCfbU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=nKdkefcY9CAm0DVTs8QfVCg60ChHKM8WmWn+spuKCXwItplPrlqOT6ikdzo0K+3IuOnqQunQE9ALFW4w9O5l8RmAKkuB/nGkkRoqzd8Kfdc8T/iO9WJzsct06SjQGnGGs8EKPQ43VSOocXZIqZhds1OmEviApO1Fuu46QE8wyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36226e98370so1110402f8f.3
        for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 07:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809027; x=1719413827;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vssNqriOLHqIUdnkaglxkDi9OeV37yPpyzlqJN4vKvc=;
        b=jViF4/64Byopu0UbNTEz6Q+ik9cEM4sC1GvBYl0+cB1/O2pwZnMyKMnjoKgmfDXDlJ
         9I0KYd8Dowhu0xJu8+xEvLzfFWhlC2eC9k8i+eAEzcUDSPzMUQzslYT/7cyEC+wUJu5F
         H/TSl8oIEocM76VeLQF34Iut7RMZWwJna7QIFJcrfY7ItZIvo6c0JhKYIS15fO5SUIM0
         lE/n59eE4lp8pRiaMAbOGFYyz0MKbfvYTsD8gqedpC0/eEFmcjBMkRdRGbUYpEwdHJSF
         AUU3/sqMIeiewq3B8ylXDmbvgsr87fzmRmk2eZI/eoXK5EVdaZYo5lhLs0lvh3N5RRIr
         10tA==
X-Forwarded-Encrypted: i=1; AJvYcCWcCFjxPHCz5IQV2R/ad9WLy0nrg5S6P6wHoHW9iU+7bSuEyHjrbwimDzyHVOQgJApDAf8FMAe8tCTp9PE4qSE8FzUbEDp4Tg==
X-Gm-Message-State: AOJu0Yxh8daFTcxfPzV2/x8JZjmlrXEwfWXsFUAXJJ5vjjVgb+QO52OM
	ijRzpwsQHbhVci19oU+DunSaOL4RdDV3JuN94cQLdBZKSyJtmR4/UkHQQA==
X-Google-Smtp-Source: AGHT+IFx5NX+V+IqVE006ig/TINNfkUdeGJOCEP3bzJBQA6TYsWJ3paCd0JVOWqyw7tsq/6N4Acd5g==
X-Received: by 2002:a5d:56c2:0:b0:35f:1bd0:4da with SMTP id ffacd0b85a97d-363175b832cmr2093603f8f.15.1718809027293;
        Wed, 19 Jun 2024 07:57:07 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3641788cf4fsm893151f8f.90.2024.06.19.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:57:06 -0700 (PDT)
References: <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <ce3d9b5c-f9f8-412d-86dd-2d3579043359@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: EVL kernel config on x86 only for 64bits ?
Date: Wed, 19 Jun 2024 16:55:55 +0200
In-reply-to: <ce3d9b5c-f9f8-412d-86dd-2d3579043359@siemens.com>
Message-ID: <87bk3xrneq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.06.24 16:13, LE-DOUARAIN Marc wrote:
>> Hello,
>> 
>> It took me some time in kernel config for x86 to discover that the EVL_CONFIG menu is hidden if < 64-bit kernel > is not checked.
>> Is EVL for Xenomai 4 on x86 not compatible with 32 bits processors ? And Xenomai 3 would be the only choice available.
>> If it is the case, it should be precised at https://v4.xenomai.org/ports/ for x86.
>> 
>
> 32-bit x86 is processors are history now (no longer in production for
> almost a decade IIRC). 32-bit-only x86 kernels should no longer be used
> for many years already, also on 64-bit CPUs supporting 32-bit modes
> still. Use the compat interface in that case (32-bit apps on 64-bit
> kernels), but that is indeed Xenomai 3 only - unless I missed something
> as well.
>

x4 does support x86_32 apps over x86_64 kernels in compat mode, and
armv7 apps over armv8 kernels.

-- 
Philippe.
