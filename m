Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992C189F58
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474024; cv=none; b=G9VboVPbmV2rvMl5sf+uDaUul5tD9Bi2YOkAKbqRl255v0deORucHMcHqHkHMv0tTYNwxbGRfvlX/uPF/HF2AHiCe1VkW62iNtZsLNg7CN9XIdnX/dON/7DdQlGyNcFdDoBmlN100z560QrdQaPUOwys++B/X6NF3VecexvK00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474024; c=relaxed/simple;
	bh=k3++SnZKWqWigfHERtUDfuTAs81S02NhUHWSqywlnok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dq0jnatylJ2Ns6bniEJjXQG6JSbP8DoPCGt3PM0Qrb1gf2ljv/SO58yD+6I4csG8FTM6iEf11oHRZkmvVxubyQy9cZW/Hvia8NLFL/fETniPENgSUT+16vlCz1WpgsjsAxOhds/IONTrOEQIUlKuLLkDtGyat02licJje713YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 09424100002
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 11:40:20 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 476DBD80477
	for <xenomai@xenomai.org>; Wed,  9 Oct 2024 11:40:19 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cdac05af9so6171799f8f.0
        for <xenomai@xenomai.org>; Wed, 09 Oct 2024 04:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474019; x=1729078819;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPD3V740+iEUNY7aL59JLL1dkv1LML1rY8h5wTrTHG0=;
        b=LZa5Bt/izdmfRlOeNi8eo3Www0+sfDubfFoKiiVfjXbXmnrwG6sDKQgB5ndURtGOs9
         MfGQB47L23+GhOEjJZLV1lqeQqt9rYdu3SlL4XTzXdEgRz9kx9YwyKcOuPFZMV38BTDy
         zFllJHNTLUbqn0auPa3plIJ/rew9zLgCYn8La6X45gJAkXrTwTTxovs+tnUVB1u6FiOc
         lPWQMSv507NclSlxDkZH4LGsINjDrbC4ywOvz1jQpznzX1QZtvpaI9B+3MZVdemzAjSn
         6LfxNFgcHv6WGk0I1jb1cdRi/BzfS4Zlbv0Tbtwd+jZSKJLWb7fZGndcO5UCRW+BBxmv
         qUgg==
X-Forwarded-Encrypted: i=1; AJvYcCX9vDmq2JB2QRM/G69UsZ4dI/AfHdUqxngSPfsJvDH2FNszIIVr0CeMzX059xfNVLds1H3AVBf7@xenomai.org
X-Gm-Message-State: AOJu0Yxev7a21c6xNM5fQX3Dvo4KdOC66F+xOmvXEsvUdA3x+A3jCYHk
	kfnrgPPfpI4cdXU9XKH1+CybwIRCdItmNM5QkND6sYwN4Knh+VgReQPIOg==
X-Google-Smtp-Source: AGHT+IH00TGEkGeOxf1Vq39LoVhW10sNwIO6i132zsAY9fd8GqEeb6Wk4k86DmZh652aPq0pG4PuCw==
X-Received: by 2002:a5d:4e0e:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-37d3aa570c3mr1845330f8f.24.1728474018526;
        Wed, 09 Oct 2024 04:40:18 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169203f4sm10213995f8f.53.2024.10.09.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:40:18 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>,  xenomai <xenomai@xenomai.org>
Subject: Re: POSIX API for EVL
In-Reply-To: <815623d2-2222-4eb7-8c64-2f5f9aaf48fb@siemens.com> (Jan Kiszka's
	message of "Wed, 9 Oct 2024 11:59:43 +0200")
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
	<87set6lajm.fsf@xenomai.org>
	<CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
	<815623d2-2222-4eb7-8c64-2f5f9aaf48fb@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 09 Oct 2024 13:40:09 +0200
Message-ID: <87ttdlcxnq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.221.42 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 09.10.24 09:53, Pierre FICHEUX wrote:
>> Hi Philippe,
>> 
>> Yes, I do remember.
>> 
>> https://source.denx.de/Xenomai/xenomai/-/wikis/Common_Xenomai_Platform
>> 
>> The lack of interest is a bit strange as the industry is mostly based on POSIX.
>> 
>
> I would say the challenge of moving forward is right now that users
> already on Xenomai 3 are happy enough to stay so far, plus some have the
> blocker of missing POSIX with EVL. So, there is now an upfront invest
> needed to enable POSIX over EVL in order to evaluate if the own
> application works even better there. This is at least the case for our
> internal users.
>

I agree, this makes sense. This said, I may emphasize a couple of major
differences between x3 and x4:

- SMP scalability. Because of its outdated serialization scheme, x3
  performs properly (latency-wise) on up to 4-6? cores max. running
  real-time threads concurrently. x4 does not have the big-lock
  scalability issue x3 has, so virtually any number of cores can be used
  for concurrent real-time activity. Granted, not every rt app needs a
  truckload of CPUs to run concurrently, however the fine-grained
  locking scheme x4 implements like the rest of the kernel does also
  greatly improves concurrency within any given real-time CPU
  (typically, this shows when running the context switcher stress test
  alongside a latency-sensitive application on mid-range or low-end hw).

- Complexity, maintenance burden. Only looking at the Cobalt vs EVL core
  code footprints, including the netstack but no drivers, excluding user
  APIS, we currently have:

{rpm@pyro} cloc kernel/evl include/uapi/evl include/evl
     147 text files.
     139 unique files.                              
       8 files ignored.

github.com/AlDanial/cloc v 2.02  T=0.11 s (1268.6 files/s, 281809.5 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C                               48           3955           4078          16404
C/C++ Header                    83           1260            932           4190
...
-------------------------------------------------------------------------------

VS

{rpm@pyro} cloc kernel/cobalt include/cobalt/kernel kernel/drivers/net/stack
     355 text files.
     329 unique files.                              
      26 files ignored.

github.com/AlDanial/cloc v 2.02  T=0.22 s (1479.4 files/s, 341314.9 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C                              109           8781          11091          33066
C/C++ Header                   198           3762           6128          12771
...
-------------------------------------------------------------------------------

- Integration. EVL reuses the standard VFS abstraction to implement the
  everything-is-a-file scheme for accessing its features/elements, which
  x3 cannot. As a result, a real-time capable driver is a regular Linux
  character driver in essence, plus there is no redundant rt-specific
  file descriptor namespace. IOW, the regular Linux file resource
  management applies to any element created by the EVL core (reference
  tracking, release, dups and so on).

- EVL is Dovetail-native. For instance, valgrind support is readily
  there and for-free, because the core relies on the prctl() redirection
  to receive real-time syscalls, which x3 won't be able to use until its
  way of marshalling syscall args is entirely reworked. The real-time
  network stack can provide UDP and raw ethernet socket support by
  sharing few but important portions of the regular network stack when
  running out-of-band, which explains why the x4 netstack exhibits
  roughly a third of the x3 footprints.

So indeed, x4 may not be a requirement to some/many, but still, there
are some advantages there.

> But my plan remains to enhance portability from Xenomai 3 to 4 so that
> more comparisons are possible, and we may eventually even consolidate
> over a single code base again.
>

Ok, I'd be there to help if/when this happens.

-- 
Philippe.
