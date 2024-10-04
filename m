Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C55146A93
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034607; cv=none; b=W1rnjjRMcDQwrPjziQkLqSohViWjU2+iEpmrlMmuEyQUwtigOP5Msp7flf/1nz7lghaU9xlW/5LGMn3j5lwtGs7l/1+EdSo3myuP+8EU32BDMFf5qhqYiRdRMf1zNa8HxbgE6INasJEUTOPdjpqzUU6526asb4FLoX4EhqcucME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034607; c=relaxed/simple;
	bh=E8Qq/Fgy1DMlJXa6aogNOU397uqjglYDmCds+DbMf9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvKzvcnmIbaJX/cbtI/+8lRLjoFhnAjCb59WwqppmkirJP/5253R9HOGMeR+/6tCmD6XVDrqFqFLZ7WPk073Ukvagm9HtohJsZDEbI6YUKWUOaJVUsanSL+gfI4aaLzUEws6kx9kxA9Zv//eSq3UbvwhAaZt1hlLw4jYxtocPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so18924305e9.0
        for <xenomai@lists.linux.dev>; Fri, 04 Oct 2024 02:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728034604; x=1728639404;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltHW20N3oyUDPvtF04a9x41cU6adCsRmbdJ3B3OGN88=;
        b=YnMXvhx9SN8+p84Ycvww6189Yhlz2uj+k4m8YDbmyBMkBvp8B6iv+pqbQyUwh2DZOO
         hLnn6fsiOgjMb4IhXORC+9KEDN611qE3EcOmcHDJFp/USpYGxyid0Ggb0Vi0wytKTMja
         HOjTd9sxszq8H74EUxIm+c+mxtQbpkN5foCDRW7zOB+aXMF9pomG0wftDycr/345lYEk
         WVgvUoJRjcrrsHfDBIBHndTW3722To3D8BO5sw2+ejuAUHz9jbqJYexXDSTscIupunn6
         XHkExOorOE0PK9n3lpxEEMQJXJdj7PBCMXr4YfUpmr5UF6hOPmpSO5tPBtjYC7Ih5CUT
         XZMg==
X-Forwarded-Encrypted: i=1; AJvYcCWjlCpVw1R0S5uo0/JtGW5nWsP+UqhFHYTAcur6VnB20RzaprFl8qTBiNOb/ASLJXK+nFlop9w3@lists.linux.dev
X-Gm-Message-State: AOJu0Yzfezx2swBdt1WVlQot2WHamtEFGK9MRUL2rXkXXxzjeOVIUqAY
	+a7Eg3RYfR62hb08wCqqqUoyxjsz635IgI9EhOILa06QAFl1n0kJx4a4Ylbj
X-Google-Smtp-Source: AGHT+IH233Hy2DyJA5XXUoyQneCE0qyGYBEtt8Cuxf397SYIA4dpFJC5RQPyXzeHuYxYy17di3lKpw==
X-Received: by 2002:a05:600c:3583:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42f85aef71amr14742535e9.29.1728034604014;
        Fri, 04 Oct 2024 02:36:44 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a201fesm11058125e9.1.2024.10.04.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:36:43 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail 6.11 0/2] RISC-V: IRQ pipelining core
In-Reply-To: <fd270dfd-f46d-4f1e-96de-41738a973c23@siemens.com> (Jan Kiszka's
	message of "Wed, 2 Oct 2024 12:54:50 +0200")
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
	<fd270dfd-f46d-4f1e-96de-41738a973c23@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 04 Oct 2024 11:36:42 +0200
Message-ID: <87a5fk5hw5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 02.10.24 12:40, Tobias Schaffner wrote:
>> Hi all,
>> 
>> This introduces IRQ pipelining for RISC-V into Dovetail. The patches
>> are on top of v6.11-dovetail-rebase. Feel free to ask for other targets
>> if needed.
>> 
>> I thought about splitting the patch up into smaller parts, but decided
>> to stick to the structure of the analogous patches of the other
>> architectures. Maybe this will make the rebasing process easier.
>> 
>> Testing was done in QEMU with IRQ pipeline torture tests, both with and
>> without SMP enabled.
>> 
>> Looking forward to your feedback.
>> 
>
> Cool stuff!
>
> Already checked what is now still missing to get EVL itself running?
>

I did, at first glance we may still need to provide:

- shared in-band/oob fpu support.
- maybe a few tweaks in the arch-specific mm code to support context
  switching from oob context while still using the regular scheduler code.
- _maybe_ exporting the machine-specific clock source we would need via
  the vDSO using the generic extension dovetail already provides
  (GENERIC_CLOCKSOURCE_VDSO). This may be needed unless we only have an
  architected timer.
- support for the RAW_PRINTK extension the interrupt pipeline
  introduces, helpful for debugging without depending on printk()'s
  delays/buffering when running oob. This entails fixing up the uart
  driver which is most commonly used to run the console.

This would give us the basic support to run the latency and context
switching tests. In addition, a complete port would require tweaks in
the DMA engine driver to enable transfers from the oob stage, some
review of the platform-specific SPI and GPIO bits to make sure we can
use them from the oob stage as well.

All in all, not that much.

-- 
Philippe.
